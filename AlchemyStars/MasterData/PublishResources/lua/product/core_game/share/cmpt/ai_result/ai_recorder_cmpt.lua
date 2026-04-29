_class("AIRecorderComponent", Object)
AIRecorderComponent = AIRecorderComponent

function AIRecorderComponent:Constructor()
  self._aiResultCollectionDict = nil
  self._aiCastSkillSequece = nil
  self._aiWalkSequence = nil
  self._aiRotateBodyAreaSequence = nil
  self._orderResultList = {}
  self._orderCastSkillSequence = {}
  self._orderWalkSequence = {}
  self._orderRotateBodyAreaSequence = {}
  self._parallelPlayResultCollectionDict = nil
end

function AIRecorderComponent:ClearAIRecorder()
  self._aiResultCollectionDict = nil
  self._aiCastSkillSequece = nil
  self._aiWalkSequence = nil
  self._aiRotateBodyAreaSequence = nil
  self._orderResultList = {}
  self._orderCastSkillSequence = {}
  self._orderWalkSequence = {}
  self._orderRotateBodyAreaSequence = {}
end

function AIRecorderComponent:AddOrderResult(order)
  local res = self._orderResultList[order]
  if res then
    return
  end
  self._orderResultList[order] = {}
  self._orderCastSkillSequence[order] = {}
  self._orderWalkSequence[order] = {}
  self._orderRotateBodyAreaSequence[order] = {}
  self._aiResultCollectionDict = self._orderResultList[order]
  self._aiCastSkillSequece = self._orderCastSkillSequence[order]
  self._aiWalkSequence = self._orderWalkSequence[order]
  self._aiRotateBodyAreaSequence = self._orderRotateBodyAreaSequence[order]
end

function AIRecorderComponent:AddRotateBodyAreaResult(casterEntityID, aiResult)
  if not table.icontains(self._aiRotateBodyAreaSequence, casterEntityID) then
    table.insert(self._aiRotateBodyAreaSequence, casterEntityID)
  end
  local collection = self._aiResultCollectionDict[casterEntityID]
  if not collection then
    collection = AIResultCollection:New()
    self._aiResultCollectionDict[casterEntityID] = collection
  end
  collection:AddRotateBodyAreaResult(aiResult)
end

function AIRecorderComponent:AddWalkResult(casterEntityID, aiResult)
  if not table.icontains(self._aiWalkSequence, casterEntityID) then
    table.insert(self._aiWalkSequence, casterEntityID)
  end
  local collection = self._aiResultCollectionDict[casterEntityID]
  if not collection then
    collection = AIResultCollection:New()
    self._aiResultCollectionDict[casterEntityID] = collection
  end
  collection:AddWalkResult(aiResult)
end

function AIRecorderComponent:FindWalkResultByCasterID(casterEntityID)
  if self._aiResultCollectionDict then
    return self._aiResultCollectionDict[casterEntityID]
  end
end

function AIRecorderComponent:AddNormalAttackResult(casterEntityID, aiResult)
  if not table.icontains(self._aiWalkSequence, casterEntityID) then
    table.insert(self._aiWalkSequence, casterEntityID)
  end
  local collection = self._aiResultCollectionDict[casterEntityID]
  if not collection then
    collection = AIResultCollection:New()
    self._aiResultCollectionDict[casterEntityID] = collection
  end
  collection:AddNormalAttackResult(aiResult)
end

function AIRecorderComponent:GetAISpellResultByCasterEntityID(casterEntityID)
  local ret = {}
  for order, aiCastSkillQueue in pairs(self._orderResultList) do
    local collection = aiCastSkillQueue[casterEntityID]
    if collection then
      local aiResultList = collection:GetSpellResultList()
      table.appendArray(ret, aiResultList)
    end
  end
  return ret
end

function AIRecorderComponent:GetAllParallelSpellResultList()
  local ret = {}
  for order, aiCastSkillQueue in pairs(self._orderResultList) do
    for k, collection in pairs(aiCastSkillQueue) do
      local aiResultList = collection:GetSpellResultList()
      for _, aiResult in ipairs(aiResultList) do
        local parallelID = aiResult:GetParallelID()
        if parallelID then
          if not ret[parallelID] then
            ret[parallelID] = {}
          end
          local casterID = aiResult:GetCasterEntityID()
          if not ret[parallelID][casterID] then
            ret[parallelID][casterID] = {}
          end
          table.insert(ret[parallelID][casterID], aiResult)
        end
      end
    end
  end
  return ret
end

function AIRecorderComponent:AddSpellResult(casterEntityID, aiResult)
  if not table.icontains(self._aiCastSkillSequece, casterEntityID) then
    table.insert(self._aiCastSkillSequece, casterEntityID)
  end
  local collection = self._aiResultCollectionDict[casterEntityID]
  if not collection then
    collection = AIResultCollection:New()
    self._aiResultCollectionDict[casterEntityID] = collection
  end
  collection:AddSpellResult(aiResult)
end

function AIRecorderComponent:GetOrderList()
  local list = {}
  for order, res in pairs(self._orderResultList) do
    list[#list + 1] = order
  end
  table.sort(list)
  return list
end

function AIRecorderComponent:SetCurrentOrder(order)
  self._aiResultCollectionDict = self._orderResultList[order]
  self._aiCastSkillSequece = self._orderCastSkillSequence[order]
  self._aiWalkSequence = self._orderWalkSequence[order]
  self._aiRotateBodyAreaSequence = self._orderRotateBodyAreaSequence[order]
end

function AIRecorderComponent:GetAICasterIDList()
  return self._aiCastSkillSequece or {}
end

function AIRecorderComponent:GetAIWalkerIDList()
  return self._aiWalkSequence or {}
end

function AIRecorderComponent:GetAIRotateBodyAreaIDList()
  return self._aiRotateBodyAreaSequence or {}
end

function AIRecorderComponent:GetAIResultCollection(casterEntityID)
  return self._aiResultCollectionDict[casterEntityID]
end

function Entity:AIRecorder()
  return self:GetComponent(self.WEComponentsEnum.AIRecorder)
end

function Entity:HasAIRecorder()
  return self:HasComponent(self.WEComponentsEnum.AIRecorder)
end

function Entity:AddAIRecorder()
  local index = self.WEComponentsEnum.AIRecorder
  local component = AIRecorderComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceAIRecorder(component)
  local index = self.WEComponentsEnum.AIRecorder
  component = component or AIRecorderComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveAIRecorder()
  if self:HasAIRecorder() then
    self:RemoveComponent(self.WEComponentsEnum.AIRecorder)
  end
end
