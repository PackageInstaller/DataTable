require("base_ins_r")
_class("PlayCasterBindRotationToTargetEffectInstruction", BaseInstruction)
PlayCasterBindRotationToTargetEffectInstruction = PlayCasterBindRotationToTargetEffectInstruction

function PlayCasterBindRotationToTargetEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._offsetX = tonumber(paramList.offsetx)
  self._offsetY = tonumber(paramList.offsety)
  self._offsetZ = tonumber(paramList.offsetz)
end

function PlayCasterBindRotationToTargetEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local tran = casterEntity:View():GetGameObject().transform
  local renderPos = tran:TransformPoint(Vector3(self._offsetX, self._offsetY, self._offsetZ))
  local effectEntity = world:GetService("Effect"):CreatePositionEffect(self._effectID, renderPos)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  local go = targetEntity:View():GetGameObject()
  local targetPos = go.transform.position
  local dir = targetPos - renderPos
  effectEntity:SetDirection(dir)
end

function PlayCasterBindRotationToTargetEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
