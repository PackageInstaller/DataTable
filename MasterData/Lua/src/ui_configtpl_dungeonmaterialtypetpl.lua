local this = class("dungeonMaterialTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTagId(tpl)
  return tpl.tagId
end

function this:getUnlock(tpl)
  return tpl.unlock
end

function this:getShowCondition(tpl)
  return tpl.showCondition
end

function this:getSortId(tpl)
  return tpl.sortId
end

return this
