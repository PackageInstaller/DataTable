local AthAreaGridData = class("AthAreaGridData")
local eAthGridState = require("Game.Arithmetic.Enum.eAthGridState")
local AthUtil = require("Game.Arithmetic.AthUtil")
local CS_MessageCommon = CS.MessageCommon

function AthAreaGridData:ctor(areaId)
  self.areaId = areaId
end

function AthAreaGridData:InitAthAreaGridData(heroData, space, maxSpace, withoutInstall)
  self.heroData = heroData
  local gridUnlockList = ConfigData.game_config.athGridUnlockList
  if space > #gridUnlockList then
    error(string.format("Ath grid count(%s) error, space = (%s)", #gridUnlockList, space))
    return
  end
  self.gridDataList = {}
  self.gridStateList = {}
  self.athInstalledDic = {}
  for k, gridId in ipairs(gridUnlockList) do
    if space >= k then
      self.gridStateList[gridId] = eAthGridState.Unlock
    elseif maxSpace >= k then
      self.gridStateList[gridId] = eAthGridState.Lock
    else
      self.gridStateList[gridId] = eAthGridState.Disable
    end
  end
  if not withoutInstall then
    local athDataList, athDic = PlayerDataCenter.allAthData:GetHeroAthList(heroData.dataId, self.areaId)
    for k, athData in ipairs(athDataList) do
      self:InstallAthGridData(athData)
    end
  end
end

function AthAreaGridData:InstallAthGridData(athData, gridPos)
  if gridPos == nil then
    if athData.bindInfo == nil then
      error(string.format("athData.bindInfo == nil, athData.uid = %s, heroId = %s", athData.uid, self.heroData.dataId))
      return
    end
    gridPos = athData.bindInfo.grid
  end
  local installable, gridIdList = self:CheckAthInstallable(athData, gridPos)
  if not installable then
    return
  end
  local uid = athData.uid
  self.athInstalledDic[uid] = athData
  for k, gridId in ipairs(gridIdList) do
    self.gridDataList[gridId] = uid
  end
end

function AthAreaGridData:UninstallAthGridData(athData, gridPos)
  local gridIdList = AthUtil.GetAthGridIdList(athData, gridPos)
  self.athInstalledDic[athData.uid] = nil
  for k, gridId in ipairs(gridIdList) do
    self.gridDataList[gridId] = nil
  end
end

function AthAreaGridData:CheckAthInstallable(athData, gridPos, containUid)
  local gridIdList = AthUtil.GetAthGridIdList(athData, gridPos)
  for k, gridId in ipairs(gridIdList) do
    if not AthUtil.AthUseGridDic[gridId] or gridId < 1 then
      return
    end
    if self.gridStateList[gridId] == eAthGridState.Lock then
      return
    end
    if self.gridStateList[gridId] == eAthGridState.Disable then
      return
    end
    if self.gridDataList[gridId] ~= nil then
      if containUid ~= nil then
        if self.gridDataList[gridId] ~= containUid then
          return
        end
      else
        return
      end
    end
  end
  return true, gridIdList
end

function AthAreaGridData:GetAthInstallableGrid(athData)
  for k, gridId in ipairs(AthUtil.AthUseGridList) do
    local uid = self.gridDataList[gridId]
    local gridState = self.gridStateList[gridId]
    if uid == nil and gridState == eAthGridState.Unlock and self:CheckAthInstallable(athData, gridId) then
      return gridId
    end
  end
  return nil
end

function AthAreaGridData:CheckAthAreaSpaceOk(athData)
  local athSpace = athData:GetAthSize()
  local ok, freeSpace = PlayerDataCenter.allAthData:GetHeroAthFreeSpace(self.heroData, self.areaId)
  return ok and athSpace <= freeSpace
end

function AthAreaGridData:AutoSortAthTable(athDataList)
  table.sort(athDataList, function(a, b)
    local sizeA = a:GetAthSize()
    local sizeB = b:GetAthSize()
    if sizeA == sizeB then
      return a.id < b.id
    else
      return sizeA > sizeB
    end
  end)
  local gridDataListBack = self.gridDataList
  local athInstalledDicBack = self.athInstalledDic
  self.gridDataList = {}
  self.athInstalledDic = {}
  local athInstallDic = {}
  local athInstalledDic = {}
  for k, data in pairs(athInstalledDicBack) do
    athInstalledDic[data.uid] = data.bindInfo.grid
  end
  local hasError = false
  for k, athData in ipairs(athDataList) do
    local installOk = false
    for k, gridId in ipairs(AthUtil.AthUseGridList) do
      local installable, gridIdList = self:CheckAthInstallable(athData, gridId)
      if installable then
        self:InstallAthGridData(athData, gridId)
        athInstallDic[athData.uid] = gridId
        installOk = true
        break
      end
    end
    if not installOk then
      error("AutoSortAthTable error, athDataId = " .. athData.id)
      hasError = true
      break
    end
  end
  self.gridDataList = gridDataListBack
  self.athInstalledDic = athInstalledDicBack
  if hasError then
    return
  else
    return athInstallDic, athInstalledDic
  end
end

function AthAreaGridData:ReSortAthTable(newAthData)
  if newAthData ~= nil and not self:CheckAthAreaSpaceOk(newAthData) then
    return
  end
  local athDataList = PlayerDataCenter.allAthData:GetHeroAthList(self.heroData.dataId, self.areaId)
  if newAthData ~= nil then
    table.insert(athDataList, newAthData)
  end
  return self:AutoSortAthTable(athDataList)
end

function AthAreaGridData:GetTryReplaceAthDic(newAthData, replacedAthData)
  local athDataList = PlayerDataCenter.allAthData:GetHeroAthList(self.heroData.dataId, self.areaId)
  local athInstalledDic = {}
  for k, data in pairs(self.athInstalledDic) do
    athInstalledDic[data.uid] = data.bindInfo.grid
  end
  table.removebyvalue(athDataList, replacedAthData)
  local sizeNew = newAthData:GetAthSize()
  local sizeOld = replacedAthData:GetAthSize()
  local athInstallDic
  if sizeNew > sizeOld then
    table.insert(athDataList, newAthData)
    athInstallDic = self:AutoSortAthTable(athDataList)
    if athInstallDic == nil then
      return
    end
  else
    athInstallDic = {}
    for k, athData in ipairs(athDataList) do
      athInstallDic[athData.uid] = athData.bindInfo.grid
    end
    athInstallDic[newAthData.uid] = replacedAthData.bindInfo.grid
  end
  return athInstallDic, athInstalledDic
end

function AthAreaGridData:CheckAthReplaceable(athData, gridPos, withTips)
  if PlayerDataCenter.allAthData:HeroContainAthByUid(self.heroData.dataId, athData.uid) then
    return
  end
  local installedUid = self.gridDataList[gridPos]
  if installedUid == nil then
    return
  end
  local tarAthData = self.athInstalledDic[installedUid]
  local tarSize = tarAthData:GetAthSize()
  local curSize = athData:GetAthSize()
  local spaceOk = false
  local ok, freeSpace = PlayerDataCenter.allAthData:GetHeroAthFreeSpace(self.heroData, self.areaId)
  if freeSpace >= curSize - tarSize then
    spaceOk = true
  elseif withTips then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_NotOneReplaceOne))
  end
  local oneReplaceMore = false
  local bigSpaceReplaceSmall = tarSize < curSize
  if spaceOk and bigSpaceReplaceSmall and not self:CheckAthInstallable(athData, gridPos, installedUid) then
    tarAthData = nil
    oneReplaceMore = true
    if withTips then
      CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Ath_NotOneReplaceOne))
    end
  end
  if spaceOk then
    return tarAthData, oneReplaceMore
  else
    return
  end
end

return AthAreaGridData
