_class("CoreGamePerformanceTestLoadingHandler", LoadingHandler)
CoreGamePerformanceTestLoadingHandler = CoreGamePerformanceTestLoadingHandler

function CoreGamePerformanceTestLoadingHandler:PreLoadBeforeLoadLevel(TT)
end

function CoreGamePerformanceTestLoadingHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
  self._levelID = 1000105
  local levelRawData = Cfg.cfg_level[self._levelID]
  local themeRawData = Cfg.cfg_theme[levelRawData.Theme]
  local levelResPath = themeRawData.SceneResPath
  self._sceneGO = GameGlobal:GetInstance().gameLogic:LoadScene(TT, levelResPath).Obj
end

function CoreGamePerformanceTestLoadingHandler:OnLoadingFinish(...)
  GameGlobal:GetInstance():GetCollector("PerformanceTestLoading"):Sample("CoreGamePerformanceTestLoadingHandler:OnLoadingFinish() begin")
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIPerformanceTest)
  GameGlobal:GetInstance():EnterPerformanceTest(self._levelID, self._sceneGO)
  GameGlobal:GetInstance():GetCollector("PerformanceTestLoading"):Sample("CoreGamePerformanceTestLoadingHandler:OnLoadingFinish()")
end
