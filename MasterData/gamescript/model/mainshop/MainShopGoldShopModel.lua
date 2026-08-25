local MainShopTypeTag = CommonDefine.MainShopTypeTag

local function createState()
  local state = {}
  state.realShopType = MainShopDataUtils.GetShopRealType(MainShopTypeTag.GoldShop)
  
  function state.nextRefreshTs()
    return MainShopDataUtils.GetNextRefreshTs(state.realShopType) or 0
  end
  
  function state.refreshTimes()
    do return end
    return MainShopDataUtils.GetGoldShopRefreshRemainTimes, nil
  end
  
  function state.refreshPrice()
    local refreshTimes = MainShopDataUtils.GetFreshCount(state.realShopType)
    local refreshPriceGroup = PlayerDataUtils.GetGoldShopRefeshGroup(PlayerDataUtils.GetLevel())
    local price = refreshPriceGroup[refreshTimes + 1] or 0
    return price or 0
  end
  
  state.refreshItemTid = CommonDefine.CurrencyType.JuniorMoney
  return state
end

local function createViews(model)
  local views = {}
  return views
end

local function createActions(model)
  local actions = {}
  
  function actions:SetNextRefreshTs(val)
    if not val then
      return
    end
    model.nextRefreshTs = val
  end
  
  function actions:SetRefreshTimes(val)
    if not val then
      return
    end
    model.refreshTimes = val
  end
  
  return actions
end

local function onSetup(binder, model)
end

local MainShopGoldShopModel = Vue.model("MainShopGoldShopModel", createState):views(createViews):actions(createActions):setup(onSetup)
return MainShopGoldShopModel
