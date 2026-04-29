require("base_ins_r")
_class("PlayEffectAtTargetGridInstruction", BaseInstruction)
PlayEffectAtTargetGridInstruction = PlayEffectAtTargetGridInstruction

function PlayEffectAtTargetGridInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
end

function PlayEffectAtTargetGridInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  if not targetEntity then
    Log.fatal("PlayEffectAtTargetGridInstruction targetEntity nil. targetEntityID=", targetEntityID)
    return
  end
  local pos = targetEntity:GetGridPosition()
  local sEffect = world:GetService("Effect")
  sEffect:CreateWorldPositionEffect(self._effectID, pos)
end

function PlayEffectAtTargetGridInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
