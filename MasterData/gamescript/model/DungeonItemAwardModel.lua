local function createDungeonItemAwardState(itemInfo)
  local state = {}
  
  state.itemInfo = itemInfo
  return state
end

local function createDungeonItemAwardViews(model)
  local views = {}
  return views
end

local function createDungeonItemAwardActions(model)
  local actions = {}
  
  function actions:SetConfigId(tid)
    if not tid then
      return
    end
    model.itemInfo.tid = tid
  end
  
  function actions:SetUid(uid)
    if not uid then
      return
    end
    model.itemInfo.uid = uid
  end
  
  function actions:SetNum(num)
    if not num then
      return
    end
    model.itemInfo.num = num
  end
  
  function actions:SetType(type)
    if not type then
      return
    end
    model.itemInfo.type = type
  end
  
  return actions
end

local function onSetup(binder, model)
end

local DungeonItemAwardModel = Vue.model("DungeonItemAwardModel", createDungeonItemAwardState):views(createDungeonItemAwardViews):actions(createDungeonItemAwardActions):setup(onSetup)
return DungeonItemAwardModel
