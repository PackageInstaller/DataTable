local UINNavSpecialUIBase = class("UINNavSpecialUIBase", UIBaseNode)
local base = UIBaseNode

function UINNavSpecialUIBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if UINNavSpecialUIBase.TimerId == nil then
    UINNavSpecialUIBase.TimerFuncs = {}
    UINNavSpecialUIBase.TimerId = TimerManager:StartTimer(1, UINNavSpecialUIBase.__NavSpecialUIBaseTimer, nil, false)
  end
end

function UINNavSpecialUIBase.GetSpecialUI(class, item, go)
  local newGo = go:Instantiate()
  local specialUI = class.New()
  specialUI:Init(newGo)
  specialUI:SetSpecialUI2Parent(item)
  return specialUI
end

function UINNavSpecialUIBase.__NavSpecialUIBaseTimer()
  for func, _ in pairs(UINNavSpecialUIBase.TimerFuncs) do
    func()
  end
end

function UINNavSpecialUIBase.__Add2TimerFuncs(func)
  UINNavSpecialUIBase.TimerFuncs[func] = true
end

function UINNavSpecialUIBase.__RemoveFromTimerFuncs(func)
  UINNavSpecialUIBase.TimerFuncs[func] = nil
end

function UINNavSpecialUIBase.CleanSpecialUIBaseTimer()
  UINNavSpecialUIBase.TimerFuncs = {}
  if UINNavSpecialUIBase.TimerId ~= nil then
    TimerManager:StopTimer(UINNavSpecialUIBase.TimerId)
    UINNavSpecialUIBase.TimerId = nil
  end
end

function UINNavSpecialUIBase.PauseSpecialUIBaseTimer()
  TimerManager:PauseTimer(UINNavSpecialUIBase.TimerId)
end

function UINNavSpecialUIBase.ResumeSpecialUIBaseTimer()
  UINNavSpecialUIBase.__NavSpecialUIBaseTimer()
  TimerManager:ResumeTimer(UINNavSpecialUIBase.TimerId)
end

function UINNavSpecialUIBase:SetSpecialUI2Parent(item)
  self.transform:SetParent(item.transform, false)
end

function UINNavSpecialUIBase:OnDelete()
  base.OnDelete(self)
end

return UINNavSpecialUIBase
