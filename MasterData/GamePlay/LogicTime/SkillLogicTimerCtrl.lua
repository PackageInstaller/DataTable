local SkillLogicTimerCtrl = class("LuaSkillTimerCtrl")
local SkillLogicTimer = require("GamePlay.LogicTime.SkillLogicTimer")

function SkillLogicTimerCtrl:ctor()
  self.__pool = {}
  self.__logic_timer = {}
  self.__logic_toadd = {}
end

local function InnerGetTimer(self, delay, func, obj, is_loop, start_time)
  local timer
  if table.length(self.__pool) > 0 then
    timer = table.remove(self.__pool)
    if delay and func then
      timer:Init(delay, func, obj, is_loop, start_time)
    end
  else
    timer = SkillLogicTimer.New(delay, func, obj, is_loop, start_time)
  end
  return timer
end

local function DelayRecycle(self, timers)
  if timers == nil or #timers <= 0 then
    return
  end
  for i = #timers, 1, -1 do
    local curTimer = timers[i]
    if curTimer:IsOver() then
      curTimer:Stop()
      table.remove(timers, i)
      curTimer:RecycleInLuaSkill()
    end
  end
end

function SkillLogicTimerCtrl:OnUpdateLogic()
  for i = #self.__logic_toadd, 1, -1 do
    table.insert(self.__logic_timer, self.__logic_toadd[i])
    table.remove(self.__logic_toadd, i)
  end
  for _, timer in ipairs(self.__logic_timer) do
    timer:Update()
  end
  DelayRecycle(self, self.__logic_timer)
end

function SkillLogicTimerCtrl:GetTimer(delay, func, obj, is_loop, start_time)
  local timer = InnerGetTimer(self, delay, func, obj, is_loop, start_time)
  table.insert(self.__logic_toadd, timer)
  return timer
end

local function RecycleAllTimer(self, timers)
  for i = #timers, 1, -1 do
    timers[i]:Stop()
    table.remove(timers, i)
  end
end

function SkillLogicTimerCtrl:StopAllTimer()
  RecycleAllTimer(self, self.__logic_toadd)
  RecycleAllTimer(self, self.__logic_timer)
end

return SkillLogicTimerCtrl
