local UINNavSpecialUIBase = require("Game.TopStatus.Navigation.SpecialUI.UINNavSpecialUIBase")
local UINNavSpeciaFactoryTimer = class("UINNavSpeciaFactoryTimer", UINNavSpecialUIBase)
local base = UINNavSpecialUIBase

function UINNavSpeciaFactoryTimer:OnInit()
  base.OnInit(self)
  self.__FreshFactoryTime = BindCallback(self, self.FreshFactoryTime)
end

function UINNavSpeciaFactoryTimer.GetSpecialUI(item, go, resloader)
  local specialUI = base.GetSpecialUI(UINNavSpeciaFactoryTimer, item, go)
  specialUI:FreshFactoryTime()
  base.__Add2TimerFuncs(specialUI.__FreshFactoryTime)
  return specialUI
end

function UINNavSpeciaFactoryTimer:FreshFactoryTime()
  local factoryEnergyItemId = ConfigData.game_config.factoryEnergyItemId
  local num, nextTime = PlayerDataCenter.allEffectorData:GetCurrentARGNum(factoryEnergyItemId)
  local speed = PlayerDataCenter.allEffectorData:GetCurrentARGSpeed(factoryEnergyItemId)
  local ceiling = PlayerDataCenter.allEffectorData:GetCurrentARGCeiling(factoryEnergyItemId)
  local isCanCountdown = num < ceiling and 0 < speed
  self.gameObject:SetActive(isCanCountdown)
  if isCanCountdown then
    self.ui.tex_Timer.text = TimeUtil:TimestampToTime((ceiling - num - 1) / speed + nextTime)
  end
end

function UINNavSpeciaFactoryTimer:OnDelete()
  base.__RemoveFromTimerFuncs(self.__FreshFactoryTime)
  base.OnDelete(self)
end

return UINNavSpeciaFactoryTimer
