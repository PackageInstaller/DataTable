_class("BattleExitLoadingHandler", LoadingHandler)
BattleExitLoadingHandler = BattleExitLoadingHandler

function BattleExitLoadingHandler:PreLoadBeforeLoadLevel(TT)
end

function BattleExitLoadingHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
end

function BattleExitLoadingHandler:OnLoadingFinish(...)
  local loadingParams = {
    ...
  }
  local statetype = loadingParams[1]
  local stateparam = loadingParams[2]
  if statetype == UIStateType.UIDiscovery then
    DiscoveryData.EnterStateUIDiscovery(4)
  else
    GameGlobal.UIStateManager():SwitchState(statetype, stateparam)
  end
end

function BattleExitLoadingHandler:LoadingType()
  return LoadingType.BOTTOM
end
