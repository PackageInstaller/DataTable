require("calc_base")
_class("SkillEffectCalc_SchummerHitback", SkillEffectCalc_Base)
SkillEffectCalc_SchummerHitback = SkillEffectCalc_SchummerHitback
SkillEffectCalc_SchummerHitback.Directions = {
  Vector2.up,
  Vector2.down,
  Vector2.left,
  Vector2.right
}

function SkillEffectCalc_SchummerHitback:CalculateOnSingleTarget(skillEffectCalcParam, targetID)
  local entity = self._world:GetEntityByID(targetID)
  local pos = entity:GetGridPosition()
  local distance = 9
  local exceptPosList
  local ignorePlayerBlock = false
  local idCaster = skillEffectCalcParam:GetCasterEntityID()
  local eCaster = self._world:GetEntityByID(idCaster)
  local v2CasterPos = eCaster:GetGridPosition()
  local v2FinalDir = Vector2.zero
  local v2FinalPos = Vector2.zero
  local distanceHitback = 0
  for _, v2Dir in ipairs(SkillEffectCalc_SchummerHitback.Directions) do
    local v2Pos = self._skillEffectService:CalHitbackPosByEntityDir(pos, entity:BodyArea(), v2Dir, distance, exceptPosList, ignorePlayerBlock, entity)
    local dis = Vector2.Distance(v2CasterPos, v2Pos)
    if distanceHitback < dis then
      v2FinalDir = v2Dir
      v2FinalPos = v2Pos
      distanceHitback = dis
    end
  end
  if v2FinalPos == Vector2.zero then
    return
  end
  local hitbackDirType
  if v2FinalDir == Vector2.up then
    hitbackDirType = HitBackDirectionType.Up
  elseif v2FinalDir == Vector2.right then
    hitbackDirType = HitBackDirectionType.Right
  elseif v2FinalDir == Vector2.down then
    hitbackDirType = HitBackDirectionType.Down
  elseif v2FinalDir == Vector2.left then
    hitbackDirType = HitBackDirectionType.Left
  end
  local skillRange = skillEffectCalcParam.skillRange
  return self._skillEffectService:CalcHitbackEffectResult(eCaster:GetGridPosition(), eCaster:GetGridDirection(), eCaster:BodyArea():GetArea(), targetID, hitbackDirType, HitBackType.PushAway, distance, HitBackCalcType.Instant, ignorePlayerBlock, false, eCaster, skillRange, nil, nil, nil, nil, skillEffectCalcParam:GetSkillEffectParam():GetSkillType())
end
