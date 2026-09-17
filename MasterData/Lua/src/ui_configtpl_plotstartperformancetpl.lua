local this = class("plotStartPerformanceTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getChapterName(tpl)
  return L_Config:provider(tpl.chapterName)
end

function this:getId(tpl)
  return tpl.id
end

function this:getType(tpl)
  return tpl.type
end

function this:getVolName(tpl)
  return L_Config:provider(tpl.volName)
end

function this:getChapterNum(tpl)
  return L_Config:provider(tpl.chapterNum)
end

return this
