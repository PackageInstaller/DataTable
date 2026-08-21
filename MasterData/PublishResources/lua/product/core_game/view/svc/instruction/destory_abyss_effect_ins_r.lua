require("base_ins_r")
_class("DestroyAbyssEffectInstruction", BaseInstruction)
DestroyAbyssEffectInstruction = DestroyAbyssEffectInstruction

function DestroyAbyssEffectInstruction:Constructor(paramList)
end

function DestroyAbyssEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  self._casterEntity = casterEntity
  if not casterEntity:HasTrapID() then
    return
  end
  local cEffectHolder = casterEntity:EffectHolder()
  if not cEffectHolder then
    casterEntity:AddEffectHolder()
  end
  cEffectHolder = casterEntity:EffectHolder()
  local dictEffectId = cEffectHolder:GetDictEffectId()
  if dictEffectId then
    for key, list in pairs(dictEffectId) do
      for index, id in ipairs(list) do
        local eEffect = self._world:GetEntityByID(id)
        if eEffect then
          self._world:DestroyEntity(eEffect)
        end
      end
    end
  end
end
