local function createDungeonMockCopyModelState(featureId, jumpStageGroupId)
  local state = {}
  
  state.featureId = CommonDefine.FeatureId.MockBattle
  state.stageGroupList = {}
  state.curStageGroupId = 0
  
  function state.curStageGroupCfg()
    if 0 == state.curStageGroupId then
      return nil
    end
    return DT.StageGroup[state.curStageGroupId]
  end
  
  function state.curStageList()
    local rst = {}
    if 0 == state.curStageGroupId then
      return rst
    end
    for _, stageCfg in pairs(DT.Stage) do
      if stageCfg.BelongGroup == state.curStageGroupId then
        table.insert(rst, stageCfg.ID)
      end
    end
    table.sort(rst, function(a, b)
      local aStageCfg = DT.Stage[a]
      local bStageCfg = DT.Stage[b]
      return aStageCfg.BaseSortID < bStageCfg.BaseSortID
    end)
    return rst
  end
  
  state.curStageId = 0
  
  function state.curStageCfg()
    if 0 == state.curStageId then
      return nil
    end
    return DT.Stage[state.curStageId]
  end
  
  return state
end

local function createDungeonMockCopyModelViews(_)
  local views = {}
  return views
end

local function createDungeonMockCopyModelActions(data)
  local actions = {}
  
  function actions:SetStageGroupList(nums)
    if not nums then
      return
    end
    data.stageGroupList = nums
  end
  
  function actions:SetCurStageGroupId(num)
    if not num then
      return
    end
    data.curStageGroupId = num
  end
  
  function actions:SetCurStageId(num)
    if not num then
      return
    end
    data.curStageId = num
  end
  
  return actions
end

local function onSetup(_, model)
  local stageGroupList = {}
  for _, stageGroupCfg in pairs(DT.StageGroup) do
    if stageGroupCfg.Type == CommonDefine.StageGroupType.MockCopy then
      table.insert(stageGroupList, stageGroupCfg.ID)
    end
  end
  model:SetStageGroupList(stageGroupList)
  model:SetCurStageGroupId(model.stageGroupList[1] or 0)
  model:SetCurStageId(model.curStageList[1] or 0)
end

local DungeonMockCopyModel = Vue.model("DungeonMockCopyModel", createDungeonMockCopyModelState):views(createDungeonMockCopyModelViews):actions(createDungeonMockCopyModelActions):setup(onSetup)
return DungeonMockCopyModel
