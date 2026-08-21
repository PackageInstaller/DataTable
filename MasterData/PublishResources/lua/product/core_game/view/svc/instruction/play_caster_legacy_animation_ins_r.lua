require("base_ins_r")
_class("PlayCasterLegacyAnimationInstruction", BaseInstruction)
PlayCasterLegacyAnimationInstruction = PlayCasterLegacyAnimationInstruction

function PlayCasterLegacyAnimationInstruction:Constructor(paramList)
  local str = paramList.animNames
  self._animNames = string.split(str, "|")
  self._playOnSuper = tonumber(paramList.playOnSuper) == 1
end

function PlayCasterLegacyAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._animNames == nil then
    Log.fatal("Legacy animation params is nil!")
    return
  end
  local e = casterEntity
  if casterEntity:HasSuperEntity() and self._playOnSuper then
    e = casterEntity:GetSuperEntity()
  end
  if not e:HasView() then
    Log.fatal("view not found, cant play legacy animation")
    return
  end
  local go = e:View():GetGameObject()
  local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
  if anim == nil then
    Log.fatal("Cant play legacy animation, animation not found in ", go.name)
    return
  end
  if table.count(self._animNames) > 1 then
    anim:Stop()
    for i = 1, #self._animNames do
      anim:PlayQueued(self._animNames[i])
    end
  else
    anim:Play(self._animNames[1])
  end
end
