local SuitCsv = require("csvdata.equip_suit")
local FilterEquipLogic = class("FilterEquipLogic")
local EquipSortRules = {
  default = function(a, b)
    local factorA = a.star * 1000000000 + a.washCount * 100000 + a:getAllExp() + SuitCsv[a.suitId].order * 1000000
    local factorB = b.star * 1000000000 + b.washCount * 100000 + b:getAllExp() + SuitCsv[b.suitId].order * 1000000
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  starDesc = function(a, b)
    local factorA = a.star * 1000000000 + a.washCount * 100000 + a:getAllExp() + SuitCsv[a.suitId].order * 1000000
    local factorB = b.star * 1000000000 + b.washCount * 100000 + b:getAllExp() + SuitCsv[b.suitId].order * 1000000
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  starAsc = function(a, b)
    local factorA = a.star * 1000000000 + a.washCount * 100000 + a:getAllExp() + SuitCsv[a.suitId].order * 1000000
    local factorB = b.star * 1000000000 + b.washCount * 100000 + b:getAllExp() + SuitCsv[b.suitId].order * 1000000
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA < factorB
  end,
  washDesc = function(a, b)
    local factorA = a.washCount * 1000000000 + a.star * 100000 + a:getAllExp() + SuitCsv[a.suitId].order * 1000000
    local factorB = b.washCount * 1000000000 + b.star * 100000 + b:getAllExp() + SuitCsv[b.suitId].order * 1000000
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  washAsc = function(a, b)
    local factorA = a.washCount * 1000000000 + a.star * 100000 + a:getAllExp() + SuitCsv[a.suitId].order * 1000000
    local factorB = b.washCount * 1000000000 + b.star * 100000 + b:getAllExp() + SuitCsv[b.suitId].order * 1000000
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA < factorB
  end,
  teamDesc = function(a, b)
    local heroA = game.role.heros[a.masterId]
    local heroB = game.role.heros[b.masterId]
    local formatA = heroA and heroA.formation or 0
    local formatB = heroB and heroB.formation or 0
    local factorA = formatA * 1000000 + a.star * 100000 + a:getAllExp()
    local factorB = formatB * 1000000 + b.star * 100000 + b:getAllExp()
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  teamAsc = function(a, b)
    local heroA = game.role.heros[a.masterId]
    local heroB = game.role.heros[b.masterId]
    local formatA = heroA and heroA.formation or 10
    local formatB = heroB and heroB.formation or 10
    local factorA = (10 - formatA) * 1000000 - a.star * 100000 - a:getAllExp()
    local factorB = (10 - formatB) * 1000000 - b.star * 100000 - b:getAllExp()
    if factorA == factorB then
      return a.type < b.type
    end
    return factorA > factorB
  end,
  timeDesc = function(a, b)
    return a.id > b.id
  end,
  timeAsc = function(a, b)
    return a.id < b.id
  end,
  strengthDesc = function(a, b)
    local factorA = a:getStrengthLevel() * 100000000 + a.csvData.star * 10000 + a.id
    local factorB = b:getStrengthLevel() * 100000000 + b.csvData.star * 10000 + b.id
    return factorA > factorB
  end,
  strengthAsc = function(a, b)
    local factorA = a:getStrengthLevel() * 100000000 + a.csvData.star * 10000 + a.id
    local factorB = b:getStrengthLevel() * 100000000 + b.csvData.star * 10000 + b.id
    return factorA < factorB
  end
}

function FilterEquipLogic:ctor(params)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  self.source = params.heros
  self.result = params.heros
  self.profession = {}
  self.sortRule = params.sortRule or "default"
end

function FilterEquipLogic:setSource(heros)
  self.source = heros
  self:filter()
end

function FilterEquipLogic:filterByConditions(params)
  self.profession = params.professions or self.profession
  self.sortRule = params.rule or self.sortRule
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterEquipLogic:filterByType(params)
  self.profession = {}
  self.profession[params.type] = 1
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterEquipLogic:orderByRule(params)
  self.sortRule = params.rule
  self:filter()
  self:dispatchEvent({
    name = "filter",
    sortRule = params.rule
  })
end

function FilterEquipLogic:filter()
  self.result = {}
  for _, equip in ipairs(self.source) do
    if self:checkProfession(equip) then
      table.insert(self.result, equip)
    end
  end
  if self.sortRule ~= "noChange" then
    table.sort(self.result, EquipSortRules[self.sortRule])
  end
end

function FilterEquipLogic:checkProfession(equip)
  if not next(self.profession) then
    return true
  end
  if self.profession[equip.csvData.profession] then
    return true
  end
  return false
end

function FilterEquipLogic:getResult()
  return self.result
end

return FilterEquipLogic
