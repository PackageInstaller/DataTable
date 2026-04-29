_class("BuffLogicChangeAttackByLayer", BuffLogicBase)
BuffLogicChangeAttackByLayer = BuffLogicChangeAttackByLayer

function BuffLogicChangeAttackByLayer:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._oneLayerAddMulValue = logicParam.oneLayerAddMulValue or 0
  self._maxAddMulValue = logicParam.maxAddMulValue
  self._oneLayerAddValue = logicParam.oneLayerAddValue or 0
  self._useCasterAttack = logicParam.useCasterAttack or 0
  self._useNotifyLayer = logicParam.useNotifyLayer or 0
  self._useTeamLayer = logicParam.useTeamLayer or 0
  self._usePetLayerPetID = logicParam.usePetLayerPetID
  self._overrideModifierIDByLayerType = logicParam.overrideModifierIDByLayerType
end

function BuffLogicChangeAttackByLayer:DoLogic(notify)
  local modifierID = self._overrideModifierIDByLayerType and self._layerType or self:GetBuffSeq()
  local context = self._buffInstance:Context()
  local casterEntity = context and context.casterEntity or nil
  local curMarkLayer = 0
  if self._useNotifyLayer == 1 then
    curMarkLayer = notify:GetLayer()
  else
    local layerEntity = self._entity
    if self._useTeamLayer == 1 then
      layerEntity = self._world:Player():GetCurrentTeamEntity()
    elseif self._usePetLayerPetID then
      local teamEntity = self._world:Player():GetCurrentTeamEntity()
      local pets = teamEntity:Team():GetTeamPetEntities()
      for i, e in ipairs(pets) do
        local cPetPstID = e:PetPstID()
        if self._usePetLayerPetID == cPetPstID:GetTemplateID() then
          layerEntity = e
          break
        end
      end
    end
    curMarkLayer = self._buffLogicService:GetBuffLayer(layerEntity, self._layerType)
  end
  self:PrintBuffLogicLog("BuffLogicChangeAttackByLayer layer=", curMarkLayer, "layerType=", self._layerType, " entity=", self._entity:GetID())
  if curMarkLayer then
    if self._oneLayerAddMulValue ~= 0 then
      local change = self._oneLayerAddMulValue * curMarkLayer
      if self._maxAddMulValue and change > self._maxAddMulValue then
        change = self._maxAddMulValue
      end
      if self._useCasterAttack == 1 and casterEntity then
        local attack = casterEntity:Attributes():GetAttribute("Attack")
        change = change * attack
        self._buffLogicService:ChangeBaseAttack(self._entity, modifierID, ModifyBaseAttackType.AttackConstantFix, change)
      else
        self._buffLogicService:ChangeBaseAttack(self._entity, modifierID, ModifyBaseAttackType.AttackPercentage, change)
      end
    end
    if self._oneLayerAddValue ~= 0 then
      local change = math.floor(self._oneLayerAddValue * curMarkLayer)
      self._buffLogicService:ChangeBaseAttack(self._entity, modifierID, ModifyBaseAttackType.AttackConstantFix, change)
    end
    return true
  end
end

function BuffLogicChangeAttackByLayer:DoOverlap(notify)
  self:DoLogic(notify)
end

_class("BuffLogicRemoveChangeAttackByLayer", BuffLogicBase)
BuffLogicRemoveChangeAttackByLayer = BuffLogicRemoveChangeAttackByLayer

function BuffLogicRemoveChangeAttackByLayer:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._overrideModifierIDByLayerType = logicParam.overrideModifierIDByLayerType
end

function BuffLogicRemoveChangeAttackByLayer:DoLogic()
  self:PrintBuffLogicLog("BuffLogicRemoveChangeAttackByLayer entity=", self._entity:GetID())
  local modifierID = self._overrideModifierIDByLayerType and self._layerType or self:GetBuffSeq()
  self._buffLogicService:RemoveBaseAttack(self._entity, modifierID, ModifyBaseAttackType.AttackPercentage)
  self._buffLogicService:RemoveBaseAttack(self._entity, modifierID, ModifyBaseAttackType.AttackConstantFix)
  return true
end

function BuffLogicRemoveChangeAttackByLayer:DoOverlap()
  return self:DoLogic()
end
