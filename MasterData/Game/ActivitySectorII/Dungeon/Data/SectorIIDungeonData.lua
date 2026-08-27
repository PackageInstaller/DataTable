local base = require("Game.DungeonCenter.Data.DungeonLevelBase")
local SectorIIDungeonData = class("SectorIIDungeonData", base)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function SectorIIDungeonData:ctor(stageId, actInfo, index)
  self.__actId = actInfo:GetActId()
  self.__actInfo = actInfo
  self.__index = index
  self.__levelPos = nil
  self.__couldSkipTimeLine = true
end

function SectorIIDungeonData:SetSectorIIDungeonExtraData(posCfg, extraCfg)
  self.__posCfg = posCfg
  self.__ActivityWinterCfg = extraCfg
end

function SectorIIDungeonData:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.SectorII
end

function SectorIIDungeonData:GetDungeonLevelName()
  return LanguageUtil.GetLocaleText(self.__dungeonStageCfg.name)
end

function SectorIIDungeonData:GetDungeonInfoDesc()
  return LanguageUtil.GetLocaleText(self.__ActivityWinterCfg.level_des)
end

function SectorIIDungeonData:GetDungeonLevelPic()
  return self.__ActivityWinterCfg.level_pic
end

function SectorIIDungeonData:GetConsumeKeyNum()
  local costNums = self.__dungeonStageCfg.cost_itemNums
  return (costNums[1] or 0) * self:GetWADunRewardRate()
end

function SectorIIDungeonData:GetEnterLevelCost()
  local costIds = self.__dungeonStageCfg.cost_itemIds
  return costIds[1] or ConstGlobalItem.SKey
end

function SectorIIDungeonData:GetEnterLevelCostItemName()
  local itemId = self:GetEnterLevelCost()
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    return tostring(itemId)
  end
  return LanguageUtil.GetLocaleText(itemCfg.name)
end

function SectorIIDungeonData:GetDungeonLevelActId()
  return self.__actId
end

function SectorIIDungeonData:GetDungeonActName()
  if self.__actInfo == nil then
    return ""
  end
  return self.__actInfo:GetActivityFrameName()
end

function SectorIIDungeonData:GetDungeonLevelOrderName()
  return LanguageUtil.GetLocaleText(self.__ActivityWinterCfg.level_num)
end

function SectorIIDungeonData:GetCommonActDropData()
  local sectorIIData = self:GetSectorIIActivityData()
  local pointMultRateDic = sectorIIData:GetSectorII_PointMultRat()
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

function SectorIIDungeonData:GetWaveNum()
  local battlePlayType = self.__dungeonStageCfg.play_para
  local playTypeCfgList = ConfigData.wave_battles[battlePlayType]
  return #playTypeCfgList
end

function SectorIIDungeonData:GetAWDungeonPos()
  if self.__levelPos ~= nil then
    return self.__levelPos
  end
  if self.__posCfg == nil then
    return Vector2.zero
  end
  self.__levelPos = Vector2.New(self.__posCfg.level_pos[1], self.__posCfg.level_pos[2])
  return self.__levelPos
end

function SectorIIDungeonData:GetSectorIIDun_ChipSuitLimitNum()
  local sectorIIData = self:GetSectorIIActivityData()
  local logicAdd = sectorIIData:GetSectorII_ChipSuitLimitNumAdd()
  local cfgNum = self.__ActivityWinterCfg.chip_select_max
  return cfgNum + logicAdd
end

function SectorIIDungeonData:GetSectorIIActivityData()
  local sectorIICtrl = ControllerManager:GetController(ControllerTypeId.SectorII)
  local sectorIIData = sectorIICtrl:GetSectorIIDataByActId(self.__actId)
  return sectorIIData
end

function SectorIIDungeonData:GetDunExtraBuffDic()
  local sectorIIData = self:GetSectorIIActivityData()
  if sectorIIData == nil then
    return nil
  end
  local actBuffUnlockDic = sectorIIData:GetSectorII_UnlockedBuffList()
  return actBuffUnlockDic
end

function SectorIIDungeonData:GetDunExtraDelectedBuffDic()
  local sectorIIData = self:GetSectorIIActivityData()
  if sectorIIData == nil then
    return nil
  end
  local actBuffRemoveDic = sectorIIData:GetSectorII_DelectedBuffList()
  return actBuffRemoveDic
end

function SectorIIDungeonData:GetCouldShowAutoPlay()
  return true
end

function SectorIIDungeonData:GetIsLevelComplete()
  local isCompleted = 0 < (PlayerDataCenter.dungeonTotalBattleTimes[self:GetDungeonLevelStageId()] or 0)
  return isCompleted
end

function SectorIIDungeonData:GetIsLevelCompleteNoSup()
  local isCompleted = PlayerDataCenter.dungeonComplectedWhithoutSupport[self:GetDungeonLevelStageId()] or false
  return isCompleted
end

function SectorIIDungeonData:GetWADunRewardRate()
  local sectorIIData = self:GetSectorIIActivityData()
  local isOpenRate = sectorIIData:GetSectorII_IsTurnOnMultEffi()
  if not isOpenRate then
    return 1
  end
  return sectorIIData:GetSectorII_EffiMultRate() + 1
end

function SectorIIDungeonData:GetLastCompleteSelectedSuitDic()
  local sectorIIData = self:GetSectorIIActivityData()
  local dunLastSuitDic = sectorIIData:GetLastCompleteDungeonSuitDic()
  local stageId = self:GetDungeonLevelStageId()
  return dunLastSuitDic[stageId] or {}
end

function SectorIIDungeonData:SaveLastCompleteSelectedSuitDic(suitDic)
  local sectorIIData = self:GetSectorIIActivityData()
  local dunLastSuitDic = sectorIIData:GetLastCompleteDungeonSuitDic()
  local stageId = self:GetDungeonLevelStageId()
  dunLastSuitDic[stageId] = suitDic
end

function SectorIIDungeonData:GetLastCompleteSelectedFormatId()
  local sectorIIData = self:GetSectorIIActivityData()
  local dunLastFormatIdDic = sectorIIData:GetLastCompleteDungeonFormatIdDic()
  local stageId = self:GetDungeonLevelStageId()
  local formId = dunLastFormatIdDic[stageId] or 1
  if formId == 0 then
    formId = 1
  end
  return formId
end

function SectorIIDungeonData:SaveLastCompleteSelectedFormatId(formatId)
  local sectorIIData = self:GetSectorIIActivityData()
  local dunLastFormatIdDic = sectorIIData:GetLastCompleteDungeonFormatIdDic()
  local stageId = self:GetDungeonLevelStageId()
  dunLastFormatIdDic[stageId] = formatId
end

function SectorIIDungeonData:GetWADunGropShowDic()
  return self.__ActivityWinterCfg.drop_show
end

return SectorIIDungeonData
