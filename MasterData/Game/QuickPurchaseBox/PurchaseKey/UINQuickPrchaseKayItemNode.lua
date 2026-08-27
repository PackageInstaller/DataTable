local UINQuickPrchaseKayMoneyNode = class("UINQuickPrchaseKayMoneyNode", UIBaseNode)
local base = UIBaseNode
local UINQuickPrchaseKayItemNodeItem = require("Game.QuickPurchaseBox.PurchaseKey.UINQuickPrchaseKayItemNodeItem")
local cs_MessageCommon = CS.MessageCommon

function UINQuickPrchaseKayMoneyNode:OnInit()
  self.warehouseNetwork = NetworkManager:GetNetwork(NetworkTypeID.Warehouse)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.keyPackageList = nil
  self.selectNumDic = nil
  self.couldAddKey = 0
  self.__arrowColorOrange = self.ui.img_Arrow.color
  self.QPKItemPool = UIItemPool.New(UINQuickPrchaseKayItemNodeItem, self.ui.obj_itemNode)
  self.ui.obj_itemNode:SetActive(false)
  self._onPackageSelectNumChange = BindCallback(self, self.OnPackageSelectNumChange)
  self._refreshStamina = BindCallback(self, self._RefreshStamina)
  MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self._refreshStamina)
  UIUtil.AddButtonListener(self.ui.btn_ClearAll, self, self.OnClickCleanAll)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self._OnClickCancle)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirem)
end

function UINQuickPrchaseKayMoneyNode:SetNodeData(parent)
  self.parent = parent
end

function UINQuickPrchaseKayMoneyNode:InitQPKNode(maxNeededKeyNum, closeCallback)
  self.maxNeededKeyNum = maxNeededKeyNum
  self.closeCallback = closeCallback
  self:_RefreshStamina()
  self:RefreshQPKPackageItemList()
  self:RefreshCouldAddKey()
end

function UINQuickPrchaseKayMoneyNode:RefreshQPKPackageItemList()
  local hasItem = #self.keyPackageList ~= 0
  self.ui.main:SetActive(hasItem)
  self.ui.empty:SetActive(not hasItem)
  self.__LimitTimeItems = {}
  if not hasItem then
    self.ui.img_Arrow.color = Color.white
    return
  else
    self.ui.img_Arrow.color = self.__arrowColorOrange
  end
  self.QPKItemPool:HideAll()
  self.selectNumDic = {}
  self.couldAddKey = 0
  local limitTimeItemFirstIndex = -1
  local isSelected = false
  for index, expPacketid in ipairs(self.keyPackageList) do
    local stackNum = PlayerDataCenter:GetDynLimtTimeItemStackCount(expPacketid)
    for i = 1, stackNum do
      local item
      local limitTimeItemCfg = ConfigData.item_time_limit[expPacketid]
      local isLimitTimeItem = limitTimeItemCfg ~= nil
      if isLimitTimeItem then
        local itemCount = 0
        local itemOutTime = 0
        if limitTimeItemCfg.type == eLimitTimeItemType.Dyn then
          if limitTimeItemFirstIndex == -1 then
            limitTimeItemFirstIndex = i
          end
          local tempIndex = i - limitTimeItemFirstIndex + 1
          local stackInfo = PlayerDataCenter:GetDynLimtTimeItemStackInfo(expPacketid, tempIndex)
          if stackInfo ~= nil then
            itemOutTime = stackInfo.time
            itemCount = stackInfo.num
          end
        elseif limitTimeItemCfg.type == eLimitTimeItemType.Fixed then
          itemOutTime = limitTimeItemCfg.time
          itemCount = PlayerDataCenter:GetItemCount(expPacketid)
        end
        if itemOutTime > PlayerDataCenter.timestamp then
          item = self.QPKItemPool:GetOne()
          item:InitQPKLimiTimeItem(expPacketid, itemOutTime, itemCount, self._onPackageSelectNumChange)
          item:UpdateLimitTimeDetail()
          self.__LimitTimeItems[item] = item
          if self.__LimitTimeUpdateTimerId == nil then
            self.__LimitTimeUpdateTimerId = TimerManager:StartTimer(1, self.__LimitTimeItemUpdate, self, false, false, true)
          end
        end
      else
        item = self.QPKItemPool:GetOne()
        limitTimeItemFirstIndex = -1
        item:InitQPKItem(expPacketid, self._onPackageSelectNumChange)
      end
      if self.maxNeededKeyNum == nil and item ~= nil and not isSelected then
        item:AddOne()
        isSelected = true
      end
    end
  end
  if self.maxNeededKeyNum ~= nil then
    local selectedDic = self:CalSelectList()
    if selectedDic == nil then
      for _, item in pairs(self.QPKItemPool.listItem) do
        item:AddAll()
      end
    else
      for _, item in pairs(self.QPKItemPool.listItem) do
        local keyNum = item:GetKeyNum()
        if selectedDic[keyNum] ~= nil and 0 < selectedDic[keyNum] then
          local warehousNum = item.warehousNum
          local addNum = Mathf.Min(warehousNum, selectedDic[keyNum])
          item:AddNum(addNum)
          selectedDic[keyNum] = selectedDic[keyNum] - addNum
        end
      end
    end
  end
  self:RefreshCouldAddKey()
end

function UINQuickPrchaseKayMoneyNode:__LimitTimeItemUpdate()
  if self.__LimitTimeItems == nil then
    TimerManager:StopTimer(self.__LimitTimeUpdateTimerId)
    self.__LimitTimeUpdateTimerId = nil
    return
  end
  for k, v in pairs(self.__LimitTimeItems) do
    v:UpdateLimitTimeDetail()
    if v:GetIsOutTime() then
      self:RefreshQPKPackageItemList()
      break
    end
  end
end

function UINQuickPrchaseKayMoneyNode:CalSelectList()
  local needNum = self.maxNeededKeyNum
  local keyPackageList = self.keyPackageList
  local sourceDic = {}
  local keyNumList = {}
  local maxAddNum = 0
  for index, packageItemId in pairs(self.keyPackageList) do
    local itemCfg = ConfigData.item[packageItemId]
    if itemCfg == nil then
      error("can't read itemCfg with id:" .. tostring(packageItemId))
    end
    local couldAddKeyNum = itemCfg.giftOptainDic[ConstGlobalItem.SKey]
    local itemNum = PlayerDataCenter:GetItemCount(packageItemId)
    sourceDic[couldAddKeyNum] = (sourceDic[couldAddKeyNum] or 0) + itemNum
    maxAddNum = maxAddNum + couldAddKeyNum * itemNum
    local isInserted
    for index, numInList in ipairs(keyNumList) do
      if numInList > couldAddKeyNum then
        table.insert(keyNumList, index, couldAddKeyNum)
        isInserted = true
        break
      elseif couldAddKeyNum == numInList then
        isInserted = true
        break
      end
    end
    if not isInserted then
      table.insert(keyNumList, couldAddKeyNum)
    end
  end
  if needNum >= maxAddNum then
    return nil
  end
  local curNum = 0
  local selectedDic = {}
  local ketNumCount = #keyNumList
  while needNum > curNum do
    local isHaveBiggerOne
    for index = ketNumCount, 1, -1 do
      local KeyNum = keyNumList[index]
      if selectedDic[KeyNum] ~= nil and 0 < selectedDic[KeyNum] and index < ketNumCount then
        local newKeyNum = keyNumList[index + 1]
        if 0 < sourceDic[newKeyNum] then
          selectedDic[KeyNum] = selectedDic[KeyNum] - 1
          sourceDic[KeyNum] = sourceDic[KeyNum] + 1
          selectedDic[newKeyNum] = (selectedDic[newKeyNum] or 0) + 1
          sourceDic[newKeyNum] = sourceDic[newKeyNum] - 1
          curNum = curNum + newKeyNum - KeyNum
          isHaveBiggerOne = true
          break
        end
      end
    end
    if not isHaveBiggerOne then
      for index, KeyNum in ipairs(keyNumList) do
        if 0 < sourceDic[KeyNum] then
          sourceDic[KeyNum] = sourceDic[KeyNum] - 1
          selectedDic[KeyNum] = (selectedDic[KeyNum] or 0) + 1
          curNum = curNum + KeyNum
          break
        end
      end
    end
  end
  return selectedDic
end

function UINQuickPrchaseKayMoneyNode:OnPackageSelectNumChange(QPKItem, num)
  local isNeedTip = false
  local outTime = QPKItem:GetOutTime()
  if outTime ~= -1 then
    local tempNum = num
    for _, item in pairs(self.QPKItemPool.listItem) do
      if item ~= QPKItem and item.packageItemId == QPKItem.packageItemId then
        local lastNum = item:GetLastNum()
        num = num + item.selectNum
        if outTime > item:GetOutTime() and 0 < lastNum and 0 < tempNum then
          if tempNum <= lastNum then
            item:AddNum(tempNum, true)
            QPKItem:MineNum(tempNum, true)
            tempNum = tempNum - lastNum
          else
            item:AddNum(lastNum, true)
            QPKItem:MineNum(lastNum, true)
            tempNum = tempNum - lastNum
          end
          isNeedTip = true
        end
      end
    end
  end
  if isNeedTip then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(17001))
  end
  local itemId = QPKItem.packageItemId
  self.couldAddKey = self.couldAddKey - (self.selectNumDic[itemId] or 0) * QPKItem:GetKeyNum()
  if num == nil or num == 0 then
    self.selectNumDic[itemId] = nil
  else
    self.selectNumDic[itemId] = num
  end
  self.couldAddKey = self.couldAddKey + num * QPKItem:GetKeyNum()
  self:RefreshCouldAddKey()
end

function UINQuickPrchaseKayMoneyNode:RefreshCouldAddKey()
  if self.couldAddKey <= 0 then
    self.ui.tex_CouldAddNumber:SetIndex(1)
  else
    self.ui.tex_CouldAddNumber:SetIndex(0, tostring(self.couldAddKey))
  end
  self.ui.tex_NewNumber.text = tostring(PlayerDataCenter.stamina:GetCurrentStamina() + self.couldAddKey)
end

function UINQuickPrchaseKayMoneyNode:_RefreshStamina()
  local ceiling = PlayerDataCenter.stamina:GetStaminaCeiling()
  local stamina, remainSecond = PlayerDataCenter.stamina:GetCurrentStamina()
  self.ui.tex_NewNumber.text = tostring(stamina + self.couldAddKey)
  self.ui.tex_OldNumber.text = tostring(stamina)
  if ceiling <= stamina then
    self.ui.tex_autoAdd:SetIndex(1)
  else
    self.ui.tex_autoAdd:SetIndex(0, tostring(TimeUtil:TimestampToTime(remainSecond)))
  end
end

function UINQuickPrchaseKayMoneyNode:RefreshCouldUsePackList()
  self.keyPackageList = {}
  local keyPackageList = ConfigData.item.fixedPacketMappingDic[ConstGlobalItem.SKey]
  if keyPackageList ~= nil and 0 < #keyPackageList then
    for _, expPacketid in ipairs(keyPackageList) do
      if 0 < PlayerDataCenter:GetItemCount(expPacketid) then
        table.insert(self.keyPackageList, expPacketid)
      end
    end
  end
  local tempTable = {}
  for i, v in ipairs(self.keyPackageList) do
    local limitTimeItemCfg = ConfigData.item_time_limit[v]
    if limitTimeItemCfg ~= nil then
      tempTable[v] = true
    else
      tempTable[v] = false
    end
  end
  table.sort(self.keyPackageList, function(a, b)
    if tempTable[a] ~= tempTable[b] then
      if tempTable[a] == true then
        return true
      elseif tempTable[b] == true then
        return false
      end
    end
    return a < b
  end)
end

function UINQuickPrchaseKayMoneyNode:OnClickCleanAll()
  for _, QPKItem in pairs(self.QPKItemPool.listItem) do
    QPKItem:CleanAll()
  end
end

function UINQuickPrchaseKayMoneyNode:_OnClickCancle()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
end

function UINQuickPrchaseKayMoneyNode:_OnClickConfirem()
  if self.parent.isSlideOuting then
    return
  end
  if table.count(self.selectNumDic) == 0 then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.notSelecedKeyCard))
    return
  end
  self.warehouseNetwork:CS_BACKPACK_UseItemGroup(self.selectNumDic, function()
    local rewardDic = {}
    for packageItemId, packageNum in pairs(self.selectNumDic) do
      local itemCfg = ConfigData.item[packageItemId]
      if itemCfg ~= nil and itemCfg.giftOptainDic ~= nil then
        for itemId, num in pairs(itemCfg.giftOptainDic) do
          rewardDic[itemId] = (rewardDic[itemId] or 0) + num * packageNum
        end
      end
    end
    local itemIds = {}
    local itemNums = {}
    for itemId, num in pairs(rewardDic) do
      table.insert(itemIds, itemId)
      table.insert(itemNums, num)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseList(itemIds, itemNums)
      window:AddAndTryShowReward(CRData)
    end)
    self:RefreshCouldUsePackList()
    self:RefreshQPKPackageItemList()
    local needClose = true
    if self.maxNeededKeyNum ~= nil and self.maxNeededKeyNum > PlayerDataCenter.stamina:GetCurrentStamina() then
      self:RefreshCouldUsePackList()
      self:RefreshQPKPackageItemList()
      needClose = false
      if 0 >= table.count(self.keyPackageList) then
        self.parent:SelectTog(self.parent.eBuyKeyTogType.useMoney)
      end
    end
    if needClose and self.closeCallback ~= nil then
      self.closeCallback()
    end
  end)
end

function UINQuickPrchaseKayMoneyNode:GetIsHavePackageList()
  return self.keyPackageList ~= nil and #self.keyPackageList > 0
end

function UINQuickPrchaseKayMoneyNode:OnShow()
  self.timerId = TimerManager:StartTimer(1, function()
    self:_RefreshStamina()
  end, self, nil, nil, true)
  base.OnShow(self)
end

function UINQuickPrchaseKayMoneyNode:OnHide()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  TimerManager:StopTimer(self.__LimitTimeUpdateTimerId)
  self.__LimitTimeItems = nil
  base.OnHide(self)
end

function UINQuickPrchaseKayMoneyNode:OnDelete()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  self.__LimitTimeItems = nil
  TimerManager:StopTimer(self.__LimitTimeUpdateTimerId)
  MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self._refreshStamina)
  base.OnDelete(self)
end

return UINQuickPrchaseKayMoneyNode
