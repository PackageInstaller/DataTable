local GetRealtimeSinceStartup = CS.Framework.TimeUtil.GetRealtimeSinceStartup
local MaxResolution = 1080
local MinClampResolution = 720
local PerformanceManager, Super = System.NewClass("PerformanceManager", Manager, IUpdater)

function PerformanceManager:ctor()
  Super.ctor(self)
end

function PerformanceManager:Awake()
  Super.Awake(self)
  self.originScreenWidth = CS.UnityEngine.Screen.width
  self.originScreenHeight = CS.UnityEngine.Screen.height
  self.resolutionPercent = 1.0
  self.screenRatio = self.originScreenWidth / self.originScreenHeight
  Logger.Debug("#初始化 真机性能管理器：管理屏幕分辨率、帧率、资源精度等")
  self:InitFPS()
  self:InitGCInfo()
  self:InitScreenRatio()
  self:InitQualityLevel()
end

function PerformanceManager:OnDestroy()
  self.resolutionPercent = 1.0
  Super.OnDestroy(self)
end

function PerformanceManager:Update()
  self:UpdateFPS()
  self:UpdateGCInfo()
end

function PerformanceManager:InitScreenRatio()
  Logger.Debug("#原生屏幕分辨率", CS.UnityEngine.Screen.width, CS.UnityEngine.Screen.height)
  self.screenRatio = CS.UnityEngine.Screen.width / CS.UnityEngine.Screen.height
end

function PerformanceManager:ChangeScreenResolutionByHeight(targetHeight, screenWidth, screenHeight)
  if not (targetHeight and screenWidth) or not screenHeight then
    return
  end
  Logger.Info("PerformanceManager:ChangeScreenResolutionByHeight targetHeight, screenWidth, screenHeight ", targetHeight, screenWidth, screenHeight)
  local scale = targetHeight / MaxResolution
  local screenRatio = screenWidth / screenHeight
  local height = math.min(screenHeight, math.max(MinClampResolution, math.floor(screenHeight * scale + 0.5)))
  local width = math.min(screenWidth, math.floor(height * screenRatio + 0.5))
  self.resolutionPercent = scale
  ScreenUtils.SetResolution(width, height)
end

function PerformanceManager:GetScreenRatio()
  return self.screenRatio
end

function PerformanceManager:InitFPS()
  self.lastUpdateFpsTime = GetRealtimeSinceStartup()
  self.frameCount = 0
  self._fps = 0
end

function PerformanceManager:GetFPS()
  return self._fps
end

function PerformanceManager:UpdateFPS()
  self.frameCount = self.frameCount + 1
  local realtimeSinceStartup = GetRealtimeSinceStartup()
  local interval = 0.5
  if interval <= realtimeSinceStartup - self.lastUpdateFpsTime then
    self._fps = math.ceil(self.frameCount / (realtimeSinceStartup - self.lastUpdateFpsTime))
    EventMgr.Instance.GMFPS:Dispatch(self._fps)
    self.lastUpdateFpsTime = realtimeSinceStartup
    self.frameCount = 0
  end
end

function PerformanceManager:ChangeMaxFPS(maxFPS)
  maxFPS = math.ceil(maxFPS)
  Logger.ForcePrint("#修改最大帧率FPS为：", maxFPS, debug.traceback())
  ApplicationUtils.SetFPS(maxFPS)
end

function PerformanceManager:UpdateSoftClipDownsampleRate()
  local SoftMaskCtrl = CS.SoftMaskCtrl
  if SoftMaskCtrl then
    local newVal = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.SystemSetting .. CommonDefine.SettingUniqueName.GraphicQuality .. "_val")
    local softClipDownSample = 0
    if "Middle" == newVal then
      softClipDownSample = 4
    end
    SoftMaskCtrl.SetDownsampleRate(softClipDownSample)
  end
end

function PerformanceManager:InitQualityLevel()
  self:ChangeQualitySetting(0)
end

function PerformanceManager:ChangeQualitySetting(level)
  CS.UnityEngine.QualitySettings.SetQualityLevel(level)
  Logger.Debug("#修改质量等级为：", level)
  CS.UnityEngine.Rendering.GraphicsSettings.renderPipelineAsset = CS.UnityEngine.QualitySettings.renderPipeline
  Logger.Debug("#当前渲染管线资源为：", CS.UnityEngine.Rendering.GraphicsSettings.currentRenderPipeline.name)
end

function PerformanceManager:SwitchPostProcessEffect()
  if bg.mainCamera then
    local cameraData = bg.mainCamera:GetUniversalAdditionalCameraData()
    cameraData.renderPostProcessing = not cameraData.renderPostProcessing
  end
end

function PerformanceManager:InitGCInfo()
  self._lastTimeGC = GetRealtimeSinceStartup()
  self._isShowGC = false
end

function PerformanceManager:SwitchGCInfo()
  self._isShowGC = not self._isShowGC
end

function PerformanceManager:IsGCInfoEnabled()
  return self._isShowGC
end

function PerformanceManager:UpdateGCInfo()
  if not self._isShowGC then
    return
  end
  local realtimeSinceStartup = GetRealtimeSinceStartup()
  local passTime = realtimeSinceStartup - self._lastTimeGC
  if passTime > 1.0 then
    self._lastTimeGC = realtimeSinceStartup
    EventMgr.Instance.GMGC:Dispatch(CS.PerformanceStatistic.Report())
  end
end

function PerformanceManager:EnablePostProcessing(enabled)
  if ApplicationUtils.is_editor_mode() then
    return
  end
  if not self.cameraComp then
    local camera = CS.UnityEngine.GameObject.Find("Main Camera"):GetComponent(typeof(CS.UnityEngine.Camera))
    self.cameraComp = camera:GetUniversalAdditionalCameraData()
  end
  local currentRenderPipeline = CS.UnityEngine.Rendering.GraphicsSettings.currentRenderPipeline
  if self.cameraComp then
    self.cameraComp.renderPostProcessing = enabled
  end
  currentRenderPipeline.supportsCameraOpaqueTexture = enabled
end

return PerformanceManager
