_class("MazeEnterLoadingHandler", LoadingHandler)
MazeEnterLoadingHandler = MazeEnterLoadingHandler

function MazeEnterLoadingHandler:PreLoadBeforeLoadLevel()
end

function MazeEnterLoadingHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
end

function MazeEnterLoadingHandler:OnLoadingFinish(...)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIMaze, self.sceneResReq)
end
