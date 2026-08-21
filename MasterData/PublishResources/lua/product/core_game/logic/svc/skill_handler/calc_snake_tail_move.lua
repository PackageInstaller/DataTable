_class("SkillEffectCalc_SnakeTailMove", Object)
SkillEffectCalc_SnakeTailMove = SkillEffectCalc_SnakeTailMove

function SkillEffectCalc_SnakeTailMove:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._monsterShowLogic = self._world:GetService("MonsterShowLogic")
end

function SkillEffectCalc_SnakeTailMove:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterID = skillEffectCalcParam.casterEntityID
  local casterEntity = self._world:GetEntityByID(casterID)
  local casterPos = casterEntity:GetGridPosition()
  local effectParam = skillEffectCalcParam.skillEffectParam
  local snakeMoveType = effectParam:GetMoveType()
  local bodyMonsterID = effectParam:GetBodyMonsterID()
  local utilDataSvc = self._world:GetService("UtilData")
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local boardEntity = self._world:GetBoardEntity()
  local shareResultCmpt = boardEntity:ShareSkillResult()
  local bodyEntityList = utilDataSvc:FindMonsterByMonsterID(bodyMonsterID)
  local bodyEntity = bodyEntityList[1]
  if bodyEntity:HasDeadMark() then
    casterEntity:Attributes():Modify("HP", 0)
    self._monsterShowLogic:AddMonsterDeadMark(casterEntity)
    Log.debug("SnakeTailDead ModifyHP =0 defender=", casterEntity:GetID())
    local result = SkillEffectSnakeTailMoveResult:New(nil, true)
    return result
  end
  local resultContainer = shareResultCmpt:GetResultContainerByEntityID(bodyEntity:GetID())
  local resultArray = resultContainer:GetEffectResultsAsArray(SkillEffectType.SnakeBodyMoveAndGrowth)
  Log.info("SnakeBodyMoveResultCount:", #resultArray)
  local bodyMoveAndGrowthResult = resultArray[#resultArray]
  if bodyMoveAndGrowthResult:IsCasterDead() then
    casterEntity:Attributes():Modify("HP", 0)
    self._monsterShowLogic:AddMonsterDeadMark(casterEntity)
    Log.debug("SnakeTailDead ModifyHP =0 defender=", casterEntity:GetID())
    local result = SkillEffectSnakeTailMoveResult:New(nil, bodyMoveAndGrowthResult:IsCasterDead())
    return result
  end
  local newBodyPos = bodyMoveAndGrowthResult:GetNewBodyPos()
  local result
  if not newBodyPos then
    local oldBodyArea = bodyMoveAndGrowthResult:GetOldBodyArea()
    local newBodyArea = bodyMoveAndGrowthResult:GetNewBodyArea()
    local oldBodyPos = bodyMoveAndGrowthResult:GetBodyOldPos()
    local bodyNewPos = bodyMoveAndGrowthResult:GetBodyNewPos()
    local tailPos = oldBodyArea[#oldBodyArea] + oldBodyPos
    Log.info("SnakeNewTailPos:", tailPos)
    local lastBodyPos = newBodyArea[#newBodyArea] + bodyNewPos
    Log.info("SnakeBodyLastPos:", lastBodyPos)
    result = SkillEffectSnakeTailMoveResult:New(tailPos, bodyMoveAndGrowthResult:IsCasterDead())
    result:SetLastBodyPos(lastBodyPos)
  else
    Log.info("SnakeNewTailPos:Nil", "newBodyPos:", newBodyPos)
    result = SkillEffectSnakeTailMoveResult:New(nil, bodyMoveAndGrowthResult:IsCasterDead())
  end
  return result
end
