local this = class("guideClickPathTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getPath(tpl)
  return tpl.path, tpl.subpath
end

return this
