local this = class("situationDataTotal")

function this:ctor()
  self.name = ""
  self.coverName = nil
  self.id = 0
  self.playerId = nil
  self.heroContainers = {}
  self.cameraContainer = nil
  self.petContainers = {}
  self.objContainers = {}
  self.stampContainers = {}
  self.envContainer = nil
  self.recordDict = {}
  self.isCaptured = false
end

function this:initDefault()
end

function this:export()
  local jsonData = {
    heroes = {},
    camera = self.cameraContainer:serialize(),
    env = self.envContainer:serialize(),
    objs = {},
    pets = {},
    stamps = {}
  }
  for i, v in pairs(self.heroContainers) do
    local json = v:serialize()
    table.insert(jsonData.heroes, json)
  end
  for i, v in pairs(self.objContainers) do
    local json = v:serialize()
    table.insert(jsonData.objs, json)
  end
  for i, v in pairs(self.petContainers) do
    local json = v:serialize()
    table.insert(jsonData.pets, json)
  end
  for i, v in pairs(self.stampContainers) do
    local json = v:serialize()
    table.insert(jsonData.stamps, json)
  end
  local exportJson = L_Json.encode(jsonData)
  return exportJson
end

function this:resetCamera()
  if self.cameraContainer and self.cameraRecord then
    self.cameraContainer:revert(self.cameraRecord.data)
    self.cameraContainer:load(self.sceneData)
  end
end

function this:record()
  table.clear(self.recordDict)
  for i, v in pairs(self.heroContainers) do
    local heroRecord = v:record()
    table.insert(self.recordDict, heroRecord)
  end
  self.cameraRecord = self.cameraContainer:record()
  self.envRecord = self.envContainer:record()
  for i, v in pairs(self.objContainers) do
    local objRecord = v:record()
    table.insert(self.recordDict, objRecord)
  end
  for i, v in pairs(self.petContainers) do
    local petRecord = v:record()
    table.insert(self.recordDict, petRecord)
  end
  for i, v in pairs(self.stampContainers) do
    local stampRecord = v:record()
    table.insert(self.recordDict, stampRecord)
  end
end

function this:revert()
  if self.cameraRecord == nil then
    return
  end
  self:clear()
  table.clear(self.heroContainers)
  table.clear(self.objContainers)
  table.clear(self.petContainers)
  table.clear(self.stampContainers)
  for i, v in pairs(self.recordDict) do
    local recordData = v.data
    local container
    if v.type == L_Const.situationDataType.hero then
      container = L_SituationManager:createHeroContainer(recordData)
      table.insert(self.heroContainers, container)
    elseif v.type == L_Const.situationDataType.obj then
      container = L_SituationManager:createObjContainer(recordData)
      table.insert(self.objContainers, container)
    elseif v.type == L_Const.situationDataType.pet then
      container = L_SituationManager:createPetContainer(recordData)
      table.insert(self.petContainers, container)
    elseif v.type == L_Const.situationDataType.stamp then
      container = L_SituationManager:createStampContainer(recordData)
      table.insert(self.stampContainers, container)
    end
  end
  self.cameraContainer:revert(self.cameraRecord.data)
  self.envContainer:revert(self.envRecord.data)
  table.clear(self.recordDict)
  self.cameraRecord = nil
  self.envRecord = nil
  self:loadSolution(self.sceneData)
end

function this:apply()
  table.clear(self.recordDict)
  self.cameraRecord = nil
  self.envRecord = nil
end

function this:clear()
  for i, v in pairs(self.heroContainers) do
    v:release()
  end
  for i, v in pairs(self.objContainers) do
    v:release()
  end
  for i, v in pairs(self.petContainers) do
    v:release()
  end
  for i, v in pairs(self.stampContainers) do
    v:release()
  end
  self.envContainer:release()
end

function this:loadSolution(sceneData)
  self.sceneData = sceneData
  for i, v in pairs(self.heroContainers) do
    v.playerId = self.playerId
    v:load(sceneData)
  end
  self.cameraContainer:load(sceneData)
  self.envContainer:load(sceneData)
  for i, v in pairs(self.objContainers) do
    v:load(sceneData)
  end
  for i, v in pairs(self.petContainers) do
    v:load(sceneData)
  end
  for i, v in pairs(self.stampContainers) do
    v:load(sceneData)
  end
  self:resortStamp()
end

function this:createHero(data)
  local container = L_SituationManager:createHeroContainer(data)
  table.insert(self.heroContainers, container)
  container.playerId = self.playerId
  container:load(self.sceneData)
  L_SituationStore:call(L_SituationStore.event.objCountChanged, L_Const.situationGroup.hero)
  return container
end

function this:removeHero(container)
  for i, v in pairs(self.heroContainers) do
    if v == container then
      self.heroContainers[i] = nil
    end
  end
  container:release()
  L_SituationStore:call(L_SituationStore.event.objCountChanged, L_Const.situationGroup.hero)
end

function this:removeHeroByConfigId(configId)
  for i, v in pairs(self.heroContainers) do
    if v.data.heroConfigId == configId then
      self.heroContainers[i]:release()
      self.heroContainers[i] = nil
      break
    end
  end
  L_SituationStore:call(L_SituationStore.event.objCountChanged, L_Const.situationGroup.hero)
end

function this:createObj(data)
  local container = L_SituationManager:createObjContainer(data)
  table.insert(self.objContainers, container)
  container:load(self.sceneData)
  L_SituationStore:call(L_SituationStore.event.objCountChanged, L_Const.situationGroup.obj)
  return container
end

function this:removeObjByGuid(guid)
  for i, v in pairs(self.objContainers) do
    if v.guid == guid then
      v:release()
      table.remove(self.objContainers, i)
      break
    end
  end
  L_SituationStore:call(L_SituationStore.event.objCountChanged, L_Const.situationGroup.obj)
end

function this:createPet(data)
  local container = L_SituationManager:createPetContainer(data)
  table.insert(self.petContainers, container)
  container:load(self.sceneData)
  L_SituationStore:call(L_SituationStore.event.objCountChanged, L_Const.situationGroup.pet)
  return container
end

function this:removePet(petGuid)
  for i, v in pairs(self.petContainers) do
    if v.data.petGuid == petGuid then
      self.petContainers[i]:release()
      self.petContainers[i] = nil
      break
    end
  end
  L_SituationStore:call(L_SituationStore.event.objCountChanged, L_Const.situationGroup.pet)
end

function this:createStamp(data, isFirst)
  local container = L_SituationManager:createStampContainer(data)
  table.insert(self.stampContainers, container)
  container:load(self.sceneData)
  L_SituationStore:call(L_SituationStore.event.objCountChanged, L_Const.situationGroup.stamp)
  self:resortStamp()
  if isFirst then
    L_SituationStore:call(L_SituationStore.event.onClickStamp, container)
  end
  return container
end

function this:removeStampByGuid(guid)
  for i, v in pairs(self.stampContainers) do
    if v.guid == guid then
      v:release()
      table.remove(self.stampContainers, i)
      break
    end
  end
  L_SituationStore:call(L_SituationStore.event.objCountChanged, L_Const.situationGroup.stamp)
end

function this:getNextStampIndex()
  local max = 0
  for i, v in pairs(self.stampContainers) do
    local index = v.data.index
    if max < index then
      max = index
    end
  end
  return max + 1
end

function this:resortStamp()
  table.sort(self.stampContainers, function(a, b)
    return a.data.index < b.data.index
  end)
  for i, v in pairs(self.stampContainers) do
    v.rectTrans:SetAsLastSibling()
  end
end

function this:changeEnv(id)
  self.envContainer:changeEnv(id)
end

function this:revertHeroAndPetAction()
  for i, v in pairs(self.heroContainers) do
    v:setAction(v.data.actionId, v.data.actionTime)
  end
  for i, v in pairs(self.petContainers) do
    v:setAction(v.data.actionId, v.data.actionTime)
  end
end

function this:checkCameraChanged()
  if self.cameraRecord == nil then
    return false
  end
  if not (self:floatEqual(self.cameraRecord.data.pos.x, self.cameraContainer.data.pos.x) and self:floatEqual(self.cameraRecord.data.pos.y, self.cameraContainer.data.pos.y) and self:floatEqual(self.cameraRecord.data.pos.z, self.cameraContainer.data.pos.z) and self:floatEqual(self.cameraRecord.data.targetPos.x, self.cameraContainer.data.targetPos.x) and self:floatEqual(self.cameraRecord.data.targetPos.y, self.cameraContainer.data.targetPos.y)) or not self:floatEqual(self.cameraRecord.data.targetPos.z, self.cameraContainer.data.targetPos.z) then
    return true
  end
  return false
end

function this:floatEqual(a, b)
  if math.abs(a - b) < 1.0E-6 then
    return true
  end
  return false
end

function this:toLocalPos(w3)
  if self.sceneData == nil then
    return w3
  end
  local localPos = self.sceneData.heroRoot:InverseTransformPoint(w3)
  return localPos
end

return this
