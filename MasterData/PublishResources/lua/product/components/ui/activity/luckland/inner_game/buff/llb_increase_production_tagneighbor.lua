require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionTagNeighbor", LLBuffLogicBase)
LLBuffLogicIncreaseProductionTagNeighbor = LLBuffLogicIncreaseProductionTagNeighbor

function LLBuffLogicIncreaseProductionTagNeighbor:Constructor(buffObj, logicParam)
  self._tagType = logicParam.tagType
  self._tagParam = logicParam.tagParam
  self._distance = logicParam.distance
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicIncreaseProductionTagNeighbor:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local deltaValue = 0
  if notifyEntity:GetEntityType() == LuckLandEntityType.Pet then
    local petEntity = notifyEntity
    local pets = LuckLandTriggerTool.GetPetsByTag(self._tagType, self._tagParam)
    if pets then
      local resultPets = {}
      if self._distance then
        for _, pet in pairs(pets) do
          if pet:ID() ~= petEntity:ID() and LuckLandTriggerTool.Distance(pet, petEntity) <= self._distance then
            table.insert(resultPets, pet)
          end
        end
      end
      deltaValue = #resultPets
    end
  end
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, deltaValue)
  end
end

function LLBuffLogicIncreaseProductionTagNeighbor:DoLogicSingle(target, deltaValue)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  if self._incType == LuckLandIncType.Accumulate then
    if self._fixVal then
      target:AddAccFixValue(self._fixVal * deltaValue)
    end
    if self._perVal then
      target:AddAccPerValue(self._perVal * deltaValue)
    end
  elseif self._incType == LuckLandIncType.Temp then
    if self._fixVal then
      target:AddTempFixValue(self._fixVal * deltaValue)
    end
    if self._perVal then
      target:AddTempPerValue(self._perVal * deltaValue)
    end
  end
end
