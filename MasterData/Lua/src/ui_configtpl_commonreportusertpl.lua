local this = class("commonReportUserTpl")

function this:init(config)
  self.data = config
end

function this:getAllData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

return this
