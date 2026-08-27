local LotteryPoolGroupData = class("LotteryPoolGroupData")

function LotteryPoolGroupData:ctor(ltrPoolData, ltrGroupId)
  self.ltrPoolData = ltrPoolData
  self.ltrGroupCfg = ConfigData.lottery_group[ltrGroupId]
end

function LotteryPoolGroupData:HasLtrMoreGroup()
  return self.ltrGroupCfg ~= nil
end

function LotteryPoolGroupData:GetLtrMoreGroupId()
  if self.ltrGroupCfg == nil then
    return
  end
  return self.ltrGroupCfg.lottery_group
end

function LotteryPoolGroupData:CanJumpByExternal()
  if not self:HasLtrMoreGroup() then
    return self.ltrPoolData:LtrCanJumpByExternal(), self.ltrPoolData.poolId
  end
  return false, 0
end

function LotteryPoolGroupData:ContainLtrGroupPool(ltrId)
  if self.ltrPoolData.poolId == ltrId then
    return true
  end
  if ltrId == nil then
    return
  end
  if self:HasLtrMoreGroup() then
    return ConfigData.lottery_group.ltrGroupIdMap[ltrId] == self.ltrGroupCfg.lottery_group and PlayerDataCenter.allLtrData:GetIsSpecificPoolOpen(ltrId)
  end
  return false
end

function LotteryPoolGroupData:GetLtrInGroupDataList()
  if not self:HasLtrMoreGroup() then
    return table.emptytable
  end
  if self._ltrDataList ~= nil then
    return self._ltrDataList
  end
  local dataList = {}
  for k, ltrId in ipairs(self.ltrGroupCfg.list) do
    if PlayerDataCenter.allLtrData:GetIsSpecificPoolOpen(ltrId) then
      local ltrData = PlayerDataCenter.allLtrData.ltrDataDic[ltrId]
      table.insert(dataList, ltrData)
    end
  end
  self._ltrDataList = dataList
  return dataList
end

function LotteryPoolGroupData:TryGetLastLtrPoolData()
  if not self:HasLtrMoreGroup() then
    return
  end
  local groupId = self:GetLtrMoreGroupId()
  local lastLtrId = 0
  lastLtrId = PlayerDataCenter.allLtrData:GetIsSelectByGroupId(groupId)
  if lastLtrId == 0 then
    lastLtrId = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetLtrGroupSelectedLtrId(groupId)
  end
  if self:ContainLtrGroupPool(lastLtrId) then
    return PlayerDataCenter.allLtrData.ltrDataDic[lastLtrId]
  else
    return nil
  end
  return
end

function LotteryPoolGroupData:HasLtrGroupHeroConvertFrag()
  if not self:HasLtrMoreGroup() then
    return self.ltrPoolData:IsLtrHeroConvertFrag()
  end
  local dataList = self:GetLtrInGroupDataList()
  for k, ltrData in ipairs(dataList) do
    if ltrData:IsLtrHeroConvertFrag() then
      return true
    end
  end
  return false
end

return LotteryPoolGroupData
