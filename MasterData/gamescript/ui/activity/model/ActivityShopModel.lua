local function createActivityShopModelState(activityTid, activityData)
  local state = {}
  
  state.activityTid = activityTid
  state.activityData = activityData
  state.selectGroupIdx = 0
  state.taskGroups = {}
  
  function state.showingTaskGroup()
    local rst = {}
    local sourceData = table.clone(state.taskGroups[state.selectGroupIdx] and state.taskGroups[state.selectGroupIdx].taskDataMap or {})
    for _, taskData in pairs(sourceData) do
      table.insert(rst, taskData)
    end
    table.sort(rst, function(a, b)
      local aSortIdx = TaskDataUtils.GetConfigByField("BaseSortID", a.tid) or 0
      local bSortIdx = TaskDataUtils.GetConfigByField("BaseSortID", b.tid) or 0
      return aSortIdx < bSortIdx
    end)
    return rst
  end
  
  function state.shopTypeCfg()
    local shopTypeList = ActivityDataUtils.GetShopList(state.activityTid)
    local shopType = shopTypeList[1]
    if shopType then
      return DT.ShopType[shopType]
    end
    return {}
  end
  
  return state
end

local function createActivityShopModelViews(model)
  local views = {}
  
  function views:Get_activityTid()
    return model.activityTid
  end
  
  function views:Get_selectGroupIdx()
    return model.selectGroupIdx
  end
  
  function views:GetTaskGroupByIdx(idx)
    return model.taskGroups[idx]
  end
  
  function views:GetTaskGroupByFieldIdx(field, idx)
    if not field or not idx then
      return
    end
    local taskGroup = self:GetTaskGroupByIdx(idx)
    if not taskGroup then
      return
    end
    return taskGroup[field]
  end
  
  return views
end

local function createActivityShopModelActions(model)
  local actions = {}
  
  function actions:Set_selectGroupIdx(idx)
    model.selectGroupIdx = idx
    local taskGroupTid = self:GetTaskGroupByFieldIdx("tid", idx)
    RedPointDataUtils.ClearActivityTaskGroupFirstOpenRed(taskGroupTid, model.activityTid)
  end
  
  function actions:Set_taskGroups(tbl)
    model.taskGroups = tbl
  end
  
  function actions:InitTaskGroups(taskDataList)
    local rst = ActivityDataUtils.GetTaskGroupDatasByCfg(model.activityTid)
    for _, taskData in pairs(taskDataList) do
      rst = self:_UpdateTaskGroupByTaskData(rst, taskData)
    end
    self:Set_taskGroups(rst)
  end
  
  function actions:_UpdateTaskGroupByTaskData(targetTbl, taskData)
    local taskTid = taskData.tid
    local iterTaskGroupTid = TaskDataUtils.GetConfigByField("BelongTaskGroup", taskTid) or 0
    for _, taskGroupData in pairs(targetTbl) do
      if taskGroupData.tid == iterTaskGroupTid then
        taskGroupData.taskDataMap[taskTid] = taskData
      end
    end
    return targetTbl
  end
  
  return actions
end

local function onSetup(_, model)
  local taskDataList = ActivityDataUtils.GetTaskDataListFormActivityData(model.activityData)
  model:InitTaskGroups(taskDataList)
end

local ActivityShopModel = Vue.model("ActivityShopModel", createActivityShopModelState):views(createActivityShopModelViews):actions(createActivityShopModelActions):setup(onSetup)
return ActivityShopModel
