local function createItemUseSelectPanelState(itemId, num)
  local state = {}
  
  state.itemId = itemId
  state.num = num
  
  function state.curSelectList()
    local rst = {}
    local itemTid = state.itemId
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
    table.sort(rst, function(a, b)
      local aSort = DT.Item[a.tid].BaseSortID
      local bSort = DT.Item[b.tid].BaseSortID
      return aSort < bSort
    end)
    return rst
  end
  
  state.curSelectTid = 0
  state.curSelectNum = 0
  return state
end

local function createItemUseSelectPanelViews(data)
  local views = {}
  
  function views:NotSelect()
    return 0 == data.curSelectTid
  end
  
  return views
end

local function createItemUseSelectPanelActions(data)
  local actions = {}
  
  function actions.SetCurSelectTid(numVal)
    if not numVal then
      Logger.Error("Error Parameter: nil")
    end
    data.curSelectTid = numVal
  end
  
  function actions:SetCurSelectNum(numVal)
    if not numVal then
      Logger.Error("Error Parameter: nil")
    end
    data.curSelectNum = numVal
  end
  
  return actions
end

local function onSetup(_, _)
end

local ItemUseSelectPanelModel = Vue.model("ItemUseSelectPanelModel", createItemUseSelectPanelState):views(createItemUseSelectPanelViews):actions(createItemUseSelectPanelActions):setup(onSetup)
return ItemUseSelectPanelModel
