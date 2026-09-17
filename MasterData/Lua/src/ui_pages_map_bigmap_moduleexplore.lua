local this = class("moduleExplore", G_UIModuleBase)
local _areaTpl = L_GameTpl:getWorldAreaTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {txt_explore = "", go_self = false}
end

function this.methods()
  return {
    onClick_explore = function(self)
      if not self.bind.go_self then
        return
      end
      L_UI:open("pageWorldExplore", {
        sceneId = self.sceneId
      })
    end
  }
end

function this:open()
  self.bind.go_self = false
  L_WorldExploreStore:listenCallFunc(L_WorldExploreStore.event.ExplorationSync, self.refreshExplore, self)
end

function this:initAreaId(areaId)
  self.areaId = areaId
  local tpl = _areaTpl:getTplById(areaId)
  if tpl then
    self.sceneId = _areaTpl:getSceneId(tpl)
    self:refreshExplore()
  end
end

function this:refreshExplore()
  local worldCityTpl = L_GameTpl:getWorldCityTpl()
  local cityTpl = worldCityTpl:getTplById(self.sceneId)
  if cityTpl and worldCityTpl:getExploreSwitch(cityTpl) then
    self.bind.go_self = true
    self.bind.txt_explore = L_WorldExploreStore:getCurExplore(self.sceneId) .. "%"
  end
end

function this:close()
  L_WorldExploreStore:unListenCallFunc(L_WorldExploreStore.event.ExplorationSync, self.refreshExplore)
end

return this
