local SHOW_MAX_NUM = 6
local AlchemyExchangeExtModel = NewClass("AlchemyExchangeExtModel", BaseModel)

function AlchemyExchangeExtModel:OnInit()
  self.selectTid = 0
  self.selectUid = 0
  self.selectCostUid = 0
  self.selectCostTid = 0
  self.oldSelectTid = 0
  self.exchangeItemList = {}
  self.curSelectCostItemGroup = {}
  self.realCostItemGroup = {}
  self.remainCostItemGroup = {}
  self.curCanCostItemGroup = {}
  self.maxSelectTypeNum = SHOW_MAX_NUM
end

function AlchemyExchangeExtModel:UpdateData()
  self:Update_exchangeItemList()
  self:ClearExchangePlan()
end

function AlchemyExchangeExtModel:Update_curCanCostItemGroup(isSetting)
  local rst = {}
  if isSetting then
    self.selectTid = 0
  end
  local exchangeData = self:GetCurSelectExchangeData()
  for _, cfg in pairs(DT.Item) do
    if cfg.Type == exchangeData.costItemMainType and (cfg.SubType == exchangeData.costItemSubType or isSetting and cfg.SubType == CommonDefine.ItemSubType.TrinketRefineLock) and cfg.ID ~= self:Get_selectTid() then
      if cfg.StartDropDate then
        if cfg.StartDropDate <= TimeUtils.GetServerTime() then
          table.insert(rst, cfg.ID)
        end
      else
        table.insert(rst, cfg.ID)
      end
    end
  end
  table.sort(rst, function(a, b)
    if DT.Item[a].SubType == CommonDefine.ItemSubType.TrinketRefineLock then
      return true
    elseif DT.Item[b].SubType == CommonDefine.ItemSubType.TrinketRefineLock then
      return false
    end
    local aCnt = ItemDataUtils.GetBagItemNum(a)
    local bCnt = ItemDataUtils.GetBagItemNum(b)
    if aCnt > bCnt then
      return true
    elseif aCnt < bCnt then
      return false
    else
      return DT.Item[a].BaseSortID < DT.Item[b].BaseSortID
    end
  end)
  self.curCanCostItemGroup = rst
end

function AlchemyExchangeExtModel:Update_exchangeItemList()
  local curTime = math.floor(TimeUtils.GetServerTime())
  local exchangeItemGroup = {}
  for tid, cfg in pairs(DT.ItemConversion) do
    if cfg.ConversionType == AlchemyDefine.AlchemyType.Exchange then
      local canShow = cfg.ConversionDisplayDate and curTime >= cfg.ConversionDisplayDate
      canShow = nil == canShow and true or canShow
      if canShow then
        local exchangeData = {
          conversionId = cfg.ID,
          convertItemTid = cfg.ItemsGet[1],
          convertItemNum = cfg.ItemsGet[2],
          costItemMainType = cfg.ConsumeItem[1],
          costItemSubType = cfg.ConsumeItem[2],
          costItemNum = cfg.ConsumeItem[3]
        }
        table.insert(exchangeItemGroup, exchangeData)
      end
    end
  end
  table.sort(exchangeItemGroup, function(a, b)
    local aCanExchange = self:CheckCanExchangeItem(a)
    local bCanExchange = self:CheckCanExchangeItem(b)
    if true == aCanExchange and false == bCanExchange then
      return true
    elseif false == aCanExchange and true == bCanExchange then
      return false
    end
    local aCfg = DT.ItemConversion[a.conversionId]
    local bCfg = DT.ItemConversion[b.conversionId]
    return aCfg.Sort < bCfg.Sort
  end)
  self:Set_exchangeItemList(exchangeItemGroup)
end

function AlchemyExchangeExtModel:Set_selectCostTid(tid)
  self.selectCostTid = tid
  local itemData = ItemDataUtils.GetItemByTid(tid)
  self:Set_selectCostUid(itemData and itemData.uid or 0)
end

function AlchemyExchangeExtModel:Get_selectCostTid()
  return self.selectCostTid
end

function AlchemyExchangeExtModel:Set_selectCostUid(uid)
  self.selectCostUid = uid
end

function AlchemyExchangeExtModel:Get_selectCostUid()
  return self.selectCostUid
end

function AlchemyExchangeExtModel:Set_selectTid(tid)
  if not tid or type(tid) ~= "number" then
    return
  end
  self.oldSelectTid = self.selectTid
  self.selectTid = tid
  self:LocalNotify(NotifyId.OnAlchemyExchangeSelectChanged)
end

function AlchemyExchangeExtModel:Get_selectTid()
  return self.selectTid
end

function AlchemyExchangeExtModel:Set_selectUid(uid)
  if not uid or type(uid) ~= "number" then
    return
  end
  self.selectUid = uid
end

function AlchemyExchangeExtModel:Get_selectUid()
  return self.selectUid
end

function AlchemyExchangeExtModel:Set_exchangeItemList(group)
  if not group then
    return
  end
  self.exchangeItemList = group
end

function AlchemyExchangeExtModel:Get_ExchangeItemList()
  return self.exchangeItemList
end

function AlchemyExchangeExtModel:CheckCanExchangeItem(exchangeData)
  local rst = false
  local haveNum = 0
  for _, item in pairs(DataCenter.itemData.BagItemData) do
    local tid = item.tid
    if DT.Item[tid].Type == exchangeData.costItemMainType and DT.Item[tid].SubType == exchangeData.costItemSubType and tid ~= exchangeData.convertItemTid then
      haveNum = haveNum + item.num
    end
  end
  if haveNum >= exchangeData.costItemNum then
    rst = true
  end
  return rst
end

function AlchemyExchangeExtModel:GetExchangeItemByItemTid(tid)
  if not tid then
    return
  end
  for _, exchangeItem in pairs(self.exchangeItemList) do
    if exchangeItem.convertItemTid == tid then
      return exchangeItem
    end
  end
  return nil
end

function AlchemyExchangeExtModel:GetCurSelectCostItemByTid(tid)
  if not tid then
    return
  end
  for _, costItem in pairs(self.curSelectCostItemGroup) do
    if costItem.tid == tid then
      return costItem
    end
  end
  return nil
end

function AlchemyExchangeExtModel:UpdateCurSelectCostItemGroup(tid, num)
  if not tid or not num then
    return
  end
  for key, itemData in pairs(self.curSelectCostItemGroup) do
    if itemData.tid == tid then
      itemData.num = num
      self.curSelectCostItemGroup[key] = itemData
      break
    end
  end
  self:LocalNotify(NotifyId.OnAlchemyExchangeCostGroupChanged)
end

function AlchemyExchangeExtModel:RemoveCurSelectCostItemGroup(tid)
  for key, itemData in pairs(self.curSelectCostItemGroup) do
    if itemData.tid == tid then
      table.remove(self.curSelectCostItemGroup, key)
      self:LocalNotify(NotifyId.OnAlchemyExchangeCostGroupChanged)
      break
    end
  end
end

function AlchemyExchangeExtModel:SetCurSelectCostItemGroup(group)
  if not group then
    return
  end
  if not table.next(self.curSelectCostItemGroup) and not table.next(group) then
    return
  end
  self.curSelectCostItemGroup = group
  self:LocalNotify(NotifyId.OnAlchemyExchangeCostGroupChanged)
end

function AlchemyExchangeExtModel:GetCurSelectNum()
  local rst = 0
  for _, itemData in pairs(self.curSelectCostItemGroup) do
    rst = itemData.num + rst
  end
  return rst
end

function AlchemyExchangeExtModel:GetCurSelectExchangeData()
  if 0 == self.selectTid then
    self.selectTid = ItemAlchemyUtils.TrinketMaterial
  end
  return self:GetExchangeItemByItemTid(self.selectTid) or {}
end

function AlchemyExchangeExtModel:GetCurExchangeItemNum()
  local selectNum = self:GetCurSelectNum()
  local curSelectExchangeData = self:GetCurSelectExchangeData()
  local costPerNum = curSelectExchangeData and curSelectExchangeData.costItemNum or 1
  return selectNum // costPerNum * (curSelectExchangeData.convertItemNum or 1)
end

function AlchemyExchangeExtModel:CheckItemExchangeEnough(exchangeData)
  if not exchangeData then
    return false
  end
  do return self.CheckCanExchangeItem, self end
  return self.CheckCanExchangeItem, self, exchangeData
end

function AlchemyExchangeExtModel:ParseCostItemGroup()
  local realCostItemGroup = table.deepclone(self.curSelectCostItemGroup)
  local remainCostItemGroup = {}
  local curSelectExchangeData = self:GetCurSelectExchangeData()
  local exchangePerCost = curSelectExchangeData.costItemNum
  local curSelectNum = self:GetCurSelectNum()
  local remainItemNum = curSelectNum % exchangePerCost
  for i = #realCostItemGroup, 1, -1 do
    local costItem = realCostItemGroup[i]
    if remainItemNum >= costItem.num then
      table.remove(realCostItemGroup, i)
      if 0 ~= remainItemNum then
        table.insert(remainCostItemGroup, 1, costItem)
      end
      remainItemNum = remainItemNum - costItem.num
    else
      costItem.num = costItem.num - remainItemNum
      realCostItemGroup[i] = costItem
      if 0 ~= remainItemNum then
        table.insert(remainCostItemGroup, 1, {
          tid = costItem.tid,
          num = remainItemNum
        })
      end
      break
    end
  end
  self:SetRealCostItemGroup(realCostItemGroup)
  self:SetRemainCostItemGroup(remainCostItemGroup)
end

function AlchemyExchangeExtModel:AddCurSelectCostItemGroup(itemData)
  if not itemData then
    return
  end
  table.insert(self.curSelectCostItemGroup, itemData)
  self:LocalNotify(NotifyId.OnAlchemyExchangeCostGroupChanged)
end

function AlchemyExchangeExtModel:SetRealCostItemGroup(group)
  if not group then
    return
  end
  self.realCostItemGroup = group
end

function AlchemyExchangeExtModel:SetRemainCostItemGroup(group)
  if not group then
    return
  end
  self.remainCostItemGroup = group
end

function AlchemyExchangeExtModel:GetExchangePlan(tid)
  if not self.exchangePlan then
    self.exchangePlan = {}
  end
  if not tid then
    return self.exchangePlan
  elseif self.exchangePlan then
    return self.exchangePlan[tid]
  end
  return nil
end

function AlchemyExchangeExtModel:AddExchangePlan(tid)
  if not self.exchangePlan then
    self.exchangePlan = {}
  end
  if not self.exchangePlan[tid] then
    self.exchangePlan[tid] = true
  end
  self:LocalNotify(NotifyId.OnAlchemyExchangeCostGroupChanged)
end

function AlchemyExchangeExtModel:DeleteExchangePlan(tid)
  if not self.exchangePlan then
    self.exchangePlan = {}
  end
  if self.exchangePlan[tid] then
    self.exchangePlan[tid] = nil
  end
  self:LocalNotify(NotifyId.OnAlchemyExchangeCostGroupChanged)
end

function AlchemyExchangeExtModel:ClearExchangePlan()
  AlchemyDataUtils.ReqGetExchangePlan()
  self.exchangePlan = self.exchangePlan or {}
  self:LocalNotify(NotifyId.OnAlchemyExchangeCostGroupChanged)
  return self.exchangePlan
end

function AlchemyExchangeExtModel:UpdateExchangePlan(exchangePlan)
  self.exchangePlan = exchangePlan or {}
end

return AlchemyExchangeExtModel
