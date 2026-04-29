_class("SkillEffectCalc_StickerLeave", Object)
SkillEffectCalc_StickerLeave = SkillEffectCalc_StickerLeave

function SkillEffectCalc_StickerLeave:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_StickerLeave:DoSkillEffectCalculator(skillEffectCalcParam)
  local pos = skillEffectCalcParam.attackPos
  local sep = skillEffectCalcParam.skillEffectParam
  local convertColor = sep:GetConvertColor()
  local boardCmpt = self._world:GetBoardEntity():Board()
  local es = boardCmpt:GetPieceEntities(pos, function(e)
    return e:Trap() and e:Trap():GetTrapType() == TrapType.TerrainAbyss
  end)
  local range = {}
  local color = boardCmpt:GetPieceType(pos)
  local onAbyss = 0 < #es
  if onAbyss then
    range[#range + 1] = pos
    color = PieceType.None
  elseif convertColor and convertColor > PieceType.None and convertColor <= PieceType.Any then
    local boardServiceLogic = self._world:GetService("BoardLogic")
    local canConverPos = boardServiceLogic:GetCanConvertGridElement(pos)
    if canConverPos then
      range[#range + 1] = pos
      color = convertColor
    end
  end
  local skillConvertEffectResult = SkillConvertGridElementEffectResult:New(range, color)
  return skillConvertEffectResult
end
