local Messenger = require("Framework.Common.Messenger")
local Timer = require("Framework.Time.Timer")
local TimerManager = class("TiemrManager")

function TimerManager:ctor()
  self.__update_handle = nil
  self.__lateupdate_handle = nil
  self.__fixedupdate_handle = nil
  self.__coupdate_handle = nil
  self.__colateupdate_handle = nil
  self.__cofixedupdate_handle = nil
  self.__update_timer = {}
  self.__lateupdate_timer = {}
  self.__fixedupdate_timer = {}
  self.__coupdate_timer = {}
  self.__colateupdate_timer = {}
  self.__cofixedupdate_timer = {}
  self.__pool = {}
  self.__update_toadd = {}
  self.__lateupdate_toadd = {}
  self.__fixedupdate_toadd = {}
  self.__coupdate_toadd = {}
  self.__colateupdate_toadd = {}
  self.__cofixedupdate_toadd = {}
  self.__lateCommand = {}
  self.started = false
  self.__incId = 0
end

local function DelayRecycle(self, timers)
  for id, timer in pairs(timers) do
    if timer:IsOver() then
      timer:Stop()
      table.insert(self.__pool, timer)
      timers[id] = nil
    end
  end
end

local function UpdateHandle(self)
  for id, timer in pairs(self.__update_timer) do
    timer:Update(false)
  end
  DelayRecycle(self, self.__update_timer)
end

local function LateUpdateHandle(self)
  for id, timer in pairs(self.__lateupdate_timer) do
    timer:Update(false)
  end
  DelayRecycle(self, self.__lateupdate_timer)
  for id, timer in pairs(self.__update_toadd) do
    self.__update_timer[id] = timer
    self.__update_toadd[id] = nil
  end
  for id, timer in pairs(self.__lateupdate_toadd) do
    self.__lateupdate_timer[id] = timer
    self.__lateupdate_toadd[id] = nil
  end
  while #self.__lateCommand > 0 do
    local func = table.remove(self.__lateCommand, 1)
    local status, err = xpcall(func, debug.traceback)
    if not status then
      error(err)
    end
  end
end

local function FixedUpdateHandle(self)
  for id, timer in pairs(self.__fixedupdate_timer) do
    timer:Update(true)
  end
  DelayRecycle(self, self.__fixedupdate_timer)
  for id, timer in pairs(self.__fixedupdate_toadd) do
    self.__fixedupdate_timer[id] = timer
    self.__fixedupdate_toadd[id] = nil
  end
end

function TimerManager:Start()
  if self.started then
    return
  end
  self.started = true
  self.__update_handle = UpdateBeat:CreateListener(UpdateHandle, self)
  self.__lateupdate_handle = LateUpdateBeat:CreateListener(LateUpdateHandle, self)
  self.__fixedupdate_handle = FixedUpdateBeat:CreateListener(FixedUpdateHandle, self)
  UpdateBeat:AddListener(self.__update_handle)
  LateUpdateBeat:AddListener(self.__lateupdate_handle)
  FixedUpdateBeat:AddListener(self.__fixedupdate_handle)
end

function TimerManager:Stop()
  if not self.started then
    return
  end
  self.started = false
  if self.__update_handle ~= nil then
    UpdateBeat:RemoveListener(self.__update_handle)
    self.__update_handle = nil
  end
  if self.__lateupdate_handle ~= nil then
    LateUpdateBeat:RemoveListener(self.__lateupdate_handle)
    self.__lateupdate_handle = nil
  end
  if self.__fixedupdate_handle ~= nil then
    FixedUpdateBeat:RemoveListener(self.__fixedupdate_handle)
    self.__fixedupdate_handle = nil
  end
end

function TimerManager:Cleanup(self)
  self.__update_timer = {}
  self.__lateupdate_timer = {}
  self.__fixedupdate_timer = {}
  self.__pool = {}
  self.__update_toadd = {}
  self.__lateupdate_toadd = {}
  self.__fixedupdate_toadd = {}
end

local function InnerGetTimer(self, delay, func, obj, one_shot, use_frame, unscaled)
  local timer
  if table.length(self.__pool) > 0 then
    timer = table.remove(self.__pool)
    if delay and func then
      timer:Init(delay, func, obj, one_shot, use_frame, unscaled)
    end
  else
    timer = Timer.New(delay, func, obj, one_shot, use_frame, unscaled)
  end
  return timer
end

function TimerManager:StartTimer(delay, func, obj, one_shot, use_frame, unscaled)
  assert(not self.__update_timer[timer] and not self.__update_toadd[timer])
  local timer = InnerGetTimer(self, delay, func, obj, one_shot, use_frame, unscaled)
  local id = self:__GenerateTimerId()
  self.__update_toadd[id] = timer
  timer:Start()
  return id
end

function TimerManager:StopTimer(id)
  if id == nil then
    return true
  end
  local timer = self:__GetUpdateTimer(id)
  if timer ~= nil then
    timer:Stop()
    return true
  end
  return false
end

function TimerManager:PauseTimer(id)
  local timer = self:__GetUpdateTimer(id)
  if timer ~= nil then
    timer:Pause()
    return true
  end
  return false
end

function TimerManager:ResumeTimer(id)
  local timer = self:__GetUpdateTimer(id)
  if timer ~= nil then
    timer:Resume()
    return true
  end
  return false
end

function TimerManager:IsTimerPaused(id)
  local timer = self:__GetUpdateTimer(id)
  if timer ~= nil then
    return not timer.started
  end
  return nil
end

function TimerManager:ResetTimer(id)
  local timer = self:__GetUpdateTimer(id)
  if timer ~= nil then
    timer:Reset()
    return true
  end
  return false
end

function TimerManager:ContainTimer(id)
  return self:__GetUpdateTimer(id) ~= nil
end

function TimerManager:__GenerateTimerId()
  self.__incId = self.__incId + 1
  return self.__incId
end

function TimerManager:__GetUpdateTimer(id)
  if id == nil then
    return nil
  end
  local timer = self.__update_timer[id]
  if timer ~= nil then
    return timer
  end
  timer = self.__update_toadd[id]
  return timer
end

function TimerManager:AddLateCommand(func)
  table.insert(self.__lateCommand, func)
end

function TimerManager:ClearCommand()
  self.__lateCommand = {}
end

function TimerManager:CleanAllUpdateTimer()
  for id, timer in pairs(self.__update_timer) do
    if timer ~= nil then
      timer:Stop()
    end
  end
  for id, timer in pairs(self.__update_toadd) do
    if timer ~= nil then
      timer:Stop()
    end
  end
end

return TimerManager
