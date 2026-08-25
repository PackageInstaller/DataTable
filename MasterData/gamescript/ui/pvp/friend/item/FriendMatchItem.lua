local TYPEOF_Slider = typeof(CS.UnityEngine.UI.Slider)
local Ease = CS.DG.Tweening.Ease
local FriendMatchItem, Super = System.NewComponent("FriendMatchItem")

function FriendMatchItem:ctor(gameObj, friendInfo)
  Super.ctor(self)
  self.ui = UI_Social_Item_FriendlyInviteResource(gameObj)
  self.playerInfo = Vue.ref(friendInfo)
end

function FriendMatchItem:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_Name)
  self:BindPlayerInfo(self.playerInfo.value)
  binder:BindButtonClick(self.ui.Btn_Accept, System.fn(self, self.OnBtnAccept))
  binder:BindButtonClick(self.ui.Btn_Refuse, System.fn(self, self.OnBtnRefuse))
  self:BindInviteStatus(binder)
  self:SetLeftTimeTween()
end

function FriendMatchItem:BindPlayerInfo(playerInfo)
  local binder = self.binder
  local facade = FriendMatchMgr.Instance:GetFriendData(self.playerInfo.value.friendRelateUid, function()
    self:BindPlayerInfo(playerInfo)
  end)
  if not facade then
    return
  end
  binder:BindComponent((CommonHeadItem(self.ui.UI_Common_Head, {
    clickCb = function()
    end,
    headIcon = ItemDataUtils.GetAvatarIcon(facade.icon),
    frameIcon = ItemDataUtils.GetItemIcon(facade.avatarFrame)
  })))
  binder:SetText(self.ui.Text_Lv, LT.Text(string.format("（Lv.%s）", facade.level)))
  binder:SetText(self.ui.Text_Name, LT.Text(SocialDataUtils.GetPlayerName(facade)))
  local node = facade.note
  if not node or "" == node then
    node = LT.Text("SocialSystemIntroductionNone")
  end
  binder:SetText(self.ui.Text_Synopsis, LT.Text(node))
  binder:SetText(self.ui.Text_State, self:_GetPlayerStateDesc())
  if SocialDataUtils.CheckOffLineState(facade.state) then
    binder:SetImage(self.ui.Image_StateIcon, SocialDefine.SocialOnlineStateIconPath.OutLineIcon)
  else
    binder:SetImage(self.ui.Image_StateIcon, SocialDataUtils.GetPlayerStateIcon(facade.state))
  end
  binder:BindToVisible(self.ui.Image_Mutual, function()
    local isCorrelations = facade.relation == SocialDefine.SocialRelationType.Cor
    return isCorrelations
  end)
  binder:BindToVisible(self.ui.Image_Love, function()
    local isCorrelations = facade.relation == SocialDefine.SocialRelationType.Cor
    local isFollowers = facade.relation == SocialDefine.SocialRelationType.MyFans
    return not isCorrelations and isFollowers
  end)
end

function FriendMatchItem:OnUnbind()
  Super.OnUnbind(self)
  self:ClearLeftTimeTween()
end

function FriendMatchItem:_GetPlayerStateDesc()
  if self.playerInfo.value.pvpType == PvpDefine.PvpType.PreBuilt then
    do return LT.Text end
    return LT.Text, "FriendGameInviteTipsNormal"
  else
    do return LT.Text end
    return LT.Text, "FriendGameInviteTipsDraft"
  end
end

function FriendMatchItem:SetLeftTimeTween()
  self:ClearLeftTimeTween()
  local curValue, time = self:GetCurSliderValue()
  self.binder:SetSliderCurValue(self.ui.Slider_Cutdown, curValue)
  local slider = self.ui.Slider_Cutdown:GetComponent(TYPEOF_Slider)
  if curValue > 0 and time > 0 then
    self.leftTimeTw = slider:DOValue(0, time):SetEase(Ease.Linear):OnComplete(function()
      self:OnTimeout()
    end)
  elseif curValue <= 0 then
    self:OnTimeout()
  end
end

function FriendMatchItem:OnTimeout()
  if self.playerInfo.value.friendGameStatus == cd.FriendMatchStatus.Inviting then
    self.playerInfo.value.friendGameStatus = cd.FriendMatchStatus.Timeout
  end
end

function FriendMatchItem:ClearLeftTimeTween()
  if self.leftTimeTw then
    self.leftTimeTw:Kill()
    self.leftTimeTw = nil
  end
end

function FriendMatchItem:GetCurSliderValue()
  local ts = self.playerInfo.value.ts
  local countDown = DT.GetConstant("FriendlyMatchInvitationCountdown", 60)
  local endTime = ts + countDown
  local curTime = TimeUtils.GetServerTime()
  local leftTime = endTime - curTime
  local slide = math.max(0, math.min(1, leftTime / countDown))
  return slide, leftTime
end

function FriendMatchItem:BindInviteStatus(binder)
  binder:BindToRaw(function(_, status)
    self.ui.Slider_Cutdown:SetActive(status == cd.FriendMatchStatus.Inviting)
    self.ui.Group_Btn:SetActive(status == cd.FriendMatchStatus.Inviting)
    self.ui.Image_Cancel:SetActive(status ~= cd.FriendMatchStatus.Inviting)
    if status ~= cd.FriendMatchStatus.Inviting then
      self:ClearLeftTimeTween()
    end
    self.ui.Image_Cancel:SetActive(self:GetInvalidText(status) ~= nil)
    binder:SetText(self.ui.Text_Cancel, self:GetInvalidText(status))
  end, function()
    return self.playerInfo.value.friendGameStatus
  end)
end

function FriendMatchItem:GetInvalidText(status)
  if status == cd.FriendMatchStatus.Timeout then
    do return LT.Text end
    return LT.Text, "TimeoutText"
  elseif status == cd.FriendMatchStatus.Refused then
    do return LT.Text end
    return LT.Text, "RefusedText"
  elseif status == cd.FriendMatchStatus.Close then
    do return LT.Text end
    return LT.Text, "CanceledText"
  end
end

function FriendMatchItem:OnBtnAccept()
  PVPCollectionDataUtils.ReqServerData(function()
    if self.playerInfo and self.playerInfo.value and self.playerInfo.value.friendRelateUid then
      FriendMatchMgr.Instance:AcceptInvite(self.playerInfo.value.friendRelateUid)
    end
  end)
end

function FriendMatchItem:OnBtnRefuse()
  FriendMatchMgr.Instance:RefuseInvite(self.playerInfo.value.friendRelateUid, function()
    self.playerInfo.value.friendGameStatus = cd.FriendMatchStatus.Refused
  end)
end

return FriendMatchItem
