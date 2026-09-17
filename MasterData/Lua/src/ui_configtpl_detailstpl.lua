local this = class("detailsTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getPage(tpl)
  return tpl.page
end

function this:getTab(tpl)
  return tpl.tab
end

return this
