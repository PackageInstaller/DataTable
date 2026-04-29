_class("UIDiscoveryLoadingEnterHandler", LoadingHandler)
UIDiscoveryLoadingEnterHandler = UIDiscoveryLoadingEnterHandler

function UIDiscoveryLoadingEnterHandler:PreLoadBeforeLoadLevel(TT)
end

function UIDiscoveryLoadingEnterHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
end

function UIDiscoveryLoadingEnterHandler:OnLoadingFinish(...)
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIDiscovery)
end

function UIDiscoveryLoadingEnterHandler:LoadingType()
  return LoadingType.BOTTOM
end
