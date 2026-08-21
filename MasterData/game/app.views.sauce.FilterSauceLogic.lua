local FilterSauceLogic = class("FilterSauceLogic")
local SauceSortRules = {
  default = function(a, b)
    local factorA = a.csvData.rare * 100000 + a.advanceL * 10000 + a.breakL * 100 + a.type
    local factorB = b.csvData.rare * 100000 + b.advanceL * 10000 + b.breakL * 100 + b.type
    return factorA > factorB
  end,
  starDesc = function(a, b)
    local factorA = a.csvData.rare * 100000 + a.advanceL * 10000 + a.breakL * 100 + a.type
    local factorB = b.csvData.rare * 100000 + b.advanceL * 10000 + b.breakL * 100 + b.type
    return factorA > factorB
  end,
  starAsc = function(a, b)
    local factorA = a.csvData.rare * 100000 + a.advanceL * 10000 + a.breakL * 100 + a.type
    local factorB = b.csvData.rare * 100000 + b.advanceL * 10000 + b.breakL * 100 + b.type
    return factorA < factorB
  end,
  advanceDesc = function(a, b)
    local factorA = a.advanceL * 100000 + a.csvData.rare * 10000 + a.breakL * 100 + a.type
    local factorB = b.advanceL * 100000 + b.csvData.rare * 10000 + b.breakL * 100 + b.type
    return factorA > factorB
  end,
  advanceAsc = function(a, b)
    local factorA = a.advanceL * 100000 + a.csvData.rare * 10000 + a.breakL * 100 + a.type
    local factorB = b.advanceL * 100000 + b.csvData.rare * 10000 + b.breakL * 100 + b.type
    return factorA < factorB
  end
}

function FilterSauceLogic:ctor(params)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  self.source = params.heros
  self.result = params.heros
  self.mType = params.mType
  self.special = {}
  self.topshow = {}
  self.profession = {}
  self.sortRule = params.sortRule or "default"
end

function FilterSauceLogic:setSource(heros)
  self.source = heros
  self:filter()
end

function FilterSauceLogic:filterByProfession(params)
  self.profession = params.profession
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterSauceLogic:orderByRule(params)
  self.sortRule = params.rule
  self:filter()
  self:dispatchEvent({
    name = "filter",
    sortRule = params.rule
  })
end

function FilterSauceLogic:orderByCondition(params)
  self.profession = params.professions
  self.sortRule = params.rule
  self:filter()
  self:dispatchEvent({
    name = "filter",
    sortRule = params.rule
  })
end

function FilterSauceLogic:filter()
  self.result = {}
  self.special = {}
  self.topshow = {}
  for _, sauce in ipairs(self.source) do
    local type = sauce.csvData.profession
    if not next(self.profession) or self.profession[type] then
      if sauce.csvData.maintype == 0 then
        table.insert(self.topshow, sauce)
      elseif self.mType and self.mType == sauce.csvData.maintype then
        table.insert(self.result, sauce)
      else
        table.insert(self.special, sauce)
      end
    end
  end
  if self.sortRule ~= "noChange" then
    table.sort(self.result, SauceSortRules[self.sortRule])
    if next(self.special) then
      table.sort(self.special, SauceSortRules[self.sortRule])
    end
  end
  if next(self.special) then
    for _, sauce in ipairs(self.special) do
      table.insert(self.result, sauce)
    end
    self.special = {}
  end
  if self.mType and next(self.topshow) then
    for _, sauce in pairs(self.topshow) do
      if self.mType == 0 then
        table.insert(self.result, sauce)
      else
        table.insert(self.result, 1, sauce)
      end
    end
    self.topshow = {}
  end
end

function FilterSauceLogic:getResult()
  return self.result
end

return FilterSauceLogic
