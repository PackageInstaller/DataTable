local RailWayActivityRemainRewardHideItems = DT.GetOriginalConstant("RailWayActivityRemainRewardHideItems")
local RailWayTaskGroup = DT.GetOriginalConstant("RailWayTaskGroup")
local RailWayModel = NewClass("RailWayModel", BaseModel)

function RailWayModel:OnInit()
  self._stageTid2RailWayMODict = {}
  self._curStageTid = nil
  self._curStage = nil
  self._curBattleNodeIdx = nil
  self._curScore = nil
  self._seasonMaxScore = nil
  self._curCreateTime = nil
  self._curSeasonId = nil
  self:_InitRailWayMO()
  self._difficultyMaxScoreMap = {
    [1] = 0,
    [2] = 0,
    [3] = 0
  }
end

function RailWayModel:OnReset()
  self:OnInit()
end

function RailWayModel:_GetCurrentStageGroupId()
  do return end
  return SeasonRotationCfgUtils.GetCurrentRailWayStageGroupId
end

function RailWayModel:_InitRailWayMO()
  for _, stageCfg in pairs(DT.Stage) do
    local stageGroupTid = stageCfg.BelongGroup
    local stageGroupType = StageGroupCfgUtils.GetCfgField("Type", stageGroupTid)
    if stageGroupType == CommonDefine.StageGroupType.RailWay then
      self:UpdateRailWayMO(stageCfg.ID, {maxScore = 0})
    end
  end
end

function RailWayModel:UpdateBySvrData(svrData)
  self:SetCurStageTid(svrData.currentStageTid)
  self:SetCurStage(svrData.currentProgress.currentStage)
  self:SetCurBattleNodeIdx(svrData.currentProgress.currentBattleNodeIndex)
  self:SetCurScore(svrData.currentProgress.scoreItemCount)
  self:SetCurSeasonId(svrData.currentProgress.seasonId)
  self:SetSeasonMaxScore(svrData.seasonMaxScore)
  for difficultyIndex, stageSvrData in pairs(svrData.difficultyStages) do
    local stageTid = stageSvrData.stageTid
    if stageTid then
      self:UpdateRailWayMO(stageTid, stageSvrData)
    end
    if stageSvrData.maxScore then
      local curMax = self._difficultyMaxScoreMap[difficultyIndex] or 0
      if curMax < stageSvrData.maxScore then
        self._difficultyMaxScoreMap[difficultyIndex] = stageSvrData.maxScore
      end
    end
  end
  EventMgr.Instance.OnRailWayDataChanged:Dispatch()
end

function RailWayModel:_AddRailWayMO(stageTid, railWayMO)
  if not stageTid or not railWayMO then
    return
  end
  self._stageTid2RailWayMODict[stageTid] = railWayMO
end

function RailWayModel:DelRailWayMO(stageTid)
  if not stageTid then
    return
  end
  self._stageTid2RailWayMODict[stageTid] = nil
end

function RailWayModel:UpdateRailWayMO(stageTid, railWaySvrData)
  if not stageTid or not railWaySvrData then
    return
  end
  local railWayMO = self:GetRailWayMO(stageTid)
  if not railWayMO then
    railWayMO = self:CreateRailWayMO(stageTid, railWaySvrData)
    self:_AddRailWayMO(stageTid, railWayMO)
  end
  railWayMO:UpdateData(stageTid, railWaySvrData)
end

function RailWayModel:SetCurStageTid(stageTid)
  if not stageTid then
    return
  end
  self._curStageTid = stageTid
end

function RailWayModel:SetCurStage(stage)
  if not stage then
    return
  end
  self._curStage = stage
end

function RailWayModel:SetCurBattleNodeIdx(battleNodeIdx)
  if not battleNodeIdx then
    return
  end
  self._curBattleNodeIdx = battleNodeIdx
end

function RailWayModel:SetCurScore(score)
  if not score then
    return
  end
  self._curScore = score
end

function RailWayModel:SetSeasonMaxScore(seasonMaxScore)
  if not seasonMaxScore then
    return
  end
  self._seasonMaxScore = seasonMaxScore
end

function RailWayModel:SetCurCreateTime(createTime)
  if not createTime then
    return
  end
  self._curCreateTime = createTime
end

function RailWayModel:SetCurSeasonId(seasonId)
  if not seasonId then
    return
  end
  self._curSeasonId = seasonId
end

function RailWayModel:GetRailWayMO(stageTid)
  return self._stageTid2RailWayMODict[stageTid]
end

function RailWayModel:GetRailWayMOByDifficult(difficult)
  local targetStageGroupId = self:_GetCurrentStageGroupId()
  local moList = {}
  for _, railWayMO in pairs(self._stageTid2RailWayMODict) do
    local stageTid = railWayMO:GetStageTid()
    local belongGroup = stageTid and DT.Stage[stageTid] and DT.Stage[stageTid].BelongGroup
    if not targetStageGroupId or belongGroup == targetStageGroupId then
      table.insert(moList, railWayMO)
    end
  end
  table.sort(moList, function(a, b)
    local aStageTid = a:GetStageTid()
    local bStageTid = b:GetStageTid()
    local aWeight = StageCfgUtils.GetCfgField("BaseSortID", aStageTid) or 0
    local bWeight = StageCfgUtils.GetCfgField("BaseSortID", bStageTid) or 0
    return aWeight < bWeight
  end)
  local mo = moList[difficult]
  if self._curStageTid and 0 ~= self._curStageTid and self:_GetDifficultyIndex(self._curStageTid) == difficult then
    mo = self:GetRailWayMO(self._curStageTid)
  end
  return mo
end

function RailWayModel:GetNotReceiveRewardInfoList()
  local notReceiveTaskRewardInfoList = TaskModel.Instance:GetNotReceiveTaskRewardInfoList(RailWayTaskGroup, CommonDefine.TaskType.TaskType_RailWay)
  local notReceiveCareerLevelRewardInfoList = CareerLevelModel.Instance:GetNotReceiveRewardInfoList(CareerLevelDefine.CareerLevelType.RailWay)
  local rst = {}
  local itemTid2NumDict = {}
  for _, rewardInfo in ipairs(notReceiveTaskRewardInfoList) do
    itemTid2NumDict[rewardInfo.tid] = (itemTid2NumDict[rewardInfo.tid] or 0) + rewardInfo.num
  end
  for _, rewardInfo in ipairs(notReceiveCareerLevelRewardInfoList) do
    itemTid2NumDict[rewardInfo.tid] = (itemTid2NumDict[rewardInfo.tid] or 0) + rewardInfo.num
  end
  for itemTid, num in pairs(itemTid2NumDict) do
    if not table.contains(RailWayActivityRemainRewardHideItems, itemTid) then
      table.insert(rst, {tid = itemTid, num = num})
    end
  end
  table.sort(rst, ItemDataUtils.CommonItemSortFunc)
  return rst
end

function RailWayModel:GetCurStageTid()
  return self._curStageTid
end

function RailWayModel:GetCurStage()
  return self._curStage
end

function RailWayModel:GetCurBattleNodeIdx()
  return self._curBattleNodeIdx
end

function RailWayModel:GetCurScore()
  return self._curScore or 0
end

function RailWayModel:GetSeasonMaxScore()
  return self._seasonMaxScore or 0
end

function RailWayModel:GetCurCreateTime()
  return self._curCreateTime
end

function RailWayModel:GetCurSeasonId()
  return self._curSeasonId
end

function RailWayModel:_GetDifficultyIndex(stageTid)
  if not stageTid or not DT.Stage[stageTid] then
    return nil
  end
  local seq = DT.Stage[stageTid].Sequence
  if not seq or seq < 1 or seq > 3 then
    return nil
  end
  return seq
end

function RailWayModel:GetDifficultyMaxScore(difficultyIndex)
  return self._difficultyMaxScoreMap[difficultyIndex] or 0
end

function RailWayModel:IsRailWayPlaying(stageTid)
  return self._curStageTid == stageTid
end

function RailWayModel:CreateRailWayMO(stageTid, svrData)
  local railWayMO = RailWayMO()
  railWayMO:UpdateData(stageTid, svrData)
  return railWayMO
end

return RailWayModel
