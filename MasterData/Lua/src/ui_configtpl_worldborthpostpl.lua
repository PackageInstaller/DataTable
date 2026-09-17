local this = class("worldBorthposTpl")

function this:init(config)
  self.data = config
  self.worldDic = {}
  for _, v in pairs(config) do
    local tab = self.worldDic[v.cityId]
    if tab == nil then
      tab = {}
      self.worldDic[v.cityId] = tab
    end
    if self:getIsMainPoint(v) then
      tab.main = v
    end
    tab[v.id] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getMainPointTplByCityId(cityId)
  local tab = self.worldDic[cityId]
  return tab and tab.main
end

function this:getAllTplByCityId(cityId, pointType)
  local tab = self.worldDic[cityId]
  if tab and pointType then
    local result = {}
    for _, v in pairs(tab) do
      if v.type == pointType then
        result[v.id] = v
      end
    end
    tab = result
  end
  return tab or {}
end

function this:getId(tpl)
  return tpl.id
end

function this:getCityId(tpl)
  return tpl.cityId
end

function this:getIsMainPoint(tpl)
  return tpl.mainPoint == 1
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIsLockPoint(tpl)
  return tpl.lockPoint == 1
end

function this:getPoint(tpl)
  return tpl.borthPoint
end

function this:getType(tpl)
  return tpl.type
end

function this:getPosition(tpl)
  local p = tpl.borthPoint
  return {
    x = p[1],
    y = p[2],
    z = p[3]
  }
end

function this:getRotation(tpl)
  local p = tpl.borthPoint
  return {
    x = p[4] / 100,
    y = p[5] / 100,
    z = p[6] / 100
  }
end

return this
