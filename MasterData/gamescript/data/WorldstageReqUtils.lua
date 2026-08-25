local WorldstageReqUtils = {}

function WorldstageReqUtils.ReqOnEnhanceRelic(relicTid, callback)
  ProtoManager.Instance:ReqServer("WorldRequest", "OnEnhanceRelic", function(data)
    Logger.Info("OnEnhanceRelic Successful ", table.tostring(data))
    if data and data.gearUid then
      ShopDataUtils.OnShopData(data)
    end
    EventMgr.Instance.OnRelicEnhance:Dispatch()
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("OnEnhanceRelic failed ", table.tostring(data))
  end, {tid = relicTid})
end

function WorldstageReqUtils.ReqOnShopCustomCmd(callback)
  ProtoManager.Instance:ReqServer("WorldRequest", "OnShopCustomCmd", function(data)
    Logger.Info("OnSpecialShopCustomUse Successful ", table.tostring(data))
    ShopDataUtils.OnShopData(data)
    EventMgr.Instance.OnSpecialShopGoodsRefresh:Dispatch()
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("OnSpecialShopCustomUse failed ", table.tostring(data))
  end)
end

function WorldstageReqUtils.ReqOnShopRefresh(params, callback)
  ProtoManager.Instance:ReqServer("WorldRequest", "OnGearShopRefresh", function(data)
    Logger.Info("WorldRequest OnGearShopRefresh Success", table.tostring(data))
    ShopDataUtils.OnShopData(data)
    EventMgr.Instance.OnSpecialShopGoodsRefresh:Dispatch()
    if callback then
      callback()
    end
  end, function()
    Logger.Info("WorldRequest OnGearShopRefresh Fail")
  end, params)
end

return WorldstageReqUtils
