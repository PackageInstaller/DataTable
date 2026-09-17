local this = class("nestcoopSiteTpl")

function this:init(config)
  self.data = config
end

function this:getAllTpl()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getSiteTipsName(tpl)
  return L_Config:provider(tpl.siteTips)
end

function this:getAreaId(tpl)
  return tpl.area_id
end

function this:getWorldMapScene(tpl)
  return tpl.worldmapScene
end

function this:getWorldMapId(tpl)
  return tpl.worldmapId
end

function this:getPoolID(tpl)
  return tpl.poolID
end

function this:getIsVisible(tpl)
  return tpl.isVisible == 1
end

return this
