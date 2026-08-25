local TimerManager, Super = System.NewClass("TimerManager", Manager, IUpdater)
TimerManager.deltaTime = 0
TimerManager.totalTime = 0

function TimerManager:ctor()
  Super.ctor(self)
end

function TimerManager:Awake()
  Super.Awake(self)
  self.timerId = 0
  self.timerContainer = {}
  self.stopContainer = {}
end

function TimerManager:Update()
  for _, value in ipairs(self.stopContainer) do
    self.timerContainer[value] = nil
  end
  table.clear(self.stopContainer)
  for _, value in pairs(self.timerContainer) do
    value:Update()
  end
end

function TimerManager:OnDestroy()
  for _, value in pairs(self.timerContainer) do
    value:stop()
  end
  self.timerContainer = {}
  Super.OnDestroy(self)
end

function TimerManager:CreateTimer(duration, repeatTimes, repeatCallback, finishCallback)
  local id = self:IncreaseTimerId()
  local timeAction = Timer(duration, repeatTimes)
  self.timerContainer[id] = timeAction
  timeAction.on_key_frame = repeatCallback
  
  function timeAction.on_end()
    if finishCallback then
      finishCallback()
    end
    self:StopTimer(id)
  end
  
  timeAction:play()
  return id
end

function TimerManager:StopTimer(id)
  if id and self.timerContainer[id] ~= nil and self.timerContainer[id]:isRunning() then
    self.timerContainer[id]:stop()
    table.insert(self.stopContainer, id)
  end
end

function TimerManager:CreateCountDown(totalSecond, tickFunc, finishFunc, precision)
  local beginTime = TimeUtils.GetRealTime()
  local timer
  local executed = {}
  
  local function repeatFunc()
    local curTime = TimeUtils.GetRealTime()
    local leftSecond = math.ceil(totalSecond - (curTime - beginTime))
    if not executed[leftSecond] and leftSecond >= 0 then
      executed[leftSecond] = true
      tickFunc(leftSecond)
    end
    if leftSecond < 0 then
      if finishFunc then
        finishFunc()
      end
      self:StopTimer(timer)
    end
  end
  
  repeatFunc()
  timer = self:CreateTimer(precision or 0.3, -1, repeatFunc)
  return timer
end

function TimerManager:IncreaseTimerId()
  self.timerId = self.timerId + 1
  return self.timerId
end

return TimerManager
