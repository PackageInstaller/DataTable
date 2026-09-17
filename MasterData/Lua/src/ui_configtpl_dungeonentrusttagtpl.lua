local this = class("dungeonEntrustTagTpl")

function this:init(config)
  self.data = config
  self.showData = {}
  for k, v in pairs(self.data) do
    if self:getIfFilter(v) then
      table.insert(self.showData, v)
    end
  end
  table.sort(self.showData, function(a, b)
    return a.sort < b.sort
  end)
end

function this:getTplById(id)
  return self.data[id]
end

function this:getShowData()
  return self.showData
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIfFilter(tpl)
  return tpl.ifFilter == 1
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getBgColor(tpl)
  return tpl.color
end

function this:getTextColor(tpl)
  return tpl.textColor
end

function this:getSort(tpl)
  return tpl.sort
end

function this:checkIsSpecial(tpl)
  return false
end

function this:checkIsTaskTarget(tpl)
  return tpl.id == 1000
end

function this:checkIsMainTask(tpl)
  return tpl.id == 6
end

return this
