_class("SkillEffectCalc_PullAround", Object)
SkillEffectCalc_PullAround = SkillEffectCalc_PullAround

function SkillEffectCalc_PullAround:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_PullAround:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    table.insert(results, self:_CalculateSingleTarget(skillEffectCalcParam, targetID))
  end
  return results
end

function SkillEffectCalc_PullAround:_CalculateSingleTarget(skillEffectCalcParam, targetEntityID)
  local skillPullAroundEffectParam = skillEffectCalcParam.skillEffectParam
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local attackerPos = attacker:GridLocation().Position
  local attackerBodyArea = attacker:BodyArea()
  local defender = self._world:GetEntityByID(targetEntityID)
  local defenderPos = defender:GridLocation().Position
  local defenderBodyArea = defender:BodyArea()
  local buffLogicService = self._world:GetService("BuffLogic")
  if not buffLogicService:CheckCanBePullAround(defender) then
    return
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local dir = utilCalcSvc:_CalcHitBackDir(HitBackDirectionType.EightDir, attackerPos, defenderPos, attackerBodyArea, defenderBodyArea)
  local atkBodyAreaVec = attackerBodyArea:GetArea()
  local targetPos = defenderPos:Clone()
  if dir.x < 0 then
    targetPos.x = BodyAreaHelper.GetBodyAreaLeft(atkBodyAreaVec) + attackerPos.x - 1
  elseif dir.x > 0 then
    targetPos.x = BodyAreaHelper.GetBodyAreaRight(atkBodyAreaVec) + attackerPos.x + 1
  end
  if 0 > dir.y then
    targetPos.y = BodyAreaHelper.GetBodyAreaDown(atkBodyAreaVec) + attackerPos.y - 1
  elseif 0 < dir.y then
    targetPos.y = BodyAreaHelper.GetBodyAreaUp(atkBodyAreaVec) + attackerPos.y + 1
  end
  local utilData = self._world:GetService("UtilData")
  if not utilData:IsValidPiecePos(targetPos) or boardServiceLogic:IsPosBlock(targetPos, BlockFlag.Skill | BlockFlag.SkillSkip) then
    targetPos = defenderPos
  end
  local utilData = self._world:GetService("UtilData")
  local pieceChangeTable = {}
  if defenderPos ~= targetPos and utilData:FindPieceElement(defenderPos) == PieceType.None then
    local supplyRes = boardServiceLogic:SupplyPieceList({defenderPos})
    for i = 1, #supplyRes do
      local res = supplyRes[i]
      pieceChangeTable[Vector2(res.x, res.y)] = res.color
    end
  end
  return SkillPullAroundEffectResult:New(targetEntityID, targetPos, pieceChangeTable)
end
