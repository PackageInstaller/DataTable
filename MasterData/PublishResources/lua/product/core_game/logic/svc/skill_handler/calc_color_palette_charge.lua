_class("SkillEffectCalc_ColorPaletteCharge", Object)
SkillEffectCalc_ColorPaletteCharge = SkillEffectCalc_ColorPaletteCharge

function SkillEffectCalc_ColorPaletteCharge:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_ColorPaletteCharge:DoSkillEffectCalculator(skillEffectCalcParam)
  local result = {}
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local pickupComponent = casterEntity:ActiveSkillPickUpComponent()
  if not pickupComponent then
    Log.error(self._className, "施法者没有ActiveSkillPickupComponent")
    return
  end
  local pickupPosArray = pickupComponent:GetAllValidPickUpGridPos()
  if #pickupPosArray == 0 then
    Log.error(self._className, "没有点选位置记录")
    return
  end
  local board = self._world:GetBoardEntity():Board()
  for _, pos in pairs(pickupPosArray) do
    local pieceType = board:GetPieceType(pos)
    table.insert(result, SkillEffectResultColorPaletteCharge:New(pieceType))
  end
  return result
end
