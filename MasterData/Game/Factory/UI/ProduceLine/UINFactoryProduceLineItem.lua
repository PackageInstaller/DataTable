local UINFactoryProduceLineItem = class("UINFactoryProduceLineItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local FactoryHelper = require("Game.Factory.FactoryHelper")
local cs_MessageCommon = CS.MessageCommon

function UINFactoryProduceLineItem:OnInit()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItemWithCount = UINBaseItemWithCount.New()
  self.baseItemWithCount:Init(self.ui.obj_uINBaseItemWithCount)
  UIUtil.AddButtonListener(self.ui.btn_Stop, self, self.OnClickStop)
  UIUtil.AddButtonListener(self.ui.btn_Immed, self, self.OnClickQuickFinish)
  UIUtil.AddButtonListener(self.ui.btn_Pick, self, self.OnClickPickReward)
end

function UINFactoryProduceLineItem:InitProduceLineItem(processingData)
  self.processingData = processingData
  self.baseItemWithCount:InitItemWithCount(processingData:GetOutputItemCfg(), processingData:GetOutputItemProduceNum())
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(processingData:GetOutputItemCfg().name)
  self:OnTimeUpdate()
  self:RefreshEnergey(true)
end

function UINFactoryProduceLineItem:OnTimeUpdate()
  local isFinish = self.processingData:GetIsFinish()
  self.ui.btn_Stop.gameObject:SetActive(not isFinish)
  self.ui.btn_Immed.gameObject:SetActive(not isFinish)
  self.ui.btn_Pick.gameObject:SetActive(isFinish)
  if not isFinish then
    self.ui.tex_Time.text = FactoryHelper.ConvertTime2DisplayMode(self.processingData:GetLeftProcessTime())
    local emerguCost = self.processingData:GetLeftProcessEnergy()
    self.ui.tex_CostEnergy.text = tostring(emerguCost)
    self.ui.slider_processRate.value = self.processingData:GetProcessRate()
    self.ui.tex_State:SetIndex(0)
  else
    self.ui.tex_Time.text = FactoryHelper.ConvertTime2DisplayMode(0)
    self.ui.slider_processRate.value = 1
    self.ui.tex_State:SetIndex(1)
  end
end

function UINFactoryProduceLineItem:RefreshEnergey(forceRefresh)
  local value, ceiling = self.factoryController:GetRoomEnegeyByIndex(self.roomIndex)
  if value == self.cacheEnergy and not forceRefresh then
    return
  end
  self.cacheEnergy = value
  self._couldQuickProduc = value >= self.processingData:GetLeftProcessEnergy()
  if self._couldQuickProduc then
    self.ui.img_btn_Immed.color = Color.white
  else
    self.ui.img_btn_Immed.color = self.ui.color_gray
  end
end

function UINFactoryProduceLineItem:OnClickStop()
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.Factory_ConfirmDeleteOrder), function()
    if self.processingData:GetIsFinish() then
      return
    end
    self.factoryController:CancleOrder(self.processingData)
  end, nil)
end

function UINFactoryProduceLineItem:OnClickQuickFinish()
  if self.processingData:GetLeftProcessEnergy() > self.factoryController:GetRoomEnegeyByIndex() then
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
        win:SlideIn()
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
  self.factoryController:QuickFinishOrder(self.processingData)
end

function UINFactoryProduceLineItem:OnClickPickReward()
  self.factoryController:PickOrderReward(self.processingData)
end

function UINFactoryProduceLineItem:OnDelete()
  base.OnDelete(self)
end

return UINFactoryProduceLineItem
