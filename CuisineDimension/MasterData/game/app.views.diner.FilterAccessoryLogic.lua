local AccCsv = require("csvdata.diner_accessory")
local FilterAccessoryLogic = class("FilterAccessoryLogic")
local SortRules = {
  default = function(a, b)
    local factorA = AccCsv[a.type].quality * 10 + a.level
    local factorB = AccCsv[b.type].quality * 10 + b.level
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  starDesc = function(a, b)
    local factorA = AccCsv[a.type].quality * 10 + a.level
    local factorB = AccCsv[b.type].quality * 10 + b.level
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  starAsc = function(a, b)
    local factorA = AccCsv[a.type].quality * 10 + a.level
    local factorB = AccCsv[b.type].quality * 10 + b.level
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA < factorB
  end,
  levelDesc = function(a, b)
    local factorA = AccCsv[a.type].quality + a.level * 10
    local factorB = AccCsv[b.type].quality + b.level * 10
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  levelAsc = function(a, b)
    local factorA = AccCsv[a.type].quality + a.level * 10
    local factorB = AccCsv[b.type].quality + b.level * 10
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA < factorB
  end
}

function FilterAccessoryLogic:ctor(params)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  self.source = params.heros
  self.result = params.heros
  self.profession = {}
  self.star = 0
  self.camp = 0
  self.sortRule = params.sortRule or "default"
end

function FilterAccessoryLogic:filterByType(params)
  self.profession = params.type
  self:filterType()
  self:dispatchEvent({name = "filter"})
end

function FilterAccessoryLogic:filterType()
  self.result = {}
  for _, access in pairs(self.source) do
    local type = AccCsv[access.type].type
    if self.profession == type or self.profession == 0 then
      table.insert(self.result, access)
    end
  end
  if self.sortRule ~= "noChange" then
    table.sort(self.result, SortRules[self.sortRule])
  end
end

function FilterAccessoryLogic:setSource(heros)
  self.source = heros
  self:filter()
end

function FilterAccessoryLogic:filterByStar(params)
  self.star = params.star
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterAccessoryLogic:filterByProfession(params)
  self.profession = params.profession
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterAccessoryLogic:filterByCamp(params)
  self.camp = params.camp
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterAccessoryLogic:showAll()
  self.profession = 0
  self.camp = 0
  self.star = 0
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterAccessoryLogic:orderByRule(params)
  self.sortRule = params.rule
  self:filter()
  self:dispatchEvent({
    name = "filter",
    sortRule = params.rule
  })
end

function FilterAccessoryLogic:filter()
  self.result = {}
  for _, access in pairs(self.source) do
    local type = AccCsv[access.type].type
    if self.profession == type or self.profession == 0 then
      table.insert(self.result, access)
    end
  end
  if self.sortRule ~= "noChange" then
    table.sort(self.result, SortRules[self.sortRule])
  end
end

function FilterAccessoryLogic:getResult()
  return self.result
end

return FilterAccessoryLogic
