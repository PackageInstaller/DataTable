require("base_ins_r")
_class("PlayDeleteCasterEffectInstruction", BaseInstruction)
PlayDeleteCasterEffectInstruction = PlayDeleteCasterEffectInstruction

function PlayDeleteCasterEffectInstruction:Constructor(paramList)
  local str = paramList.effectIDList
  local tmpStrIDList = string.split(str, "|")
  self._deleteEffectID = {}
  for i, strID in ipairs(tmpStrIDList) do
    table.insert(self._deleteEffectID, tonumber(strID))
  end
end

function PlayDeleteCasterEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  if casterEntity:HasEffectHolder() then
    local effectHolderCmpt = casterEntity:EffectHolder()
    local effectDictList1 = effectHolderCmpt:GetDictEffectId()
    local effectDictList2 = effectHolderCmpt:GetEffectIDEntityDic()
    self:DeleteEffect(effectDictList1)
    self:DeleteEffect(effectDictList2)
  end
end

function PlayDeleteCasterEffectInstruction:DeleteEffect(effectList)
  for effectID, entityIDList in pairs(effectList) do
    if table.icontains(self._deleteEffectID, effectID) then
      for i, entityID in ipairs(entityIDList) do
        local entity = self._world:GetEntityByID(entityID)
        if entity then
          self._world:DestroyEntity(entity)
        end
      end
    end
  end
  for effectID, entityIDList in pairs(effectList) do
    if table.icontains(self._deleteEffectID, effectID) then
      entityIDList = {}
    end
  end
end
