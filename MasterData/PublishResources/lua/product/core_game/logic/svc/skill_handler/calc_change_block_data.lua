_class("SkillEffectCalc_ChangeBlockData", Object)
SkillEffectCalc_ChangeBlockData = SkillEffectCalc_ChangeBlockData

function SkillEffectCalc_ChangeBlockData:Constructor(world)
  self._world = world
end

function SkillEffectCalc_ChangeBlockData:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillParam = skillEffectCalcParam.skillEffectParam
  local change = skillParam:GetChangeType()
  local centerPos = skillEffectCalcParam.centerPos
  local boardCmpt = self._world:GetBoardEntity():Board()
  local blockData = boardCmpt:FindBlockByPos(centerPos)
  local es = boardCmpt:GetPieceEntities(centerPos, function(e)
    return e:Trap() and e:Trap():GetTrapType() == TrapType.TerrainAbyss
  end)
  if #es == 0 then
    return SkillEffectResultChangeBlockData:New(false, change)
  end
  local e = es[1]
  if change == "push" then
    blockData:AddBlock(e:GetID(), 0)
  elseif change == "pop" then
    blockData:AddBlock(e:GetID(), e:BlockFlag():GetBlockFlag())
  end
  return SkillEffectResultChangeBlockData:New(true, change)
end
