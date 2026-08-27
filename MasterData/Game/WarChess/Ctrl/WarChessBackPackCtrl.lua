local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessBackPackCtrl = class("WarChessBackPackCtrl", base)
local WarChessBuffData = require("Game.WarChess.Data.WarChessBuffData")

function WarChessBackPackCtrl:ctor(wcCtrl)
  self.__backpackDic = {}
  self.__backpackLimitAddNumDic = {}
  self.__BuffDataDic = {}
  self.__numericDic = {}
  self.__isHaveRewardBag = false
  self.__pickableItemList = {}
end

function WarChessBackPackCtrl:SetWCBakcPack(warChessUser, seasonItemNum, isHaveRewardBag, strengthWinReward)
  self.__backpackDic = {}
  self.__BuffDataDic = {}
  for itemId, itemNum in pairs(warChessUser.items) do
    self.__backpackDic[itemId] = itemNum + (self.__backpackDic[itemId] or 0)
  end
  for _, buffMsg in pairs(warChessUser.warChessBuffs) do
    local buffUID = buffMsg.uid
    local buffData = WarChessBuffData.CrearteBuffByMsg(buffMsg)
    self.__BuffDataDic[buffUID] = buffData
  end
  self.__backpackLimitAddNumDic = seasonItemNum
  self.__numericDic = warChessUser.numeric
  for itemId, itemMaxNum in pairs(warChessUser.triggerItemLimit) do
    self.__backpackLimitAddNumDic[itemId] = itemMaxNum
  end
  self.__isHaveRewardBag = isHaveRewardBag
  self.__isNeedUpdateList = true
  self.__pickableItemList = {}
  self:__DealRewardBagRewardList(strengthWinReward)
end

function WarChessBackPackCtrl:UpdateBackPack(roleItemDiff)
  for itemId, num in pairs(roleItemDiff.update) do
    local addNum = 0
    if num == 0 then
      self.__backpackDic[itemId] = nil
    else
      addNum = num - (self.__backpackDic[itemId] or 0)
      self.__backpackDic[itemId] = num
    end
    MsgCenter:Broadcast(eMsgEventId.WC_ItemNumChange, itemId, num, addNum)
    if ConstWCShowCoin[itemId] ~= nil then
      MsgCenter:Broadcast(eMsgEventId.WC_CoinNumChange, itemId, num, addNum)
      if 0 < addNum and itemId == ConstGlobalItem.WCDeployPoint then
        UIManager:ShowWindowAsync(UIWindowTypeID.WarChessNotice, function(window)
          if window ~= nil then
            window:OnWCGetDeployPoint(itemId, addNum)
          end
        end)
      end
    end
  end
  for itemId, limitNum in pairs(roleItemDiff.updateLimit) do
    self.__backpackLimitAddNumDic[itemId] = limitNum
    MsgCenter:Broadcast(eMsgEventId.WC_ItemLimitNumChange, itemId, limitNum)
  end
  local isBuffUpdated = false
  for key, buffMsg in pairs(roleItemDiff.warChessBuffsUpdate) do
    local buffUID = buffMsg.uid
    local buffData = self.__BuffDataDic[buffUID]
    if buffData == nil then
      local buffData = WarChessBuffData.CrearteBuffByMsg(buffMsg)
      self.__BuffDataDic[buffUID] = buffData
    else
      buffData:UpdateWCBuff(buffMsg)
    end
    isBuffUpdated = true
  end
  for uid, _ in pairs(roleItemDiff.buffDelete) do
    local buffUID = uid
    local buffData = self.__BuffDataDic[buffUID]
    if buffData ~= nil then
      self.__BuffDataDic[buffUID] = nil
    end
    isBuffUpdated = true
  end
  if isBuffUpdated then
    MsgCenter:Broadcast(eMsgEventId.WC_BuffChange)
  end
  for type, value in pairs(roleItemDiff.numericUpdate) do
    if value == 0 then
      self.__numericDic[type] = nil
    else
      self.__numericDic[type] = value
    end
    if type == proto_object_WarChessNumeric.WarChessNumericModifyBehaviorPointLimit then
      MsgCenter:Broadcast(eMsgEventId.WC_APLimitChange)
    end
  end
  self:__DealRewardBagRewardList(roleItemDiff.updateStrength)
  self.wcCtrl.palySquCtrl:WhenBackPackUpdate()
end

function WarChessBackPackCtrl:__DealRewardBagRewardList(list)
  if list == nil then
    return
  end
  if table.count(list) > 0 then
    self.wcCtrl.palySquCtrl:SetIsHaveNewRewradBagReward(true)
    for _, StmGoodElem in pairs(list) do
      table.insert(self.__pickableItemList, StmGoodElem)
    end
  end
end

function WarChessBackPackCtrl:GetWCCoinNum()
  return self:GetWCItemNum(ConstGlobalItem.WCMoney)
end

function WarChessBackPackCtrl:AddCacheMoneyCount(goldCount)
  if self.cacheMoney == nil then
    self.cacheMoney = 0
  end
  self.cacheMoney = self.cacheMoney + goldCount
end

function WarChessBackPackCtrl:SetCacheMoneyCount(goldCount)
  self.cacheMoney = goldCount
end

function WarChessBackPackCtrl:GetCacheMoneyCount()
  return self.cacheMoney or 0
end

function WarChessBackPackCtrl:GetWCItemNum(itemId)
  return self.__backpackDic[itemId] or 0
end

function WarChessBackPackCtrl:GetWCItemCapacity(itemId)
  return self.__backpackLimitAddNumDic[itemId] or 0
end

function WarChessBackPackCtrl:GetWCDeployPointNum()
  return self:GetWCItemNum(ConstGlobalItem.WCDeployPoint)
end

function WarChessBackPackCtrl:GetWCBuffDic()
  return self.__BuffDataDic
end

function WarChessBackPackCtrl:GetWCUserNumericNum(type)
  return self.__numericDic[type] or 0
end

function WarChessBackPackCtrl:GetIsWCHaveRewardBag()
  return self.__isHaveRewardBag
end

function WarChessBackPackCtrl:GetIsWCRewardBagItemList()
  return self.__pickableItemList
end

function WarChessBackPackCtrl:Delete()
end

return WarChessBackPackCtrl
