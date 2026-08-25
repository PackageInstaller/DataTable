local ScreenUtils = System.NewClass("ScreenUtils")

function ScreenUtils.SetResolution(width, height)
  Logger.Info("ScreenUtils.SetResolution CS.UnityEngine.Screen.fullScreen ", CS.UnityEngine.Screen.fullScreen)
  ScreenUtils._SetResolution(width, height, CS.UnityEngine.Screen.fullScreen)
end

function ScreenUtils._SetResolution(width, height, isFullScreen)
  Logger.Info("ScreenUtils._SetResolution width, height, isFullScreen ", width, height, isFullScreen)
  CS.UnityEngine.Screen.SetResolution(width, height, isFullScreen)
end

function ScreenUtils.SetFullScreen(isFullScreen)
  if CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.WindowsPlayer then
    return
  end
  ScreenUtils._SetFullscreen(isFullScreen)
end

function ScreenUtils._SetFullscreen(boolVal)
  Logger.Info("ScreenUtils._SetFullscreen boolVal ", boolVal)
  CS.UnityEngine.Screen.fullScreen = boolVal
end

function ScreenUtils.IsAlwaysFullScreen()
  return CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.WindowsPlayer or CS.UnityEngine.Screen.fullScreen
end

return ScreenUtils
