local function createMainShopEnergyMonthCardTipsState()
  local state = {}
  
  state.itemTid = DT.GetConstant("EnergyMonthlyCardDropItemId")
  state.itemCfg = DT.Item[state.itemTid]
  state.costItemTid = DT.GetOriginalConstant("EnergyMonthlyCardPrice")[1]
  state.price = DT.GetOriginalConstant("EnergyMonthlyCardPrice")[2]
  
  function state.showRewardGroup()
    local rst = {}
    local diamondItemShowData = {
      itemTid = DT.GetOriginalConstant("EnergyMonthlyCardReward")[1],
      itemCount = DT.GetOriginalConstant("EnergyMonthlyCardReward")[2],
      bgType = CommonDefine.MainShopContentItemDescBgType.Blue,
      desc = LT.Text("EnergyMonthCardImmediateRewardDesc")
    }
    table.insert(rst, diamondItemShowData)
    local cfgEnergyMonthlyCardDailyReward = DT.GetOriginalConstant("EnergyMonthlyCardDailyReward")
    for i = 1, #cfgEnergyMonthlyCardDailyReward, 2 do
      table.insert(rst, {
        itemTid = cfgEnergyMonthlyCardDailyReward[i],
        itemCount = cfgEnergyMonthlyCardDailyReward[i + 1],
        bgType = CommonDefine.MainShopContentItemDescBgType.Yellow,
        desc = LT.Text("EnergyMonthCardDailyRewardDesc")
      })
    end
    return rst
  end
  
  return state
end

local function createMainShopEnergyMonthCardTipsViews(data)
  local views = {}
  return views
end

local function createMainShopEnergyMonthCardTipsActions(data)
  local actions = {}
  return actions
end

local function onSetup(binder, model)
end

local MainShopEnergyMonthCardTipsModel = Vue.model("MainShopEnergyMonthCardTipsModel", createMainShopEnergyMonthCardTipsState):views(createMainShopEnergyMonthCardTipsViews):actions(createMainShopEnergyMonthCardTipsActions):setup(onSetup)
return MainShopEnergyMonthCardTipsModel
