local DailyAttendanceHelper = {}
local MINIMUM_CHECK_INTERVAL_SECONDS = 600
local lastSignInCheckTime = 0
local lastSignInCheckHour = -1

function DailyAttendanceHelper.CheckFrequencyLimit()
  if not CommonTips.IsResEN() then
    return true
  end
  local currentTime = TimeUtil:GetServerTimeStamp()
  local timeTable = TimeUtil:GetServerDayTableWith5AM()
  local currentHour = timeTable.hour
  if currentHour == lastSignInCheckHour and currentTime - lastSignInCheckTime < MINIMUM_CHECK_INTERVAL_SECONDS then
    return false
  end
  lastSignInCheckTime = currentTime
  lastSignInCheckHour = currentHour
  return true
end

return DailyAttendanceHelper
