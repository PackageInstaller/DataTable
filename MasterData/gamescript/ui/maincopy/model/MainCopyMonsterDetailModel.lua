local function createMainCopyMonsterDetailModelState(monsterTid)
  local state = {}
  
  state.monsterTid = monsterTid or 0
  return state
end

local function createMainCopyMonsterDetailModelViews(data)
  local views = {}
  
  function views:GetMonsterName()
    do return CopyDataUtils.GetMonsterName end
    return CopyDataUtils.GetMonsterName, data.monsterTid
  end
  
  function views:GetMonsterIntro()
    do return CopyDataUtils.GetMonsterDesc end
    return CopyDataUtils.GetMonsterDesc, data.monsterTid
  end
  
  function views:HasTypeName()
    do return CopyDataUtils.HasMonsterTypeName end
    return CopyDataUtils.HasMonsterTypeName, data.monsterTid
  end
  
  function views:GetMonsterTypeName()
    do return CopyDataUtils.GetMonsterTypeName end
    return CopyDataUtils.GetMonsterTypeName, data.monsterTid
  end
  
  return views
end

local function createMainCopyMonsterDetailModelActions(data)
  local actions = {}
  
  function actions:SetMonsterTid(tid)
    tid = tid or 0
    data.monsterTid = tid
  end
  
  return actions
end

local function onSetup(_, _)
end

local MainCopyMonsterDetailModel = Vue.model("MainCopyMonsterDetailModel", createMainCopyMonsterDetailModelState):views(createMainCopyMonsterDetailModelViews):actions(createMainCopyMonsterDetailModelActions):setup(onSetup)
return MainCopyMonsterDetailModel
