local CacheSaveData = class("CacheSaveData")

function CacheSaveData:ctor()
  self._lastDunTowerLevel = {}
end

function CacheSaveData:GetEnableConfirmInfinityNot50()
  if self.enableConfirmInfinityNot50 == nil then
    self.enableConfirmInfinityNot50 = true
  end
  return self.enableConfirmInfinityNot50
end

function CacheSaveData:SetEnableConfirmInfinityNot50(enable)
  self.enableConfirmInfinityNot50 = enable
end

function CacheSaveData:GetEnableLotteryPaidExecuteConfirm()
  if self.enableLotteryPaidExecuteConfirm == nil then
    self.enableLotteryPaidExecuteConfirm = true
  end
  return self.enableLotteryPaidExecuteConfirm
end

function CacheSaveData:SetEnableLotteryPaidExecuteConfirm(enable)
  self.enableLotteryPaidExecuteConfirm = enable
end

function CacheSaveData:GetEnableEpRewardBagExitConfirm()
  if self.enableEpRewardBagExitConfirm == nil then
    self.enableEpRewardBagExitConfirm = true
  end
  return self.enableEpRewardBagExitConfirm
end

function CacheSaveData:SetEnableEpRewardBagExitConfirm(enable)
  self.enableEpRewardBagExitConfirm = enable
end

function CacheSaveData:GetEnableShopRefreshExecuteConfirm()
  if self.enableShopRefreshExecuteConfirm == nil then
    self.enableShopRefreshExecuteConfirm = true
  end
  return self.enableShopRefreshExecuteConfirm
end

function CacheSaveData:SetEnableShopRefreshExecuteConfirm(enable)
  self.enableShopRefreshExecuteConfirm = enable
end

function CacheSaveData:GetSectorChapterAvgSkipConfirm()
  if self._sectorChapterAvgSkipConfirm == nil then
    self._sectorChapterAvgSkipConfirm = true
  end
  return self._sectorChapterAvgSkipConfirm
end

function CacheSaveData:SetSectorChapterAvgSkipConfirm(enable)
  self._sectorChapterAvgSkipConfirm = enable
end

function CacheSaveData:GetEnableActivitySpringLongTailConfirm()
  if self.enableEnableActivitySpringLongTailConfirm == nil then
    self.enableEnableActivitySpringLongTailConfirm = true
  end
  return self.enableEnableActivitySpringLongTailConfirm
end

function CacheSaveData:SetEnableActivitySpringLongTailConfirm(enable)
  self.enableEnableActivitySpringLongTailConfirm = enable
end

function CacheSaveData:GetEnableActivityCardSetNextRoundConfirm()
  if self.enableEnableActivityCardSetNextRoundConfirm == nil then
    self.enableEnableActivityCardSetNextRoundConfirm = true
  end
  return self.enableEnableActivityCardSetNextRoundConfirm
end

function CacheSaveData:SetEnableActivityCardSetNextRoundConfirm(enable)
  self.enableEnableActivityCardSetNextRoundConfirm = enable
end

function CacheSaveData:GetEnableActivityCardSetResetRoundConfirm()
  if self.enableEnableActivityCardSetResetRoundConfirm == nil then
    self.enableEnableActivityCardSetResetRoundConfirm = true
  end
  return self.enableEnableActivityCardSetResetRoundConfirm
end

function CacheSaveData:SetEnableActivityCardSetResetRoundConfirm(enable)
  self.enableEnableActivityCardSetResetRoundConfirm = enable
end

function CacheSaveData:GetEnableActivityCardSetRewindEndConfirm()
  if self.enableEnableActivityCardSetRewindEndConfirm == nil then
    self.enableEnableActivityCardSetRewindEndConfirm = true
  end
  return self.enableEnableActivityCardSetRewindEndConfirm
end

function CacheSaveData:SetEnableActivityCardSetRewindEndConfirm(enable)
  self.enableEnableActivityCardSetRewindEndConfirm = enable
end

function CacheSaveData:GetEnableActivityWinter23NoRepeatTip()
  if self.enableEnableActivityWinter23NoRepeatTip == nil then
    self.enableEnableActivityWinter23NoRepeatTip = true
  end
  return self.enableEnableActivityWinter23NoRepeatTip
end

function CacheSaveData:SetEnableActivityWinter23NoRepeatTip(enable)
  self.enableEnableActivityWinter23NoRepeatTip = enable
end

function CacheSaveData:GetEnableRfCardSaveReplaceTip()
  if self.enableRfCardSaveReplaceTip == nil then
    self.enableRfCardSaveReplaceTip = true
  end
  return self.enableRfCardSaveReplaceTip
end

function CacheSaveData:SetEnableRfCardSaveReplaceTip(enable)
  self.enableRfCardSaveReplaceTip = enable
end

function CacheSaveData:GetEnableRfCardSaveSkipTip()
  if self.enableRfCardSaveSkipTip == nil then
    self.enableRfCardSaveSkipTip = true
  end
  return self.enableRfCardSaveSkipTip
end

function CacheSaveData:SetEnableRfCardSaveSkipTip(enable)
  self.enableRfCardSaveSkipTip = enable
end

function CacheSaveData:GetEnableCardSetRemoveAll()
  if self.enableCardSetRemoveAll == nil then
    self.enableCardSetRemoveAll = true
  end
  return self.enableCardSetRemoveAll
end

function CacheSaveData:SetEnableCardSetRemoveAll(enable)
  self.enableCardSetRemoveAll = enable
end

function CacheSaveData:GetEnableCardSetFacEquipTip()
  if self.enableCardSetFacEquipTip == nil then
    self.enableCardSetFacEquipTip = true
  end
  return self.enableCardSetFacEquipTip
end

function CacheSaveData:SetEnableCardSetFacEquipTip(enable)
  self.enableCardSetFacEquipTip = enable
end

function CacheSaveData:SetSpecificHeroListSort(fid, eSortMannerType, isAsceSort)
  if self.specificHeroListSort == nil then
    self.specificHeroListSort = {}
  end
  self.specificHeroListSort[fid] = {eSortMannerType = eSortMannerType, isAsceSort = isAsceSort}
end

function CacheSaveData:GetSpecificHeroListSort(fid)
  if self.specificHeroListSort == nil or self.specificHeroListSort[fid] == nil then
    return nil
  end
  local pecificHeroListSortData = self.specificHeroListSort[fid]
  return pecificHeroListSortData.eSortMannerType, pecificHeroListSortData.isAsceSort
end

function CacheSaveData:GetOasisSkyHourOffset()
  return self.oasisSkyHour or 0
end

function CacheSaveData:SetOasisSkyHourOffset(value)
  if self.oasisSkyHour ~= value then
    self.oasisSkyHour = value
  end
end

function CacheSaveData:GetOasisSkyMonthOffset()
  return self.oasisSkyMonth or 0
end

function CacheSaveData:SetOasisSkyMonthOffset(value)
  if self.oasisSkyMonth ~= value then
    self.oasisSkyMonth = value
  end
end

function CacheSaveData:GetLastDunTowerProgress(towerId)
  return self._lastDunTowerLevel[towerId]
end

function CacheSaveData:SaveLastDunTowerProgress(towerId, level)
  self._lastDunTowerLevel[towerId] = level
end

function CacheSaveData:SetLastHeroInterationCVInfo(lastCvInfo)
  self._lastCvInfo = lastCvInfo
end

function CacheSaveData:GetLastHeroInterationCVInfo()
  if self._lastCvInfo == nil then
    self._lastCvInfo = {}
    self._lastCvInfo.lastVoiceHeroId = nil
    self._lastCvInfo.lastVoiceTIme = CS.UnityEngine.Time.time
  end
  return self._lastCvInfo
end

function CacheSaveData:SetIsEndBattleForHeroInteration(value)
  self._isEndBattleForHeroInteration = value
end

function CacheSaveData:GetIsEndBattleForHeroInteration()
  return self._isEndBattleForHeroInteration
end

function CacheSaveData:SetLastChangeWeatherTimeStamp(value)
  self._lastChangeWeatherTimeStamp = value
end

function CacheSaveData:GetLastChangeWeatherTimeStamp()
  if self._lastChangeWeatherTimeStamp == nil then
    return 0
  end
  return self._lastChangeWeatherTimeStamp
end

function CacheSaveData:SetLastWeatherIndex(index)
  self._lastWeatherIndex = index
end

function CacheSaveData:GetLastWeatherIndex()
  return self._lastWeatherIndex
end

function CacheSaveData:IsHasPlayedL2dLoginAnim()
  return self.isHasPlayedL2dLoginAnim == true
end

function CacheSaveData:SetHasPlayedL2dLoginAnim(value)
  self.isHasPlayedL2dLoginAnim = value
end

function CacheSaveData:SetFairySortType(sortType, isDesc)
  self.fairySortType = sortType
  self.isDesc = isDesc
end

function CacheSaveData:GetFairySortType()
  if self.fairySortType then
    return self.fairySortType, self.isDesc
  end
  return 2, true
end

function CacheSaveData:SetEnableUseFlipCardItemConfirm(enable)
  self.enableUseFlipCardItemConfirm = enable
end

function CacheSaveData:GetEnableUseFlipCardItemConfirm()
  if self.enableUseFlipCardItemConfirm == nil then
    self.enableUseFlipCardItemConfirm = true
  end
  return self.enableUseFlipCardItemConfirm
end

function CacheSaveData:IsEpSvFmtSelectChipTip()
  return self._EpSvFmtSelectChipTip
end

function CacheSaveData:SetEpSvFmtSelectChipTip(flag)
  self._EpSvFmtSelectChipTip = flag
end

return CacheSaveData
