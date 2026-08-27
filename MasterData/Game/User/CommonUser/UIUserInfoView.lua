local UIUserInfoView = class("UIUserInfoView", UIBaseWindow)
local base = UIBaseWindow
local UINUserInfoNode = require("Game.User.UINUserInfoNode")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local eFriendEnum = require("Game.Friend.eFriendEnum")

function UIUserInfoView:OnInit()
  self.resLoader = cs_ResLoader.Create()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Delete):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.background, self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_Require, self, self.AddStrangerAsFriend)
  UIUtil.AddButtonListener(self.ui.btn_Delete, self, self.OnClickDeleteFriend)
  self.friendDataCenter = PlayerDataCenter.friendDataCenter
  self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  self.userInfoNode = UINUserInfoNode.New()
  self.userInfoNode:Init(self.ui.obj_uINUserInfoNode)
  self.ui.btn_Require.gameObject:SetActive(false)
  self.ui.btn_Delete.gameObject:SetActive(false)
  self.ui.obj_Wait:SetActive(false)
  self._OnFriendListChange = BindCallback(self, self.RefreshUserInfo)
  MsgCenter:AddListener(eMsgEventId.OnUserFriendListChange, self._OnFriendListChange)
end

function UIUserInfoView:InitUserInfoView(userInfoData, applyMode)
  self.userInfoData = userInfoData
  self.applyMode = applyMode or eFriendEnum.eFriendApplyWay.WayNone
  self.userInfoNode:RefershInfoNode(userInfoData, nil, self.resLoader, false)
  local isFriend = userInfoData:GetIsFriend()
  local isSelf = userInfoData:GetIsSelfUserInfo()
  local hasApplied = PlayerDataCenter.friendDataCenter:HasAppliedUser(self.userInfoData:GetUserUID())
  if not isFriend and not isSelf then
    self.ui.obj_Wait:SetActive(hasApplied)
    self.ui.btn_Require.gameObject:SetActive(not hasApplied)
  else
    self.ui.btn_Require.gameObject:SetActive(false)
  end
  if isFriend and not isSelf then
    self.ui.obj_Wait:SetActive(false)
    self.ui.btn_Delete.gameObject:SetActive(true)
  else
    self.ui.btn_Delete.gameObject:SetActive(false)
  end
end

function UIUserInfoView:RefreshUserInfo()
  PlayerDataCenter:GetUserInfoByUID(self.userInfoData:GetUserUID(), function(userInfoData)
    self:InitUserInfoView(userInfoData)
  end)
end

function UIUserInfoView:SetBackgroundPlateId(bgPlateId)
  self.overrideBackgroundPlateId = bgPlateId
  self.userInfoNode:RefreshDressUp(bgPlateId)
end

function UIUserInfoView:AddStrangerAsFriend()
  if self.friendDataCenter:GetIsFriendFull() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Friend_AddFailure))
    return
  end
  self.friendNetworkCtrl:CS_FRIEND_ApplyFriend(self.userInfoData:GetUserUID(), self.applyMode, function()
    if not self.userInfoData:GetIsFriend() then
      self.ui.obj_Wait:SetActive(true)
      self.ui.btn_Require.gameObject:SetActive(false)
      self.ui.btn_Delete.gameObject:SetActive(false)
    end
  end)
end

function UIUserInfoView:OnClickDeleteFriend()
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.Friend_DeleteAlert), function()
    if self.friendDataCenter:TryGetFriendData(self.userInfoData:GetUserUID()) ~= nil then
      self.friendNetworkCtrl:CS_FRIEND_DissolveFriend(self.userInfoData:GetUserUID(), function()
        self:RefreshUserInfo()
      end)
    end
  end, nil)
end

function UIUserInfoView:AddHideFunc(func)
  self.hideFunc = func
end

function UIUserInfoView:OnClickBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UIUserInfoView:OnHide()
  if self.hideFunc ~= nil then
    local func = self.hideFunc
    self.hideFunc = nil
    func()
  end
end

function UIUserInfoView:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnUserFriendListChange, self._OnFriendListChange)
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  self.userInfoNode:Delete()
  base.OnDelete(self)
end

return UIUserInfoView
