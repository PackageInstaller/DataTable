local function createMainShopPanelState()
  local state = {}
  
  function state.showShopItemList()
    do return MainShopDataUtils.GetShopItemList end
    return MainShopDataUtils.GetShopItemList, state.curShopType
  end
  
  function state.battlePassCountDown()
    local endCountDown = BattlePassDataUtils.GetEndCountDown()
    if endCountDown then
      do return LT.Text end
      return LT.Text, endCountDown
    else
      do return LT.Text end
      return LT.Text, ""
    end
  end
  
  state.curShopTypeGroup = nil
  state.curShopType = nil
  
  function state.shopTypeId()
    do return MainShopDataUtils.GetShopTypeIDByTag end
    return MainShopDataUtils.GetShopTypeIDByTag, state.curShopType
  end
  
  function state.currencyList()
    if not state.curShopType then
      return {}
    end
    local cfg = DT.ShopType[state.shopTypeId]
    return cfg.ShowMoney or {}
  end
  
  function state.productList()
    do return SdkMgr.Instance.GetProductList end
    return SdkMgr.Instance.GetProductList, SdkMgr.Instance
  end
  
  function state.moonCardSdkData()
    local moonCardChargeCfg
    local chargeConfig = ShopDataUtils.GetChargeConfig()
    for _, cfg in pairs(chargeConfig) do
      if cfg.Type == CommonDefine.ChagreType.MoonCard and cfg.Channel == SdkMgr.Instance.model.packageChannel then
        moonCardChargeCfg = cfg
      end
    end
    if not moonCardChargeCfg then
      return nil
    end
    for _, data in pairs(SdkMgr.Instance:GetProductList()) do
      if data.product_id == moonCardChargeCfg.PayCode then
        return data
      end
    end
    return nil
  end
  
  state.goldShopModel = nil
  state.tabClassifyArg = {a = 1, b = 2}
  return state
end

local function createMainShopPanelViews(model)
  local views = {}
  
  function views:GetCanBuyShopDataList()
    local rst = {}
    local list = model.showShopItemList
    if not list then
      return rst
    end
    for _, shopItemData in pairs(list) do
      local lockReason = MainShopDataUtils.GetShopItemLockedReason(shopItemData.tid)
      local remaining = shopItemData.maxBuyCount and MainShopDataUtils.GetGoodRemaining(shopItemData) or 0
      if not lockReason and remaining > 0 then
        table.insert(rst, shopItemData)
      end
    end
    return rst
  end
  
  return views
end

local function createMainShopPanelActions(data)
  local actions = {}
  
  function actions:SetCurShopType(typeTag)
    if not typeTag then
      return
    end
    data.curShopType = typeTag
  end
  
  function actions:GetShopTypeGroup(typeTag)
    return data.tabClassifyArg[typeTag] or 1
  end
  
  function actions:GetCurShopTypeGroup()
    return data.curShopTypeGroup or 1
  end
  
  function actions:SetCurShopTypeGroup(groupId)
    data.curShopTypeGroup = groupId or 1
  end
  
  function actions:GetParentShopType(typeTag)
    local multiUiGroups = MainShopDataUtils.GetMultiUIGroups()
    for parentShop, shopTags in pairs(multiUiGroups) do
      for _, shopTag in pairs(shopTags) do
        if shopTag == typeTag then
          return parentShop
        end
      end
    end
  end
  
  function actions:SetGoldShopModel(val)
    if not val or type(val) ~= "table" then
      Logger.Error("Error param ", val)
      return
    end
    data.goldShopModel = val
  end
  
  return actions
end

local function onSetup(_, _)
end

local MainShopPanelModel = Vue.model("MainShopPanelModel", createMainShopPanelState):views(createMainShopPanelViews):actions(createMainShopPanelActions):setup(onSetup)
return MainShopPanelModel
