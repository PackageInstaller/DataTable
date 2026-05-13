local FormatCsv = require("csvdata.formation")
local UnitCsv = require("csvdata.unit")
local FormatLogic = {}
local formatMap = {
  [1] = {
    2,
    3,
    4,
    5,
    6,
    7
  },
  [2] = {
    0,
    8,
    3,
    1,
    7,
    13
  },
  [3] = {
    8,
    0,
    9,
    4,
    1,
    2
  },
  [4] = {
    3,
    9,
    0,
    10,
    5,
    1
  },
  [5] = {
    1,
    4,
    10,
    0,
    11,
    6
  },
  [6] = {
    7,
    1,
    5,
    11,
    0,
    12
  },
  [7] = {
    13,
    2,
    1,
    6,
    12,
    0
  },
  [8] = {
    0,
    0,
    0,
    3,
    2,
    0
  },
  [9] = {
    0,
    0,
    0,
    0,
    4,
    3
  },
  [10] = {
    4,
    0,
    0,
    0,
    0,
    5
  },
  [11] = {
    6,
    5,
    0,
    0,
    0,
    0
  },
  [12] = {
    0,
    7,
    6,
    0,
    0,
    0
  },
  [13] = {
    0,
    0,
    2,
    7,
    0,
    0
  }
}

function FormatLogic.getFormatRotation(a, b)
  local format = formatMap[a]
  for rotation, pos in ipairs(format) do
    if pos == b then
      return rotation
    end
  end
end

function FormatLogic.getActiveStatus(format, heros)
  heros = heros or game.role.heros
  for _, hero in pairs(heros) do
    hero.formationId = hero.formationId or UnitCsv[hero.type].formation
  end
  local result = {}
  for pos, heroId in pairs(format) do
    local status = {
      links = FormatLogic.getLinkHeros(pos, format),
      active = FormatLogic.isActive(pos, format, heros)
    }
    result[heroId] = status
  end
  return result
end

function FormatLogic.getActiveEffect(format, heros)
  heros = heros or game.role.heros
  for _, hero in pairs(heros) do
    hero.formationId = hero.formationId or UnitCsv[hero.type].formation
  end
  local activeStatus = FormatLogic.getActiveStatus(format, heros)
  local effects = {}
  for heroId, status in pairs(activeStatus) do
    if status.active then
      local hero = heros[heroId]
      local formatData = FormatCsv[hero.formationId][hero.fieldLevel]
      local active = math.randomInt(1, 100) <= formatData.chance
      for _, effect in ipairs(formatData.effectValue:toTableArray(" ")) do
        local type, pro, value = tonumber(effect[1]), tonumber(effect[2]), tonumber(effect[3])
        if not effects[pro] then
          effects[pro] = {}
        end
        if effect[4] and pro == 7 then
          table.insert(effects[pro], {
            type = type,
            value = value,
            active = active,
            unitType = tonumber(effect[4])
          })
        else
          table.insert(effects[pro], {
            type = type,
            value = value,
            active = active
          })
        end
      end
    end
  end
  return effects
end

function FormatLogic.isActive(pos, format, heros)
  local heroId = format[pos]
  local hero = heros[heroId]
  local formatData = FormatCsv[hero.formationId][hero.fieldLevel]
  if not formatData then
    return false
  end
  local linkHeros = FormatLogic.getLinkHeros(pos, format)
  for index, condition in ipairs(formatData.condition:toTableArray()) do
    local type, profession, num = tonumber(condition[1]), tonumber(condition[2]), tonumber(condition[3])
    local count = 0
    for _heroId, pos in pairs(linkHeros) do
      local unitData = UnitCsv[heros[_heroId].type]
      if profession == 0 or unitData.profession == profession then
        count = count + 1
      end
    end
    if type == 1 and num > count or type == 2 and num <= count then
      return false
    end
  end
  return true
end

function FormatLogic.getLinkHeros(pos, format)
  local heros = {}
  local map = formatMap[pos]
  for index, pos in ipairs(map) do
    local heroId = format[pos]
    if heroId then
      heros[heroId] = true
    end
  end
  return heros
end

function FormatLogic.getUnLinkHeros(pos, format)
  local heros = {}
  local linkheros = FormatLogic.getLinkHeros(pos, format)
  for pos, heroId in ipairs(format) do
    if not linkheros[heroId] then
      heros[heroId] = true
    end
  end
  return heros
end

return FormatLogic
