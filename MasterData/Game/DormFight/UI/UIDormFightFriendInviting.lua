local UIDormFightFriendInviting = class("UIDormFightFriendInviting", UIBaseWindow)
local base = UIBaseWindow
local UIDormFightUserInfo = require("Game.DormFight.UI.UIDormFightUserInfo")
local UINUserTitle = require("Game.CommonUI.Title.UINNormalTitleItem")

function UIDormFightFriendInviting:OnInit()
  self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  UIUtil.SetGlobalHideTopStatus(true)
  UIUtil.SetGlobalIsBlockEsc(true)
  UIUtil.HideTopStatus()
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self._OnClickCancel)
  self.selfDormFightUserInfo = UIDormFightUserInfo.New()
  self.selfDormFightUserInfo:Init(self.ui.selfDormFightUserInfo)
  self.selfUserTitle = UINUserTitle.New()
  self.selfUserTitle:Init(self.ui.selfUINAppellation)
  self.otherDormFightUserInfo = UIDormFightUserInfo.New()
  self.otherDormFightUserInfo:Init(self.ui.otherDormFightUserInfo)
  self.otherUserTitle = UINUserTitle.New()
  self.otherUserTitle:Init(self.ui.otherUINAppellation)
end

function UIDormFightFriendInviting:InitDormFightFriendInviting(selfUserInfoData, otherUserInfoData, resLoader, duelId, expireTm)
  self.invitingDuelId = duelId
  self.expireTm = expireTm
  self.selfDormFightUserInfo:InitDormFightUserInfo(selfUserInfoData, resLoader)
  self.otherDormFightUserInfo:InitDormFightUserInfo(otherUserInfoData, resLoader)
  local selfTitleInfo = selfUserInfoData:GetAvatarTitleId()
  self:_InitUserTitle(self.selfUserTitle, selfTitleInfo, resLoader)
  local otherTitleInfo = otherUserInfoData:GetAvatarTitleId()
  self:_InitUserTitle(self.otherUserTitle, otherTitleInfo, resLoader)
  self.CountDownSecend = self:GetInvitingExpireSecend()
  self:UpdateCountDown()
  if self._countDownTimerId ~= nil and self._countDownTimerId > 0 then
    TimerManager:StopTimer(self._countDownTimerId)
  end
  self.ui.btn_Cancel.gameObject:SetActive(true)
  self._countDownTimerId = TimerManager:StartTimer(1, BindCallback(self, self.UpdateCountDown), nil, false, false, false)
end

function UIDormFightFriendInviting:_InitUserTitle(userTitle, titleInfo, resLoader)
  if titleInfo ~= nil and titleInfo.titlePrefix ~= 0 then
    local atlasPath = PathConsts:GetSpriteAtlasPath("TitleIcon")
    local _titleBgAtlas = resLoader:LoadABAsset(atlasPath)
    userTitle:InitNormalTitleItem(titleInfo.titlePrefix, titleInfo.titlePostfix, titleInfo.titleBackGround, resLoader, _titleBgAtlas)
  else
    userTitle.gameObject:SetActive(false)
  end
end

function UIDormFightFriendInviting:GetInvitingExpireSecend()
  return self.expireTm - PlayerDataCenter.timestamp + 1
end

function UIDormFightFriendInviting:UpdateCountDown()
  self.CountDownSecend = self.CountDownSecend - 1
  local time = self:GetInvitingExpireSecend()
  if math.abs(self.CountDownSecend - time) > 2 then
    self.CountDownSecend = time
  end
  self.ui.tex_countDown.text = TimeUtil:TimestampToTime(self.CountDownSecend)
  if self._sucessTime ~= nil then
    self._sucessTime = self._sucessTime - 1
    if self._sucessTime < 0 then
      if self.inviteSucesscallback ~= nil then
        self.inviteSucesscallback()
        self.inviteSucesscallback = nil
      end
      self:Delete()
      return
    end
  end
  if self._failTime ~= nil then
    self._failTime = self._failTime - 1
    if 0 > self._failTime then
      self:OnClose()
      return
    end
  end
  if self.CountDownSecend < 0 then
    self:OnClose()
    return
  end
end

function UIDormFightFriendInviting:OnInviteSucess(callback)
  self.ui.tex_inviting:SetIndex(1)
  self.inviteSucesscallback = callback
  self.ui.btn_Cancel.gameObject:SetActive(false)
  self:ShowSucessMsg()
  self._sucessTime = 3
end

function UIDormFightFriendInviting:ShowSucessMsg()
  self.ui.obj_InviteSuccesssBg:SetActive(true)
end

function UIDormFightFriendInviting:OnInviteFail()
  self.ui.tex_inviting:SetIndex(2)
  CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9353))
  self._failTime = 1
end

function UIDormFightFriendInviting:OnClose()
  UIUtil.SetGlobalHideTopStatus(false)
  UIUtil.SetGlobalIsBlockEsc(false)
  UIUtil.ReShowTopStatus()
  self:Delete()
end

function UIDormFightFriendInviting:_OnClickCancel()
  if self._sucessTime ~= nil then
    return
  end
  if self._failTime ~= nil then
    self:OnClose()
  end
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  if dormFightCtrl ~= nil then
    dormFightCtrl:CancelInvite(self.invitingDuelId, function()
      self:OnClose()
    end)
  end
end

function UIDormFightFriendInviting:OnDelete()
  self.selfDormFightUserInfo:Delete()
  self.selfDormFightUserInfo = nil
  self.selfUserTitle:Delete()
  self.selfUserTitle = nil
  self.otherDormFightUserInfo:Delete()
  self.otherDormFightUserInfo = nil
  self.otherUserTitle:Delete()
  self.otherUserTitle = nil
  self._sucessTime = nil
  self._failTime = nil
  if self._countDownTimerId ~= nil and self._countDownTimerId > 0 then
    TimerManager:StopTimer(self._countDownTimerId)
  end
  base.OnDelete(self)
end

return UIDormFightFriendInviting
