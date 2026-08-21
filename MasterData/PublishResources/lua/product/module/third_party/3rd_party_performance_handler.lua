if H3DGCloudLuaHelper.MsdkStatus ~= MSDKStatus.MS_Inland then
  return
end
_class("ThirdPartyPerfHandler", Object)
ThirdPartyPerfHandler = ThirdPartyPerfHandler
local GPM = GCloud.GPM.GPMAgent
local GameDataKey = GCloud.TGPA.GameDataKey

function ThirdPartyPerfHandler:Constructor()
  GPM.InitContext(EngineGameHelper.GCloudGameID, App.IsDevelopmentVersion)
  GPM.UpdateGameInfo(GCloud.TGPA.GameDataKey.HeavyThreadTid, tostring(GPM.GetCurrentThreadTid()))
  local deviceClass = GPM.CheckDeviceClass("default")
  if deviceClass < 0 then
    Log.error("[GCloud-GPM] 获取机型档位错误，返回值为 " .. tostring(deviceClass))
  else
    EngineGameHelper.PerformanceLevel = deviceClass
    Log.info("[GCloud-GPM] 机型档位为：" .. tostring(DeviceInfoHub.PerfomanceLevel))
  end
end

function ThirdPartyPerfHandler:SyncOpenID(openID)
  GPM.SetOpenId(openID)
  GPM.UpdateGameInfo(GameDataKey.OpenID, openID)
  GPM.UpdateGameInfo(GameDataKey.MainVersion, EngineGameHelper.CurrentAppVersion())
  GPM.UpdateGameInfo(GameDataKey.SubVersion, EngineGameHelper.CurrentResVersion())
  GPM.UpdateGameInfo(GameDataKey.FPSTarget, "30")
  H3DGCloudLuaHelper.RegGPMNotifyCallback(function(jsonObj)
    local hasChanged = false
    if jsonObj.UnityJsonDict["1"] == "1" or jsonObj.UnityJsonDict["1"] == "3" then
      Log.info("[GCloud-GPM] 检测到设备因电量不足或其他原因降频，请调低性能设置。")
      EngineGameHelper.PerformanceLevel = EngineGameHelper.PerformanceLevel - 1
      hasChanged = true
    end
    if jsonObj.UnityJsonDict["1"] == "2" and jsonObj.UnityJsonDict["4"] == "2" then
      Log.info("[GCloud-GPM] 检测到设备因温度过高严重降频，请大幅调低性能设置。")
      EngineGameHelper.PerformanceLevel = EngineGameHelper.PerformanceLevel - 2
      hasChanged = true
    end
    if hasChanged then
      Log.info("[GCloud-GPM] 当前性能评级已调整为 " .. tostring(DeviceInfoHub.PerfomanceLevel))
    end
  end)
  GameGlobal.GameLogic().onLoadSceneBegin = function(sceneName)
    local curScene = UnityEngine.SceneManagement.SceneManager.GetActiveScene().name
    if curScene ~= sceneName then
      GPM.MarkLevelFin()
      GPM.MarkLevelLoad(sceneName)
      Log.info("[GCloud-GPM] 标记场景切换  " .. curScene .. " 到 " .. sceneName)
    end
  end
end
