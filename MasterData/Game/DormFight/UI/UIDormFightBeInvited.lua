local UIDormFightBeInvited = class("UIDormFightBeInvited", UIBaseWindow)
local base = UIBaseWindow
local UIDormFightUserInfo = require("Game.DormFight.UI.UIDormFightUserInfo")
local UINUserTitle = require("Game.CommonUI.Title.UINNormalTitleItem")
local cs_ResLoader = CS.ResLoader

function UIDormFightBeInvited:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_SmallWindow, self, self.OnClickSmallWindow)
  UIUtil.AddButtonListener(self.ui.btn_Refuse, self, self.OnClickBtnRefuse)
  UIUtil.AddButtonListener(self.ui.btn_Minimize, self, self.OnClickBtnMinimize)
  UIUtil.AddButtonListener(self.ui.btn_Accept, self, self.OnClickBtnAccept)
  UIUtil.AddButtonListener(self.ui.btn_LeftSwitch, self, self.OnClickBtnLeftSwitch)
  UIUtil.AddButtonListener(self.ui.btn_RightSwitch, self, self.OnClickBtnRightSwitch)
  self.otherDormFightUserInfo = UIDormFightUserInfo.New()
  self.otherDormFightUserInfo:Init(self.ui.otherDormFightUserInfo)
  self.otherUserTitle = UINUserTitle.New()
  self.otherUserTitle:Init(self.ui.otherUINAppellation)
  self.isMinimize = true
  self.inviteTimeOutLimit = 60
end

function UIDormFightBeInvited:GetOtherUserInfoData()
  return self.currentInviteData.otherUserInfoData
end

function UIDormFightBeInvited:GetCurrentCountDownSecend()
  return self.currentInviteData.inviteExpiredTimeStamp - PlayerDataCenter.timestamp + 1
end

function UIDormFightBeInvited:InitDormFightBeInvited(dormFightCtrl)
  self.dormFightCtrl = dormFightCtrl
  self.selfUserInfoData = dormFightCtrl:GetSelfUserData()
  self.inviteDataList = dormFightCtrl:GetInviteDataList()
  self.resloader = cs_ResLoader.Create()
  if self._countDownTimerId ~= nil and self._countDownTimerId > 0 then
    TimerManager:StopTimer(self._countDownTimerId)
  end
  self._countDownTimerId = TimerManager:StartTimer(1, BindCallback(self, self.UpdateCountDown), nil, false, false, false)
  self:SwitchToEarliestInvite()
  self:OpenBigWindow()
end

function UIDormFightBeInvited:Refresh()
  if self.currentInviteData == nil then
    return
  end
  if not self.currentInviteData:IsLegal() then
    self:OnInviteEnd()
    return
  end
  local otherUserInfoData = self:GetOtherUserInfoData()
  self.otherDormFightUserInfo:InitDormFightUserInfo(otherUserInfoData, self.resloader)
  local otherTitleInfo = otherUserInfoData:GetAvatarTitleId()
  self:_InitUserTitle(self.otherUserTitle, otherTitleInfo, self.resloader)
  self.CountDownSecend = self:GetCurrentCountDownSecend()
  if self.CountDownSecend < 1 then
    return
  end
  self:UpdateCountDown()
  if IsNull(self.ui) then
    return
  end
  self.ui.tex_Title.text = ConfigData:GetTipContent(9305, otherUserInfoData:GetUserName())
  local inviteDataCount = self.dormFightCtrl:GetLegalInviteDataCount()
  self.ui.tex_inviteCount.text = inviteDataCount
  local needShowSwichBtn = 1 < inviteDataCount
  self.ui.btn_LeftSwitch.gameObject:SetActive(needShowSwichBtn)
  self.ui.btn_RightSwitch.gameObject:SetActive(needShowSwichBtn)
end

function UIDormFightBeInvited:_InitUserTitle(userTitle, titleInfo, resLoader)
  if titleInfo ~= nil and titleInfo.titlePrefix ~= 0 then
    local atlasPath = PathConsts:GetSpriteAtlasPath("TitleIcon")
    local _titleBgAtlas = resLoader:LoadABAsset(atlasPath)
    userTitle:InitNormalTitleItem(titleInfo.titlePrefix, titleInfo.titlePostfix, titleInfo.titleBackGround, resLoader, _titleBgAtlas)
  else
    userTitle.gameObject:SetActive(false)
  end
end

function UIDormFightBeInvited:SwitchInvite(flag)
  local index = table.indexof(self.inviteDataList, self.currentInviteData)
  if not index then
    return
  end
  if not self.dormFightCtrl:IsExistLegalInvited() then
    self:CloseWindow()
    return
  end
  index = index + flag
  if index > #self.inviteDataList then
    index = 1
  end
  if index <= 0 then
    index = #self.inviteDataList
  end
  while not self.inviteDataList[index]:IsLegal() do
    index = index + flag
    if index > #self.inviteDataList then
      index = 1
    end
    if index <= 0 then
      index = #self.inviteDataList
    end
  end
  self:ChangeInviteByIndex(index)
end

function UIDormFightBeInvited:SwitchToEarliestInvite()
  local index = self.dormFightCtrl:GetEarliestInviteDataIndex()
  if 0 < index then
    self:ChangeInviteByIndex(index)
  end
end

function UIDormFightBeInvited:ChangeInviteByIndex(index)
  local inviteData = self.inviteDataList[index]
  self.currentInviteData = inviteData
  self.currentIndex = index
  self:Refresh()
end

function UIDormFightBeInvited:OnClickSmallWindow()
  self:OpenBigWindow()
end

function UIDormFightBeInvited:OnClickBtnRefuse()
  self.currentInviteData.isRefuse = true
  self.dormFightCtrl:RefuseInviteDormFight(self.currentInviteData.duelId)
  self:OnInviteEnd()
end

function UIDormFightBeInvited:OnClickBtnMinimize()
  self:WindowMinimize()
end

function UIDormFightBeInvited:OnClickBtnAccept()
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  if dormFightCtrl == nil then
    return
  end
  dormFightCtrl:AcceptInvitedDormFight(self.currentInviteData.duelId, self:GetOtherUserInfoData():GetUserUID(), self.currentInviteData.roomType, function()
    self.ui.obj_successBg:SetActive(true)
    TimerManager:StartTimer(3, function()
      self:Delete()
    end, nil, true, false, false)
  end)
end

function UIDormFightBeInvited:OnClickBtnLeftSwitch()
  self:SwitchInvite(1)
end

function UIDormFightBeInvited:OnClickBtnRightSwitch()
  self:SwitchInvite(-1)
end

function UIDormFightBeInvited:UpdateCountDown()
  self.CountDownSecend = self.CountDownSecend - 1
  local time = self:GetCurrentCountDownSecend()
  if math.abs(self.CountDownSecend - time) > 2 then
    self.CountDownSecend = time
  end
  if self.CountDownSecend < 0 then
    self:OnInviteEnd()
    return
  end
  self:RefreshCountDownText(TimeUtil:TimestampToTime(self.CountDownSecend))
end

function UIDormFightBeInvited:RefreshCountDownText(text)
  self.ui.tex_smallCountDown.text = text
  self.ui.tex_bigCountDown.text = text
end

function UIDormFightBeInvited:OnInviteEnd()
  if not self.dormFightCtrl:IsExistLegalInvited() then
    self:CloseWindow()
  else
    self:SwitchToEarliestInvite()
  end
end

function UIDormFightBeInvited:OpenBigWindow()
  self.ui.BigWindow:SetActive(true)
  self.ui.SmallWindow:SetActive(false)
  self.isMinimize = false
end

function UIDormFightBeInvited:WindowMinimize()
  self.ui.BigWindow:SetActive(false)
  self.ui.SmallWindow:SetActive(true)
  self:SwitchToEarliestInvite()
  self.isMinimize = true
end

function UIDormFightBeInvited:OnInviteCancel()
  local otherUserInfoData = self:GetOtherUserInfoData()
  local userName = otherUserInfoData:GetUserName()
  CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9352, userName))
  self:OnInviteEnd()
end

function UIDormFightBeInvited:CloseWindow()
  self:Delete()
end

function UIDormFightBeInvited:OnDelete()
  self.otherDormFightUserInfo:Delete()
  self.otherDormFightUserInfo = nil
  self.otherUserTitle:Delete()
  self.otherUserTitle = nil
  if self._countDownTimerId ~= nil and self._countDownTimerId > 0 then
    TimerManager:StopTimer(self._countDownTimerId)
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIDormFightBeInvited
