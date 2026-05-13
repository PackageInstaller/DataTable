local AccessCsv = require("csvdata.diner_accessory")
local AccEntryCsv = require("csvdata.diner_entry")
local CarCsv = require("csvdata.diner_car")
local DishCsv = require("csvdata.diner_dish")
local MapCsv = require("csvdata.diner_sell")
local ConditionCsv = require("csvdata.diner_sellcondition")
local Diner = class("Diner")
Diner.schema = {
  "id",
  "car",
  "material",
  "accessories"
}

function Diner:ctor(msg)
  for key, value in pairs(msg) do
    self:setProperty(key, value)
  end
end

function Diner:updateProperty(msg)
  for _, key in ipairs(Diner.schema) do
    self:setProperty(key, msg[key])
  end
end

function Diner:setProperty(key, value)
  self[key] = value
end

function Diner:getProperty(key)
  return self[key]
end

function Diner:getAccessOwner(accId)
  if not game.role.diner then
    return nil
  end
  for _, dinerData in pairs(game.role.diner.diners) do
    local accessStr = dinerData.accessories or ""
    for _, id in pairs(accessStr:toNumMap()) do
      if id == accId then
        return dinerData.id
      end
    end
  end
  return nil
end

function Diner:getFreeAccessType(type)
  local free = {}
  for _, data in pairs(game.role.diner.accessories) do
    local tempType = AccessCsv[data.type].type
    if not self:getAccessOwner(data.id) then
      if type == tempType then
        return true
      end
      if not free[tempType] then
        free[tempType] = true
      end
    end
  end
  if type then
    return false
  end
  return free
end

function Diner:getCarOwner(carId)
  if not game.role.diner then
    return nil
  end
  for _, dinerData in pairs(game.role.diner.diners) do
    if carId == dinerData.car then
      return dinerData.id
    end
  end
  return nil
end

function Diner:getSelfCar()
  return self.car
end

function Diner:getEnergyTotal()
  local total = 0
  if self.accessories then
    for type, id in pairs(self.accessories:toNumMap()) do
      local access = game.role.diner.accessories[id]
      local data = AccessCsv[access.type]
      if data and data.type == 1 then
        total = total + math.floor(data.energy * globalCsv.dinnerEntryStrengthRange:getv(access.level, 1))
      end
    end
  end
  return total
end

function Diner:getEnergyCost()
  local cost = 0
  if self.accessories then
    for type, id in pairs(self.accessories:toNumMap()) do
      local access = game.role.diner.accessories[id]
      local data = AccessCsv[access.type]
      if data and data.type ~= 1 then
        cost = cost + math.floor(data.energy * globalCsv.dinnerEntryStrengthRange:getv(access.level, 1))
      end
    end
  end
  return cost
end

function Diner:getFinalAttrs()
  local attr = {}
  local act = {}
  if not self.car or self.car == 0 then
    return attr
  end
  if self.accessories and self.accessories ~= "" then
    local hadSubType = {}
    for _, id in pairs(self.accessories:toNumMap()) do
      local accessory = game.role.diner.accessories[id]
      local accData = AccessCsv[accessory.type]
      if accData then
        hadSubType[accData.subtype] = (hadSubType[accData.subtype] or 0) + 1
      end
    end
    local fields = {"baseAttr", "extraAttr"}
    for _, id in pairs(self.accessories:toNumMap()) do
      local accessory = game.role.diner.accessories[id]
      local accData = AccessCsv[accessory.type]
      if accData and accData.type ~= 3 then
        for index, field in pairs(fields) do
          local id, value = accessory[field]:match("(%d+)=(%d+%.?%d*)")
          local data = AccEntryCsv[tonumber(id)]
          if data then
            local conSubType, count = data.condition:match("(%d+)=(%d+)")
            local add = index == 1 and globalCsv.dinnerEntryStrengthRange:getv(accessory.level, 1) * tonumber(value) or tonumber(value)
            if not conSubType or (hadSubType[tonumber(conSubType)] or 0) >= tonumber(count) then
              if field == "extraAttr" then
                act[accessory.id] = true
              end
              attr[data.type] = (attr[data.type] or 0) + add
            end
          end
        end
      end
    end
  end
  local carData = CarCsv[self.car]
  attr.base1 = carData.baseAttr1 + carData.baseAttr1 * ((attr[5] or 0) - (attr[6] or 0)) / 100 + (attr[7] or 0) - (attr[8] or 0)
  attr.base2 = carData.baseAttr2 + carData.baseAttr2 * ((attr[9] or 0) - (attr[10] or 0)) / 100 + (attr[11] or 0) - (attr[12] or 0)
  attr.base3 = carData.baseAttr3 + carData.baseAttr3 * ((attr[13] or 0) - (attr[14] or 0)) / 100 + (attr[15] or 0) - (attr[16] or 0)
  return attr, act
end

function Diner:getPresetReward(heros, mapId)
  local sellInfo = json.decode(game.role.diner.sellInfo).sell
  local curSell = sellInfo[tostring(mapId)]
  local heros = heros or curSell.heros or {}
  local reward = {}
  local condition = {}
  local dinerAttr = self:getFinalAttrs()
  local dishTypeCount = {}
  local dishSpecialCount = {}
  local taste = {
    0,
    0,
    0
  }
  for _, heroInfo in pairs(heros) do
    local dishData = DishCsv[heroInfo.type]
    dishTypeCount[dishData.type] = (dishTypeCount[dishData.type] or 0) + 1
    dishSpecialCount[dishData.special] = (dishSpecialCount[dishData.special] or 0) + 1
    taste[1] = taste[1] + dishData.taste1:getv(heroInfo.level, 0)
    taste[2] = taste[2] + dishData.taste2:getv(heroInfo.level, 0)
    taste[3] = taste[3] + dishData.taste3:getv(heroInfo.level, 0)
  end
  local areaEffect = 0
  local group = curSell.nowGroup ~= 0 and curSell.nowGroup or curSell.aimGroup
  local mapData = MapCsv[mapId][group]
  local curConds = mapData.require:toArray("=", true)
  for mapId_, sellData in pairs(sellInfo) do
    local group = sellData.nowGroup ~= 0 and sellData.nowGroup or sellData.aimGroup
    local map = MapCsv[tonumber(mapId_)][group]
    local include = mapId == tonumber(mapId_)
    for _, conId in ipairs(map.require:toArray("=", true)) do
      local condData = ConditionCsv[conId]
      if not condData then
        break
      end
      local ok = false
      if condData.type == 1 then
        if dinerAttr.base1 >= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 2 then
        if dinerAttr.base1 <= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 3 then
        if dinerAttr.base2 >= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 4 then
        if dinerAttr.base2 <= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 5 then
        if dinerAttr.base3 >= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 6 then
        if dinerAttr.base3 <= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 7 then
        if taste[1] + taste[2] + taste[3] >= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 8 then
        if taste[1] + taste[2] + taste[3] <= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 9 then
        if condData.condition2 == 0 and #heros >= condData.condition1 or (dishSpecialCount[condData.condition2] or 0) >= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 10 then
        if condData.condition2 == 0 and #heros <= condData.condition1 or (dishSpecialCount[condData.condition2] or 0) <= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 11 then
        if condData.condition2 == 0 and #heros >= condData.condition1 or (dishTypeCount[condData.condition2] or 0) >= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 12 then
        if condData.condition2 == 0 and #heros <= condData.condition1 or (dishTypeCount[condData.condition2] or 0) <= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 13 then
        if taste[1] >= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 14 then
        if taste[1] <= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 15 then
        if taste[2] >= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 16 then
        if taste[2] <= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 17 then
        if taste[3] >= condData.condition1 then
          condition[conId] = true
          if include then
            ok = true
          end
        end
      elseif condData.type == 18 and taste[3] <= condData.condition1 then
        condition[conId] = true
        if include then
          ok = true
        end
      end
      if ok then
        areaEffect = areaEffect + condData.effect
      end
    end
  end
  areaEffect = areaEffect + areaEffect * ((dinerAttr[19] or 0) - (dinerAttr[20] or 0)) / 100 + (dinerAttr[21] or 0) - (dinerAttr[22] or 0)
  for itemId, count in pairs(mapData.gift1:toNumMap()) do
    reward[itemId] = (reward[itemId] or 0) + count
  end
  for itemId, count in pairs(mapData.gift2:toNumMap()) do
    reward[itemId] = (reward[itemId] or 0) + count
  end
  local silver = reward[6] or 0
  local gold = reward[7] or 0
  local baseValue = (dinerAttr.base1 + dinerAttr.base2 + dinerAttr.base3 + (taste[1] + taste[2] + taste[3])) / 10000 * silver
  reward[6] = math.floor(100 + baseValue + baseValue * ((dinerAttr[1] or 0) - (dinerAttr[2] or 0) + areaEffect) / 100 + (dinerAttr[3] or 0) - (dinerAttr[4] or 0))
  reward[7] = math.floor(gold * math.pow((dinerAttr.base1 + dinerAttr.base2 + dinerAttr.base3 + (taste[1] + taste[2] + taste[3])) / 9400, 0.8))
  reward[6] = math.max(reward[6], 1)
  reward[7] = math.max(reward[7], 1)
  reward.material = (dinerAttr[17] or 0) - (dinerAttr[18] or 0)
  reward.taste = taste
  reward.base1 = dinerAttr.base1
  reward.base2 = dinerAttr.base2
  reward.base3 = dinerAttr.base3
  return reward, condition
end

function Diner:getSellState(dinerId)
  dinerId = dinerId or self.id
  local sellInfo = json.decode(game.role.diner.sellInfo).sell
  for _, mapData in pairs(sellInfo) do
    if mapData.diner == dinerId then
      return true, mapData
    end
  end
  return false
end

return Diner
