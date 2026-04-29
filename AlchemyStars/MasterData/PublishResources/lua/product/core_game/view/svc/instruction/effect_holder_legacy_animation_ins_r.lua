require("base_ins_r")
_class("EffectHolderLegacyAnimationInstruction", BaseInstruction)
EffectHolderLegacyAnimationInstruction = EffectHolderLegacyAnimationInstruction

function EffectHolderLegacyAnimationInstruction:Constructor(paramList)
  self._effHolderType = paramList.effHolderType
  local str = paramList.animNames
  self._animNames = string.split(str, "|")
end

function EffectHolderLegacyAnimationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  if self._animNames == nil then
    Log.fatal("Legacy animation params is nil!")
    return
  end
  local cEffectHolder = casterEntity:EffectHolder()
  if not cEffectHolder then
    Log.fatal("### no EffectHolderComponent on casterEntity")
    return
  end
  local effectList = {}
  if self._effHolderType == "Idle" then
    effectList = cEffectHolder:GetIdleEffect()
  elseif self._effHolderType == "Permanent" then
    effectList = cEffectHolder:GetPermanentEffect()
  else
    effectList = cEffectHolder:GetEffectList(self._effHolderType)
  end
  if not effectList then
    Log.fatal("### EffectHolderLegacyAnimationInstruction effectList nil", self._effHolderType)
    return
  end
  for i, eff in ipairs(effectList) do
    local e = world:GetEntityByID(eff)
    if e and e:HasView() then
      local go = e:View():GetGameObject()
      if go then
        local anim = go:GetComponentInChildren(typeof(UnityEngine.Animation))
        if anim then
          if table.count(self._animNames) > 1 then
            anim:Stop()
            for i = 1, #self._animNames do
              anim:PlayQueued(self._animNames[i])
            end
          else
            anim:Play(self._animNames[1])
          end
        else
          Log.fatal("### Cant play legacy animation, animation not found in ", go.name)
        end
      else
        Log.fatal("### no go. effId=", eff)
      end
    else
      Log.fatal("### no View. effId=", eff)
    end
  end
end
