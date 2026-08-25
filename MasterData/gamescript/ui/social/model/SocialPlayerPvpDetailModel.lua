local AWAKER_MAX_NUM = 4

local function createState(data)
  local state = {}
  state.playerUid = data.selfUid
  state.playerTeamSettleDataGroup = {}
  state.enermyTeamSettleDataGroup = {}
  return state
end

local function createViews(_)
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
  
  local function CreateShowingData(statsData)
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
        tid2 = statsData.weaponList[i].tid
      })
    end
    return rst
  end
  
  function actions:SetTeamSettleDataGroup(statsData)
    if nil == statsData or type(statsData) ~= "table" then
      Logger.Error("Error statsData ", table.tostring(statsData))
      return
    end
    local enemyStatsData, playerStatsData
    for uid, stats in pairs(statsData) do
      if uid == model.playerUid then
        playerStatsData = stats
      else
        enemyStatsData = stats
      end
    end
    model.playerTeamSettleDataGroup = CreateShowingData(playerStatsData)
    model.enermyTeamSettleDataGroup = CreateShowingData(enemyStatsData)
  end
  
  return actions
end

local function onSetup(_, _)
end

local SocialPlayerPvpDetailModel = Vue.model("SocialPlayerPvpDetailModel", createState):views(createViews):actions(createActions):setup(onSetup)
return SocialPlayerPvpDetailModel
