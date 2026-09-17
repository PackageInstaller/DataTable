local this = class("gameActivityIntegralTpl")

function this:init(config)
  self.data = config
  self.currencyGroups = {}
  for id, tpl in pairs(config) do
    local currencyId = self:getCurrencyId(tpl)
    if currencyId then
      if not self.currencyGroups[currencyId] then
        self.currencyGroups[currencyId] = {}
      end
      table.insert(self.currencyGroups[currencyId], {
        id = id,
        tpl = tpl,
        daynum = self:getDayNum(tpl)
      })
    end
  end
  for currencyId, group in pairs(self.currencyGroups) do
    table.sort(group, function(a, b)
      return a.daynum < b.daynum
    end)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getCurrencyId(tpl)
  return tpl.currencyid
end

function this:getDayNum(tpl)
  return tpl.daynum
end

function this:getIntelgralMax(tpl)
  return tpl.intelgralmax
end

function this:getIdsByCurrencyId(currencyId)
  local ids = {}
  if self.currencyGroups[currencyId] then
    for _, item in ipairs(self.currencyGroups[currencyId]) do
      table.insert(ids, item.id)
    end
  end
  return ids
end

function this:getMaxByCurrencyIdAndDay(currencyId, daynum)
  if not self.currencyGroups[currencyId] then
    return nil
  end
  for _, item in ipairs(self.currencyGroups[currencyId]) do
    if item.daynum == daynum then
      local tpl = item.tpl
      local max = self:getIntelgralMax(tpl)
      return max
    end
  end
  return nil
end

function this:getMaxDayNum(currencyId)
  if not self.currencyGroups[currencyId] then
    return 0
  end
  local group = self.currencyGroups[currencyId]
  if 0 < #group then
    return group[#group].daynum
  end
  return 0
end

return this
