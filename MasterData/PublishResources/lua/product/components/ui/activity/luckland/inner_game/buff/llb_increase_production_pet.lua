require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionPet", LLBuffLogicBase)
LLBuffLogicIncreaseProductionPet = LLBuffLogicIncreaseProductionPet

function LLBuffLogicIncreaseProductionPet:Constructor(buffObj, logicParam)
  self._id = logicParam.id
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicIncreaseProductionPet:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local petCount = 0
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  local fightPets = entityMgr:GetFightPets()
  if fightPets then
    for _, pet in pairs(fightPets) do
      if pet:GetTemplateID() == self._id then
        petCount = petCount + 1
      end
    end
  end
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, petCount)
  end
end

function LLBuffLogicIncreaseProductionPet:DoLogicSingle(target, fightPetCount)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  if self._incType == LuckLandIncType.Accumulate then
    if self._fixVal then
      target:AddAccFixValue(self._fixVal * fightPetCount)
    end
    if self._perVal then
      target:AddAccPerValue(self._perVal * fightPetCount)
    end
  elseif self._incType == LuckLandIncType.Temp then
    if self._fixVal then
      target:AddTempFixValue(self._fixVal * fightPetCount)
    end
    if self._perVal then
      target:AddTempPerValue(self._perVal * fightPetCount)
    end
  end
end
