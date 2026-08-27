local UINUserFriendOperateBar = class("UINUserFriendOperateBar", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local eFriendEnum = require("Game.Friend.eFriendEnum")
local eFriendUIState = eFriendEnum.eFriendUIState
local ChatSystemEnum = require("Game.ChatSystem.ChatSystemEnum")
local JumpManager = require("Game.Jump.JumpManager")
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function UINUserFriendOperateBar:ctor(friendNetworkCtrl)
  self.friendNetworkCtrl = friendNetworkCtrl
end

function UINUserFriendOperateBar:OnInit()
  self.friendDataCenter = PlayerDataCenter.friendDataCenter
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Require, self, self.OnClickAddFriend)
  UIUtil.AddButtonListener(self.ui.btn_Delete, self, self.OnClickDeleteFriend)
  UIUtil.AddButtonListener(self.ui.btn_Cancle, self, self.OnClickCanacle)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Fight, self, self.OnClickFight)
  UIUtil.AddButtonListener(self.ui.btn_SetAlias, self, self.OnclickSetAlias)
  UIUtil.AddButtonListener(self.ui.btn_PrivateChat, self, self.OnClickFriendChat)
  UIUtil.AddButtonListener(self.ui.btn_DormFightGuide, self, self.OnClickFightGuide)
end

function UINUserFriendOperateBar:SetResLoader(resLoader)
  self.resLoader = resLoader
end

function UINUserFriendOperateBar:SetRecommendFunc(recommendFunc)
  self.recommendFunc = recommendFunc
end

function UINUserFriendOperateBar:ShowApplyFriendBtn()
  self.ui.btn_Require.gameObject:SetActive(true)
  self.ui.btn_Cancle.gameObject:SetActive(false)
  self.ui.btn_Confirm.gameObject:SetActive(false)
  self.ui.btn_PrivateChat.gameObject:SetActive(false)
  self.ui.btn_Fight.gameObject:SetActive(false)
end

function UINUserFriendOperateBar:RefreshFriendBar(friendUIState, userInfoData)
  self.userInfoData = userInfoData
  self.ui.obj_Wait:SetActive(false)
  self.ui.btn_SetAlias.gameObject:SetActive(false)
  self.ui.btn_Delete.gameObject:SetActive(false)
  if friendUIState == eFriendUIState.friendList then
    self.ui.btn_Require.gameObject:SetActive(true)
    self.ui.btn_Cancle.gameObject:SetActive(false)
    self.ui.btn_Confirm.gameObject:SetActive(false)
    self.ui.btn_PrivateChat.gameObject:SetActive(true)
    self.ui.btn_Fight.gameObject:SetActive(true)
  elseif friendUIState == eFriendUIState.friendApplication then
    self.ui.btn_Require.gameObject:SetActive(false)
    self.ui.btn_Cancle.gameObject:SetActive(true)
    self.ui.btn_Confirm.gameObject:SetActive(true)
    self.ui.btn_PrivateChat.gameObject:SetActive(false)
    self.ui.btn_Fight.gameObject:SetActive(false)
  elseif friendUIState == eFriendUIState.searchResult then
    self.ui.btn_Require.gameObject:SetActive(false)
    self.ui.btn_Cancle.gameObject:SetActive(false)
    self.ui.btn_Confirm.gameObject:SetActive(false)
    self.ui.btn_PrivateChat.gameObject:SetActive(false)
    self.ui.btn_Fight.gameObject:SetActive(false)
  elseif friendUIState == eFriendUIState.searchSelf then
    self.ui.btn_Require.gameObject:SetActive(false)
    self.ui.btn_Delete.gameObject:SetActive(false)
    self.ui.btn_Confirm.gameObject:SetActive(false)
    self.ui.btn_PrivateChat.gameObject:SetActive(false)
    self.ui.btn_Fight.gameObject:SetActive(false)
  end
  self:RefreshDormFightBtn(userInfoData)
end

function UINUserFriendOperateBar:RefreshDormFightBtn(userInfoData)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local frameDataTable = actFrameCtrl:GetShowByActType(ActivityFrameEnum.eActivityType.DormFight)
  if frameDataTable == nil then
    self.ui.btn_Fight.gameObject:SetActive(false)
    return
  end
  for actId, isOpen in pairs(frameDataTable) do
    if isOpen == false then
      self.ui.btn_Fight.gameObject:SetActive(false)
      return
    end
  end
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DormFight) then
    self.ui.btn_Fight.gameObject:SetActive(false)
    return
  end
  if userInfoData:IsOnline() then
    self.ui.img_BtnFightBottom.color = Color.white
  else
    self.ui.img_BtnFightBottom.color = Color.gray
  end
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  if not userChatCtrl:GetIsChatSystemCanShow() then
    self.ui.btn_PrivateChat.gameObject:SetActive(false)
  end
end

function UINUserFriendOperateBar:OnClickDeleteFriend()
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.Friend_DeleteAlert), function()
    if self.friendDataCenter:TryGetFriendData(self.userInfoData:GetUserUID()) ~= nil then
      self.friendNetworkCtrl:CS_FRIEND_DissolveFriend(self.userInfoData:GetUserUID())
    end
  end, nil)
end

function UINUserFriendOperateBar:OnClickConfirm()
  if self:__JudgeIsApplyOutOfData() then
    return
  end
  if self.friendDataCenter:GetIsFriendFull() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Friend_AddFailure))
    self:OnClickCanacle()
    return
  end
  self.friendNetworkCtrl:CS_FRIEND_AgreeApply(self.userInfoData:GetUserUID(), function(args)
    local isSuccess
    if args ~= nil and args.Count > 0 then
      isSuccess = args[0]
    else
      return
    end
    if isSuccess then
      self.friendDataCenter:UpdateFriendApplyReddotNum()
    else
      self.friendDataCenter:DeleteApplyNotice(self.userInfoData:GetUserUID())
    end
  end)
end

function UINUserFriendOperateBar:OnClickCanacle()
  if self:__JudgeIsApplyOutOfData(true) then
    return
  end
  local uid = self.userInfoData:GetUserUID()
  self.friendNetworkCtrl:CS_FRIEND_IgnoreApply(uid, function()
    self.friendDataCenter:DeleteApplyNotice(uid)
  end)
end

function UINUserFriendOperateBar:OnClickAddFriend()
  if self.recommendFunc then
    self.recommendFunc()
  end
end

function UINUserFriendOperateBar:OnClickFight()
  if self.userInfoData:GetIsSelfUserInfo() then
    return
  end
  if not self.userInfoData:IsOnline() then
    local err = ConfigData:GetTipContent(9357)
    cs_MessageCommon.ShowMessageTips(err)
    return
  end
  local window = UIManager:GetWindow(UIWindowTypeID.DormFightFriendInviting)
  if window ~= nil then
    return
  end
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  if dormFightCtrl == nil then
    return
  end
  dormFightCtrl:InviteUserToDormFight(self.userInfoData:GetUserUID(), 1, function(duelId, expireTm)
    local invitingDuelId = duelId
    UIManager:ShowWindowAsync(UIWindowTypeID.DormFightFriendInviting, function(window)
      if window ~= nil then
        window:InitDormFightFriendInviting(PlayerDataCenter.inforData, self.userInfoData, self.resLoader, invitingDuelId, expireTm)
      end
    end)
  end)
end

function UINUserFriendOperateBar:OnclickSetAlias()
  if CloseCustomBename then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(393))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UserFreinedSetAlias, function(win)
    if win == nil then
      return
    end
    win:InitSetFriendAlias(self.userInfoData)
  end)
end

function UINUserFriendOperateBar:OnClickFriendChat()
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  if not userChatCtrl:GetIsChatSystemUnlock() then
    return
  end
  JumpManager:Jump(JumpManager.eJumpTarget.ChatSystem, nil, nil, {
    ChatSystemEnum.EChatChannel.Friend,
    self.userInfoData:GetUserUID()
  })
end

function UINUserFriendOperateBar:__JudgeIsApplyOutOfData(notPopMsg)
  if self.userInfoData:GetIsApplicationTimeOut() then
    if not notPopMsg then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Friend_AppExpire))
    end
    self.friendDataCenter:DeleteApplyNotice(self.userInfoData:GetUserUID())
    return true
  end
end

function UINUserFriendOperateBar:OnClickFightGuide()
  GuidePicture.OpenGuidePicture(ConfigData.dorm_fight_config.dormfightGuidePictureId)
end

function UINUserFriendOperateBar:OnDelete()
  base.OnDelete(self)
end

return UINUserFriendOperateBar
