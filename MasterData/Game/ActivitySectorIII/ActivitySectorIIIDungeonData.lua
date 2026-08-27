local base = require("Game.ActivitySectorII.Dungeon.Data.SectorIIDungeonData")
local ActivitySectorIIIDungeonData = class("ActivitySectorIIIDungeonData", base)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function ActivitySectorIIIDungeonData:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.SectorIII
end

function ActivitySectorIIIDungeonData:GetDungeonIndex()
  return self.__index
end

function ActivitySectorIIIDungeonData:GetWADunRewardRate()
  local sectorIIData = self:GetSectorIIIActivityData()
  local isOpenRate = sectorIIData:SectorIII_IsFarmDouble()
  if not isOpenRate then
    return 1
  end
  return sectorIIData:GetSectorIII_EffiMultRate() + 1
end

function ActivitySectorIIIDungeonData:GetSectorIIIActivityData()
  local ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySectorIII)
  if ctrl == nil then
    return nil
  end
  local sectorIII = ctrl:GetSectorIIIAct(self.__actId)
  return sectorIII
end

function ActivitySectorIIIDungeonData:GetDunExtraBuffDic()
  local sectorIII = self:GetSectorIIIActivityData()
  if sectorIII == nil then
    return nil
  end
  local actBuffUnlockDic = sectorIII:GetCommonActUnlockedBuffList()
  return actBuffUnlockDic
end

function ActivitySectorIIIDungeonData:GetDunExtraDelectedBuffDic()
  local sectorIII = self:GetSectorIIIActivityData()
  if sectorIII == nil then
    return nil
  end
  local actBuffRemoveDic = sectorIII:GetCommonActDelectedBuffList()
  return actBuffRemoveDic
end

function ActivitySectorIIIDungeonData:GetCommonActDropData()
  local sectorIII = self:GetSectorIIIActivityData()
  local pointMultRateDic = sectorIII:GetSectorIII_PointMultRat()
  local rate = self:GetWADunRewardRate()
  local dropDic = {}
  for itemId, itemNumTable in pairs(self.__ActivityWinterCfg.drop_show) do
    dropDic[itemId] = {}
    dropDic[itemId].min = itemNumTable.minValue * rate
    if itemNumTable.maxValue ~= nil then
      dropDic[itemId].max = itemNumTable.maxValue * rate
    end
    local pointRate = pointMultRateDic[itemId]
    if pointRate ~= nil then
      pointRate = pointRate / 1000
      for key, value in pairs(dropDic[itemId]) do
        dropDic[itemId][key] = math.floor(value * (pointRate + 1))
      end
    end
  end
  return dropDic
end

return ActivitySectorIIIDungeonData
