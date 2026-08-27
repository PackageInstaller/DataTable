local UINAddFriendListNode = class("UINAddFriendListNode", UIBaseNode)
local base = UIBaseNode
local EmptyStr = ""
local cs_MessageCommon = CS.MessageCommon
local UINAddFriendListItem = require("Game.Friend.UI.UINAddFriendListItem")

function UINAddFriendListNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  self.friendDataCenter = PlayerDataCenter.friendDataCenter
  self.friendItemPool = UIItemPool.New(UINAddFriendListItem, self.ui.obj_friendItem)
  self.ui.obj_friendItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_close, self, self.OnClickBtnClose)
  UIUtil.AddButtonListener(self.ui.btn_findUID, self, self.OnClickBtnFind)
  UIUtil.AddButtonListener(self.ui.btn_refresh, self, self.OnClickBtnRefresh)
  if ConfigData.game_config.closeFriendRecommend then
    self.ui.btn_refresh.gameObject:SetActive(false)
    self.ui.obj_wait:SetActive(false)
  end
end

function UINAddFriendListNode:InitRecommendList(itemClickFunc, resLoader)
  self._clickFunc = itemClickFunc
  self.resLoader = resLoader
  self:OnFreshTimerFinish()
end

function UINAddFriendListNode:ShowRecommendList()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Hide):SetTopStatusVisible(false):PushTopStatusDataToBackStack()
  self:Show()
  if ConfigData.game_config.closeFriendRecommend then
    self.friendItemPool:HideAll()
    return
  end
  local list = self.friendDataCenter:GetRecommendFriendList()
  if list == nil or #list < 1 then
    self:OnClickBtnRefresh()
    return
  end
  self:RefreshRecommendList(list)
end

function UINAddFriendListNode:RefreshRecommendList(list, isSearch)
  self.friendItemPool:HideAll()
  if list == nil then
    return
  end
  for index, friendData in ipairs(list) do
    local item = self.friendItemPool:GetOne()
    item:InitWithFriendData(friendData, self._clickFunc, self.resLoader, isSearch)
  end
end

function UINAddFriendListNode:RefreshRecommendListItemState()
  for _, item in pairs(self.friendItemPool.listItem) do
    item:RefreshFriendRelationState()
    item:RefreshFriendOnlineState()
  end
end

function UINAddFriendListNode:OnClickBtnClose()
  self.ui.input_findUID.text = EmptyStr
  UIUtil.OnClickBackByUiTab(self)
end

function UINAddFriendListNode:OnClickBtnFind(searchUID)
  local inputUID = tonumber(searchUID or self.ui.input_findUID.text)
  if inputUID == nil or not string.isNumber(inputUID) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Friend_SearchFail))
    return
  end
  local curBlack = PlayerDataCenter.friendDataCenter:TryGetBlackListData(inputUID)
  if curBlack ~= nil then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Friend_FriendInBlackList))
    return
  end
  local curFriend = PlayerDataCenter.friendDataCenter:TryGetFriendData(inputUID)
  if curFriend ~= nil then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9713))
    return
  end
  if inputUID == PlayerDataCenter.inforData:GetUserUID() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9712))
    return
  end
  PlayerDataCenter:GetUserInfoByUID(inputUID, function(userInfoData)
    self.__serchingUserId = inputUID
    if userInfoData == nil then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Friend_SearchFail))
      return
    end
    local list = {userInfoData}
    self:RefreshRecommendList(list, true)
  end)
end

function UINAddFriendListNode:OnClickBtnRefresh()
  if ConfigData.game_config.closeFriendRecommend then
    return
  end
  if self.ui.obj_wait.activeSelf then
    return
  end
  local lastUids = self.friendDataCenter:GetLastRecommendUIDs()
  self.friendNetworkCtrl:CS_FRIEND_Recommend(lastUids, function()
    local list = self.friendDataCenter:GetRecommendFriendList()
    self:RefreshRecommendList(list)
    self:Try2StartFreshTimer()
  end)
end

function UINAddFriendListNode:Try2StartFreshTimer()
  self:OnFreshTimerFinish()
  self.freshEndTime = ConfigData.game_config.friendRecommendFreshTime
  self.freshStartTime = 0
  self.ui.obj_wait:SetActive(true)
  self.ui.btn_refresh.gameObject:SetActive(false)
  self:__OnFreshTimer()
  self.freshTimer = TimerManager:StartTimer(1, self.__OnFreshTimer, self)
end

function UINAddFriendListNode:__OnFreshTimer()
  if self.freshStartTime >= self.freshEndTime then
    self:OnFreshTimerFinish()
    self.ui.obj_wait:SetActive(false)
    self.ui.btn_refresh.gameObject:SetActive(true)
    return
  end
  self.ui.text_wait:SetIndex(0, tostring(self.freshEndTime - self.freshStartTime))
  self.freshStartTime = self.freshStartTime + 1
end

function UINAddFriendListNode:OnFreshTimerFinish()
  if self.freshTimer ~= nil then
    TimerManager:StopTimer(self.freshTimer)
    self.freshTimer = nil
  end
end

function UINAddFriendListNode:OnDelete()
  self:OnFreshTimerFinish()
  self.friendItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINAddFriendListNode
