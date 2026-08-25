local function createChargeMainPanelState()
  local state = {}
  
  function state.showRechargeItemList()
    local ret = {}
    local chargeMap = MainShopDataUtils.GetChargeData()
    local chargeConfig = ShopDataUtils.GetChargeConfig()
    for _, config in pairs(chargeConfig) do
      if config.Type == CommonDefine.ChagreType.Recharge and config.Channel == SdkMgr.Instance.model.packageChannel and (not config.PCExclusive or 0 == config.PCExclusive or ApplicationUtils.IsWindowsOrEditor()) then
        local isDouble = false
        if config.PayCode then
          isDouble = chargeMap[config.ID] ~= false
        end
        table.insert(ret, {
          tid = config.ID,
          isDouble = isDouble
        })
      end
    end
    table.sort(ret, function(a, b)
      local chargeCfgA = ShopDataUtils.GetChargeCfgById(a.tid)
      local chargeCfgB = ShopDataUtils.GetChargeCfgById(b.tid)
      local aSort = chargeCfgA.BaseSortID
      local bSort = chargeCfgB.BaseSortID
      return aSort < bSort
    end)
    return ret
  end
  
  function state.productList()
    do return SdkMgr.Instance.GetProductList end
    return SdkMgr.Instance.GetProductList, SdkMgr.Instance
  end
  
  return state
end

local function createChargeMainPanelViews(data)
  local views = {}
  return views
end

local function createChargeMainPanelActions(data)
  local actions = {}
  return actions
end

local function onSetup(binder, model)
end

local ChargeMainPanelModel = Vue.model("ChargeMainPanelModel", createChargeMainPanelState):views(createChargeMainPanelViews):actions(createChargeMainPanelActions):setup(onSetup)
return ChargeMainPanelModel
