local StageInitialStateModel = NewClass("StageInitialStateModel", BaseModel)

function StageInitialStateModel:GetInitialState(stageId)
  local stageCfg = DT.Stage[stageId]
  if not stageCfg then
    return
  end
  return stageCfg.StageInitState
end

function StageInitialStateModel:GetPositiveInitialState(stageId)
  local stageCfg = DT.Stage[stageId]
  if not stageCfg then
    return
  end
  return stageCfg.StagePositiveInitState
end

function StageInitialStateModel:GetStageInitStateText(stageId)
  local stageCfg = DT.Stage[stageId]
  if not stageCfg then
    return
  end
  return stageCfg.StageInitStateText or "DisasterReliefKuroshio"
end

function StageInitialStateModel:IsHideStageInitState(stageId)
  local stageCfg = DT.Stage[stageId]
  if not stageCfg then
    return false
  end
  return stageCfg.StageInitStateHide and 1 == stageCfg.StageInitStateHide or false
end

function StageInitialStateModel:ExistsInitialState(stageId)
  local stageInitialState = self:GetInitialState(stageId)
  local stagePositiveInitialState = self:GetPositiveInitialState(stageId)
  local existDebuffState = stageInitialState and #stageInitialState > 0
  local existBuffState = stagePositiveInitialState and #stagePositiveInitialState > 0
  return existDebuffState or existBuffState or false
end

function StageInitialStateModel:HasPositiveInitialBuffState(stageId)
  local stagePositiveInitialState = self:GetPositiveInitialState(stageId)
  if not stagePositiveInitialState then
    return false
  end
  return #stagePositiveInitialState > 0
end

return StageInitialStateModel
