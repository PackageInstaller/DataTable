require("base_ins_r")
_class("PlayDeadEffectInstruction", BaseInstruction)
PlayDeadEffectInstruction = PlayDeadEffectInstruction

function PlayDeadEffectInstruction:Constructor(paramList)
  self._deadType = tonumber(paramList.deadType)
end

function PlayDeadEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local monsterDeadType = self._deadType
  local deathEffectID
  if self._deadType == DeathShowType.DissolveLight then
    casterEntity:NewPlayDeadLight()
    deathEffectID = BattleConst.MonsterDeadEffectLight
  elseif monsterDeadType == DeathShowType.DissolveDark then
    casterEntity:NewPlayDeadDark()
    deathEffectID = BattleConst.MonsterDeadEffectDark
  end
  if deathEffectID then
    local effectService = world:GetService("Effect")
    if type(deathEffectID) == "number" then
      deathEffectID = {deathEffectID}
    end
    for i, effID in ipairs(deathEffectID) do
      local effectEntity = effectService:CreateEffect(effID, casterEntity)
    end
  end
end

function PlayDeadEffectInstruction:GetCacheResource()
  local t = {}
  if BattleConst.MonsterDeadEffectLight and BattleConst.MonsterDeadEffectLight > 0 then
    table.insert(t, {
      Cfg.cfg_effect[BattleConst.MonsterDeadEffectLight].ResPath,
      1
    })
  end
  if BattleConst.MonsterDeadEffectDark and 0 < BattleConst.MonsterDeadEffectDark then
    table.insert(t, {
      Cfg.cfg_effect[BattleConst.MonsterDeadEffectDark].ResPath,
      1
    })
  end
  return t
end
