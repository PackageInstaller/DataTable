local this = class("illustratedhandbookMainTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getData()
  return self.data
end

function this:getIsLock(tpl)
  return tpl.isLock
end

function this:getImg_bg(tpl)
  return tpl.icon
end

function this:getTxt_cst(tpl)
  return tpl.words
end

function this:getName(tpl)
  return L_Config:provider(tpl.areaName)
end

function this:getPage(tpl)
  return tpl.page
end

return this
