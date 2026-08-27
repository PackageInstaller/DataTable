local UINNavSpecialUIBase = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpecialUIBase")
local UINNavSpeciaLotteryMarker = class("UINNavSpeciaLotteryMarker", UINNavSpecialUIBase)
local base = UINNavSpecialUIBase

function UINNavSpeciaLotteryMarker:OnInit()
  base.OnInit(self)
  self.__RefreshMarker = BindCallback(self, self.RefreshMarker)
end

function UINNavSpeciaLotteryMarker.GetSpecialUI(item, go, resloader)
  local specialUI = base.GetSpecialUI(UINNavSpeciaLotteryMarker, item, go)
  specialUI.item = item
  specialUI.resloader = resloader
  specialUI:RefreshMarker()
  base.__Add2TimerFuncs(specialUI.__RefreshMarker)
  return specialUI
end

function UINNavSpeciaLotteryMarker:RefreshMarker()
  if not self.item:GetNBBIsUnlock() then
    self.gameObject:SetActive(false)
    return
  else
    self.gameObject:SetActive(true)
  end
  local maxLtrCfg = PlayerDataCenter.allLtrData:GetMaxPriorityLtrCfg()
  if maxLtrCfg ~= nil then
    self.gameObject:SetActive(true)
    self.ui.tex_Tips.text = LanguageUtil.GetLocaleText(maxLtrCfg.nav_tagName)
    self.ui.img_Icon:SetIndex(maxLtrCfg.nav_tagIcon)
  else
    self.gameObject:SetActive(false)
  end
end

function UINNavSpeciaLotteryMarker:OnDelete()
  base.__RemoveFromTimerFuncs(self.__RefreshMarker)
  base.OnDelete(self)
end

return UINNavSpeciaLotteryMarker
