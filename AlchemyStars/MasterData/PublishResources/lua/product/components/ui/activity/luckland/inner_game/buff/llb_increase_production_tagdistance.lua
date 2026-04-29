require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionTagDistance", LLBuffLogicBase)
LLBuffLogicIncreaseProductionTagDistance = LLBuffLogicIncreaseProductionTagDistance

function LLBuffLogicIncreaseProductionTagDistance:Constructor(buffObj, logicParam)
  self._tagType = logicParam.tagType
  self._tagParam = logicParam.tagParam
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicIncreaseProductionTagDistance:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local maxDistance = 0
  local pets = LuckLandTriggerTool.GetPetsByTag(self._tagType, self._tagParam)
  if pets and notifyEntity:GetEntityType() == LuckLandEntityType.Pet then
    local petEntity = notifyEntity
    for _, pet in pairs(pets) do
      local distance = LuckLandTriggerTool.Distance(petEntity, pet)
      if maxDistance < distance then
        maxDistance = distance
      end
    end
  end
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, maxDistance)
  end
end

function LLBuffLogicIncreaseProductionTagDistance:DoLogicSingle(target, maxDistance)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  if self._incType == LuckLandIncType.Accumulate then
    if self._fixVal then
      target:AddAccFixValue(self._fixVal * maxDistance)
    end
    if self._perVal then
      target:AddAccPerValue(self._perVal * maxDistance)
    end
  elseif self._incType == LuckLandIncType.Temp then
    if self._fixVal then
      target:AddTempFixValue(self._fixVal * maxDistance)
    end
    if self._perVal then
      target:AddTempPerValue(self._perVal * maxDistance)
    end
  end
end
