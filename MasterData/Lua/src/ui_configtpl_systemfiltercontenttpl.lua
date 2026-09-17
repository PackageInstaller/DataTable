local this = class("systemFiltercontentTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getEnumId(tpl)
  if not tpl then
    return nil
  end
  return tpl.EnumId
end

function this:getFilterContent(tpl)
  return L_Config:provider(tpl.filterContent)
end

function this:getId(tpl)
  if not tpl then
    return nil
  end
  return tpl.id
end

return this
