local AWAKER_MAX_NUM = 4

local function createState()
  local state = {}
  state.playerTeamSettleDataGroup = {}
  state.enermyTeamSettleDataGroup = {}
  
  function state.playerInfo()
    local rst = {}
    for uid, stats in pairs(PvPSettleDataUtils.GetStatsData()) do
      if uid == DataCenter.playerData.DRole.uid then
        rst = stats
        rst.uid = uid
        break
      end
    end
    return rst
  end
  
  function state.enermyInfo()
    local rst = {}
    for uid, stats in pairs(PvPSettleDataUtils.GetStatsData()) do
      if uid ~= DataCenter.playerData.DRole.uid then
        rst = stats
        rst.uid = uid
        break
      end
    end
    return rst
  end
  
  state.moreGameState = CommonDefine.PvPMoreGameState.CanPlay
  return state
end

local function createViews(model)
  local views = {}
  
  function views:GetTeamSettleDataGroupHigestVal(tblVal)
    local rst = 0
    for _, showData in pairs(tblVal) do
      rst = math.max(self:GetSettleDataTotalVal(showData.settleData), rst)
    end
    return rst
  end
  
  function views:GetSettleDataTotalVal(tblVal)
    return tblVal.damage + tblVal.heal + tblVal.shield
  end
  
  return views
end

local function createActions(model)
  local actions = {}
  
  function actions:Set_moreGameState(numVal)
    model.moreGameState = numVal
  end
  
  function actions:SetPlayerTeamSettleDataGroup(val)
    if nil == val or type(val) ~= "table" then
      Logger.Error("Error Val ", table.tostring(val))
      return
    end
    model.playerTeamSettleDataGroup = val
  end
  
  function actions:InsertPlayerTeamSettleDataGroup(val)
    if not val then
      Logger.Error("Error param ", val)
      return
    end
    table.insert(model.playerTeamSettleDataGroup, val)
  end
  
  function actions:SetEnermyTeamSettleDataGroup(val)
    if nil == val or type(val) ~= "table" then
      Logger.Error("Error Val ", table.tostring(val))
      return
    end
    model.enermyTeamSettleDataGroup = val
  end
  
  function actions:InsertEnermyTeamSettleDataGroup(val)
    if not val then
      Logger.Error("Error param ", val)
      return
    end
    table.insert(model.enermyTeamSettleDataGroup, val)
  end
  
  return actions
end

local function onSetup(_, model)
  local stateData = PvPSettleDataUtils.GetStatsData()
  if not table.next(stateData) then
    Logger.ReportApusInfo("没有pvp结算数据")
  end
  if not DataCenter.playerData.DRole.uid then
    Logger.ReportApusInfo("没有playerData.DRole.uid ")
  end
  local enemyStatsData, playerStatsData
  for uid, stats in pairs(PvPSettleDataUtils.GetStatsData()) do
    if uid == DataCenter.playerData.DRole.uid then
      playerStatsData = stats
    else
      enemyStatsData = stats
    end
  end
  if PvPSettleDataUtils.GetNoMoreGame() then
    model:Set_moreGameState(cd.PvPMoreGameState.NoMoreGame)
  end
  
  local function CreateShowingData(statsData, isPlayer)
    local rst = {
      {
        settleData = statsData.specialStats.stats,
        type = CommonDefine.PvPUnitSettleType.Keeper,
        tid1 = statsData.keeperSkillList[1].tid,
        tid2 = statsData.keeperSkillList[2].tid
      }
    }
    for i = 1, AWAKER_MAX_NUM do
      table.insert(rst, {
        settleData = statsData.awakerList[i].stats,
        type = CommonDefine.PvPUnitSettleType.Awaker,
        tid1 = statsData.awakerList[i].awakers.tid,
        curSkin = statsData.awakerList[i].awakers.curSkin,
        tid2 = statsData.weaponList[i].tid
      })
    end
    return rst
  end
  
  model:SetPlayerTeamSettleDataGroup(CreateShowingData(playerStatsData, true))
  model:SetEnermyTeamSettleDataGroup(CreateShowingData(enemyStatsData, false))
end

local PvPBattleDataSettlePanelModel = Vue.model("PvPBattleDataSettlePanelModel", createState):views(createViews):actions(createActions):setup(onSetup)
return PvPBattleDataSettlePanelModel
