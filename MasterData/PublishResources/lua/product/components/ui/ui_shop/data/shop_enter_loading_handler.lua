_class("ShopEnterLoadingHandler", LoadingHandler)
ShopEnterLoadingHandler = ShopEnterLoadingHandler

function ShopEnterLoadingHandler:Constructor()
end

function ShopEnterLoadingHandler:PreLoadBeforeLoadLevel(TT)
end

function ShopEnterLoadingHandler:PreLoadAfterLoadLevel(TT, ...)
  LoadingHandler.PreLoadAfterLoadLevel(self, TT, ...)
end

function ShopEnterLoadingHandler:OnLoadingFinish(...)
  local _, _, param = table.unpack({
    ...
  })
  GameGlobal.UIStateManager():SwitchState(UIStateType.UIShop, param)
end

function ShopEnterLoadingHandler:LoadingType()
  return LoadingType.BOTTOM
end
