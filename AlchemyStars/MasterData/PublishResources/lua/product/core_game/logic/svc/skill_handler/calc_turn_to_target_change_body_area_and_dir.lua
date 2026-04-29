_class("SkillEffectCalc_TurnToTargetChangeBodyAreaAndDir", SkillEffectCalc_Base)
SkillEffectCalc_TurnToTargetChangeBodyAreaAndDir = SkillEffectCalc_TurnToTargetChangeBodyAreaAndDir

function SkillEffectCalc_TurnToTargetChangeBodyAreaAndDir:Constructor(world)
  self._world = world
end

function SkillEffectCalc_TurnToTargetChangeBodyAreaAndDir:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam.skillEffectParam
  local forceTurn = skillParam:GetForceTurn()
  local caster = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterBodyArea = caster:BodyArea():GetArea()
  local casterPos = caster:GetGridPosition()
  local casterDir = caster:GetGridDirection()
  local casterBodyAreaPosList = {}
  for _, area in ipairs(casterBodyArea) do
    local workPos = area + casterPos
    table.insert(casterBodyAreaPosList, workPos)
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local playerBodyArea = teamEntity:BodyArea():GetArea()
  local newBodyArea = casterBodyArea
  local newPos = casterPos
  local newDir = casterDir
  local utilDataSvc = self._world:GetService("UtilData")
  local vectors = {
    Vector2(-1, 0),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(0, 1)
  }
  local minIdx, minAngle = 1, 180
  local vec = playerPos - casterPos
  for i, v in ipairs(vectors) do
    local angle = Vector2.Angle(vec, v)
    if minAngle > angle then
      minAngle = angle
      minIdx = i
    end
  end
  newDir = vectors[minIdx]
  if table.count(casterBodyArea) == 6 then
    if newDir == Vector2(0, -1) then
      newBodyArea = {
        Vector2(0, 0),
        Vector2(1, 0),
        Vector2(-1, 0),
        Vector2(0, 1),
        Vector2(1, 1),
        Vector2(-1, 1)
      }
    elseif newDir == Vector2(1, 0) then
      newBodyArea = {
        Vector2(0, 0),
        Vector2(0, 1),
        Vector2(0, -1),
        Vector2(-1, 0),
        Vector2(-1, 1),
        Vector2(-1, -1)
      }
    elseif newDir == Vector2(-1, 0) then
      newBodyArea = {
        Vector2(0, 0),
        Vector2(0, 1),
        Vector2(0, -1),
        Vector2(1, 0),
        Vector2(1, 1),
        Vector2(1, -1)
      }
    elseif newDir == Vector2(0, 1) then
      newBodyArea = {
        Vector2(0, 0),
        Vector2(-1, 0),
        Vector2(1, 0),
        Vector2(0, -1),
        Vector2(-1, -1),
        Vector2(1, -1)
      }
    end
  end
  if forceTurn == 1 then
  else
    local canChangeBodyArea = true
    for _, area in ipairs(newBodyArea) do
      local workPos = area + casterPos
      if utilDataSvc:IsPosBlock(workPos, BlockFlag.MonsterLand) and not table.intable(casterBodyAreaPosList, workPos) then
        canChangeBodyArea = false
        break
      end
    end
    if canChangeBodyArea == false then
      newBodyArea = casterBodyArea
      newDir = casterDir
    end
  end
  local skillEffectResultContainer = caster:SkillContext():GetResultContainer()
  if newDir ~= casterDir then
    local skillRotateEffectResult = SkillRotateEffectResult:New(caster:GetID(), casterDir, newDir)
    skillEffectResultContainer:AddEffectResult(skillRotateEffectResult)
    local skillEffectResultChangeBodyArea = SkillEffectResultChangeBodyArea:New(caster:GetID(), newBodyArea)
    skillEffectResultContainer:AddEffectResult(skillEffectResultChangeBodyArea)
  end
  local colorOld = utilDataSvc:FindPieceElement(casterPos)
  local stageIndex = skillEffectCalcParam.skillEffectParam:GetSkillEffectDamageStageIndex()
  local skillEffectResult_Teleport = SkillEffectResult_Teleport:New(skillEffectCalcParam.casterEntityID, casterPos, colorOld, newPos, newDir, stageIndex)
  skillEffectResultContainer:AddEffectResult(skillEffectResult_Teleport)
end
