local BaseSceneState = System.NewClass("BaseSceneState")
local gcInterval = 10

function BaseSceneState:ctor()
end

function BaseSceneState:OnInitSceneData()
end

function BaseSceneState:OnEnterScene()
  Logger.ReportApusInfo("OnEnterScene = {sceneType}", self.__name)
end

function BaseSceneState:OnExitScene()
  self:_StopReleaseResTimer()
  Logger.ReportApusInfo("OnExitScene = {sceneType}", self.__name)
end

function BaseSceneState:SetIngoreGc(ingGc)
  self._ingoreGc = ingGc
end

function BaseSceneState:_StartReleaseResTimer()
  self:_StopReleaseResTimer()
  if not self._ingoreGc then
    ResGcMgr.Instance:Gc()
  end
  self._ingoreGc = false
end

function BaseSceneState:_StopReleaseResTimer()
  if self._releaseResTimer then
    TimerManager.Instance:StopTimer(self._releaseResTimer)
    self._releaseResTimer = nil
  end
end

function BaseSceneState:_UnloadUnUsedResoucrs()
end

return BaseSceneState
