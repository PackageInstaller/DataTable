local EquipCsv = require("csvdata.equip")
local SuitCsv = require("csvdata.equip_suit")
local LevelCsv = require("csvdata.equip_level")
local ReDefineCsv = require("csvdata.equip_refine")
local Equip = class("Equip")

function Equip:ctor(msg)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  for key, value in pairs(msg) do
    self:setProperty(key, value)
  end
  self.csvData = EquipCsv[self.type]
  self.star = self.csvData.star
  self.type = self.csvData.type
end

function Equip:updateProperty(msg)
  for key, value in pairs(msg) do
    self:setProperty(key, value)
  end
end

function Equip:getStrengthLevel()
  local level = 0
  for Type = 1, 2 do
    for slot = 1, 2 do
      level = level + self:getAttrLevel(slot, Type == 1)
    end
  end
  return level
end

function Equip:getAttrLevel(slot, isBase)
  local exp = self:getAttrExp(slot, isBase)
  local level = 0
  for index, data in ipairs(LevelCsv) do
    if exp >= data.exp then
      level = index
    else
      break
    end
  end
  return level
end

function Equip:getAttrExp(slot, isBase)
  local attrExpStr = isBase and self.baseExp or self.exExp
  return attrExpStr:getv(slot, 0)
end

function Equip:getAllExp()
  local exp = 0
  for slot = 1, 2 do
    exp = exp + self.baseExp:getv(slot, 0)
  end
  for slot = 1, 2 do
    exp = exp + self.exExp:getv(slot, 0)
  end
  return exp
end

function Equip:getName()
  local bef = self.suitId == 0 and "" or SuitCsv[self.suitId].name
  local aft = self.csvData.name
  if bef == "" then
    return string.format("<div color=#703802 >%s</div>", aft)
  end
  return string.format("<div color=#df410a >%s</div> <div color=#703802 >%s</div>", bef, aft)
end

function Equip:getSuitName()
  return self.suitId == 0 and "" or SuitCsv[self.suitId].name
end

function Equip:getItemId()
  if self.type > 1000 then
    return self.type + ItemStartId.newEquip
  end
  return self.type + ItemStartId.equip
end

function Equip:getMaxExAttr(attrType)
  local unitData = EquipCsv[self.type]
  local values = string.toTableArray(unitData["type" .. attrType])
  return checknumber(values[#values][2])
end

function Equip:getRepairCost()
  local cost = {}
  local equipData = EquipCsv[self.type]
  local costSet = ReDefineCsv[equipData.profession]
  local num = (equipData.durability - self.durability) * costSet.repair_material
  return math.ceil(num)
end

function Equip:showRed()
  return self.durability <= globalCsv.equipWarningDurability, self.durability
end

function Equip:setProperty(key, value)
  if type(value) == "number" then
    self[key .. "__ed"] = tostring(value)
  end
  self[key] = value
end

function Equip:getProperty(key)
  if self[key .. "__ed"] then
    return tonumber(self[key .. "__ed"])
  else
    return self[key]
  end
end

return Equip
