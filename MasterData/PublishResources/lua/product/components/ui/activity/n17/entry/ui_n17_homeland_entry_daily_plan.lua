_class("UIN17HomelandEntryDailyPlan", Object)
UIN17HomelandEntryDailyPlan = UIN17HomelandEntryDailyPlan

function UIN17HomelandEntryDailyPlan:Constructor(campaign)
  self._campaign = campaign
end

function UIN17HomelandEntryDailyPlan:GetNew()
  return false
end

function UIN17HomelandEntryDailyPlan:GetRedCount()
  return 0
end

function UIN17HomelandEntryDailyPlan:OpenUI()
  GameGlobal.UIStateManager():ShowDialog("UIN17DailyPlanController", true)
end
