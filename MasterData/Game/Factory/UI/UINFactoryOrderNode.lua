local UINFactoryOrderNode = class("UINFactoryOrderNode", UIBaseNode)
local base = UIBaseNode
local FactoryEnum = require("Game.Factory.FactoryEnum")
local UINFactoryOrderNodeProductItem = require("Game.Factory.UI.UINFactoryOrderNodeProductItem")
local FactoryHelper = require("Game.Factory.FactoryHelper")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local cs_MessageCommon = CS.MessageCommon

function UINFactoryOrderNode:ctor(isQuickProduce)
  self.isQuickProduce = isQuickProduce
end

function UINFactoryOrderNode:OnInit()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.orderType = FactoryEnum.eOrderType.dig
  self.costTime = 0
  self._costEnergy = 0
  self._couldQuickProduct = false
  self._pressCount = 0
  self.fileInputVal = 0
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_Add.onPress:AddListener(BindCallback(self, self.OnClickAddOnPress))
  self.ui.btn_Add.onPressUp:AddListener(BindCallback(self, self.OnPressUp))
  self.ui.btn_Min.onPress:AddListener(BindCallback(self, self.OnClickMinOnPress))
  self.ui.btn_Min.onPressUp:AddListener(BindCallback(self, self.OnPressUp))
  self.ui.inputField.onEndEdit:AddListener(BindCallback(self, self.OnInputFieldEndEdit))
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnClickAdd)
  UIUtil.AddButtonListener(self.ui.btn_Max, self, self.OnClickAdd2Max)
  UIUtil.AddButtonListener(self.ui.btn_Min, self, self.OnClickMin)
  UIUtil.AddButtonListener(self.ui.btn_Least, self, self.OnClickMin2Least)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickStartroduct)
  UIUtil.AddButtonListener(self.ui.btn_Quick, self, self.OnClickQuickProduct)
  self.m_OnProduceOver = BindCallback(self, self.OnProduceOver)
  self.m_OnTimeProduceSendOver = BindCallback(self, self.OnTimeProduceSendOver)
  self.__OnItemRefresh = BindCallback(self, self.OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
end

function UINFactoryOrderNode:InitOrderNode(roomIndex, isTryNotClearOrder)
  self.roomIndex = roomIndex
  if isTryNotClearOrder and self.factoryController.Order4SendData ~= nil then
    if self.factoryController.Order4SendData.usedTime > self.factoryController:GetRoomEnegeyByIndex(self.roomIndex) then
      self.factoryController:ClearOrder()
    else
      self.factoryController.Order4SendData.lineIndex = roomIndex
    end
  else
    self.factoryController:ClearOrder()
  end
  self:RefreshOrderInfo()
end

function UINFactoryOrderNode:ShowOrder(orderData)
  if self.orderData ~= orderData then
    self.factoryController:ClearOrder()
    self.orderData = orderData
    self.orderCfg = orderData:GetOrderCfg()
    self.orderType = orderData:GetOrderType()
    self.ui.tex_StartType:SetIndex(self.orderType - 1)
    self.ui.tex_QuickType:SetIndex(self.orderType - 1)
    self.ui.tex_From:SetIndex(self.orderType - 1)
    if self.orderType == FactoryEnum.eOrderType.dig then
      self:ShowDigOrder()
    elseif self.orderType == FactoryEnum.eOrderType.product then
      self:ShowProduceOrder()
    end
    self:RefreshOrderInfo()
  end
end

function UINFactoryOrderNode:OnItemRefresh(itemUpdate)
  if self.active then
    local usedItemDic = self.factoryController:GetResItemDic4Order4Send()
    local needReAdd = false
    if usedItemDic ~= nil then
      for itemId, _ in pairs(itemUpdate) do
        if usedItemDic[itemId] ~= nil then
          needReAdd = true
          break
        end
      end
    end
    if needReAdd then
      local curNum = self.fileInputVal
      self:OnClickMin2Least()
      self:_TryAddMult(curNum)
    end
    self:RefreshOrderInfo()
  end
end

function UINFactoryOrderNode:RefreshEnergey(isUpdate)
  local value, ceiling = self.factoryController:GetRoomEnegeyByIndex(self.roomIndex)
  if isUpdate and value == self.cacheEnergy then
    return
  end
  self.cacheEnergy = value
  self._couldQuickProduc = value >= self._costEnergy
  if self._couldQuickProduc then
    self.ui.img_btn_Qucik.color = Color.white
  else
    self.ui.img_btn_Qucik.color = self.ui.color_gray
  end
end

function UINFactoryOrderNode:UpdateEnergy()
  self:RefreshEnergey(true)
end

function UINFactoryOrderNode:ShowDigOrder()
  self.ui.itemNode:SetActive(true)
  self.ui.formulaNode:SetActive(false)
  local itemCfg = ConfigData.item[self.orderCfg.outPutItemId]
  self.ui.img_ItemIcon.sprite = CRH:GetSpriteByItemConfig(itemCfg)
end

function UINFactoryOrderNode:ShowProduceOrder()
  self.ui.itemNode:SetActive(false)
  self.ui.formulaNode:SetActive(true)
  if self.finalProductItem == nil then
    self.finalProductItem = UINFactoryOrderNodeProductItem.New()
    self.finalProductItem:Init(self.ui.finalFormulaItem)
  end
  if self.productItemPool == nil then
    self.productItemPool = UIItemPool.New(UINFactoryOrderNodeProductItem, self.ui.formulaItem)
    self.ui.formulaItem:SetActive(false)
  end
  self.finalProductItem:InitProductItem(self.orderCfg, true)
end

function UINFactoryOrderNode:OnClickAdd()
  local couldAdd, reason = self.factoryController:TryAddOneOrder(self.roomIndex, self.orderData)
  if couldAdd then
    self:RefreshOrderInfo()
    AudioManager:PlayAudioById(1064)
  elseif reason == FactoryEnum.eCannotAddReason.timeBeyountLimit then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_BeyoundOrderTime))
  elseif reason == FactoryEnum.eCannotAddReason.matInsufficeient then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_MatInsufficient, ""))
  elseif reason == FactoryEnum.eCannotAddReason.warehouseFull then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_WarehousFull))
  end
end

function UINFactoryOrderNode:OnClickAdd2Max()
  local couldAdd = self.factoryController:TryAddMaxOrder(self.roomIndex, self.orderData)
  if couldAdd then
    self:RefreshOrderInfo()
  end
  AudioManager:PlayAudioById(1064)
end

function UINFactoryOrderNode:OnClickMin()
  local couldMin = self.factoryController:TryMinOneOrder(self.roomIndex, self.orderData)
  if couldMin then
    self:RefreshOrderInfo()
    AudioManager:PlayAudioById(1065)
  end
end

function UINFactoryOrderNode:OnClickMin2Least()
  self.factoryController:ClearOrder()
  self:RefreshOrderInfo()
  AudioManager:PlayAudioById(1065)
end

function UINFactoryOrderNode:OnClickAddOnPress()
  local count = self:GetLongPressCount()
  if self:_TryAddMult(count) then
    AudioManager:PlayAudioById(1064)
  end
end

function UINFactoryOrderNode:_TryAddMult(count)
  local change = false
  while count ~= 0 do
    local couldAdd, reason = self.factoryController:TryAddOneOrder(self.roomIndex, self.orderData)
    if couldAdd then
      count = count - 1
      change = true
    else
      count = 0
      self:ShowTipsByReason(reason)
    end
    self:RefreshOrderInfo()
    if count <= 0 then
      break
    end
  end
  return change
end

function UINFactoryOrderNode:OnClickMinOnPress()
  local count = self:GetLongPressCount()
  if self:_TrySubMult(count) then
    AudioManager:PlayAudioById(1065)
  end
end

function UINFactoryOrderNode:_TrySubMult(count)
  local change = false
  while count ~= 0 do
    local couldAdd, reason = self.factoryController:TryMinOneOrder(self.roomIndex, self.orderData)
    if couldAdd then
      self:RefreshOrderInfo()
      count = count - 1
      change = true
    else
      count = 0
      self:ShowTipsByReason(reason)
    end
    if count <= 0 then
      break
    end
  end
  return change
end

function UINFactoryOrderNode:OnPressUp()
  self._pressCount = 0
end

function UINFactoryOrderNode:OnInputFieldEndEdit(value)
  local val = 0
  if not string.IsNullOrEmpty(value) then
    val = tonumber(value)
  end
  if val <= 0 then
    self.fileInputVal = 0
    self:OnClickMin2Least()
    return
  end
  local diff = 0
  if self.fileInputVal ~= val then
    diff = val - self.fileInputVal
    self.fileInputVal = val
  end
  if diff == 0 then
    return
  end
  if 0 < diff then
    self:_TryAddMult(diff)
  else
    diff = math.abs(diff)
    self:_TrySubMult(diff)
  end
end

function UINFactoryOrderNode:GetLongPressCount()
  self._pressCount = self._pressCount + 1
  local count = 1
  count = count + self._pressCount // 2
  count = math.min(10, count)
  return count
end

function UINFactoryOrderNode:ShowTipsByReason(reason)
  if reason == FactoryEnum.eCannotAddReason.timeBeyountLimit then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_BeyoundOrderTime))
  elseif reason == FactoryEnum.eCannotAddReason.matInsufficeient then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_MatInsufficient, ""))
  elseif reason == FactoryEnum.eCannotAddReason.warehouseFull then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_WarehousFull))
  end
end

function UINFactoryOrderNode:ChangeConfirmLook(couldClick)
  if couldClick then
    self.ui.img_btn_Qucik.color = Color.white
    self.ui.img_Type.color = Color.white
    self.ui.tex_QuickType.text.color = Color.white
    self.ui.tex_StartType.text.color = Color.white
  else
    self.ui.img_btn_Qucik.color = self.ui.color_gray
    local white = Color.New(1, 1, 1, 0.4)
    self.ui.img_Type.color = white
    self.ui.tex_QuickType.text.color = white
    self.ui.tex_StartType.text.color = white
  end
end

function UINFactoryOrderNode:RefreshOrderInfo()
  local Order4SendData = self.factoryController:GetOrder4Send()
  if Order4SendData == nil or Order4SendData.curOrderNum < 1 then
    self.fileInputVal = 0
    self.ui.inputField.text = tostring(0)
    self:ChangeConfirmLook(false)
    self.costTime = 0
    if self.orderType == FactoryEnum.eOrderType.product then
      self.finalProductItem:SetOutPut(1, true)
      self.productItemPool:HideAll()
      for i, emptyItem in ipairs(self.ui.emptyItemList) do
        emptyItem:SetActive(true)
      end
    elseif self.orderType == FactoryEnum.eOrderType.dig then
      self.ui.tex_ItemCount.text = tostring(0)
    end
  else
    self.fileInputVal = Order4SendData.curOrderNum
    self.ui.inputField.text = tostring(Order4SendData.curOrderNum)
    self:ChangeConfirmLook(true)
    self.costTime = Order4SendData.usedTime
    if Order4SendData.orderType == FactoryEnum.eOrderType.product then
      if self.finalProductItem ~= nil then
        self.finalProductItem:SetOutPut(Order4SendData.curOrderNum)
      end
      if self.productItemPool ~= nil and Order4SendData.assistOrderDic ~= nil then
        local count = table.count(Order4SendData.assistOrderDic)
        self.productItemPool:HideAll()
        for orderId, num in pairs(Order4SendData.assistOrderDic) do
          local subOrderItem = self.productItemPool:GetOne()
          subOrderItem:InitProductItem(ConfigData.factory_order[orderId], false)
          subOrderItem:SetOutPut(num)
        end
        for i, emptyItem in ipairs(self.ui.emptyItemList) do
          emptyItem:SetActive(i > count)
          emptyItem.transform:SetAsLastSibling()
        end
      end
    elseif self.orderType == FactoryEnum.eOrderType.dig and self.orderData ~= nil then
      self.ui.tex_ItemCount.text = tostring(Order4SendData.curOrderNum * self.orderData:GetOrderCfg().outPutItemNum)
    end
  end
  self:RefreshProductCost()
  self:RefreshEnergey()
end

function UINFactoryOrderNode:RefreshProductCost()
  self.ui.tex_ConFirmCost.text = FactoryHelper.ConvertTime2DisplayMode(self.costTime)
  self._costEnergy = FactoryHelper.GetFactoryTime2EnergyCost(self.costTime)
  self.ui.tex_QuickCost.text = tostring(self._costEnergy)
end

function UINFactoryOrderNode:OnClickQuickProduct()
  if not self._couldQuickProduc then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_EnergyInsufficient))
    local ShopEnum = require("Game.Shop.ShopEnum")
    local quickBuyData = ShopEnum.eQuickBuy.factoryEnergy
    local shopId = quickBuyData.shopId
    local shelfId = quickBuyData.shelfId
    local goodData
    local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    ctrl:GetShopData(shopId, function(shopData)
      goodData = shopData.shopGoodsDic[shelfId]
      UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
        if win == nil then
          error("can't open QuickBuy win")
          return
        end
        win:SlideIn(nil, true)
        win:InitBuyTarget(goodData, nil, true, quickBuyData.resourceIds, function()
          if self.closeCommonRewardCallback ~= nil then
            self.closeCommonRewardCallback()
            self.closeCommonRewardCallback = nil
          end
        end)
        win:OnClickAdd(true)
        if not IsNull(self.ui.quickPurchaseRoot) then
          win:SetRoot(self.ui.quickPurchaseRoot)
        end
      end)
    end)
    return
  end
  local Order4SendData = self.factoryController:GetOrder4Send()
  if Order4SendData == nil or Order4SendData.curOrderNum < 1 then
    return
  end
  local orderCfg = ConfigData.factory_order[Order4SendData.curOrderId]
  self.rewardTable = {
    rewardIds = {
      orderCfg.outPutItemId
    },
    rewardNums = {
      orderCfg.outPutItemNum * Order4SendData.curOrderNum
    }
  }
  self.factoryController:SendOrder(self.m_OnProduceOver)
end

function UINFactoryOrderNode:OnClickStartroduct()
  if self.factoryController.ProcessingOrders[self.roomIndex] ~= nil and table.count(self.factoryController.ProcessingOrders[self.roomIndex]) > 0 then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_AlreadyHaveOrder, ""))
    return
  end
  local Order4SendData = self.factoryController:GetOrder4Send()
  if Order4SendData == nil or Order4SendData.curOrderNum < 1 then
    return
  end
  local orderCfg = ConfigData.factory_order[Order4SendData.curOrderId]
  self.rewardTable = {
    rewardIds = {
      orderCfg.outPutItemId
    },
    rewardNums = {
      orderCfg.outPutItemNum * Order4SendData.curOrderNum
    }
  }
  self.factoryController:SendOrder(self.m_OnTimeProduceSendOver, true)
  if self.isQuickProduce then
    if self.closeQuickProduceNode ~= nil then
      self:closeQuickProduceNode()
    end
  else
    UIUtil.ForceOnClickBack()
    UIUtil.ForceOnClickBack()
  end
end

function UINFactoryOrderNode:SetCloseCommonRewardCallback(closeCommonRewardCallback)
  self.closeCommonRewardCallback = closeCommonRewardCallback
end

function UINFactoryOrderNode:OnProduceOver()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CRData = CommonRewardData.CreateCRDataUseList(self.rewardTable.rewardIds, self.rewardTable.rewardNums):SetCRShowOverFunc(self.closeCommonRewardCallback)
    window:AddAndTryShowReward(CRData)
    self.rewardTable = nil
  end)
  self.factoryController:ClearOrder()
  self:RefreshOrderInfo()
end

function UINFactoryOrderNode:OnTimeProduceSendOver()
end

function UINFactoryOrderNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
  base.OnDelete(self)
end

return UINFactoryOrderNode
