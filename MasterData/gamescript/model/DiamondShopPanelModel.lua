local function createDiamondShopPanelState()
  local state = {}
  
  state.costItemTid = CommonDefine.CurrencyType.PayMoney
  state.buyItemTid = CommonDefine.CurrencyType.SeniorMoney
  state.curBuyNum = tonumber(DT.GetConstant("ExchangeNumAddPerClick"))
  
  function state.maxBuyNum()
    local ret = 1
    local haveNum = ItemDataUtils.GetItemNum(state.costItemTid)
    ret = haveNum
    return ret
  end
  
  state.minBuyNum = 0
  state.changeNumPerClick = tonumber(DT.GetConstant("ExchangeNumAddPerClick"))
  state.exchangeNumPerGold = 1
  state.curCostCurrencyNum = state.exchangeNumPerGold * state.curBuyNum
  return state
end

local function createDiamondShopPanelViews(data)
  local views = {}
  return views
end

local function createDiamondShopPanelActions(data)
  local actions = {}
  
  function actions:UpdateBuyNum(buyNum)
    buyNum = math.max(buyNum, data.minBuyNum)
    data.curBuyNum = buyNum
    data.curCostCurrencyNum = data.exchangeNumPerGold * buyNum
  end
  
  function actions:SetCostCurrencyNum(costCurrencyNum)
    data.curCostCurrencyNum = costCurrencyNum
  end
  
  return actions
end

local function onSetup(binder, model)
end

local DiamondShopPanelModel = Vue.model("DiamondShopPanelModel", createDiamondShopPanelState):views(createDiamondShopPanelViews):actions(createDiamondShopPanelActions):setup(onSetup)
return DiamondShopPanelModel
