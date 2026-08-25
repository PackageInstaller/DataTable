local BpExchangeLevelModel = NewClass("BpExchangeLevelModel", BaseModel)

function BpExchangeLevelModel:OnInit()
  local dataBPBuyLevelPrice = DT.Constant.BPBuyLevelPrice
  self.costItemTid = dataBPBuyLevelPrice.Data[1]
  self.exchangeNumPerGold = dataBPBuyLevelPrice.Data[2]
  self.maxBuyNum = BattlePassDataUtils.GetMaxBpLevel() - BattlePassDataUtils.GetLevel()
  self.minBuyNum = 1
  self.curBuyNum = self.minBuyNum
  self.curCostCurrencyNum = self.curBuyNum * self.exchangeNumPerGold
  self.changeNumPerClick = 1
  self.showRewardList = {}
end

function BpExchangeLevelModel:OnReset()
  self.showRewardList = self:GetShowRewardList()
end

function BpExchangeLevelModel:UpdateBuyNum(numVal)
  numVal = math.max(numVal, self.minBuyNum)
  numVal = math.min(numVal, self.maxBuyNum)
  self.curBuyNum = numVal
  self.curCostCurrencyNum = self.exchangeNumPerGold * numVal
  self:LocalNotify(NotifyId.OnBpExchangeLevelChangeBuyNum)
end

function BpExchangeLevelModel:GetShowRewardList()
  local rst = {}
  local tmp = {}
  local bpLevel = BattlePassDataUtils.GetLevel()
  local privilegeLevel = BattlePassDataUtils.GetPrivilegeLevel()
  for _, data in pairs(BattlePassDataUtils.GetRewardList()) do
    if not data.haveReceive and bpLevel + self.curBuyNum >= data.unlockLevel and bpLevel < data.unlockLevel and privilegeLevel >= data.bpRewardType then
      if not tmp[data.tid] then
        tmp[data.tid] = {
          tid = data.tid,
          num = data.num
        }
      else
        tmp[data.tid].num = tmp[data.tid].num + data.num
      end
    end
  end
  for _, data in pairs(tmp) do
    table.insert(rst, data)
  end
  table.sort(rst, function(a, b)
    local aSort = DT.Item[a.tid].BaseSortID
    local bSort = DT.Item[b.tid].BaseSortID
    return aSort < bSort
  end)
  return rst
end

return BpExchangeLevelModel
