local QualitySortID = CommonDefine.QualitySortID

local function createTaskAppointBuildTipsState(data)
  local state = {}
  state.taskData = data.taskData
  state.taskCfg = DT.Task[state.taskData.tid]
  
  function state.showAwakerGroup()
    local rst = AwakerDataUtils.GetOwnedAwakerList()
    for i = #rst, 1, -1 do
      local awakerData = rst[i]
      if AwakerDataUtils.IsOriginType(awakerData.tid) then
        table.remove(rst, i)
      end
    end
    table.sort(rst, function(a, b)
      local aAwakerId = a.tid
      local bAwakerId = b.tid
      local aAwakerCfg = DT.AwakerConfig[aAwakerId]
      local bAwakerCfg = DT.AwakerConfig[bAwakerId]
      local aAppointWeight = TaskDataUtils.AwakerInTask(aAwakerId) and 1 or 0
      local bAppointWeight = TaskDataUtils.AwakerInTask(bAwakerId) and 1 or 0
      local aLevel = a.level
      local bLevel = b.level
      local aQualityWeight = QualitySortID[aAwakerCfg.Quality]
      local bQualityWeight = QualitySortID[bAwakerCfg.Quality]
      if aAppointWeight ~= bAppointWeight then
        return aAppointWeight < bAppointWeight
      end
      if aLevel ~= bLevel then
        return aLevel > bLevel
      end
      if aQualityWeight ~= bQualityWeight then
        return aQualityWeight > bQualityWeight
      end
      return aAwakerCfg.BaseSortID < bAwakerCfg.BaseSortID
    end)
    return rst
  end
  
  function state.conditionTips()
    if not state.taskCfg.CompleteCondDesc then
      return ""
    end
    do return LT.Textf, state.taskCfg.CompleteCondDesc, table.unpack(state.taskCfg.CompleteCondPara) end
    return LT.Textf, state.taskCfg.CompleteCondDesc, table.unpack(state.taskCfg.CompleteCondPara)
  end
  
  function state.extraTips()
    if not state.taskCfg.ExtraCondDesc then
      return ""
    end
    do return LT.Textf, state.taskCfg.ExtraCondDesc, table.unpack(state.taskCfg.ExtraCondPara) end
    return LT.Textf, state.taskCfg.ExtraCondDesc, table.unpack(state.taskCfg.ExtraCondPara)
  end
  
  function state.showAwardGroup()
    local rst = {}
    local tmp = {}
    local itemCountMap = {}
    for key, count in table.iteraDouble(state.taskCfg.CompleteAward or {}) do
      table.insert(tmp, key)
      itemCountMap[key] = count
    end
    for _, itemId in pairs(tmp) do
      table.insert(rst, {
        itemTid = itemId,
        count = itemCountMap[itemId]
      })
    end
    local extraAwardInfo = TaskDataUtils.GetDispatchExtraAward(state.taskData.tid, state.taskData.awakerList)
    if extraAwardInfo then
      table.insert(rst, {
        itemTid = extraAwardInfo.tid,
        count = extraAwardInfo.num,
        reach = extraAwardInfo.reach,
        isExtra = true
      })
    end
    return rst
  end
  
  state.MAX_AWAKER_NUM = state.taskCfg.MaxAwakerNum or 0
  state.chooseAwakerGroup = {}
  
  function state.chooseAwakerNum()
    return #state.chooseAwakerGroup
  end
  
  return state
end

local function createTaskAppointBuildTipsViews(data)
  local views = {}
  
  function views.IsEmptyTeam()
    if not data.chooseAwakerGroup then
      return false
    end
    return 0 == #data.chooseAwakerGroup
  end
  
  return views
end

local function createTaskAppointBuildTipsActions(data)
  local actions = {}
  
  function actions.AddAwaker(awakerTid)
    if not awakerTid then
      Logger.Error("Error param awakerTid", awakerTid)
    end
    if #data.chooseAwakerGroup >= data.MAX_AWAKER_NUM then
      return
    end
    table.insert(data.chooseAwakerGroup, awakerTid)
  end
  
  function actions.RemoveAwaker(awakerTid)
    if not awakerTid then
      Logger.Error("Error param awakerTid", awakerTid)
    end
    if #data.chooseAwakerGroup <= 0 then
      return
    end
    table.remove(data.chooseAwakerGroup, table.findvalue(data.chooseAwakerGroup, awakerTid))
  end
  
  function actions.Clear_chooseAwakerGroup()
    data.chooseAwakerGroup = {}
  end
  
  function actions:OneClickFormation()
    for _, awakerData in ipairs(data.showAwakerGroup) do
      if #data.chooseAwakerGroup >= data.MAX_AWAKER_NUM then
        break
      end
      local awakerTid = awakerData.tid
      if TaskDataUtils.AwakerInTask(awakerTid) then
      else
        self.AddAwaker(awakerTid)
      end
    end
  end
  
  return actions
end

local function onSetup(_, _)
end

local TaskAppointBuildTipsModel = Vue.model("TaskAppointBuildTipsModel", createTaskAppointBuildTipsState):views(createTaskAppointBuildTipsViews):actions(createTaskAppointBuildTipsActions):setup(onSetup)
return TaskAppointBuildTipsModel
