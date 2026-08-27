local UIUserFriend = class("UIUserFriend", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local UIUserFriendBlackListNode = require("Game.Friend.UI.UIUserFriendBlackListNode")
local UINUserFrienItem = require("Game.Friend.UI.UINUserFrienItem")
local UINUserInfoNode = require("Game.User.UINUserInfoNode")
local UINUserFriendOperateBar = require("Game.Friend.UI.UINUserFriendOperateBar")
local UINAddFriendListNode = require("Game.Friend.UI.UINAddFriendListNode")
local eFriendEnum = require("Game.Friend.eFriendEnum")
local eFriendUIState = eFriendEnum.eFriendUIState

function UIUserFriend:OnInit()
  self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  self.resLoader = cs_ResLoader.Create()
  self.eFriendUIState = nil
  self.userInfoNode = UINUserInfoNode.New()
  self.userInfoNode:Init(self.ui.uINUserInfoNode)
  self.operateBar = UINUserFriendOperateBar.New(self.friendNetworkCtrl)
  self.operateBar:Init(self.ui.operateBar)
  self.operateBar:SetResLoader(self.resLoader)
  self.addFriendListNode = UINAddFriendListNode.New()
  self.addFriendListNode:Init(self.ui.uiAddFriendListNode)
  UIUtil.SetTopStatus(self, self.OnUserInfoReturnClick)
  UIUtil.AddValueChangedListener(self.ui.tog_Friend, self, self.OnFriendTogChange)
  UIUtil.AddValueChangedListener(self.ui.tog_Recommend, self, self.OnFriendApplicationTogChange)
  UIUtil.AddButtonListener(self.ui.btn_CopyUID, self, self.OnClickCopyUID)
  UIUtil.AddButtonListener(self.ui.btn_blackListOpen, self, self.OnClickBlackListOpen)
  UIUtil.AddButtonListener(self.ui.btn_blackListClose, self, self.OnClickBlackListClose)
  self.__OnClickFriendItem = BindCallback(self, self.OnClickFriendItem)
  self.friendItemPool = UIItemPool.New(UINUserFrienItem, self.ui.friendItem)
  self.ui.friendItem:SetActive(false)
  self.ui.img_OnSelect:SetActive(false)
  self.__OnSelfNameChange = BindCallback(self, self._OnSelfNameChange)
  MsgCenter:AddListener(eMsgEventId.UserNameChanged, self.__OnSelfNameChange)
  self.__OnClickRecommendItem = BindCallback(self, self.OnClickRecommendItem)
  self.__OnClickAddFriend = BindCallback(self, self.OnClickAddFriend)
  self.__OnRefreshRecommendItemState = BindCallback(self, self.OnRefreshRecommendItemState)
  self.operateBar:SetRecommendFunc(self.__OnClickAddFriend)
  self.addFriendListNode:InitRecommendList(self.__OnClickRecommendItem, self.resLoader)
end

function UIUserFriend:SetUserFriendCallback(callback)
  self._closeCallback = callback
end

function UIUserFriend:InitUserFriend()
  self.friendDataCenter = PlayerDataCenter.friendDataCenter
  self:TryUpdateAllFriendData()
  self.ui.tog_Friend.group:SetAllTogglesOff()
  self.ui.tog_Friend.isOn = true
  self.ui.tex_UserUid.text = PlayerDataCenter.inforData:GetUserUID()
  self:__AddRedDot2Listerner()
end

function UIUserFriend:OnFriendTogChange(bool, selectUID)
  if bool then
    self.ui.img_tog_Friend.color = self.ui.color_gray
    self.ui.text_tog_friend.color = Color.black
    self.eFriendUIState = eFriendUIState.friendList
    self:RefreshFriendList(self.friendDataCenter:GetFreindList(), selectUID)
  else
    self.ui.img_tog_Friend.color = self.ui.color_black
    self.ui.text_tog_friend.color = Color.white
  end
end

function UIUserFriend:OnFriendApplicationTogChange(bool)
  if bool then
    self.ui.img_tog_Recommend.color = self.ui.color_gray
    self.ui.text_tog_Recommend.color = Color.black
    self.eFriendUIState = eFriendUIState.friendApplication
    self:RefreshFriendList(self.friendDataCenter:GetFriendApplicationList())
  else
    self.ui.img_tog_Recommend.color = self.ui.color_black
    self.ui.text_tog_Recommend.color = Color.white
  end
end

function UIUserFriend:RefreshFriendList(list, selectUID)
  self.friendItemPool:HideAll()
  self.ui.img_OnSelect:SetActive(false)
  local listNum
  if list == nil then
    listNum = 0
  else
    listNum = #list
  end
  self.ui.tex_limitCount:SetIndex(0, tostring(self.friendDataCenter:GetFreindNum()), tostring(ConfigData.game_config.friendListLimitNum))
  self.operateBar:Show()
  self.operateBar:ShowApplyFriendBtn()
  if listNum <= 0 then
    self.ui.friendList_empty:SetActive(true)
    self.ui.friendInfo_empty:SetActive(true)
    self.userInfoNode:Hide()
    if self.eFriendUIState == eFriendUIState.friendList then
      self.ui.emptyText.gameObject:SetActive(true)
      self.ui.emptyText:SetIndex(0)
    elseif self.eFriendUIState == eFriendUIState.friendApplication then
      self.ui.emptyText.gameObject:SetActive(true)
      self.ui.emptyText:SetIndex(1)
    else
      self.ui.emptyText.gameObject:SetActive(false)
    end
    return
  else
    self.ui.friendList_empty:SetActive(false)
    self.ui.friendInfo_empty:SetActive(false)
    self.userInfoNode:Show()
  end
  for index, friendData in ipairs(list) do
    local item = self.friendItemPool:GetOne()
    item:InitWithFriendData(friendData, self.__OnClickFriendItem, self.resLoader)
    if selectUID == nil then
      if index == 1 then
        self:OnClickFriendItem(item)
      end
    elseif selectUID == friendData:GetUserUID() then
      self:OnClickFriendItem(item)
    end
  end
end

function UIUserFriend:OnClickFriendItem(item)
  self.ui.img_OnSelect.transform:SetParent(item.transform)
  self.ui.img_OnSelect.transform.localPosition = Vector3.zero
  self.ui.img_OnSelect:SetActive(true)
  PlayerDataCenter:GetUserInfoByUID(item.friendData:GetUserUID(), function(userInfoData)
    item:FrienItemRefreshUI()
    self.userInfoNode:RefershInfoNode(userInfoData, nil, self.resLoader, false, self.eFriendUIState)
    self.operateBar:RefreshFriendBar(self.eFriendUIState, userInfoData)
  end)
end

function UIUserFriend:OnClickSearch(searchUID)
  local inputUID = tonumber(searchUID or self.ui.iF_FindUID.text)
  if inputUID == nil or not string.isNumber(inputUID) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Friend_SearchFail))
    return
  end
  local curFriend = self.friendDataCenter:TryGetFriendData(inputUID)
  if curFriend ~= nil then
    self.ui.tog_Friend.isOn = true
    self.ui.tog_Recommend.isOn = false
    self:OnFriendTogChange(true, inputUID)
    self:OnFriendApplicationTogChange(false)
    return
  end
  if inputUID == PlayerDataCenter.inforData:GetUserUID() then
    local list = {
      PlayerDataCenter.inforData
    }
    self.ui.tog_Friend.isOn = false
    self.ui.tog_Recommend.isOn = false
    self:OnFriendTogChange(false)
    self:OnFriendApplicationTogChange(false)
    self.eFriendUIState = eFriendUIState.searchSelf
    self:RefreshFriendList(list)
    return
  end
  PlayerDataCenter:GetUserInfoByUID(inputUID, function(userInfoData)
    self.__serchingUserId = inputUID
    if userInfoData == nil then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Friend_SearchFail))
      return
    end
    local list = {userInfoData}
    self.ui.tog_Friend.isOn = false
    self.ui.tog_Recommend.isOn = false
    self:OnFriendTogChange(false)
    self:OnFriendApplicationTogChange(false)
    self.eFriendUIState = eFriendUIState.searchResult
    self:RefreshFriendList(list)
  end)
end

function UIUserFriend:OnClickCopyUID()
  CS.UnityEngine.GUIUtility.systemCopyBuffer = PlayerDataCenter.inforData:GetUserUID()
  CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.UserInfo_CopyUIDDone))
  AudioManager:PlayAudioById(1124)
end

function UIUserFriend:OnFriendListRefresh()
  if self.eFriendUIState == eFriendUIState.friendList then
    self:RefreshFriendList(self.friendDataCenter:GetFreindList())
  elseif self.eFriendUIState == eFriendUIState.friendApplication then
    self:RefreshFriendList(self.friendDataCenter:GetFriendApplicationList())
  elseif self.eFriendUIState == eFriendUIState.searchResult and self.friendDataCenter:TryGetFriendData(self.__serchingUserId) ~= nil then
    self:OnClickSearch(self.__serchingUserId)
  end
  self:RefreshBlackList()
  if self.addFriendListNode then
    self.addFriendListNode:RefreshRecommendListItemState()
  end
end

function UIUserFriend:TryUpdateAllFriendData()
  if self.friendDataCenter:IsExpireFriendData() then
    self.friendNetworkCtrl:CS_FRIEND_RefreshFriend()
  end
end

function UIUserFriend:UpdateHeroList()
  if self.eFriendUIState == eFriendUIState.friendList then
    for _, item in pairs(self.friendItemPool.listItem) do
      item:FrienItemRefreshUI()
    end
    self.userInfoNode:UpdateInfoNode()
  end
end

function UIUserFriend:RefreshBlackList()
  if not self.ui.obj_blackListNode.activeSelf or self.blackListNode == nil then
    return
  end
  self.blackListNode:RefreshBlackListNode(self.resLoader)
end

function UIUserFriend:_OnSelfNameChange()
  if self.eFriendUIState == eFriendUIState.searchSelf then
    for _, item in pairs(self.friendItemPool.listItem) do
      item:FrienItemRefreshUI()
    end
  end
end

function UIUserFriend:__AddRedDot2Listerner()
  local ok, applyNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.UserFriend, RedDotStaticTypeId.UserFriendApplyPath)
  if ok then
    self.ui.obj_redDotApply:SetActive(applyNode:GetRedDotCount() > 0)
    
    function self.__RefreshRedDot(node)
      self.ui.obj_redDotApply:SetActive(node:GetRedDotCount() > 0)
    end
    
    RedDotController:AddListener(applyNode.nodePath, self.__RefreshRedDot)
  end
end

function UIUserFriend:OnUserInfoReturnClick()
  self:OnCloseWin()
  self:Delete()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
end

function UIUserFriend:OnClickBlackListOpen()
  self.ui.obj_blackListNode:SetActive(true)
  if self.blackListNode == nil then
    local blackListNode = UIUserFriendBlackListNode.New()
    blackListNode:Init(self.ui.obj_blackListNode)
    self.blackListNode = blackListNode
  end
  self.blackListNode:RefreshBlackListNode(self.resLoader)
  UIUtil.HideTopStatus()
end

function UIUserFriend:OnClickBlackListClose()
  self.ui.obj_blackListNode:SetActive(false)
  UIUtil.ReShowTopStatus()
end

function UIUserFriend:OnClickAddFriend()
  if self.addFriendListNode then
    self.addFriendListNode:ShowRecommendList()
  end
end

function UIUserFriend:OnClickPrivateChat()
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  if not userChatCtrl:GetIsChatSystemUnlock() then
    return
  end
  JumpManager:Jump(JumpManager.eJumpTarget.ChatSystem, nil, nil, {
    ChatSystemEnum.EChatChannel.Friend,
    self.userInfoData:GetUserUID()
  })
end

function UIUserFriend:OnClickRecommendItem(userInfoData)
  if userInfoData == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonUserInfo, function(win)
    if win == nil then
      return
    end
    win:InitUserInfoView(userInfoData)
    win:AddHideFunc(self.__OnRefreshRecommendItemState)
  end)
end

function UIUserFriend:OnRefreshRecommendItemState()
  if self.addFriendListNode then
    self.addFriendListNode:RefreshRecommendListItemState()
  end
end

function UIUserFriend:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UserNameChanged, self.__OnSelfNameChange)
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  self.userInfoNode:Delete()
  self.operateBar:Delete()
  if self.addFriendListNode then
    self.addFriendListNode:Delete()
  end
  if self.blackListNode then
    self.blackListNode:Delete()
  end
  local ok, applyNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.UserFriend, RedDotStaticTypeId.UserFriendApplyPath)
  if ok then
    RedDotController:RemoveListener(applyNode.nodePath, self.__RefreshRedDot)
  end
  base.OnDelete(self)
end

return UIUserFriend
