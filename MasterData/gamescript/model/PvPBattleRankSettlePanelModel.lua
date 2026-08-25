local AccountExpItemTid = DT.GetConstant("AccountExpItemTid")
local PVPPreconModeRewardExp = DT.GetConstant("PVPPreconModeRewardExp")
local PVPDraftPickModeRewardExp = DT.GetConstant("PVPDraftPickModeRewardExp")
local GoldItemTid = DT.GetConstant("GoldItemTid")
local PvPRankRewardType = CommonDefine.PvPRankRewardType

local function createState()
  local state = {}
  
  function state.seasonBonusNum()
    return PvPSettleDataUtils.GetRankRewardByType(PvPRankRewardType.seasonBonus) or 0
  end
  
  function state.streakBonusNum()
    return PvPSettleDataUtils.GetRankRewardByType(PvPRankRewardType.streakBonus) or 0
  end
  
  function state.battleRstStarNum()
    return PvPSettleDataUtils.GetRankRewardByType(PvPRankRewardType.BattleRst) or 0
  end
  
  function state.firstWinStarNum()
    return PvPSettleDataUtils.GetRankRewardByType(PvPRankRewardType.firstWinBonus) or 0
  end
  
  state.showingRankId = PvPSeasonDataUtils.GetRankId()
  state.showingStarNum = PvPSeasonDataUtils.GetStar()
  
  function state.maxShowingStarNum()
    local rankCfg = DT.PVPRank[state.showingRankId]
    local nextRankCfg = PvPTeamBuildDataUtils.GetPvpRankCfgBySortId(rankCfg.BaseSortID + 1)
    if not nextRankCfg then
      return 0
    end
    return nextRankCfg.ScoreRequired - rankCfg.ScoreRequired
  end
  
  function state.battleRewards()
    local rst = {}
    local itemTid2RewardDict = {}
    local settleRewards = PvPSettleDataUtils.GetSettleRewards()
    for _, settleReward in pairs(settleRewards) do
      if settleReward.tid == CommonDefine.CurrencyType.AwakerLike then
      else
        if not itemTid2RewardDict[settleReward.tid] then
          itemTid2RewardDict[settleReward.tid] = {}
        end
        table.insert(itemTid2RewardDict[settleReward.tid], settleReward)
      end
    end
    itemTid2RewardDict[AccountExpItemTid] = nil
    local isDraftPvp = PvPSettleDataUtils.GetPvpType() == PvpDefine.PvpType.Draft
    if isDraftPvp and not itemTid2RewardDict[PVPDraftPickModeRewardExp] then
      itemTid2RewardDict[PVPDraftPickModeRewardExp] = {
        {
          num = 0,
          tid = PVPDraftPickModeRewardExp,
          reason = CommonDefine.PvPSettleRewardDataType.PVPStyle,
          type = CommonDefine.PvPSettleRewardDataType.PVPStyle
        }
      }
    elseif not isDraftPvp and not itemTid2RewardDict[PVPPreconModeRewardExp] then
      itemTid2RewardDict[PVPPreconModeRewardExp] = {
        {
          num = 0,
          tid = PVPPreconModeRewardExp,
          reason = CommonDefine.PvPSettleRewardDataType.PVPStyle,
          type = CommonDefine.PvPSettleRewardDataType.PVPStyle
        }
      }
    end
    if not itemTid2RewardDict[GoldItemTid] then
      itemTid2RewardDict[GoldItemTid] = {
        {
          num = 0,
          tid = GoldItemTid,
          reason = CommonDefine.PvPSettleRewardDataType.PVPStyle,
          type = CommonDefine.PvPSettleRewardDataType.PVPStyle
        }
      }
    end
    for _, sameTidRewards in pairs(itemTid2RewardDict) do
      table.insert(rst, sameTidRewards)
    end
    table.sort(rst, function(a, b)
      local aTid = a[1].tid
      local bTid = b[1].tid
      return DT.Item[aTid].BaseSortID > DT.Item[bTid].BaseSortID
    end)
    return rst
  end
  
  return state
end

local function createViews(model)
  local views = {}
  
  function views:GetTotalRankStar()
    return model.seasonBonusNum + model.streakBonusNum + model.battleRstStarNum + model.firstWinStarNum
  end
  
  return views
end

local function createActions(model)
  local actions = {}
  
  function actions:SetShowingRankId(val)
    if nil == val then
      Logger.Error("Error Val ", table.tostring(val))
      return
    end
    model.showingRankId = val
  end
  
  function actions:SetShowingStarNum(val)
    if nil == val then
      Logger.Error("Error Val ", table.tostring(val))
      return
    end
    model.showingStarNum = val
  end
  
  return actions
end

local function onSetup(_, model)
end

local PvPBattleRankSettlePanelModel = Vue.model("PvPBattleRankSettlePanelModel", createState):views(createViews):actions(createActions):setup(onSetup)
return PvPBattleRankSettlePanelModel
