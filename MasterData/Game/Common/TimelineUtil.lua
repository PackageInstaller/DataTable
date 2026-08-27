TimelineUtil = {}
local cs_coroutine = require("XLua.Common.cs_coroutine")

function TimelineUtil.Rewind(director, endEvent, endNoStop, startWithCurrent, useUnscaledTime, updateCallback)
  startWithCurrent = startWithCurrent or false
  useUnscaledTime = useUnscaledTime or false
  endNoStop = endNoStop or false
  return cs_coroutine.start(function()
    if not startWithCurrent then
      director.time = director.duration
    end
    director.initialTime = director.duration
    director:Evaluate()
    coroutine.yield(nil)
    while director.time > 0 do
      local curDeltaTime = useUnscaledTime and Time.unscaledDeltaTime or Time.deltaTime
      director.time = director.time - curDeltaTime
      if director.time < 0 then
        director.time = 0
      end
      director:Evaluate()
      if updateCallback ~= nil then
        updateCallback()
      end
      coroutine.yield(nil)
    end
    if endEvent ~= nil then
      endEvent()
    end
    if not endNoStop then
      director:Stop()
    end
  end)
end

function TimelineUtil.Play(director, endEvent, startWithCurrent, endNoStop, useUnscaledTime, updateCallback, playRate)
  useUnscaledTime = useUnscaledTime or false
  startWithCurrent = startWithCurrent or false
  endNoStop = endNoStop or false
  director.initialTime = -1
  return cs_coroutine.start(function()
    local duration = director.duration
    if not startWithCurrent then
      director.time = 0
      director:Evaluate()
      coroutine.yield(nil)
    end
    while duration > director.time do
      local curDeltaTime = useUnscaledTime and Time.unscaledDeltaTime or Time.deltaTime
      curDeltaTime = curDeltaTime * (playRate or 1)
      director.time = director.time + curDeltaTime
      if duration < director.time then
        director.time = duration
      end
      director:Evaluate()
      if updateCallback ~= nil then
        updateCallback()
      end
      coroutine.yield(nil)
    end
    if endEvent ~= nil then
      endEvent()
    end
    if not endNoStop then
      director:Stop()
    end
  end)
end

function TimelineUtil.StopTlCo(coroutine)
  cs_coroutine.stop(coroutine)
end

function TimelineUtil.StopAll()
  cs_coroutine.stopall()
end
