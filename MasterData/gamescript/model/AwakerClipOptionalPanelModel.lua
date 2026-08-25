local function createAwakerClipOptionalPanelState(itemTid)
  local state = {}
  
  state.useItemTid = itemTid
  
  function state.showAwakerGroup()
    local itemCfg = DT.Item[itemTid]
    do return ItemDataUtils.GetUseAwakerChipList end
    return ItemDataUtils.GetUseAwakerChipList, itemCfg.SpParam[1]
  end
  
  state.curSelectAwakerClipTid = nil
  return state
end

local function createAwakerClipOptionalPanelViews(data)
  local views = {}
  return views
end

local function createAwakerClipOptionalPanelActions(data)
  local actions = {}
  
  function actions:SetCurSelectAwakerClipTid(tid)
    if not tid then
      return
    end
    data.curSelectAwakerClipTid = tid
  end
  
  return actions
end

local function onSetup(binder, model)
  if #model.showAwakerGroup > 0 then
    model:SetCurSelectAwakerClipTid(model.showAwakerGroup[1].tid)
  end
end

local AwakerClipOptionalPanelModel = Vue.model("AwakerClipOptionalPanelModel", createAwakerClipOptionalPanelState):views(createAwakerClipOptionalPanelViews):actions(createAwakerClipOptionalPanelActions):setup(onSetup)
return AwakerClipOptionalPanelModel
