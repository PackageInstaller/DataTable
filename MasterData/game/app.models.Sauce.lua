local SauceCsv = require("csvdata.sauce")
local SauceBreakCsv = require("csvdata.sauce_break")
local SauceAdvanceCsv = require("csvdata.sauce_advance")
local ItemCsv = require("csvdata.item")
local Sauce = class("Sauce")

function Sauce:ctor(msg)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  for key, value in pairs(msg) do
    self:setProperty(key, value)
  end
  self.csvData = SauceCsv[self.type]
end

function Sauce:updateProperty(msg)
  for key, value in pairs(msg) do
    self:setProperty(key, value)
  end
end

function Sauce:getName()
  return self.csvData.name
end

function Sauce:getItemId()
  return self.type + ItemStartId.sauce
end

function Sauce:getImgEx(more)
  local exs = {
    [1] = "",
    [2] = "_2",
    [3] = "_3"
  }
  local exsTanli = {
    [1] = "",
    [2] = "_2",
    [3] = "_3",
    [4] = "_4",
    [5] = "_5",
    [6] = "_6"
  }
  if self.csvData.isTanli == 1 then
    return exsTanli[globalCsv.sauceShapeChangeTanli[self:getProperty("advanceL") + (more or 0)]] or ""
  else
    return exs[globalCsv.sauceShapeChange[self:getProperty("advanceL") + (more or 0)]] or ""
  end
end

function Sauce:getBigImg(more)
  return self.csvData.image .. self:getImgEx(more) .. ".png"
end

function Sauce:getSmallImg()
  return self.csvData.image .. "_s" .. self:getImgEx() .. ".png"
end

function Sauce:getIconImg()
  return ItemCsv[self:getItemId()].icon:match("(%w+).png") .. self:getImgEx() .. ".png"
end

function Sauce:getCsvData()
  return self.csvData
end

function Sauce:getAllBrealExp()
  local breakData = SauceBreakCsv[self:getProperty("type")]
  local allExp = self:getProperty("breakE")
  local curLevel = self:getProperty("breakL")
  for i = 1, curLevel - 1 do
    allExp = allExp + breakData[i].exp
  end
  return allExp
end

function Sauce:getBreakBuff()
  local csvData = SauceBreakCsv[self:getProperty("type")][self:getProperty("breakL")]
  local result = {
    damage = csvData.damageup + csvData.extradamageup,
    shield = csvData.shieldup + csvData.extrashieldup,
    speciallv = csvData.speciallv,
    blocklv = csvData.blocklv
  }
  if self:getProperty("breakL") >= globalCsv.specialSauceBreak then
    local counterType = {
      [1] = "damage",
      [2] = "shield"
    }
    for _, one in pairs(self:getCsvData().counter:toArray()) do
      local temp = one:toArray("=", true)
      result[counterType[temp[2]] .. temp[1]] = (result[counterType[temp[2]] .. temp[1]] or 0) + temp[3]
    end
  end
  return result
end

function Sauce:getAllBreakBuff()
  local result = {
    unlock = {},
    lock = {},
    extra = {}
  }
  local csvData = SauceBreakCsv[self:getProperty("type")][self:getProperty("breakL")]
  local tempBuff = {
    damageup = csvData.damageup + csvData.extradamageup,
    shieldup = csvData.shieldup + csvData.extrashieldup,
    speciallv = csvData.speciallv,
    blocklv = csvData.blocklv
  }
  for k, v in pairs(tempBuff) do
    if v ~= 0 then
      result.unlock[k] = v
    end
  end
  local counterType = {
    [1] = "damage",
    [2] = "shield"
  }
  for _, one in pairs(self:getCsvData().counter:toArray()) do
    local temp = one:toArray("=", true)
    if self:getProperty("breakL") >= globalCsv.specialSauceBreak then
      result.unlock[counterType[temp[2]] .. temp[1]] = temp[3]
    else
      result.lock[counterType[temp[2]] .. temp[1]] = temp[3]
    end
  end
  local csvData = SauceBreakCsv[self:getProperty("type")]
  local endData = csvData[#csvData]
  local keys = {
    "damageup",
    "shieldup",
    "speciallv",
    "blocklv"
  }
  for idx, key in pairs(keys) do
    if endData[key] == 0 and endData["extra" .. key] ~= 0 then
      if not result.unlock[key] then
        result.lock[key] = endData["extra" .. key]
      end
    elseif endData[key] ~= 0 and not endData["extra" .. key] then
      if not result.unlock[key] then
        result.lock[key] = endData[key]
      end
    elseif endData[key] ~= 0 and endData["extra" .. key] ~= 0 and (not result.unlock[key] or self:getProperty("breakL") < endData.breaklv) then
      result.extra["extra" .. key] = endData["extra" .. key]
    end
  end
  return result
end

local BuffType = {
  [1] = "hp",
  [2] = "atk",
  [3] = "phyDef",
  [4] = "hit",
  [5] = "miss",
  [6] = "crit",
  [7] = "critHurt",
  [8] = "atkSpeed",
  [9] = "speciallv",
  [10] = "blocklv",
  [11] = "damage",
  [12] = "shield",
  [13] = "skill_passive"
}

function Sauce:getAdvanceBuff(params)
  params = params or {}
  local advanceL = params.advanceL or self:getProperty("advanceL")
  local csvData = SauceAdvanceCsv[self:getProperty("type")]
  local result = {
    skill_passive = {}
  }
  local isBuffHero = false
  local curHeroType = 0
  if self:getProperty("masterId") ~= 0 then
    local hero = game.role.heros[self:getProperty("masterId")]
    if hero then
      curHeroType = hero:getProperty("type")
    end
  end
  if curHeroType ~= 0 then
    for _, heroType in pairs(self:getCsvData().type:toArray("=", true)) do
      if heroType == curHeroType then
        isBuffHero = true
        break
      end
    end
  end
  for i = 0, advanceL do
    for _, one in pairs(csvData[i].saucetype:toArray()) do
      local temp = one:toArray("=", true)
      if BuffType[temp[1]] and (temp[3] == 0 or isBuffHero) then
        if temp[1] == 13 then
          table.insert(result[BuffType[temp[1]]], temp[2])
        else
          result[BuffType[temp[1]]] = (result[BuffType[temp[1]]] or 0) + temp[2]
        end
      end
    end
  end
  return result
end

function Sauce:getAllAdvanceBuff(params)
  params = params or {}
  local result = {
    unlock = {},
    lock = {}
  }
  local advanceL = params.advanceL or self:getProperty("advanceL")
  local csvData = SauceAdvanceCsv[self:getProperty("type")]
  local isBuffHero = false
  local curHeroType = 0
  if self:getProperty("masterId") ~= 0 then
    local hero = game.role.heros[self:getProperty("masterId")]
    if hero then
      curHeroType = hero:getProperty("type")
    end
  end
  local AllBuff = {}
  for _, data in ipairs(csvData) do
    for _, one in pairs(data.saucetype:toArray()) do
      local temp = one:toArray("=", true)
      if temp[1] == 13 then
        if not AllBuff[temp[2]] then
          AllBuff[temp[2]] = 1
        end
      else
        AllBuff[temp[1]] = (AllBuff[temp[1]] or 0) + temp[2]
      end
    end
  end
  if curHeroType ~= 0 then
    for _, heroType in pairs(self:getCsvData().type:toArray("=", true)) do
      if heroType == 9999 or heroType == curHeroType then
        isBuffHero = true
        break
      end
    end
  end
  local HaveBuff = {}
  for i = 0, advanceL do
    for _, one in pairs(csvData[i].saucetype:toArray()) do
      local temp = one:toArray("=", true)
      if BuffType[temp[1]] and (temp[3] == 0 or isBuffHero) then
        if temp[1] == 13 then
          HaveBuff[temp[2]] = 1
        else
          HaveBuff[temp[1]] = (HaveBuff[temp[1]] or 0) + temp[2]
        end
      end
    end
  end
  for buffId, value in pairs(AllBuff) do
    if HaveBuff[buffId] then
      result.unlock[buffId] = HaveBuff[buffId]
    else
      result.lock[buffId] = value
    end
  end
  return result
end

function Sauce:getBuff()
  local advanceBuff = self:getAdvanceBuff()
  local breakBuff = self:getBreakBuff()
  for k, v in pairs(breakBuff) do
    if advanceBuff[k] then
      advanceBuff[k] = advanceBuff[k] + v
    else
      advanceBuff[k] = v
    end
  end
  return advanceBuff
end

function Sauce:setProperty(key, value)
  if type(value) == "number" then
    self[key .. "__ed"] = tostring(value)
  end
  self[key] = value
end

function Sauce:getProperty(key)
  if self[key .. "__ed"] then
    return tonumber(self[key .. "__ed"])
  else
    return self[key]
  end
end

return Sauce
