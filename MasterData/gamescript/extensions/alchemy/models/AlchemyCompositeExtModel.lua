local ConversionRedPoint = DT.GetOriginalConstant("ConversionRedPoint") or {}
local QualitySortID = CommonDefine.QualitySortID
local AlchemyCompositeExtModel = NewClass("AlchemyCompositeExtModel", BaseModel)

function AlchemyCompositeExtModel:OnInit()
  self.curSelectTid = 0
  self.curCompositeNum = 1
  self.curConsumeList = {}
  self.compositeItemList = {}
  self.maxCompositeNum = 0
  self.minCompositeNum = 1
  self.curCompositeCurrencyTid = 0
  self.curCompositeCurrencyCostNum = 0
  self.remainCompositeTimeDict = {}
  self.refreshTimeDict = {}
  self:UpdateData()
end

function AlchemyCompositeExtModel:UpdateCompositeRemainCountInfo(svrData)
  for _, data in pairs(svrData) do
    self.remainCompositeTimeDict[data.formulaTid] = data.remainCount
    self.refreshTimeDict[data.formulaTid] = ItemConversionCfgUtils.GetConvertionRefreshTime(data.formulaTid)
  end
  EventMgr.Instance.OnRemainCompositeTimeChanged:Dispatch()
end

function AlchemyCompositeExtModel:Set_curCompositeNum(numVal)
  self.curCompositeNum = numVal
  self:Update_curConsumeList()
  self:Update_curCompositeCurrencyCostNum()
  self:LocalNotify(NotifyId.OnAlchemyCompositeNumChanged, numVal)
end

function AlchemyCompositeExtModel:Get_curCompositeNum()
  return self.curCompositeNum
end

function AlchemyCompositeExtModel:Set_curSelectTid(numVal)
  self.curSelectTid = numVal
  self:UpdateDataWhenTidChanged()
  self:LocalNotify(NotifyId.OnAlchemyCompositeSelectChanged, numVal)
end

function AlchemyCompositeExtModel:Get_curSelectTid()
  return self.curSelectTid
end

function AlchemyCompositeExtModel:UpdateData()
  self:Update_compositeItemList()
  self:Update_curCompositeCurrencyTid()
  self:Update_curCompositeCurrencyCostNum()
  self:Update_maxCompositeNum()
end

function AlchemyCompositeExtModel:UpdateDataWhenTidChanged()
  self:Update_curConsumeList()
  self:Update_curCompositeCurrencyTid()
  self:Update_curCompositeCurrencyCostNum()
  self:Update_maxCompositeNum()
end

function AlchemyCompositeExtModel:Update_maxCompositeNum()
  local tid = self.curSelectTid
  local conversionId = self:GetCurCompositeConvertionId()
  local compositeNum = self:GetEffectiveMaxComposeCount(tid, conversionId)
  self.maxCompositeNum = compositeNum > AlchemyDefine.AlchemySliderLimit and AlchemyDefine.AlchemySliderLimit or compositeNum
end

function AlchemyCompositeExtModel:IsForceDirectComposeByConversionId(conversionId)
  return self:GetRemainCompositeTime(conversionId) ~= nil
end

function AlchemyCompositeExtModel:GetEffectiveMaxComposeCount(itemTid, conversionId, compositeData)
  if self:IsForceDirectComposeByConversionId(conversionId) then
    compositeData = compositeData or self:GetCompositeDataByTid(itemTid)
    do return self.GetDirectMaxComposeCountWithData, self, compositeData end
    return self.GetDirectMaxComposeCountWithData, self, compositeData, conversionId
  end
  do return ItemAlchemyUtils.MaxComposeCount, itemTid end
  return ItemAlchemyUtils.MaxComposeCount, itemTid, conversionId, conversionId
end

function AlchemyCompositeExtModel:GetDirectMaxComposeCount(tid, conversionId)
  do return self.GetDirectMaxComposeCountWithData, self, (self:GetCompositeDataByTid(tid)) end
  return self.GetDirectMaxComposeCountWithData, self, self:GetCompositeDataByTid(tid), conversionId, tid
end

function AlchemyCompositeExtModel:GetDirectMaxComposeCountWithData(compositeData, conversionId)
  if not compositeData then
    return 0
  end
  local maxCompositeNum = math.huge
  if compositeData.convertItemTids then
    for i = 1, #compositeData.convertItemTids do
      local consumeTid = compositeData.convertItemTids[i]
      local consumeNum = compositeData.convertItemNum[i] or 0
      if consumeNum > 0 then
        local haveNum = ItemDataUtils.GetItemNum(consumeTid) or 0
        maxCompositeNum = math.min(maxCompositeNum, math.floor(haveNum / consumeNum))
      end
    end
  end
  if maxCompositeNum == math.huge then
    maxCompositeNum = 0
  end
  local remainCompositeTime = self:GetRemainCompositeTime(conversionId)
  if remainCompositeTime then
    maxCompositeNum = math.min(maxCompositeNum, remainCompositeTime)
  end
  do return math.max, 0 end
  return math.max, 0, maxCompositeNum, compositeData.convertItemTids[i], 0, 0, math.min(maxCompositeNum, math.floor(haveNum / consumeNum)), maxCompositeNum, math.floor(haveNum / consumeNum)
end

function AlchemyCompositeExtModel:Update_curCompositeCurrencyCostNum()
  local currencyCostNum = 0
  for _, data in pairs(self.curConsumeList) do
    if data.tid == DT.GetConstant("GoldItemTid") then
      currencyCostNum = data.num
      break
    end
  end
  self.curCompositeCurrencyCostNum = currencyCostNum
end

function AlchemyCompositeExtModel:Update_curCompositeCurrencyTid()
  local currencyTid
  local compositeItemData = table.deepclone(self:GetCompositeDataByTid(self:Get_curSelectTid()))
  if compositeItemData and compositeItemData.convertItemTids then
    for _, tid in pairs(compositeItemData.convertItemTids) do
      if DT.Item[tid].Type == CommonDefine.ItemType.TopBarItem then
        currencyTid = tid
        break
      end
    end
  end
  self.curCompositeCurrencyTid = currencyTid
end

function AlchemyCompositeExtModel:_BuildDirectConsumeList(compositeItemData, compositeNum)
  local rst = {}
  if compositeItemData and compositeItemData.convertItemTids then
    for i = 1, #compositeItemData.convertItemTids do
      local tid = compositeItemData.convertItemTids[i]
      local num = (compositeItemData.convertItemNum[i] or 0) * compositeNum
      table.insert(rst, {tid = tid, num = num})
    end
  end
  return rst
end

function AlchemyCompositeExtModel:_BuildFormulaConsumeList(compositeItemData)
  local rst = {}
  if compositeItemData and compositeItemData.convertItemTids then
    for i = 1, #compositeItemData.convertItemTids do
      local tid = compositeItemData.convertItemTids[i]
      local num = compositeItemData.convertItemNum[i]
      local alchemyItemData = {tid = tid, num = num}
      table.insert(rst, alchemyItemData)
    end
  end
  return rst
end

function AlchemyCompositeExtModel:_IsAllMaterialZero(composeResult)
  local countNum = 1
  for _, consumeData in ipairs(composeResult) do
    local cfg = DT.Item[consumeData.id] or {}
    if cfg.Type and cfg.Type ~= CommonDefine.ItemType.TopBarItem then
      countNum = countNum * (ItemDataUtils.GetItemNum(consumeData.id) or 0)
    end
  end
  return 0 == countNum
end

function AlchemyCompositeExtModel:_CheckIsMultiComp(directConsumeMap, singleComposeMap)
  for tid, num in pairs(directConsumeMap) do
    if (singleComposeMap[tid] or 0) ~= num then
      return true
    end
  end
  for tid, num in pairs(singleComposeMap) do
    if (directConsumeMap[tid] or 0) ~= num then
      return true
    end
  end
  return false
end

function AlchemyCompositeExtModel:_ProcessSingleComposeResult(compositeItemData, composeResult)
  local curCompositeNum = math.max(1, self:Get_curCompositeNum())
  local directConsumeMap = {}
  if compositeItemData and compositeItemData.convertItemTids then
    for i = 1, #compositeItemData.convertItemTids do
      local tid = compositeItemData.convertItemTids[i]
      local num = (compositeItemData.convertItemNum[i] or 0) * curCompositeNum
      if num > 0 then
        directConsumeMap[tid] = (directConsumeMap[tid] or 0) + num
      end
    end
  end
  local singleComposeMap = {}
  for _, data in ipairs(composeResult) do
    if data.count and data.count > 0 then
      singleComposeMap[data.id] = (singleComposeMap[data.id] or 0) + data.count
    end
  end
  self.isMultiComp = self:_CheckIsMultiComp(directConsumeMap, singleComposeMap)
  if self.isMultiComp then
    local ret = {}
    for _, data in ipairs(composeResult) do
      table.insert(ret, {
        tid = data.id,
        num = data.count
      })
    end
    self.curConsumeList = ret
  else
    self.curConsumeList = self:_BuildDirectConsumeList(compositeItemData, curCompositeNum)
  end
end

function AlchemyCompositeExtModel:Update_curConsumeList()
  local compositeItemData = self:GetCompositeDataByTid(self:Get_curSelectTid())
  local conversionId = compositeItemData and compositeItemData.conversionId
  if self:IsForceDirectComposeByConversionId(conversionId) then
    local curCompositeNum = math.max(1, self:Get_curCompositeNum())
    self.isMultiComp = false
    self.curConsumeList = self:_BuildDirectConsumeList(compositeItemData, curCompositeNum)
    return
  end
  local tmp, _ = ItemAlchemyUtils.SingleCompose(self:Get_curSelectTid(), math.max(1, self:Get_curCompositeNum()), true)
  if tmp and self:_IsAllMaterialZero(tmp) then
    tmp = nil
  end
  self.isMultiComp = false
  if not tmp then
    local compositeItemDataClone = table.deepclone(self:GetCompositeDataByTid(self:Get_curSelectTid()))
    self.curConsumeList = self:_BuildFormulaConsumeList(compositeItemDataClone)
  else
    self:_ProcessSingleComposeResult(compositeItemData, tmp)
  end
end

function AlchemyCompositeExtModel:GetCurCompositeConvertionId()
  local compositeData = self:GetCompositeDataByTid(self:Get_curSelectTid())
  return compositeData and compositeData.conversionId
end

function AlchemyCompositeExtModel:Update_compositeItemList()
  local curTime = math.floor(TimeUtils.GetServerTime())
  local rst = {}
  local itemConversionConfig = DT.ItemConversion
  for tid, cfgData in pairs(itemConversionConfig) do
    if cfgData.ConversionType == AlchemyDefine.AlchemyType.Compose then
      local canShow = cfgData.ConversionDisplayDate and curTime >= cfgData.ConversionDisplayDate
      canShow = nil == canShow and true or canShow
      if not canShow then
      else
        local remainCompositeTime = self:GetRemainCompositeTime(tid)
        local haveRefreshTime = self:GetRefreshTime(tid)
        if remainCompositeTime and 0 == remainCompositeTime and not haveRefreshTime then
        else
          local consumeItemList = cfgData.ConsumeItem
          local convertItemTids = {}
          local convertItemNum = {}
          local idx = 1
          while idx <= #consumeItemList do
            table.insert(convertItemTids, consumeItemList[idx])
            table.insert(convertItemNum, consumeItemList[idx + 1])
            idx = idx + 2
          end
          local compositeData = {
            itemTid = cfgData.ItemsGet[1],
            itemNum = cfgData.ItemsGet[2],
            convertItemTids = convertItemTids,
            convertItemNum = convertItemNum,
            conversionId = tid
          }
          table.insert(rst, compositeData)
        end
      end
    end
  end
  table.sort(rst, function(a, b)
    local aCanComposite = self:GetEffectiveMaxComposeCount(a.itemTid, a.conversionId, a) > 0
    local bCanComposite = self:GetEffectiveMaxComposeCount(b.itemTid, b.conversionId, b) > 0
    if true == aCanComposite and false == bCanComposite then
      return true
    elseif false == aCanComposite and true == bCanComposite then
      return false
    end
    local aItemTid = a.itemTid
    local bItemTid = b.itemTid
    local aQuality = DT.Item[aItemTid].Quality
    local bQuality = DT.Item[bItemTid].Quality
    if QualitySortID[aQuality] == QualitySortID[bQuality] then
      local aCfg = ItemDataUtils.GetItemConfig(aItemTid)
      local bCfg = ItemDataUtils.GetItemConfig(bItemTid)
      if not aCfg or not bCfg then
        return aItemTid < bItemTid
      end
      return aCfg.BaseSortID < bCfg.BaseSortID
    end
    return QualitySortID[aQuality] > QualitySortID[bQuality]
  end)
  self.compositeItemList = rst
end

function AlchemyCompositeExtModel:GetCompositeConversionIdList()
  local rst = {}
  for _, data in pairs(self.compositeItemList) do
    table.insert(rst, data.conversionId)
  end
  return rst
end

function AlchemyCompositeExtModel:GetCompositeDataByTid(tid)
  for _, data in pairs(self.compositeItemList) do
    if tid == data.itemTid then
      return data
    end
  end
  return nil
end

function AlchemyCompositeExtModel:GetShowConsumeList()
  local rst = {}
  for _, consumeData in ipairs(self.curConsumeList) do
    local cfg = DT.Item[consumeData.tid] or {}
    if cfg.Type and cfg.Type == CommonDefine.ItemType.TopBarItem then
    else
      table.insert(rst, consumeData)
    end
  end
  return rst
end

function AlchemyCompositeExtModel:GetConsumeDataByTid(tid)
  for _, data in pairs(self.curConsumeList) do
    if tid == data.tid then
      return data
    end
  end
  return nil
end

function AlchemyCompositeExtModel:GetRefreshTime(tid)
  return self.refreshTimeDict[tid]
end

function AlchemyCompositeExtModel:GetRemainCompositeTime(tid)
  if not tid then
    return nil
  end
  return self.remainCompositeTimeDict[tid]
end

function AlchemyCompositeExtModel:DelRemainCompositeTime(tid, num)
  if not self.remainCompositeTimeDict[tid] or type(self.remainCompositeTimeDict[tid]) ~= "number" then
    return
  end
  self.remainCompositeTimeDict[tid] = math.max(0, self.remainCompositeTimeDict[tid] - num)
end

function AlchemyCompositeExtModel:IsMaxCompositeNumNotEnough(itemTid, conversionId)
  local compositeNum = self:GetEffectiveMaxComposeCount(itemTid, conversionId)
  local maxCompositeNum = compositeNum > AlchemyDefine.AlchemySliderLimit and AlchemyDefine.AlchemySliderLimit or compositeNum
  return maxCompositeNum <= 0
end

function AlchemyCompositeExtModel:IsAnyCompositeRemainShowRed()
  local convertionIdList = {}
  for _, data in pairs(self.compositeItemList) do
    table.insert(convertionIdList, data.conversionId)
  end
  for _, data in pairs(self.compositeItemList) do
    table.insert(convertionIdList, data.conversionId)
    if self:IsCompositeRemainShowRed(data.itemTid, data.conversionId) then
      return true
    end
  end
  return false
end

function AlchemyCompositeExtModel:IsHaveRemainCompositeTime(tid)
  local remainCompositeTime = self:GetRemainCompositeTime(tid)
  if not remainCompositeTime then
    return true
  end
  return remainCompositeTime and remainCompositeTime > 0
end

function AlchemyCompositeExtModel:IsCompositeRemainShowRed(itemTid, conversionId)
  if not self:IsHaveRemainCompositeTime(conversionId) then
    return false
  end
  if self:IsMaxCompositeNumNotEnough(itemTid, conversionId) then
    return false
  end
  do return table.contains, ConversionRedPoint end
  return table.contains, ConversionRedPoint, conversionId, conversionId
end

function AlchemyCompositeExtModel:CanComposite()
  local canComPosite = true
  for _, data in pairs(self.curConsumeList) do
    local tid = data.tid
    local costNumPerItem = data.num
    local haveNum = ItemDataUtils.GetItemNum(tid)
    if costNumPerItem > haveNum then
      canComPosite = false
      break
    end
  end
  return canComPosite
end

function AlchemyCompositeExtModel:IsMultiComposite()
  return self.isMultiComp
end

return AlchemyCompositeExtModel
