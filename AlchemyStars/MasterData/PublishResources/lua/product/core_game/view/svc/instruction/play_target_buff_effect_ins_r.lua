require("base_ins_r")
_class("PlayTargetBuffEffectInstruction", BaseInstruction)
PlayTargetBuffEffectInstruction = PlayTargetBuffEffectInstruction

function PlayTargetBuffEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
end

function PlayTargetBuffEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end

function PlayTargetBuffEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playBuffService = world:GetService("PlayBuff")
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  if targetEntityID and 0 < targetEntityID then
    local targetEntity = world:GetEntityByID(targetEntityID)
    local effect = world:GetService("Effect"):CreateEffect(self._effectID, targetEntity)
  end
end
