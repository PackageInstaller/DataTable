require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionTag", LLBuffLogicBase)
LLBuffLogicIncreaseProductionTag = LLBuffLogicIncreaseProductionTag

function LLBuffLogicIncreaseProductionTag:Constructor(buffObj, logicParam)
  self._tagType = logicParam.tagType
  self._tagParam = logicParam.tagParam
  self._containSelf = logicParam.containSelf
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicIncreaseProductionTag:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local petCount = 0
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  local pets
  if self._tagType == LLPetTagType.Element then
    pets = entityMgr:GetFightPetsByElement(self._tagParam)
  elseif self._tagType == LLPetTagType.Camp then
    pets = entityMgr:GetFightPetsByCamp(self._tagParam)
  elseif self._tagType == LLPetTagType.Level then
    pets = entityMgr:GetFightPetsByLevel(self._tagParam)
  elseif self._tagType == LLPetTagType.Res then
    pets = entityMgr:GetFightPetsByResType(self._tagParam)
  end
  if pets then
    if self._containSelf then
      petCount = #pets
    elseif notifyEntity:GetEntityType() == LuckLandEntityType.Pet then
      local result = {}
      for _, pet in pairs(pets) do
        if pet:ID() ~= notifyEntity:ID() then
          table.insert(result, pet)
        end
      end
      petCount = #result
    end
  end
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, petCount)
  end
end

function LLBuffLogicIncreaseProductionTag:DoLogicSingle(target, petCount)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  if self._incType == LuckLandIncType.Accumulate then
    if self._fixVal then
      target:AddAccFixValue(self._fixVal * petCount)
    end
    if self._perVal then
      target:AddAccPerValue(self._perVal * petCount)
    end
  elseif self._incType == LuckLandIncType.Temp then
    if self._fixVal then
      target:AddTempFixValue(self._fixVal * petCount)
    end
    if self._perVal then
      target:AddTempPerValue(self._perVal * petCount)
    end
  end
end
