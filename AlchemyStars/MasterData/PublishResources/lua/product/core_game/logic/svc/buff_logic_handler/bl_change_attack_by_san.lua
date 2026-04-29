_class("BuffLogicChangeAttackBySan", BuffLogicBase)
BuffLogicChangeAttackBySan = BuffLogicChangeAttackBySan

function BuffLogicChangeAttackBySan:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._baseSan = logicParam.baseSan or 100
  self._minValue = logicParam.minValue
  self._maxValue = logicParam.maxValue
  self._attackSourceType = logicParam.attackSourceType
  self._attackSourceParam = logicParam.attackSourceParam
end

function BuffLogicChangeAttackBySan:DoLogic()
  local featureLogicSvc = self._world:GetService("FeatureLogic")
  if not featureLogicSvc then
    return
  end
  if not featureLogicSvc:HasFeatureType(FeatureType.Sanity) then
    return
  end
  local curSanValue = featureLogicSvc:GetSanValue()
  local entity = self._buffInstance:Entity()
  local baseAttack = self:ChangeAttackBySan_CalcBaseAttack()
  local changeSan = curSanValue - self._baseSan
  local newChangeValue = changeSan * self._mulValue
  if self._minValue then
    newChangeValue = math.max(newChangeValue, self._minValue)
  end
  if self._maxValue then
    newChangeValue = math.min(newChangeValue, self._maxValue)
  end
  local attack = math.floor(baseAttack * newChangeValue)
  Log.debug("CalcChangeAttackBySan entity=", entity:GetID(), " baseAttack=", baseAttack, " curSanValue=", curSanValue, " newChangeValue=", newChangeValue, " deltaAttack=", attack)
  self._buffLogicService:ChangeBaseAttack(entity, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix, attack)
end

function BuffLogicChangeAttackBySan:ChangeAttackBySan_CalcBaseAttack()
  local sourceEntity = self._buffInstance:Entity()
  if self._attackSourceType == 1 then
    local specialPetTemplateID = self._attackSourceParam
    local petPstIDGroup = self._world:GetGroup(self._world.BW_WEMatchers.PetPstID)
    for i, e in ipairs(petPstIDGroup:GetEntities()) do
      local petPstIDCmpt = e:PetPstID()
      local tmplateID = petPstIDCmpt:GetTemplateID()
      if specialPetTemplateID == tmplateID then
        sourceEntity = e
        break
      end
    end
  end
  local lsvcFormula = self._world:GetService("Formula")
  local baseAttack = lsvcFormula:CalcAttack(sourceEntity)
  return baseAttack
end

_class("BuffLogicRemoveAttackBySan", BuffLogicBase)
BuffLogicRemoveAttackBySan = BuffLogicRemoveAttackBySan

function BuffLogicRemoveAttackBySan:DoLogic()
  local entity = self._buffInstance:Entity()
  self._buffLogicService:RemoveBaseAttack(entity, self:GetBuffSeq(), ModifyBaseAttackType.AttackConstantFix)
end
