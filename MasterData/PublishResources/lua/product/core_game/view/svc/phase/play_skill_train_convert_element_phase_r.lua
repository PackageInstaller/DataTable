require("play_skill_phase_base_r")
_class("PlaySkillTrainConvertElementPhase", PlaySkillPhaseBase)
PlaySkillTrainConvertElementPhase = PlaySkillTrainConvertElementPhase

function PlaySkillTrainConvertElementPhase:PlayFlight(TT, casterEntity, phaseParam)
  local trainConvertElementParam = phaseParam
  local gridEffectID = trainConvertElementParam:GetGridEffectID()
  local bestEffectTime = trainConvertElementParam:GetBestEffectTime()
  local gridIntervalTime = trainConvertElementParam:GetGridIntervalTime()
  local castPos = casterEntity:GridLocation().Position
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local targetGridType
  local convertResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ConvertGridElement)
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local convertGridPosList = convertResult:GetTargetGridArray()
  local directType = renderPickUpComponent:GetLastPickUpDirection()
  local gridPosList = self:_SortGridByDirection(convertGridPosList, directType)
  local beginIndex, endIndex, step = self:_GetStepAndBegin(directType)
  targetGridType = convertResult:GetTargetElementType()
  for index = beginIndex, endIndex, step do
    local posList = gridPosList[index]
    if posList then
      for _, pos in pairs(posList) do
        GameGlobal.TaskManager():CoreGameStartTask(self:SkillService()._SingleGridEffect, self:SkillService(), gridEffectID, pos, bestEffectTime, targetGridType)
      end
    end
    if index ~= endIndex then
      YIELD(TT, gridIntervalTime)
    end
  end
  local finishDelayTime = trainConvertElementParam:GetFinishDelayTime()
  YIELD(TT, finishDelayTime)
end

function PlaySkillTrainConvertElementPhase:_SortGridByDirection(girdPosList, directionType)
  local girdList = {}
  if directionType == HitBackDirectionType.Up or directionType == HitBackDirectionType.Down then
    for _, pos in pairs(girdPosList) do
      if not girdList[pos.y] then
        girdList[pos.y] = {}
      end
      table.insert(girdList[pos.y], pos)
    end
  elseif directionType == HitBackDirectionType.Left or directionType == HitBackDirectionType.Right then
    for _, pos in pairs(girdPosList) do
      if not girdList[pos.x] then
        girdList[pos.x] = {}
      end
      table.insert(girdList[pos.x], pos)
    end
  end
  return girdList
end

function PlaySkillTrainConvertElementPhase:_GetStepAndBegin(directionType)
  local utilData = self._world:GetService("UtilData")
  local maxLen = utilData:GetCurBoardMaxLen()
  if directionType == HitBackDirectionType.Down or directionType == HitBackDirectionType.Left then
    return maxLen, 1, -1
  elseif directionType == HitBackDirectionType.Up or directionType == HitBackDirectionType.Right then
    return 1, maxLen + 1, 1
  end
end
