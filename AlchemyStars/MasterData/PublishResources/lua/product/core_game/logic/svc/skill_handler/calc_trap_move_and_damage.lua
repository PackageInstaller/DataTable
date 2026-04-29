_class("SkillEffectCalc_TrapMoveAndDamage", Object)
SkillEffectCalc_TrapMoveAndDamage = SkillEffectCalc_TrapMoveAndDamage

function SkillEffectCalc_TrapMoveAndDamage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_TrapMoveAndDamage:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local casterDir = casterEntity:GetGridDirection()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local utilDataSvc = self._world:GetService("UtilData")
  local effectParam = skillEffectCalcParam.skillEffectParam
  local mobility = effectParam:GetMobility()
  local mirageSvc = self._world:GetService("MirageLogic")
  local mirageCmpt = mirageSvc:GetMirageComponent()
  if mirageCmpt:IsMirageForceClose() then
    local count = mirageCmpt:GetRemainRoundCount()
    if 0 < count then
      mobility = mobility * count
    end
  end
  local isHitPlayer = false
  local isOut = false
  local newPos = Vector2.zero
  local movePath = {}
  for i = 1, mobility do
    newPos = casterPos + casterDir * i
    if newPos == teamPos then
      isHitPlayer = true
      table.insert(movePath, newPos)
      break
    elseif not utilDataSvc:IsValidPiecePos(newPos) then
      isOut = true
      break
    end
    table.insert(movePath, newPos)
  end
  local walkResultList = self:DoWalk(casterEntity, movePath)
  local damageResult
  if isHitPlayer then
    damageResult = self:CalcDamageResult(skillEffectCalcParam)
  end
  local result = SkillEffectTrapMoveAndDamageResult:New(casterEntityID, walkResultList, damageResult, isOut)
  return {result}
end

function SkillEffectCalc_TrapMoveAndDamage:DoWalk(casterEntity, movePath)
  local sBoard = self._world:GetService("BoardLogic")
  local posWalkResultList = {}
  if #movePath ~= 0 then
    for _, pos in ipairs(movePath) do
      local posSelf = casterEntity:GetGridPosition()
      local walkRes = MonsterWalkResult:New()
      sBoard:UpdateEntityBlockFlag(casterEntity, posSelf, pos)
      casterEntity:SetGridPosition(pos)
      casterEntity:SetGridDirection(pos - posSelf)
      walkRes:SetWalkPos(pos)
      table.insert(posWalkResultList, walkRes)
    end
  end
  return posWalkResultList
end

function SkillEffectCalc_TrapMoveAndDamage:CalcDamageResult(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local damageResult
  local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(casterEntity, teamPos, teamEntity, teamPos, skillEffectCalcParam:GetSkillID(), skillEffectCalcParam:GetSkillEffectParam(), SkillEffectType.TrapMoveAndDamage, 1)
  damageResult = self._skillEffectService:NewSkillDamageEffectResult(teamPos, teamEntity:GetID(), nTotalDamage, listDamageInfo)
  return damageResult
end
