local DynRewardBag = class("DynRewardBag")

function DynRewardBag:InitEpDynRewardBag(epStmGoods)
  self.rewardBagDataList = {}
  if epStmGoods ~= nil then
    for k, elem in ipairs(epStmGoods.stmStore) do
      table.insert(self.rewardBagDataList, elem)
    end
  end
end

function DynRewardBag:UpdateEpDynRewardBag(epStmGoodsList)
  for k, elem in ipairs(epStmGoodsList) do
    table.insert(self.rewardBagDataList, elem)
  end
  self.lastRewardDataList = epStmGoodsList
end

function DynRewardBag:GetEpRewardBagDataList()
  return self.rewardBagDataList
end

function DynRewardBag:GetEpRewardBagDataDic()
  local rewardDic = {}
  for k, v in ipairs(self.rewardBagDataList) do
    if rewardDic[v.itemId] == nil then
      rewardDic[v.itemId] = v.num
    else
      rewardDic[v.itemId] = rewardDic[v.itemId] + v.num
    end
  end
  return rewardDic
end

function DynRewardBag:HasEpRewardBagData()
  return #self.rewardBagDataList > 0
end

function DynRewardBag:TryGetLastEpRewardBagDataList()
  local lastRewardDataList = self.lastRewardDataList
  self.lastRewardDataList = nil
  return lastRewardDataList
end

return DynRewardBag
