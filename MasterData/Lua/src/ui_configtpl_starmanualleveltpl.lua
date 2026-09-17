local this = class("starManualLevelTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(config) do
    if self.groupData[v.starManualId] == nil then
      self.groupData[v.starManualId] = {}
    end
    table.insert(self.groupData[v.starManualId], v)
  end
  for _, v in pairs(self.groupData) do
    table.sort(v, function(a, b)
      return a.id < b.id
    end)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getOpen(tpl)
  return tpl.open
end

function this:getShow(tpl)
  return tpl.show
end

function this:getDoubleTime(tpl)
  return tpl.doubleTime
end

function this:getOpenDesc(tpl)
  return L_Config:provider(tpl.openDesc)
end

function this:getDoubleDesc(tpl)
  return L_Config:provider(tpl.doubleDesc)
end

function this:getStarManualId(tpl)
  return tpl.starManualId
end

function this:getPoint(tpl)
  return tpl.point
end

function this:getLimitNum(tpl)
  return tpl.limitNum
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getUiType(tpl)
  return tpl.uiType
end

function this:getSystem(tpl)
  return tpl.system
end

function this:getCost(tpl)
  return tpl.cost
end

function this:getItem(tpl)
  return tpl.item
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getPic(tpl)
  local icon = tpl.pic
  return icon
end

function this:getPicBoss(tpl)
  local iconList = tpl.picBoss
  return iconList
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getGroupData(starManualId)
  return self.groupData[starManualId]
end

function this:getOrder(tpl)
  return tpl.order
end

return this
