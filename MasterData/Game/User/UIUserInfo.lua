local UIUserInfo = class("UIUserNameModify", UIBaseWindow)
local base = UIBaseWindow
local UINUserInfoNode = require("Game.User.UINUserInfoNode")
local UINShareCommonBtn = require("Game.Share.UI.UINShareCommonBtn")
local eShare = require("Game.Share.eShare")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader

function UIUserInfo:OnInit()
  self.resLoader = cs_ResLoader.Create()
  UIUtil.SetTopStatus(self, self.OnUserInfoReturnClick)
  UIUtil.AddButtonListener(self.ui.btn_toAchievement, self, self.OpenAchievement)
  self._RefreshAchievementInfo = BindCallback(self, self.RefreshAchievementInfo)
  MsgCenter:AddListener(eMsgEventId.UpdatePickedAchivTask, self._RefreshAchievementInfo)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self._RefreshAchievementInfo)
  self.userInfoNode = UINUserInfoNode.New()
  self.userInfoNode:Init(self.ui.obj_uINUserInfoNode)
  UIUtil.AddButtonListener(self.ui.btn_ChangeDressUp, self, self._OpenChangeDressUp)
  UIUtil.AddButtonListener(self.ui.btn_ChangePro, self, self._OpenChangePro)
  self._shareBtn = UINShareCommonBtn.New()
  self._shareBtn:Init(self.ui.shareCommonButton)
  self._shareBtn:Hide()
end

function UIUserInfo:InitUserInfo()
  self:RefreshPlayerInfo()
  self:RefreshAchievementInfo()
  local shareCtr = ControllerManager:GetController(ControllerTypeId.Share, true)
  if shareCtr:IsShareUnlock() then
    self._shareId = eShare.eShareType.CommonReward
    self._shareBtn:Show()
    self._shareBtn:InitShareCommonBtn(BindCallback(self, self._OnClickShare), self._shareId)
  end
end

function UIUserInfo:RefreshPlayerInfo()
  self.userInfoNode:RefershInfoNode(PlayerDataCenter.inforData, BindCallback(self, self.ChangeNameAction), self.resLoader, true)
end

function UIUserInfo:RefreshUserHead(id)
  self.userInfoNode:RefreshUserHeadOnly(id)
end

function UIUserInfo:RefreshUserHeadFrame(id)
  self.userInfoNode:RefreshUserHeadFrameOnly(id)
end

function UIUserInfo:ChangeNameAction()
  local num = PlayerDataCenter:GetItemCount(ConfigData.game_config.changeNameItemId)
  if num < 1 then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(173))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoDialog, function(window)
    if window ~= nil then
      window:OpenChangeNameDialog()
    end
  end)
end

function UIUserInfo:RefreshAchievementInfo()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  self.ui.btn_toAchievement.gameObject:SetActive(isUnlock)
  if not isUnlock then
    return
  end
  self.userInfoNode:RefreshUserLevel(PlayerDataCenter.playerLevel.level)
  local cur = PlayerDataCenter.achivLevelData:GetPickedAchNum() or 0
  local total = PlayerDataCenter.achivLevelData:GetTotalAchNum() or 0
  local rate = 0
  if cur ~= 0 and total ~= 0 then
    rate = GetPreciseDecimalStr(cur / total * 100, 0)
  end
  self.ui.tex_CompleteNum.text = rate .. "%"
end

function UIUserInfo:OpenAchievement()
  UIManager:ShowWindowAsync(UIWindowTypeID.AchievementSystem, function(win)
    if win ~= nil then
      win:InitAchievement(nil, false)
      win:SetOnAchievementSystemCloseCallback(BindCallback(self, self.RefreshPlayerInfo))
    end
  end)
end

function UIUserInfo:OnUserInfoReturnClick()
  self.userInfoNode:SaveUserSignature()
  self:OnCloseWin()
  self:Delete()
end

function UIUserInfo:_OpenChangeDressUp()
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoDialog, function(window)
    if window ~= nil then
      window:OpenChangeDressUpDialog()
    end
  end)
end

function UIUserInfo:_OpenChangePro()
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoDialog, function(window)
    if window ~= nil then
      window:OpenChangePro()
    end
  end)
end

function UIUserInfo:_OnClickShare()
  UIManager:ShowWindowAsync(UIWindowTypeID.Share, function(win)
    if win == nil then
      return
    end
    win:SetShareBeforeCaptureFunc(function()
      self:_ShareShow(false)
    end):SetShareAfterCaptureFunc(function()
      self:_ShareShow(true)
    end):InitShare(self._shareId)
  end)
end

function UIUserInfo:_ShareShow(show)
  self._shareBtn.gameObject:SetActive(show)
  self.ui.buttom.gameObject:SetActive(show)
  if show then
    UIUtil.ReShowTopStatus()
  else
    UIUtil.HideTopStatus()
  end
end

function UIUserInfo:OnDelete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdatePickedAchivTask, self._RefreshAchievementInfo)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self._RefreshAchievementInfo)
  self.userInfoNode:Delete()
  self._shareBtn:Delete()
  base.OnDelete(self)
end

return UIUserInfo
