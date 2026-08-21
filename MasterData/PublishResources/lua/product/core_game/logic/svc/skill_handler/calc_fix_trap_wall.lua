_class("SkillEffectCalc_FixTrapWall", SkillEffectCalc_Base)
SkillEffectCalc_FixTrapWall = SkillEffectCalc_FixTrapWall

function SkillEffectCalc_FixTrapWall:Constructor(world)
  self._world = world
end

function SkillEffectCalc_FixTrapWall:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam.skillEffectParam
  local skillRange = skillEffectCalcParam.skillRange or {}
  local stageIndex = skillParam:GetSkillEffectDamageStageIndex()
  local fixTrapWallType = skillParam:GetFixTrapWallType()
  local skillParamPosList = skillParam:GetFixTrapWallPosList()
  local skillRangePosList = {}
  if skillParamPosList then
    for i, v in ipairs(skillParamPosList) do
      local pos = Vector2(v[1], v[2])
      table.insert(skillRangePosList, pos)
    end
  end
  local boardEntity = self._world:GetBoardEntity()
  local logicTrapWallComponent = boardEntity:LogicTrapWall()
  if not logicTrapWallComponent then
    return
  end
  local utilData = self._world:GetService("UtilData")
  local isAdd = true
  if fixTrapWallType >= FixTrapWallType.DeleteSelectPos then
    isAdd = false
  end
  local allTrapWallPosList = {}
  if fixTrapWallType == FixTrapWallType.AddSelectPos or fixTrapWallType == FixTrapWallType.DeleteSelectPos then
    allTrapWallPosList = skillRangePosList
  elseif fixTrapWallType == FixTrapWallType.AddSelectRange or fixTrapWallType == FixTrapWallType.DeleteSelectRange then
    allTrapWallPosList = utilData:CalcTrapWallPosEdgeAll(skillRangePosList)
  elseif fixTrapWallType == FixTrapWallType.AddSelectRangeOut then
    allTrapWallPosList = utilData:CalcTrapWallPosEdgeOut(skillRangePosList)
  elseif fixTrapWallType == FixTrapWallType.AddSkillRange or fixTrapWallType == FixTrapWallType.DeleteSkillRange then
    skillRangePosList = skillRange
    allTrapWallPosList = utilData:CalcTrapWallPosEdgeAll(skillRangePosList)
  elseif fixTrapWallType == FixTrapWallType.AddSkillRangeOut then
    skillRangePosList = skillRange
    allTrapWallPosList = utilData:CalcTrapWallPosEdgeOut(skillRangePosList)
  elseif fixTrapWallType == FixTrapWallType.DeleteSelectRangeIn then
    allTrapWallPosList = utilData:CalcTrapWallPosEdgeIn(skillRangePosList)
  elseif fixTrapWallType == FixTrapWallType.DeleteSkillRangeIn then
    skillRangePosList = skillRange
    allTrapWallPosList = utilData:CalcTrapWallPosEdgeIn(skillRangePosList)
  end
  if fixTrapWallType < FixTrapWallType.DeleteSelectPos then
    local invalidPosList = utilData:OnGetInvalidCreateTrapWallPosList()
    for _, pos in ipairs(invalidPosList) do
      table.removev(allTrapWallPosList, pos)
    end
  end
  local skillResult = SkillEffectResultFixTrapWall:New(isAdd, allTrapWallPosList, stageIndex)
  return skillResult
end
