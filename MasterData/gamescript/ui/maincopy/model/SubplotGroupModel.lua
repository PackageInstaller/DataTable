local function createSubplotGroupModelState(stageGroupTid)
  local state = {}
  
  local MainCopyData = DataCenter.MainCopyData
  state.curGroupTid = stageGroupTid
  
  function state.curGroupData()
    if not state:CheckNumblerValid(state.curGroupTid) then
      return
    end
    return MainCopyData.allPlots[state.curGroupTid]
  end
  
  function state.groupStarInfo()
    if not state.curGroupData then
      return
    end
    return state.curGroupData.starGainInfo
  end
  
  state.curStageTid = 0
  state.stageMap = {}
  
  function state.difficult()
    local groupTid = state.curGroupTid
    if not groupTid then
      return 0
    end
    local config = CopyDataUtils.GetStageGroupConfig(groupTid)
    return config and config.Type or 0
  end
  
  state.difficult2Group = {}
  
  function state.hasSubplotActivity()
    do return ActivityManager.Instance.HasOpeningSubplotActivity, ActivityManager.Instance end
    return ActivityManager.Instance.HasOpeningSubplotActivity, ActivityManager.Instance, state.curGroupTid
  end
  
  function state.isLarge()
    local isSubplot, isLargeSubplot = CopyDataUtils.IsSubplotGroup(state.curGroupTid)
    return isSubplot and isLargeSubplot
  end
  
  return state
end

local function createSubplotGroupModelViews(data)
  local views = {}
  
  function views:CheckNumblerValid(numValue)
    if not numValue or type(numValue) ~= "number" or 0 == numValue then
      return false
    end
    return true
  end
  
  function views:IsNormalGroup(stageGroupTid)
    if not data:CheckNumblerValid(stageGroupTid) then
      return false
    end
    do return CopyDataUtils.IsNormalSubplotGroup end
    return CopyDataUtils.IsNormalSubplotGroup, stageGroupTid, stageGroupTid
  end
  
  function views:IsHardGroup(stageGroupTid)
    if not data:CheckNumblerValid(stageGroupTid) then
      return false
    end
    do return CopyDataUtils.IsHardSubplotGroup end
    return CopyDataUtils.IsHardSubplotGroup, stageGroupTid, stageGroupTid
  end
  
  function views:IsCrazyGroup(stageGroupTid)
    if not data:CheckNumblerValid(stageGroupTid) then
      return false
    end
    do return CopyDataUtils.IsCrazySubplotGroup end
    return CopyDataUtils.IsCrazySubplotGroup, stageGroupTid, stageGroupTid
  end
  
  function views:GetCurrStageGroupTotalStar(stageGroupId)
    stageGroupId = stageGroupId or data.curGroupTid
    do return MainCopyDataUtils.GetTotalStar end
    return MainCopyDataUtils.GetTotalStar, stageGroupId
  end
  
  function views:GetStarProgressText()
    if not data.curGroupData then
      return ""
    end
    local totalStar = MainCopyDataUtils.GetTotalStar(data.curGroupTid)
    local currStar = data.curGroupData.totalStar
    do return string.format, "%s/%s", currStar end
    return string.format, "%s/%s", currStar, totalStar
  end
  
  function views:GetStageGroupDesc(stageGroupTid)
    if not data:CheckNumblerValid(stageGroupTid) then
      return
    end
    local config = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
    return config and LT.Text(config.Desc)
  end
  
  function views:HasStarPrize(stageGroupTid)
    if not data:CheckNumblerValid(stageGroupTid) then
      return false
    end
    local totalStar = MainCopyDataUtils.GetTotalStar(stageGroupTid)
    return totalStar and totalStar > 0
  end
  
  function views:GetStageGroupName(stageGroupId)
    if not data:CheckNumblerValid(stageGroupId) then
      return
    end
    local config = CopyDataUtils.GetStageGroupConfig(stageGroupId)
    return config and LT.Text(config.Name)
  end
  
  function views:GetStageGroupBgImage(stageGroupTid)
    if not data:CheckNumblerValid(stageGroupTid) then
      return
    end
    local config = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
    return config and config.Backgrand
  end
  
  function views:GetStageIndex(stageTid)
    local config = CopyDataUtils.GetStageConfig(stageTid)
    return config and config.NameNumber
  end
  
  function views:GetStageName(stageTid)
    if not data:CheckNumblerValid(stageTid) then
      return
    end
    local config = CopyDataUtils.GetStageConfig(stageTid)
    return config and LT.Text(config.Name)
  end
  
  function views:GetStageData(stageTid)
    if not self:CheckNumblerValid(stageTid) then
      return
    end
    if not data.stageMap then
      return
    end
    return data.stageMap[stageTid]
  end
  
  function views:GetStageStar(stageTid)
    if not data:CheckNumblerValid(stageTid) then
      return 0
    end
    local stageData = data:GetStageData(stageTid)
    return stageData and stageData.star or 0
  end
  
  function views:IsStoryStage(stageTid)
    if not data:CheckNumblerValid(stageTid) then
      return false
    end
    local stageCfg = CopyDataUtils.GetStageConfig(stageTid)
    return stageCfg and not stageCfg.Map
  end
  
  function views:GetOpenTime(stageTid)
    if not data:CheckNumblerValid(stageTid) then
      return 0
    end
    local stageData = data:GetStageData(stageTid)
    return stageData and stageData.openTime or 0
  end
  
  function views:IsSubplotUnlocked(stageTid)
    if not data:CheckNumblerValid(stageTid) then
      return false
    end
    local stageData = data:GetStageData(stageTid)
    local config = CopyDataUtils.GetStageConfig(stageTid)
    if not stageData or not config then
      return
    end
    if stageData.star > 0 then
      return true
    end
    local openTime = stageData.openTime
    if not openTime then
      return true
    end
    local now = TimeUtils.GetServerTime()
    return openTime <= now
  end
  
  function views:GetLeftTime(stageTid)
    if not data:CheckNumblerValid(stageTid) then
      return 0
    end
    local openTime = data:GetOpenTime(stageTid)
    local now = TimeUtils.GetServerTime()
    if openTime <= now then
      return 0
    end
    return openTime - now
  end
  
  function views:HasAchievement(stageTid)
    local config = CopyDataUtils.GetStageConfig(stageTid)
    if not config or not config.LevelAchieve then
      return false
    end
    return #config.LevelAchieve > 0
  end
  
  function views:GetAchivementProgress(stageTid)
    local stageData = data:GetStageData(stageTid)
    if not stageData then
      return ""
    end
    if not data:HasAchievement(stageTid) then
      return ""
    end
    local stageCfg = CopyDataUtils.GetStageConfig(stageTid)
    local maxAchieveCount = #stageCfg.LevelAchieve
    local progress = 0
    for _, finishValue in pairs(stageData.achivement) do
      if 1 == finishValue then
        progress = progress + 1
      end
    end
    do return string.format, "%s/%s", progress end
    return string.format, "%s/%s", progress, maxAchieveCount, nil, nil, nil
  end
  
  return views
end

local function createSubplotGroupModelActions(data)
  local actions = {}
  
  function actions:SetCurGroupTid(groupTid)
    if not groupTid then
      return
    end
    data.curGroupTid = groupTid
  end
  
  function actions:SetDifficult2GroupMap(groupTid)
    if not data:CheckNumblerValid(groupTid) then
      return
    end
    local NormalModeIndex = CommonDefine.StageGroupHardModeIndex.Normal
    local HardModeIndex = CommonDefine.StageGroupHardModeIndex.Hard
    local CrazyModeIndex = CommonDefine.StageGroupHardModeIndex.Crazy
    local difficult2TidMap = CopyDataUtils.GetSubplotDifficult2IdMap(groupTid) or {}
    local normalGroupTid = difficult2TidMap[NormalModeIndex]
    local hardGroupTid = difficult2TidMap[HardModeIndex]
    local crazyGroupTid = difficult2TidMap[CrazyModeIndex]
    local normalType = CopyDataUtils.GetStageGroupType(normalGroupTid)
    local hardType = CopyDataUtils.GetStageGroupType(hardGroupTid)
    local crazyType = CopyDataUtils.GetStageGroupType(crazyGroupTid)
    data.difficult2Group = {
      [normalType] = normalGroupTid,
      [hardType] = hardGroupTid,
      [crazyType] = crazyGroupTid
    }
  end
  
  function actions:_UpdateCurGroupData()
    if not data:CheckNumblerValid(data.curGroupTid) then
      return
    end
    data.curGroupData = DataCenter.MainCopyData.allPlots[data.curGroupTid]
  end
  
  function actions:_UpdateStageMap()
    if not data:CheckNumblerValid(data.curGroupTid) then
      return
    end
    if not data.curGroupData or not data.curGroupData.stageList then
      return
    end
    local map = {}
    for _, stageData in pairs(data.curGroupData.stageList) do
      if stageData then
        map[stageData.stageID] = stageData
      end
    end
    data.stageMap = map
  end
  
  function actions:SetCurStageTid(stageTid)
    if not data:CheckNumblerValid(stageTid) then
      return
    end
    data.curStageTid = stageTid
  end
  
  function actions:_SetDefaultStage()
    if not data:CheckNumblerValid(data.curGroupTid) then
      return
    end
    if not data.curGroupData or not data.curGroupData.stageList then
      return
    end
    local stageTid = data.curGroupData.stageList[1]
    data.curStageTid = stageTid or 0
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindToRaw(function(_, nStageGroupTid, oStageGroupTid)
    if not nStageGroupTid then
      return
    end
    if oStageGroupTid and oStageGroupTid == nStageGroupTid then
      return
    end
    model:SetDifficult2GroupMap(nStageGroupTid)
    model:_UpdateStageMap()
    model:_SetDefaultStage()
  end, function()
    return model.curGroupTid
  end)
end

local SubplotGroupModel = Vue.model("SubplotGroupModel", createSubplotGroupModelState):views(createSubplotGroupModelViews):actions(createSubplotGroupModelActions):setup(onSetup)
return SubplotGroupModel
