local LocalData = require("GameCore.Data.LocalData")
local RapidJson = require("rapidjson")
local IceCreamLevelData = class("IceCreamLevelData")

function IceCreamLevelData:InitData(nLevelId, nActId)
  self.levelId = nLevelId
  self.nActId = nActId
  self.cacheHasDicList = {}
  self.levelConfig = ConfigTable.GetData("ActivityIceCreamLevel", nLevelId)
  if not self.levelConfig then
    printError("关卡Id" .. nLevelId .. "不存在")
    return
  end
  self:InitTbBuffs()
  local sJson = LocalData.GetPlayerLocalData("IceCreamDicId")
  local tb = decodeJson(sJson)
  if type(tb) == "table" then
    self.cacheHasDicList = tb
  end
  local nOctopusFoot = ConfigTable.GetConfigNumberArray("IceCreamOctopusClick")
  self.nOctopusFoot_min = nOctopusFoot[1]
  self.nOctopusFoot_max = nOctopusFoot[2]
  self.nLevelMaxScore = ConfigTable.GetConfigNumber("IceCreamMaxTotalScore") or 999999999
end

function IceCreamLevelData:InitTbBuffs()
  if self.tbCurrentBuffs == nil then
    self.tbCurrentBuffs = {}
    self.tbCurrentBuffs[1] = 0
    self.tbCurrentBuffs[2] = 0
  end
end

function IceCreamLevelData:GetCurrentLevelData(nLevelId)
  if self.levelId ~= nLevelId then
    printError("关卡ID 错误")
    return nil
  end
  return self.levelConfig
end

function IceCreamLevelData:GetNewBuffItem(nItemId)
  local nIndex = 1
  local bSlot1Empty = self.tbCurrentBuffs[1] == 0
  local bSlot2Empty = self.tbCurrentBuffs[2] == 0
  if bSlot1Empty and bSlot2Empty then
    self.tbCurrentBuffs[1] = nItemId
  elseif bSlot1Empty then
    self.tbCurrentBuffs[1] = nItemId
  elseif bSlot2Empty then
    self.tbCurrentBuffs[2] = nItemId
    nIndex = 2
  else
    self.tbCurrentBuffs[1] = self.tbCurrentBuffs[2]
    self.tbCurrentBuffs[2] = nItemId
    nIndex = 2
  end
  return nIndex
end

function IceCreamLevelData:GetCurrentBuffs()
  if not self.tbCurrentBuffs then
    self:InitTbBuffs()
  end
  return self.tbCurrentBuffs
end

function IceCreamLevelData:UseBuffsItem(nItemId, nIndex)
  if self.tbCurrentBuffs[nIndex] == nil or self.tbCurrentBuffs[nIndex] ~= nItemId then
    printError("在不存在的位置点击了道具--虚空索道具")
    return
  end
  self.tbCurrentBuffs[nIndex] = 0
  printLog("使用了道具:" .. nItemId)
end

function IceCreamLevelData:GetCurrentLevelFever()
  if self.levelConfig == nil then
    return -1
  end
  return self.levelConfig.Fever
end

function IceCreamLevelData:IsTrueBuffID(nBuffId)
  if ConfigTable.GetData("IceCreamBuff", nBuffId) then
    return true
  end
  return false
end

function IceCreamLevelData:GM_GetNewBuffItem(nBuffId, nIndex)
  self.tbCurrentBuffs[nIndex] = nBuffId
end

function IceCreamLevelData:GetFloorHasOpenDic(nLevelId)
  if self.levelId ~= nLevelId then
    printError("关卡ID 错误")
    return false
  end
  local bResult = false
  if self.levelConfig ~= nil and self.levelConfig.DictionaryId ~= 0 then
    if table.indexof(self.cacheHasDicList, nLevelId) == 0 then
      bResult = false
    else
      bResult = true
    end
  end
  return bResult
end

function IceCreamLevelData:GetDicId(nLevelId)
  if self.levelId ~= nLevelId then
    printError("关卡ID 错误")
    return 0
  end
  if self.levelConfig ~= nil then
    return self.levelConfig.DictionaryId
  end
  return 0
end

function IceCreamLevelData:OnEvent_SetFloorHasDic(nLevelId)
  if table.indexof(self.cacheHasDicList, nLevelId) == 0 then
    table.insert(self.cacheHasDicList, nLevelId)
    local tbLocalSave = {}
    for _, v in ipairs(self.cacheHasDicList) do
      table.insert(tbLocalSave, v)
    end
    LocalData.SetPlayerLocalData("IceCreamDicId", RapidJson.encode(tbLocalSave))
  end
end

function IceCreamLevelData:CreatOctopusFoots()
  local tbOctopus = {}
  local tbPool = {
    1,
    2,
    3,
    4,
    5,
    6
  }
  local nNumberOctopus = math.random(self.nOctopusFoot_min, self.nOctopusFoot_max)
  if nNumberOctopus < 0 then
    return nil
  end
  for i = 1, nNumberOctopus do
    local nIndex = math.random(i, #tbPool)
    tbPool[i], tbPool[nIndex] = tbPool[i], tbPool[nIndex]
    tbOctopus[i] = tbPool[i]
  end
  if #tbOctopus == 0 then
    return nil
  else
    return tbOctopus
  end
end

function IceCreamLevelData:GetProtectScore(nLevelScore)
  nLevelScore = math.min(nLevelScore, self.nLevelMaxScore)
  return nLevelScore
end

return IceCreamLevelData
