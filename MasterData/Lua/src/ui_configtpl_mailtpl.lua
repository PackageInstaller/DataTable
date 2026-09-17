local this = class("mailTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getTitle(tpl)
  return tpl.title
end

function this:getName(tpl)
  return tpl.name
end

function this:getContent(tpl)
  return tpl.content
end

function this:getLink(tpl)
  return tpl.link
end

function this:getType(tpl)
  return tpl.type
end

function this:getJumpType(tpl)
  return tpl.jumpType
end

function this:getJumpId(tpl)
  return tpl.jumpId
end

function this:getJumpShow(tpl)
  return L_Config:provider(tpl.jumpShow)
end

return this
