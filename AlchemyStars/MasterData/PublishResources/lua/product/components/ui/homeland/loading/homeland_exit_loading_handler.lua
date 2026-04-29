_class("HomelandExitLoadingHandler", LoadingHandler)
HomelandExitLoadingHandler = HomelandExitLoadingHandler

function HomelandExitLoadingHandler:Constructor()
  GameGlobal.UIStateManager():Lock("HomelandExitLoading")
end

function HomelandExitLoadingHandler:PreLoadBeforeLoadLevel(TT)
  local uiModule = GameGlobal.GetUIModule(HomelandModule)
  uiModule:LeaveHomeland()
end

function HomelandExitLoadingHandler:OnLoadingFinish(...)
  local loadingParams = {
    ...
  }
  local finishCallBack = loadingParams[1]
  if finishCallBack then
    finishCallBack()
  else
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  end
  GameGlobal.UIStateManager():UnLock("HomelandExitLoading")
end

function HomelandExitLoadingHandler:LoadingType()
  return LoadingType.STATICPIC
end
