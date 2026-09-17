local this = class("conditionNode_1100", require(L_R.condition .. "conditionNode"))

function this:ctor(condition)
  this.super.ctor(self, condition)
  C_WorldEvent.instance:Listen(C_EWorldEvent.OnTimeHourChange, self.refresh)
  self.autoDestroy = false
end

function this:onDestroy()
  this.super.onDestroy(self)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.OnTimeHourChange, self.refresh)
end

function this.checkFunc(codData)
  local hour = C_GameTime.GetNowHour()
  local startHour = codData[2]
  local endHour = codData[3]
  if startHour > endHour then
    return hour < endHour or hour >= startHour
  else
    return hour >= startHour and hour < endHour
  end
end

return this
