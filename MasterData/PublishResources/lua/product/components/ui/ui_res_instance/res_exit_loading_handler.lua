_class("ResExitLoadingHandler", LoadingHandler)
ResExitLoadingHandler = ResExitLoadingHandler

function ResExitLoadingHandler:PreLoadBeforeLoadLevel(TT)
end

function ResExitLoadingHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
end

function ResExitLoadingHandler:OnLoadingFinish(...)
  local module = GameGlobal.GetModule(ResDungeonModule)
  local clientResInstance = module:GetClientResInstance()
  local instanceId = module:GetEnterInstanceId()
  local mainType = clientResInstance:GetMainTypeByInstanceId(instanceId)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIResDetailController, mainType)
end

function ResExitLoadingHandler:LoadingType()
  return LoadingType.BOTTOM
end
