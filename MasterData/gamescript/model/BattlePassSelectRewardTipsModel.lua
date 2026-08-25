local function createBattlePassSelectRewardTipsState(dropIdList)
  local state = {}
  
  state.dropIdList = dropIdList
  state.curSelectIdx = 1
  
  function state.curSelectList()
    local rst = {}
    local itemTid = state.dropIdList[state.curSelectIdx].tid
    local itemCfg = DT.Item[itemTid]
    if not itemCfg then
      return rst
    end
    local dropCfg = DT.Drop[itemCfg.SpParam[1]]
    for _, data in pairs(dropCfg.data_list) do
      table.insert(rst, {
        tid = data.DropItem,
        num = data.DropNum or 0
      })
    end
    
    local function _Category(tid)
      local cfg = DT.Item[tid]
      if not cfg or cfg.Type ~= CommonDefine.ItemType.Weapon then
        return 2
      end
      if MainShopDataUtils.IsMaxPotencyByItemId(tid) then
        return 3
      end
      if ItemDataUtils.GetItemByTid(tid) then
        return 1
      end
      return 0
    end
    
    table.sort(rst, function(a, b)
      local ca, cb = _Category(a.tid), _Category(b.tid)
      if ca ~= cb then
        return ca < cb
      end
      local aSort = DT.Item[a.tid] and DT.Item[a.tid].BaseSortID or math.huge
      local bSort = DT.Item[b.tid] and DT.Item[b.tid].BaseSortID or math.huge
      return aSort < bSort
    end)
    return rst
  end
  
  state.curSelectTid = 0
  state.finalList = {}
  state.btnNextState = CommonDefine.BtnType.High
  state.btnCancelState = CommonDefine.BtnType.Normal
  state.btnReceiveState = CommonDefine.BtnType.Disabled
  return state
end

local function createBattlePassSelectRewardTipsViews(data)
  local views = {}
  
  function views.NotSelect()
    return 0 == data.curSelectTid
  end
  
  function views.FinalAward()
    return data.curSelectIdx >= #data.dropIdList
  end
  
  function views.SingleReward()
    return 1 == #data.dropIdList
  end
  
  return views
end

local function createBattlePassSelectRewardTipsActions(data)
  local actions = {}
  
  function actions.SetCurSelectTid(numVal)
    if not numVal then
      Logger.Error("Error Parameter: nil")
    end
    data.curSelectTid = numVal
  end
  
  function actions.AddItemTid()
    if 0 == data.curSelectTid then
      return
    end
    local bpGetRewardProtoData = data.dropIdList[data.curSelectIdx]
    bpGetRewardProtoData.chooseTid = data.curSelectTid
    table.insert(data.finalList, bpGetRewardProtoData)
  end
  
  function actions.NextAward()
    data.curSelectIdx = data.curSelectIdx + 1
    data.curSelectTid = 0
  end
  
  return actions
end

local function onSetup(_, _)
end

local BattlePassSelectRewardTipsModel = Vue.model("BattlePassSelectRewardTipsModel", createBattlePassSelectRewardTipsState):views(createBattlePassSelectRewardTipsViews):actions(createBattlePassSelectRewardTipsActions):setup(onSetup)
return BattlePassSelectRewardTipsModel
