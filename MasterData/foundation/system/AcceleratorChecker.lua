local Type = CS.System.Type
local TimeUtil = CS.Framework.TimeUtil
local TypeOfTime = Type.GetType("UnityEngine.Time, UnityEngine.CoreModule")
local PropertyTimeScale = TypeOfTime:GetProperty("timeScale")
local M = {
  _counter = 5,
  _lastTimestamp = 0,
  _cheatingDetected = false
}

function M.Init()
  EventMgr.Instance.OnHeartbeatResponse:RegisterEvent(function(timestamp, interval)
    if not M._cheatingDetected then
      if interval > timestamp - M._lastTimestamp then
        M._counter = M._counter - 1
        if 0 == M._counter then
          M._cheatingDetected = true
          M._UploadLog()
        end
      end
      M._lastTimestamp = timestamp
    end
  end)
end

function M.Update()
  if not M._cheatingDetected then
    local timeScale_1 = PropertyTimeScale:GetValue(nil, nil)
    local timeScale_2 = TimeUtil.GetTimeScale()
    if math.abs(timeScale_1 - timeScale_2) > 0.001 then
      M._cheatingDetected = true
      M._UploadLog()
    end
  end
end

function M._UploadLog()
  Logger.ReportApusInfo("检测到可能的作弊！{type}", "加速器")
end

return M
