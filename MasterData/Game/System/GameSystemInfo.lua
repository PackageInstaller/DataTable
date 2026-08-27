local GameSystemInfo = {}
local cs_platform = GR.EnumToInt(CS.UnityEngine.Application.platform)
GameSystemInfo.PlatformType = {
  Windows = 1,
  Mac = 2,
  Android = 3,
  iOS = 4
}
if cs_platform == 11 then
  GameSystemInfo.Platform = GameSystemInfo.PlatformType.Android
elseif cs_platform == 8 then
  GameSystemInfo.Platform = GameSystemInfo.PlatformType.iOS
elseif cs_platform == 0 or cs_platform == 1 then
  GameSystemInfo.Platform = GameSystemInfo.PlatformType.Mac
else
  GameSystemInfo.Platform = GameSystemInfo.PlatformType.Windows
end
local CS_PlayerPrefs = CS.UnityEngine.PlayerPrefs
local PlayerPrefsConsts = require("Game.Login.PlayerPrefsEnum")
local CS_SystemInfo = CS.UnityEngine.SystemInfo
local CS_MTPManager = CS.MTPManager.Instance

function GameSystemInfo.InitDefaultPerformance()
  if CS_MTPManager.isSimulator then
    GameSystemInfo.__SetDefaultPerformance(5, 4, true)
    return
  end
  local performanceId = CS_PlayerPrefs.GetInt(PlayerPrefsConsts.DefaultPerformanceId)
  local preGuideDefaultPerformanceId = CS_PlayerPrefs.GetInt(PlayerPrefsConsts.PreGuideDefaultPerformanceId)
  if 0 < performanceId and 0 < preGuideDefaultPerformanceId then
    GameSystemInfo.__SetDefaultPerformance(performanceId, preGuideDefaultPerformanceId, false)
    return
  else
    local deviceModel = CS_SystemInfo.deviceModel
    if not string.IsNullOrEmpty(deviceModel) then
      deviceModel = string.lower(deviceModel)
      local deviceModelConfig = ConfigData.performance_device[deviceModel]
      if deviceModelConfig ~= nil and 0 < deviceModelConfig.level_id and 0 < deviceModelConfig.pre_level_id then
        GameSystemInfo.__SetDefaultPerformance(deviceModelConfig.level_id, deviceModelConfig.pre_level_id, true)
        return
      end
      if string.contains(deviceModel, ",") then
        local listDevice = string.split(deviceModel, ",")
        if 2 <= #listDevice and not string.IsNullOrEmpty(listDevice[1]) then
          local devicePrefix = listDevice[1]
          deviceModelConfig = ConfigData.performance_device[devicePrefix]
          if deviceModelConfig ~= nil and 0 < deviceModelConfig.level_id and 0 < deviceModelConfig.pre_level_id then
            GameSystemInfo.__SetDefaultPerformance(deviceModelConfig.level_id, deviceModelConfig.pre_level_id, true)
            return
          end
        end
      end
    end
    local graphicsDeviceName = CS_SystemInfo.graphicsDeviceName
    if not string.IsNullOrEmpty(graphicsDeviceName) then
      graphicsDeviceName = string.lower(graphicsDeviceName)
      local graphicsDeviceConfig = ConfigData.performance_gpu[graphicsDeviceName]
      if graphicsDeviceConfig ~= nil and 0 < graphicsDeviceConfig.level_id and 0 < graphicsDeviceConfig.pre_level_id then
        GameSystemInfo.__SetDefaultPerformance(graphicsDeviceConfig.level_id, graphicsDeviceConfig.pre_level_id, true)
        return
      end
    end
    local systemMemorySize = CS_SystemInfo.systemMemorySize
    if systemMemorySize < 1600 then
      GameSystemInfo.__SetDefaultPerformance(1, 1, true)
      return
    end
    local supportsInstancing = CS_SystemInfo.supportsInstancing
    if not supportsInstancing then
      GameSystemInfo.__SetDefaultPerformance(1, 1, true)
      return
    end
    local graphicsMultiThreaded = CS_SystemInfo.graphicsMultiThreaded
    if not graphicsMultiThreaded then
      GameSystemInfo.__SetDefaultPerformance(1, 1, true)
      return
    end
    local operatingSystemFamily = CS_SystemInfo.operatingSystemFamily:ToString()
    if operatingSystemFamily == "Windows" or operatingSystemFamily == "MacOSX" then
      GameSystemInfo.__SetDefaultPerformance(5, 4, true)
      return
    end
    local cpuFrequency = CS_SystemInfo.processorFrequency
    local cpuCount = CS_SystemInfo.processorCount
    if 2400 <= cpuFrequency and 6 <= cpuCount and 6000 < systemMemorySize then
      GameSystemInfo.__SetDefaultPerformance(4, 4, true)
      return
    end
    if (cpuFrequency < 2000 or cpuCount < 4) and systemMemorySize < 3000 then
      GameSystemInfo.__SetDefaultPerformance(1, 4, true)
      return
    end
    GameSystemInfo.__SetDefaultPerformance(3, 3, true)
  end
end

function GameSystemInfo.__SetDefaultPerformance(levelId, preLevelId, save)
  if save then
    CS_PlayerPrefs.SetInt(PlayerPrefsConsts.DefaultPerformanceId, levelId)
    CS_PlayerPrefs.SetInt(PlayerPrefsConsts.PreGuideDefaultPerformanceId, preLevelId)
  end
  GameSystemInfo.PerformanceLevelId = levelId
  GameSystemInfo.PreGuidePerformanceLevelId = preLevelId
end

function GameSystemInfo.GetDefaultPerformance()
  return GameSystemInfo.PerformanceLevelId
end

function GameSystemInfo.GetGuideDefaultPerformance()
  return GameSystemInfo.PreGuidePerformanceLevelId
end

function GameSystemInfo.IsMuMuSimulator()
  local isSimulator = CS_MTPManager.isSimulator
  local graphicsDeviceName = CS_SystemInfo.graphicsDeviceName
  local isMuMu = string.find(string.lower(graphicsDeviceName), "mumu gl") ~= nil
  return isMuMu and isSimulator
end

return GameSystemInfo
