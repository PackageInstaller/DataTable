local function createDungeonSweepPanelModelState(stageId, activityTid, limitTimes)
  local state = {}
  
  state.stageId = stageId
  state.activityTid = activityTid
  
  function state.stageCfg()
    local rst = {}
    if state.stageId and DT.Stage[state.stageId] then
      rst = DT.Stage[state.stageId]
    end
    return rst
  end
  
  function state.costItemGroup()
    local rst = {
      [1] = DT.GetConstant("EnergyItemTid")
    }
    return rst
  end
  
  function state.costItemNum()
    local perCost = state.stageCfg.Cost
    if StageCfgUtils.GetExtraCostItemTid(state.stageId) then
      perCost = StageCfgUtils.GetExtraCostItemNum(state.stageId)
    end
    return perCost * math.max(1, state.sweepTimes)
  end
  
  state.sweepMinTime = 1
  
  function state.sweepMaxTime()
    if limitTimes then
      return limitTimes
    end
    local constLimit = DT.GetConstant("SweepLimit")
    local canSweepTime = math.floor(PlayerDataUtils.GetEnergy() / state.stageCfg.Cost)
    if StageCfgUtils.GetExtraCostItemTid(state.stageId) then
      local costItemTid = StageCfgUtils.GetExtraCostItemTid(state.stageId)
      local haveNum = ItemDataUtils.GetItemNum(costItemTid) or 0
      canSweepTime = math.floor(haveNum / StageCfgUtils.GetExtraCostItemNum(state.stageId))
    end
    do return math.min, constLimit end
    return math.min, constLimit, canSweepTime, haveNum / StageCfgUtils.GetExtraCostItemNum(state.stageId), state.stageId
  end
  
  state.sweepTimes = 1
  state.teamId = nil
  state.teamType = CommonDefine.TeamType.Normal
  state.showAwakerGroup = {}
  return state
end

local function createDungeonSweepPanelModelViews(model)
  local views = {}
  
  function views:GetSelectedCost()
    return model.stageCfg.Cost * model.sweepTimes
  end
  
  return views
end

local function createDungeonSweepPanelModelActions(data)
  local actions = {}
  
  function actions:SetSweepTimes(num)
    if not num then
      return
    end
    num = math.max(num, data.sweepMinTime)
    num = math.min(num, data.sweepMaxTime)
    data.sweepTimes = math.floor(num)
  end
  
  function actions:SetShowAwakerGroup(group)
    if not group then
      return
    end
    for _, val in pairs(group) do
      if 0 == val then
        data.showAwakerGroup = {}
        return
      end
    end
    data.showAwakerGroup = group
  end
  
  function actions:SetTeamId(num)
    if not num then
      return
    end
    data.teamId = num
  end
  
  return actions
end

local function onSetup(_, model)
  local teamType = model.teamType or CommonDefine.TeamType.Normal
  local lastSelectTeam = DBGTeamDataUtils.GetDBGLastSelectTeam(teamType)
  if lastSelectTeam then
    model:SetTeamId(lastSelectTeam)
  else
    model:SetTeamId(1)
  end
  local teamsData = DBGTeamDataUtils.GetDBGTeams(teamType)
  local awakerGroup = teamsData and teamsData[model.teamId]
  if awakerGroup then
    model:SetShowAwakerGroup(awakerGroup.awakerTids or {})
  end
end

local DungeonSweepPanelModel = Vue.model("DungeonSweepPanelModel", createDungeonSweepPanelModelState):views(createDungeonSweepPanelModelViews):actions(createDungeonSweepPanelModelActions):setup(onSetup)
return DungeonSweepPanelModel
