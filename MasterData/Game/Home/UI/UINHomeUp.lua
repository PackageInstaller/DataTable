local UINHomeUp = class("UINHomeUp", UIBaseNode)
local base = UIBaseNode
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINHomeResourceItem = require("Game.Home.UI.UINHomeResourceItem")
local UINHomeGeneralBtn = require("Game.Home.UI.UINHomeGeneralBtn")

function UINHomeUp:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.resourceGroup = UINResourceGroup.New()
  self.resourceGroup:Init(self.ui.obj_resourceGroup)
  UIUtil.AddButtonListener(self.ui.btn_Mail, self, self.OnClickMail)
  UIUtil.AddButtonListener(self.ui.btn_Setting, self, self.OnClickSetting)
  UIUtil.AddButtonListener(self.ui.btn_userInfo, self, self.OnClickUserInfo)
end

function UINHomeUp:InitHomeUpNode(homeUI)
  self.homeUI = homeUI
  self.homeController = homeUI.homeController
  self:RefershUserInfo()
  self:RefreshMailBtn()
  self:RefreshSettingBtn()
end

function UINHomeUp:OnHomeShow()
end

function UINHomeUp:RefershUserInfo()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CommanderInformation)
  self.ui.btn_userInfo.enabled = isUnlock
  self.ui.btn_userInfo.gameObject:SetActive(isUnlock)
  if not isUnlock then
    return
  end
  self.ui.tex_UserName.text = PlayerDataCenter.playerName
  self.ui.tex_UserID:SetIndex(0, PlayerDataCenter.strPlayerId)
  local curLevel = PlayerDataCenter.playerLevel.level or 1
  local empty = ""
  if curLevel <= 9 then
    empty = "0"
  end
  self.ui.tex_UserLevel.text = empty .. tostring(curLevel)
end

function UINHomeUp:RefreshMailBtn()
  if self.mailBtn == nil then
    self.mailBtn = UINHomeGeneralBtn.New()
    self.mailBtn:Init(self.ui.btn_Mail.gameObject)
    self.homeController:AddRedDotEvent(self.mailBtn:GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Mail)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  self.mailBtn:RefeshUnlockInfo(isUnlock)
  local moveX = 0
  local mailActive = self.ui.btn_Mail.gameObject.activeSelf
  if not isUnlock and mailActive then
    moveX = 135
  elseif isUnlock and not mailActive then
    moveX = -135
  end
  local resPos = self.ui.obj_resourceGroup.transform.localPosition
  self.ui.obj_resourceGroup.transform.localPosition = Vector3.New(resPos.x + moveX, resPos.y, resPos.z)
  self.ui.btn_Mail.gameObject:SetActive(isUnlock)
end

function UINHomeUp:OnClickMail()
  if self.mailBtn.isUnlock then
    UIManager:ShowWindowAsync(UIWindowTypeID.Mail, function(win)
      if win ~= nil then
        self.homeUI:OpenOtherCoverWin()
        win:SetFromWhichUI(eBaseWinFromWhere.homeCorver)
      end
    end)
  end
end

function UINHomeUp:RefreshSettingBtn()
  if self.settingBtn == nil then
    self.settingBtn = UINHomeGeneralBtn.New()
    self.settingBtn:Init(self.ui.btn_Setting.gameObject)
    self.homeController:AddRedDotEvent(function(redDotCount)
      self.settingBtn:RefreshRedDot(redDotCount, true)
    end, RedDotStaticTypeId.Main, RedDotStaticTypeId.Setting)
  end
  local ok, settingNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Setting)
  local redDotCount = ok and settingNode:GetRedDotCount() or 0
  self.settingBtn:RefreshRedDot(redDotCount, true)
  self.settingBtn:RefeshUnlockInfo(true)
end

function UINHomeUp:OnClickSetting()
  UIManager:ShowWindowAsync(UIWindowTypeID.Setting, function(win)
    if win ~= nil then
      self.homeUI:OpenOtherCoverWin()
      win:SetFromWhichUI(eBaseWinFromWhere.homeCorver)
      win:InitSettingByFrom(UIWindowTypeID.homeCorver)
    end
  end)
end

function UINHomeUp:OnClickUserInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfo, function(win)
    if win ~= nil then
      self.homeUI:OpenOtherWin()
      win:SetFromWhichUI(eBaseWinFromWhere.home)
      win:InitUserInfo()
    end
  end)
end

function UINHomeUp:OnDelete()
  self.resourceGroup:Delete()
  base.OnDelete(self)
end

return UINHomeUp
