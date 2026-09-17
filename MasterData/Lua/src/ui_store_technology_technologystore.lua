local this = class("technologyStore", G_BaseStore)
this.event = {refresh = "refresh", refreshDot = "refreshDot"}
this:importPartialClass(require(L_R.store .. "technology.technologyState"))
this:importPartialClass(require(L_R.store .. "technology.technologyAction"))

function this:ctor()
  this.super.ctor(self)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.playerLevelUp, self.onEvent_playerLevelUp, self)
end

function this:onEvent_playerLevelUp(lastLv)
end

function this:technologyTreeId2TechnologyId(treeId)
  return treeId * 100 + 1
end

function this:technologyId2TechnologyTreeId(id)
  local homeTechnologyTpl = L_GameTpl:getHomeTechnologyTpl()
  local tpl = homeTechnologyTpl:getTplById(id)
  return homeTechnologyTpl:getType(tpl)
end

return this
