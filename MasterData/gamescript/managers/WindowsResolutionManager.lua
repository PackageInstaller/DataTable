local WindowsResolutionManager, Super = System.NewClass("WindowsResolutionManager", Manager, IUpdater)
local CSScreen = CS.UnityEngine.Screen

function WindowsResolutionManager:ctor()
  Super.ctor(self)
end

function WindowsResolutionManager:Awake()
  Super.Awake(self)
  self._curScreenWidth = CSScreen.width
  self._curScreenHeight = CSScreen.height
  self._isFullScreen = CSScreen.fullScreen
end

function WindowsResolutionManager:Update()
  if self._curScreenWidth == CSScreen.width and self._curScreenHeight == CSScreen.height and self._isFullScreen == CSScreen.fullScreen then
    return
  end
  if not CSScreen.fullScreen then
    self._curScreenWidth = CSScreen.width
    self._curScreenHeight = CSScreen.height
  end
  self._isFullScreen = CSScreen.fullScreen
  if PerformanceManager.Instance then
    PerformanceManager.Instance.originScreenWidth = CSScreen.width
    PerformanceManager.Instance.originScreenHeight = CSScreen.height
    PerformanceManager.Instance.screenRatio = CSScreen.width / CSScreen.height
  end
  SettingManager.Instance:SaveResolution(self._curScreenWidth, self._curScreenHeight, self._isFullScreen)
  GlobalDispatcher:Dispatch(NotifyId.OnWindowsResolutionChange)
end

function WindowsResolutionManager:GetScreenWidth()
  return self._curScreenWidth
end

function WindowsResolutionManager:GetScreenHeight()
  return self._curScreenHeight
end

return WindowsResolutionManager
