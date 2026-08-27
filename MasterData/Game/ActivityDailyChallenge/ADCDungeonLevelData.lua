local DungeonLevelBase = require("Game.DungeonCenter.Data.DungeonLevelBase")
local ADCDungeonLevelData = class("ADCDungeonLevelData", DungeonLevelBase)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local cs_MessageCommon = CS.MessageCommon

function ADCDungeonLevelData:SetDungeonADCData(adcData)
  self._adcData = adcData
  self._adcDungeonCfg = self._adcData:GetADCDungeonCfg()[self:GetDungeonLevelStageId()]
end

function ADCDungeonLevelData:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.ADC
end

function ADCDungeonLevelData:GetDungeonInfoDesc()
  return LanguageUtil.GetLocaleText(self._adcDungeonCfg.dungeon_desc)
end

function ADCDungeonLevelData:GetDungeonLevelPic()
  return self._adcDungeonCfg.dungeon_pic
end

function ADCDungeonLevelData:DealDungeonResult(resultInfo)
  local rewardMsg = resultInfo.rewardMsg
  local dungeonId
  if rewardMsg ~= nil then
    local adcScore = rewardMsg.activityDailyChallengeDungeonScore
    dungeonId = adcScore[1]
    if dungeonId == nil then
      return
    end
    local score = adcScore[2] or 0
    if score > self._adcData:GetADCDungeonPoint(dungeonId) or score == 0 then
      self._adcData:SetADCDunegonPoint(dungeonId, score)
    end
  end
  local endDamageValue = resultInfo.endDamageValue
  if endDamageValue ~= nil and rewardMsg.__endDamageValue ~= nil and 0 < rewardMsg.__endDamageValue then
    self._adcData:TryUpdateADCDunegonMaxDmg(dungeonId, rewardMsg.__endDamageValue)
  end
end

function ADCDungeonLevelData:GetLevelResourceGroup()
  return self._adcData:GetADCMainCfg().unlock_item
end

function ADCDungeonLevelData:GetDungeonADCData()
  return self._adcData
end

function ADCDungeonLevelData:GetDungeonADCScore()
  return self._adcData:GetADCDungeonPoint(self:GetDungeonLevelStageId())
end

function ADCDungeonLevelData:GetDungeonADCMaxDamage()
  return self._adcData:GetADCHeightestDamage(self:GetDungeonLevelStageId())
end

function ADCDungeonLevelData:GetDungeonADCRankId()
  return self._adcDungeonCfg.ranklist_id
end

function ADCDungeonLevelData:GetIsInfinite()
  return self._adcDungeonCfg.is_infinite
end

function ADCDungeonLevelData:IsADCDungeonLevelUnlock()
  return self._adcData:IsADCDungeonUnlock(self:GetDungeonLevelStageId())
end

function ADCDungeonLevelData:GetADCDunUnlockItemAndCount()
  return self._adcData:GetADCMainCfg().unlock_item, self._adcDungeonCfg.unlock_item
end

function ADCDungeonLevelData:ReqADCDunUnlock(callback)
  if self:IsADCDungeonLevelUnlock() then
    return
  end
  local itemId, itemCount = self:GetADCDunUnlockItemAndCount()
  if itemCount > self._adcData:GetADCKeyItemCount() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(8414))
    return
  end
  local itemName = ConfigData:GetItemName(itemId)
  local dungeonName = self:GetDungeonLevelName()
  local tips = string.format(ConfigData:GetTipContent(8413), tostring(itemCount), itemName, dungeonName)
  cs_MessageCommon.ShowMessageBox(tips, function()
    self._adcData:ReqADCUnlockDungeon(self:GetDungeonLevelStageId(), callback)
  end, nil)
end

function ADCDungeonLevelData:GetIsShowRacingTime()
  return not self._adcDungeonCfg.is_infinite
end

function ADCDungeonLevelData:GetIsShowDamageNum()
  return self._adcDungeonCfg.is_infinite
end

function ADCDungeonLevelData:GetIsShowDunRank()
  return true
end

function ADCDungeonLevelData:GetIsOnlyShowScore()
  return not self:GetIsInfinite()
end

return ADCDungeonLevelData
