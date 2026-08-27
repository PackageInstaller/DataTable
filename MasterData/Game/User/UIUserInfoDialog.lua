local UIUserInfoDialog = class("UIUserInfoDialog", UIBaseWindow)
local base = UIBaseWindow
local UINChangeName = require("Game.User.Dialogs.UIChangeName")
local UINChangeUserHead = require("Game.User.Dialogs.UIChangeUserHead")
local UINChangeDressUp = require("Game.User.Dialogs.UIChangeDressUp")
local UINChangePro = require("Game.User.Dialogs.UINChangePro")
local UINChangeUserTitle = require("Game.User.Dialogs.UIChangeUserTitle")

function UIUserInfoDialog:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.Cancle)
  self.ui.changeName:SetActive(false)
  self.ui.changeUserHead:SetActive(false)
  self.ui.changeDressUp:SetActive(false)
  self.ui.changeChangePro:SetActive(false)
  self.ui.changeUserTitle:SetActive(false)
  UIUtil.SetTopStatus(self, self.BackAction)
end

function UIUserInfoDialog:OpenChangeNameDialogFromStore()
  UIUtil.HideTopStatus()
  if self.changeName == nil then
    self.changeName = UINChangeName.New()
    self.changeName.CloseFunction = BindCallback(self, self.Cancle)
    self.changeName:Init(self.ui.changeName)
  end
  self.changeName.isFromStore = true
  self.changeName:Show()
end

function UIUserInfoDialog:OpenChangeNameDialog()
  UIUtil.HideTopStatus()
  if self.changeName == nil then
    self.changeName = UINChangeName.New()
    self.changeName.CloseFunction = BindCallback(self, self.Cancle)
    self.changeName:Init(self.ui.changeName)
  end
  self.changeName.isFromStore = false
  self.changeName:Show()
end

function UIUserInfoDialog:OpenChangeUserHeadDialog()
  UIUtil.HideTopStatus()
  if self.changeUserHead == nil then
    self.changeUserHead = UINChangeUserHead.New()
    self.changeUserHead:Init(self.ui.changeUserHead)
    self.changeUserHead:BindCloseFun(BindCallback(self, self.Cancle))
  end
  self.changeUserHead:Show()
end

function UIUserInfoDialog:OpenChangeDressUpDialog()
  UIUtil.HideTopStatus()
  if self.changeDressUp == nil then
    self.changeDressUp = UINChangeDressUp.New()
    self.changeDressUp:Init(self.ui.changeDressUp)
  end
  self.changeDressUp:RefreshChangeDressUp(BindCallback(self, self.Cancle))
end

function UIUserInfoDialog:OpenChangePro()
  GameGlobalUtil.InitCustomLightingGlobalValue()
  UIUtil.HideTopStatus()
  if self.changePro == nil then
    self.changePro = UINChangePro.New()
    self.changePro:Init(self.ui.changeChangePro)
  end
  self.changePro:_ShowUI()
  self.changePro:BindCloseFun(BindCallback(self, self.Cancle))
end

function UIUserInfoDialog:OpenChangeUserTitle(exUserTitleChangeCallback)
  UIUtil.HideTopStatus()
  if self.changeUserTitle == nil then
    self.changeUserTitle = UINChangeUserTitle.New()
    self.changeUserTitle:Init(self.ui.changeUserTitle)
    self.changeUserTitle:SetExUserTitleChangeCallback(exUserTitleChangeCallback)
  end
  self.changeUserTitle:BindCloseFun(BindCallback(self, self.Cancle))
  self.changeUserTitle:SetToggleGroupAllowSwitchOff(true)
  self.changeUserTitle:Show()
  self.changeUserTitle:InitChangeUserTitle()
  self.changeUserTitle:SetToggleGroupAllowSwitchOff(false)
end

function UIUserInfoDialog:BackAction()
  self:OnCloseWin()
  self:Delete()
end

function UIUserInfoDialog:Cancle()
  UIUtil.OnClickBackByUiTab(self)
end

function UIUserInfoDialog:OnShow()
  base.OnShow(self)
  AudioManager:PlayAudioById(1066)
end

function UIUserInfoDialog:OnDelete()
  UIUtil.ReShowTopStatus()
  if self.changeName ~= nil then
    self.changeName:Delete()
  end
  if self.changeUserHead ~= nil then
    self.changeUserHead:Delete()
  end
  if self.changeDressUp ~= nil then
    self.changeDressUp:Delete()
  end
  if self.changePro ~= nil then
    self.changePro:Delete()
  end
  if self.changeUserTitle ~= nil then
    self.changeUserTitle:Delete()
  end
  base.OnDelete(self)
end

return UIUserInfoDialog
