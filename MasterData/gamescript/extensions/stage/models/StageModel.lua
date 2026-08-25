local StageModel = NewClass("StageModel", BaseModel)

function StageModel:OnInit()
  self:OnReset()
end

function StageModel:OnReset()
end

function StageModel:IsStageCanSweepBySweepType(stageTid)
  local stageSweepType = StageCfgUtils.GetStageSweepType(stageTid)
  if not stageSweepType or stageSweepType == StageDefine.StageSweepType.Unable then
    return false
  end
  local stageData = MainCopyDataUtils.GetStageData(stageTid)
  if not stageData then
    return false
  end
  if stageSweepType == StageDefine.StageSweepType.ThreeStarAble then
    return stageData.star >= 3
  end
  if stageSweepType == StageDefine.StageSweepType.PassedAble then
    return stageData.firstRewardDraw or (stageData.star or 0) > 0
  end
  return false
end

return StageModel
