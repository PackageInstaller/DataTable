local unitCsv = require("csvdata.unit")
local FilterLogic = class("FilterLogic")
local FriendSortRules = {
  default = function(a, b)
    return a.roleId < b.roleId
  end,
  levelDesc = function(a, b)
    local factorA = a.level
    local factorB = b.level
    if factorA == factorB then
      return a.roleId > b.roleId
    end
    return factorA > factorB
  end,
  levelAsc = function(a, b)
    local factorA = a.level
    local factorB = b.level
    if factorA == factorB then
      return a.roleId < b.roleId
    end
    return factorA < factorB
  end,
  loginDesc = function(a, b)
    local factorA = a.lastLoginTime
    local factorB = b.lastLoginTime
    if factorA == factorB then
      return a.roleId < b.roleId
    end
    return factorA < factorB
  end,
  loginAsc = function(a, b)
    local factorA = a.lastLoginTime
    local factorB = b.lastLoginTime
    if factorA == factorB then
      return a.roleId < b.roleId
    end
    return factorA > factorB
  end
}

function FilterLogic:ctor(params)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  self.source = params.roles or {}
  self.result = params.roles or {}
  self.profession = {}
  self.star = 0
  self.camp = 0
  self.sortRule = params.sortRule or "default"
end

function FilterLogic:filterByType(params)
  self.profession = params.type
  self:filterType()
  self:dispatchEvent({name = "filter"})
end

function FilterLogic:filterType()
  self.result = {}
  for _, hero in ipairs(self.source) do
    local type = hero.unit.profession
    if self.profession == type or self.profession == 0 then
      table.insert(self.result, hero)
    end
  end
  if self.sortRule ~= "noChange" then
    table.sort(self.result, HeroSortRules[self.sortRule])
  end
end

function FilterLogic:setSource(roles)
  self.source = roles
  self:filter()
end

function FilterLogic:filterByStar(params)
  self.star = params.star
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterLogic:filterByProfession(params)
  self.profession = params.profession
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterLogic:filterByCamp(params)
  self.camp = params.camp
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterLogic:showAll()
  self.profession = 0
  self.camp = 0
  self.star = 0
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterLogic:orderByRule(params)
  self.sortRule = params.rule
  self:filter()
  self:dispatchEvent({
    name = "filter",
    sortRule = params.rule
  })
end

function FilterLogic:filter()
  self.result = {}
  for _, role in pairs(self.source) do
    table.insert(self.result, role)
  end
  if self.sortRule ~= "noChange" then
    table.sort(self.result, FriendSortRules[self.sortRule])
  end
end

function FilterLogic:getResult()
  return self.result
end

return FilterLogic
