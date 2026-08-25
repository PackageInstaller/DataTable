local SleepTimeOutUtils = {}
local unity = CS.UnityEngine

function SleepTimeOutUtils.SetNeverSleep()
  unity.Screen.sleepTimeout = unity.SleepTimeout.NeverSleep
end

function SleepTimeOutUtils.SetSystemSetting()
  unity.Screen.sleepTimeout = unity.SleepTimeout.SystemSetting
end

return SleepTimeOutUtils
