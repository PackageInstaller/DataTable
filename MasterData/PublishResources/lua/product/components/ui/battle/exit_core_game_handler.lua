_class("ExitCoreGameHandler", LoadingHandler)
ExitCoreGameHandler = ExitCoreGameHandler

function ExitCoreGameHandler:PreLoadBeforeLoadLevel(TT)
end

function ExitCoreGameHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
end

function ExitCoreGameHandler:OnLoadingFinish(...)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ExitCoreGame, {
    ...
  })
end

function ExitCoreGameHandler:LoadingType()
  return LoadingType.BOTTOM
end
