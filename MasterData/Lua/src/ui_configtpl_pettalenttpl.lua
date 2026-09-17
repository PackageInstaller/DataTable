local this = class("petTalentTpl")

function this:init(config)
  self.data = config
  self.list = {}
  for _, v in pairs(config) do
    table.insert(self.list, v)
  end
  table.sort(self.list, function(a, b)
    return a.id < b.id
  end)
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAllList()
  return self.list
end

function this:getId(tpl)
  return tpl.id
end

function this:getGrade(tpl)
  return tpl.grade or {}
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getPixelIcon(tpl)
  return L_Config:getPathByHash(tpl.pixelIcon)
end

function this:getNameBg(tpl)
  return L_Config:getPathByHash(tpl.nameBg)
end

function this:getPetPixelBase(tpl)
  return tpl.petPixelBase
end

function this:getFilterContentId(tpl)
  return tpl.filterContentId
end

return this
