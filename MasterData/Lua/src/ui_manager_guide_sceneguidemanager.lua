local this = class("sceneGuideManager", G_EventManagerBase)

function this:initialize()
  self.guidePathEntity = require("ui.manager.guide.sceneGuidePathEntity").new()
  self:reset()
end

function this:dispose()
  self:clear()
end

function this:reset()
  self.startSceneGuide = false
  self.allowGuide = false
  self.hasPlayer = false
  self.hasEntity = false
  self.targetPathIndex = 1
end

function this:clear()
  self.arrow = nil
  self.arrowObj = nil
  self:reset()
  self.guidePathEntity:clear()
end

function this:setPlayer()
  local player = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  self.hasPlayer = player and player.transform.gameObject.activeInHierarchy
end

function this:CloseArrow()
end

function this:removeDeepGuides()
  L_TaskStore:disposeTraceTask()
  local mapStore = C_MapManager:GetMapStore()
  if mapStore then
    mapStore:removeDeepGuide()
  end
end

return this
