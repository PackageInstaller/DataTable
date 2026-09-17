local this = class("dungeonMaterialDiffTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDiffName(tpl)
  return tpl.name
end

function this:getPic(tpl)
  return tpl.pic
end

return this
