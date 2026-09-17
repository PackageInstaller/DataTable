local this = {}
local _solutionTpl = L_GameTpl:getPhotoSpaceCaseTpl()

function this:init()
  self.solutionInfo = {}
end

function this:getSolutionInfo(id)
  local info = self.solutionInfo[id]
  if not info then
    local data = self:constructSolutionInfo(id)
    if data then
      self.solutionInfo[id] = data
      info = data
    end
  end
  return info
end

function this:constructSolutionInfo(id, playerId)
  local tpl = _solutionTpl:getTplById(id)
  if not tpl then
    return nil
  end
  if not L_ConditionManager:isComplete(_solutionTpl:getUnlock(tpl)) then
    return nil
  end
  local info = require("ui.manager.situation.data.situationDataTotal").new()
  info.id = id
  info.name = _solutionTpl:getCaseName(tpl)
  info.playerId = playerId or L_PlayerStore:getPlayerId()
  self:initDefault(info)
  return info
end

function this:initDefault(solutionData)
  local heroServerData = L_HeroStore:getHero(L_HeroStore:getDefaultHeroGuid())
  local heroConfigId = L_HeroStore:getHeroConfigId(heroServerData)
  local heroParam = {
    heroConfigId = heroConfigId,
    pos = L_Vector3.new(0.71, 0, 0.51),
    rot = L_Vector3.new(0, 39.9, 0),
    actionId = L_Const.photoParam.idle,
    actionTime = 0,
    faceId = L_Const.photoParam.defaultFace
  }
  local heroDataContainer = L_SituationManager:createHeroContainer(heroParam)
  table.insert(solutionData.heroContainers, heroDataContainer)
  local cameraParam = {
    pos = L_Vector3.new(2.062012, 1.599, 3.042999),
    targetPos = L_Vector3.new(0, 1, 0)
  }
  local cameraDataContainer = require("ui.manager.situation.data.situationDataContainer_camera").new(cameraParam)
  solutionData.cameraContainer = cameraDataContainer
  local envParam = {configId = 1}
  local envDataContainer = require("ui.manager.situation.data.situationDataContainer_env").new(envParam)
  solutionData.envContainer = envDataContainer
end

function this:isUnlock(id)
  return L_ConditionManager:isComplete(_solutionTpl:getUnlock(_solutionTpl:getTplById(id)))
end

return this
