local UINNavSpecialUIBase = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpecialUIBase")
local UINNavSpecialSectorActivity = class("UINNavSpecialSectorActivity", UINNavSpecialUIBase)
local base = UINNavSpecialUIBase
local ActEntryEnum = require("Game.Home.UI.Side.Enum.ActEntryEnum")
local JumpManager = require("Game.Jump.JumpManager")
local UINHomeActivityEntryList = require("Game.Home.UI.Side.UINHomeActivityEntryList")

function UINNavSpecialSectorActivity:OnInit()
  base.OnInit(self)
  self.activityEntry = UINHomeActivityEntryList.New()
  self.activityEntry:Init(self.ui.activityEntry)
  self.activityEntry:BindingEntryCountChange(BindCallback(self, self.__RefreshByEntryCount))
  self.activityEntry:BingEntryJumpCallback(BindCallback(self, self.__OnClickedEntry))
end

function UINNavSpecialSectorActivity.GetSpecialUI(item, go, resloader)
  local specialUI = base.GetSpecialUI(UINNavSpecialSectorActivity, item, go)
  specialUI.resloader = resloader
  specialUI:InitSpcSectorActivityUI()
  return specialUI
end

function UINNavSpecialSectorActivity:InitSpcSectorActivityUI()
  self.activityEntry:InitHomeActivityEntryList(ActEntryEnum.EnterWay.TopNav)
end

function UINNavSpecialSectorActivity:__RefreshByEntryCount(count)
  if 0 < count then
    self:Show()
  else
    self:Hide()
  end
end

function UINNavSpecialSectorActivity:__OnClickedEntry()
  local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if win ~= nil then
    win:HideNavigation()
  end
end

function UINNavSpecialSectorActivity:OnDelete()
  self.activityEntry:Delete()
  base.OnDelete(self)
end

return UINNavSpecialSectorActivity
