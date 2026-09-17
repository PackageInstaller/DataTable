local this = class("libraryReadingsTpl")

function this:init(config)
  self.data = config
end

function this:getAllData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getSubTitle(tpl)
  return L_Config:provider(tpl.subTitle)
end

function this:getChapter(tpl)
  return L_Config:provider(tpl.chapter)
end

function this:getDetail(tpl)
  return L_Config:provider(tpl.detail)
end

function this:getAuthor(tpl)
  return L_Config:provider(tpl.author)
end

return this
