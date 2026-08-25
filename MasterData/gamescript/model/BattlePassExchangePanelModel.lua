local function createBattlePassExchangePanelState(bpModel)
  local state = {}
  
  state.bpModel = bpModel
  state.costItemTid = DT.Constant.BPBuyLevelPrice.Data[1]
  
  function state.maxBuyNum()
    return BattlePassDataUtils.GetMaxBpLevel() - BattlePassDataUtils.GetLevel()
  end
  
  state.minBuyNum = 1
  state.curBuyNum = state.minBuyNum
  state.changeNumPerClick = 1
  state.exchangeNumPerGold = DT.Constant.BPBuyLevelPrice.Data[2]
  state.curCostCurrencyNum = state.curBuyNum * state.exchangeNumPerGold
  
  function state.ShowRewardList()
    local rst = {}
    local tmp = {}
    local bpLevel = BattlePassDataUtils.GetLevel()
    local privilegeLevel = BattlePassDataUtils.GetPrivilegeLevel()
    for _, data in pairs(BattlePassDataUtils.GetRewardList()) do
      if not data.haveReceive and bpLevel + state.curBuyNum >= data.unlockLevel and bpLevel < data.unlockLevel and privilegeLevel >= data.bpRewardType then
        if not tmp[data.tid] then
          tmp[data.tid] = {
            tid = data.tid,
            num = data.num
          }
        else
          tmp[data.tid].num = tmp[data.tid].num + data.num
        end
      end
    end
    for _, data in pairs(tmp) do
      table.insert(rst, data)
    end
    table.sort(rst, function(a, b)
      local aSort = DT.Item[a.tid].BaseSortID
      local bSort = DT.Item[b.tid].BaseSortID
      return aSort < bSort
    end)
    return rst
  end
  
  return state
end

local function createBattlePassExchangePanelViews(_)
  local views = {}
  return views
end

local function createBattlePassExchangePanelActions(data)
  local actions = {}
  
  function actions.UpdateBuyNum(num)
    num = math.max(num, data.minBuyNum)
    num = math.min(num, data.maxBuyNum)
    data.curBuyNum = num
    data.curCostCurrencyNum = data.exchangeNumPerGold * num
  end
  
  return actions
end

local function onSetup(_, _)
end

local BattlePassExchangePanelModel = Vue.model("BattlePassExchangePanelModel", createBattlePassExchangePanelState):views(createBattlePassExchangePanelViews):actions(createBattlePassExchangePanelActions):setup(onSetup)
return BattlePassExchangePanelModel
