local unitCsv = require("csvdata.unit")
local FilterLogic = class("FilterLogic")
local HeroSortRules = {
  default = function(a, b)
    local formatA = a.formation > 0 and 10 - a.formation or 0
    local formatB = b.formation > 0 and 10 - b.formation or 0
    local factorA = formatA * 100000 + a.unit.star * 10000 + a.quality * 1000 + a.level * 10 + a.lock
    local factorB = formatB * 100000 + b.unit.star * 10000 + b.quality * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  cure = function(a, b)
    local fA, fB = 200000, 200000
    local aState = a:getState()
    for index, res in pairs(aState) do
      if res then
        fA = -800000
        break
      end
    end
    local bState = b:getState()
    for index, res in pairs(bState) do
      if res then
        fB = -800000
        break
      end
    end
    local aFormation = a.formation == 0 and 10 or a.formation
    local bFormation = b.formation == 0 and 10 or b.formation
    local factorA = fA + (20 - aFormation) * 100000 + a.lock * 10000 + a.level * 100 + (9 - a.unit.profession) * 10 + a.quality
    local factorB = fB + (20 - bFormation) * 100000 + b.lock * 10000 + b.level * 100 + (9 - b.unit.profession) * 10 + b.quality
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  teamDesc = function(a, b)
    local factorA = a.formation * 100000 + a.unit.star * 10000 + a.quality * 1000 + a.level * 10 + a.lock
    local factorB = b.formation * 100000 + b.unit.star * 10000 + b.quality * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  teamAsc = function(a, b)
    local formatA = a.formation > 0 and 20 - a.formation or 0
    local formatB = b.formation > 0 and 20 - b.formation or 0
    local factorA = formatA * 100000 + a.unit.star * 10000 + a.quality * 1000 + a.level * 10 + a.lock
    local factorB = formatB * 100000 + b.unit.star * 10000 + b.quality * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  levelDesc = function(a, b)
    local factorA = a.level * 20000 + a.formation * 1000 + a.unit.star * 100 + a.quality * 10 + a.lock
    local factorB = b.level * 20000 + b.formation * 1000 + b.unit.star * 100 + b.quality * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  levelAsc = function(a, b)
    local factorA = a.level * 20000 + a.formation * 1000 + a.unit.star * 100 + a.quality * 10 + a.lock
    local factorB = b.level * 20000 + b.formation * 1000 + b.unit.star * 100 + b.quality * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA < factorB
  end,
  starDesc = function(a, b)
    local factorA = a.unit.star * 200000 + a.formation * 10000 + a.quality * 1000 + a.level * 10 + a.lock
    local factorB = b.unit.star * 200000 + b.formation * 10000 + b.quality * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  starAsc = function(a, b)
    local factorA = a.unit.star * 200000 + a.formation * 10000 + a.quality * 1000 + a.level * 10 + a.lock
    local factorB = b.unit.star * 200000 + b.formation * 10000 + b.quality * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA < factorB
  end,
  qualityDesc = function(a, b)
    local factorA = a.quality * 200000 + a.formation * 10000 + a.unit.star * 1000 + a.level * 10 + a.lock
    local factorB = b.quality * 200000 + b.formation * 10000 + b.unit.star * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  qualityAsc = function(a, b)
    local factorA = a.quality * 200000 + a.formation * 10000 + a.unit.star * 1000 + a.level * 10 + a.lock
    local factorB = b.quality * 200000 + b.formation * 10000 + b.unit.star * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA < factorB
  end,
  battleDesc = function(a, b)
    local factorA = a.battleValue * 2000000 + a.formation * 100000 + a.unit.star * 10000 + a.quality * 1000 + a.level * 10 + a.lock
    local factorB = b.battleValue * 2000000 + b.formation * 100000 + b.unit.star * 10000 + b.quality * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  battleAsc = function(a, b)
    local factorA = a.battleValue * 2000000 + a.formation * 100000 + a.unit.star * 10000 + a.quality * 1000 + a.level * 10 + a.lock
    local factorB = b.battleValue * 2000000 + b.formation * 100000 + b.unit.star * 10000 + b.quality * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA < factorB
  end,
  loveDesc = function(a, b)
    local formatA = a.formation > 0 and 9 - a.formation or 0
    local formatB = b.formation > 0 and 9 - b.formation or 0
    local factorA = a.love * 2000000 + formatA * 100000 + a.unit.star * 10000 + a.quality * 1000 + a.level * 10 + a.lock
    local factorB = b.love * 2000000 + formatB * 100000 + b.unit.star * 10000 + b.quality * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  loveAsc = function(a, b)
    local formatA = a.formation > 0 and 9 - a.formation or 0
    local formatB = b.formation > 0 and 9 - b.formation or 0
    local factorA = a.love * 2000000 + formatA * 100000 + a.unit.star * 10000 + a.quality * 1000 + a.level * 10 + a.lock
    local factorB = b.love * 2000000 + formatB * 100000 + b.unit.star * 10000 + b.quality * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA < factorB
  end,
  awakeDesc = function(a, b)
    local formatA = a.formation > 0 and 9 - a.formation or 0
    local formatB = b.formation > 0 and 9 - b.formation or 0
    local awakeA = CommonHelper.isOpenAwake(a.id) and a.awake or -1
    local awakeB = CommonHelper.isOpenAwake(b.id) and b.awake or -1
    local factorA = awakeA * 2000000 + formatA * 100000 + a.unit.star * 10000 + a.quality * 1000 + a.level * 10 + a.lock
    local factorB = awakeB * 2000000 + formatB * 100000 + b.unit.star * 10000 + b.quality * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  awakeAsc = function(a, b)
    local formatA = a.formation > 0 and 9 - a.formation or 0
    local formatB = b.formation > 0 and 9 - b.formation or 0
    local awakeA = CommonHelper.isOpenAwake(a.id) and a.awake or -1
    local awakeB = CommonHelper.isOpenAwake(b.id) and b.awake or -1
    local factorA = awakeA * 2000000 + formatA * 100000 + a.unit.star * 10000 + a.quality * 1000 + a.level * 10 + a.lock
    local factorB = awakeA * 2000000 + formatB * 100000 + b.unit.star * 10000 + b.quality * 1000 + b.level * 10 + b.lock
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA < factorB
  end
}

function FilterLogic:ctor(params)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  self.source = params.heros
  self.result = params.heros
  self.special = params.special
  self.specialHero = {}
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
      if self.special and hero.unit.star == 1 then
        table.insert(self.specialHero, hero)
      else
        table.insert(self.result, hero)
      end
    end
  end
  if self.sortRule ~= "noChange" then
    table.sort(self.result, HeroSortRules[self.sortRule])
    if next(self.specialHero) then
      table.sort(self.specialHero, HeroSortRules[self.sortRule])
    end
  end
  if next(self.specialHero) then
    for _, hero in ipairs(self.specialHero) do
      table.insert(self.result, hero)
    end
    self.specialHero = {}
  end
end

function FilterLogic:setSource(heros)
  self.source = heros
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterLogic:orderByCondition(params)
  self.profession = params.professions or self.profession
  self.sortRule = params.rule or self.sortRule
  self:filter()
  self:dispatchEvent({name = "filter"})
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
  for _, hero in ipairs(self.source) do
    local type = hero.unit.profession
    if not next(self.profession) or self.profession[type] then
      if self.special and hero.unit.star == 1 then
        table.insert(self.specialHero, hero)
      else
        table.insert(self.result, hero)
      end
    end
  end
  if self.sortRule ~= "noChange" then
    table.sort(self.result, HeroSortRules[self.sortRule])
    if next(self.specialHero) then
      table.sort(self.specialHero, HeroSortRules[self.sortRule])
    end
  end
  if next(self.specialHero) then
    for _, hero in ipairs(self.specialHero) do
      table.insert(self.result, hero)
    end
    self.specialHero = {}
  end
end

function FilterLogic:getResult()
  return self.result
end

return FilterLogic
