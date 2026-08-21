require("base_ins_r")
_class("PlayCasterEffectHolderInstruction", BaseInstruction)
PlayCasterEffectHolderInstruction = PlayCasterEffectHolderInstruction

function PlayCasterEffectHolderInstruction:Constructor(paramList)
  self._effHolderType = paramList.effHolderType
  self._isShow = false
  local s = tonumber(paramList.isShow)
  if s == 1 then
    self._isShow = true
  end
end

function PlayCasterEffectHolderInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local cEffectHolder = casterEntity:EffectHolder()
  if not cEffectHolder then
    Log.warn("### no EffectHolderComponent on casterEntity. EntityId=", casterEntity:GetID())
    return
  end
  if self._effHolderType == "Idle" then
    effectService:ShowIdleEffect(casterEntity, self._isShow)
  elseif self._effHolderType == "Permanent" then
    effectService:ShowPermanentEffect(casterEntity, self._isShow)
  else
    local effectList = cEffectHolder:GetEffectList(self._effHolderType)
    effectService:ShowEffect(effectList, self._isShow)
  end
end
