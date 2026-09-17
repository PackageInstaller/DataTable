local this = class("situationStore", G_BaseStore)
local _solutionTpl = L_GameTpl:getPhotoSpaceCaseTpl()
this.event = {
  undoCountChanged = "undoCountChanged",
  objCountChanged = "objCountChanged",
  loadingCountChanged = "loadingCountChanged",
  onSave = "onSave",
  onClickStamp = "onClickStamp",
  cameraPosChanged = "cameraPosChanged",
  coverChanged = "coverChanged",
  nameChanged = "nameChanged"
}
this:importPartialClass(require("ui.store.situation.situationAction"))
this:importPartialClass(require("ui.store.situation.situationState"))

function this:ctor()
  this.super.ctor(self)
  self:init()
end

function this:sync_situationData(dataList)
  for i, data in pairs(dataList) do
    local id = data.id
    local name = data.name
    local coverName = data.Cover
    local json = data.show_data
    local curSolution = self.solutionInfo[id]
    if curSolution then
      if string.isEmpty(name) then
        local tpl = _solutionTpl:getTplById(id)
        curSolution.name = _solutionTpl:getCaseName(tpl)
      else
        curSolution.name = name
      end
    else
      local info = require("ui.manager.situation.data.situationDataTotal").new()
      info.id = id
      if string.isEmpty(name) then
        local tpl = _solutionTpl:getTplById(id)
        info.name = _solutionTpl:getCaseName(tpl)
      else
        info.name = name
      end
      info.coverName = coverName
      info.playerId = L_PlayerStore:getPlayerId()
      local allData = self:deserialize(json)
      for i, v in pairs(allData.heroes) do
        local heroContainer = L_SituationManager:createHeroContainer(v)
        table.insert(info.heroContainers, heroContainer)
      end
      for i, v in pairs(allData.objs) do
        local objContainer = L_SituationManager:createObjContainer(v)
        table.insert(info.objContainers, objContainer)
      end
      for i, v in pairs(allData.pets) do
        local petContainer = L_SituationManager:createPetContainer(v)
        table.insert(info.petContainers, petContainer)
      end
      for i, v in pairs(allData.stamps) do
        local stampContainer = L_SituationManager:createStampContainer(v)
        table.insert(info.stampContainers, stampContainer)
      end
      local cameraDataContainer = require("ui.manager.situation.data.situationDataContainer_camera").new(allData.camera)
      info.cameraContainer = cameraDataContainer
      local envDataContainer = require("ui.manager.situation.data.situationDataContainer_env").new(allData.env)
      info.envContainer = envDataContainer
      self.solutionInfo[id] = info
    end
  end
end

function this:deserializeSituation(data, playerId)
  local id = data.id
  local name = data.name
  local coverName = data.Cover
  local json = data.show_data
  local info = require("ui.manager.situation.data.situationDataTotal").new()
  info.id = id
  info.name = name
  info.coverName = coverName
  info.playerId = playerId
  local allData = self:deserialize(json)
  for i, v in pairs(allData.heroes) do
    local heroContainer = L_SituationManager:createHeroContainer(v)
    table.insert(info.heroContainers, heroContainer)
  end
  for i, v in pairs(allData.objs) do
    local objContainer = L_SituationManager:createObjContainer(v)
    table.insert(info.objContainers, objContainer)
  end
  for i, v in pairs(allData.pets) do
    local petContainer = L_SituationManager:createPetContainer(v)
    table.insert(info.petContainers, petContainer)
  end
  for i, v in pairs(allData.stamps) do
    local stampContainer = L_SituationManager:createStampContainer(v)
    table.insert(info.stampContainers, stampContainer)
  end
  local cameraDataContainer = require("ui.manager.situation.data.situationDataContainer_camera").new(allData.camera)
  info.cameraContainer = cameraDataContainer
  local envDataContainer = require("ui.manager.situation.data.situationDataContainer_env").new(allData.env)
  info.envContainer = envDataContainer
  return info
end

return this
