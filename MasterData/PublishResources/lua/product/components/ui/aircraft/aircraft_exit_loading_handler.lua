_class("AircraftExitLoadingHandler", LoadingHandler)
AircraftExitLoadingHandler = AircraftExitLoadingHandler

function AircraftExitLoadingHandler:Constructor()
  GameGlobal.UIStateManager():Lock("AircraftExitLoading")
end

function AircraftExitLoadingHandler:PreLoadBeforeLoadLevel(TT)
  local module = GameGlobal.GetModule(AircraftModule)
  local main = module:GetClientMain()
  if main then
    main:Dispose()
  end
  module:SetClientMain(nil)
  module:PushLeaveAircraft()
end

function AircraftExitLoadingHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
end

function AircraftExitLoadingHandler:OnLoadingFinish(...)
  local loadingParams = {
    ...
  }
  local finishCallBack = loadingParams[1]
  local triggerGuide = false
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideLeaveAircraft, function(trigger)
    triggerGuide = trigger
  end)
  if not triggerGuide then
    if finishCallBack then
      finishCallBack()
    else
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
    end
  end
  GameGlobal.UIStateManager():UnLock("AircraftExitLoading")
end

function AircraftExitLoadingHandler:LoadingType()
  return LoadingType.STATICPIC
end
