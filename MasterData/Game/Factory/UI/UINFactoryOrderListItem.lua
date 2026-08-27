local UINFactoryOrderListItem = class("UINFactoryOrderListItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_MessageCommon = CS.MessageCommon
local FactoryHelper = require("Game.Factory.FactoryHelper")

function UINFactoryOrderListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_factoryItem, self, self.OnClick)
  self.item = UINBaseItemWithCount.New()
  self.item:Init(self.ui.obj_itemWithCount)
end

function UINFactoryOrderListItem:SetValueChangeCallback(callback)
  self.callback = callback
end

function UINFactoryOrderListItem:InitOrderListItem(orderData, couldProdunc)
  self.orderData = orderData
  self.orderCfg = orderData:GetOrderCfg()
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.orderCfg.name)
  local costTime = orderData:GetTimeCost()
  self.ui.tex_CostTime.text = FactoryHelper.ConvertTime2DisplayMode(costTime)
  local itemCfg = ConfigData.item[self.orderCfg.outPutItemId]
  self.item:InitItemWithCount(itemCfg, 0, nil)
  self.ui.tex_Detail.text = LanguageUtil.GetLocaleText(itemCfg.describe)
  self.isUnlcok = CheckCondition.CheckLua(self.orderCfg.pre_condition, self.orderCfg.pre_para1, self.orderCfg.pre_para2)
  self.ui.obj_lock:SetActive(not self.isUnlcok)
  if not self.isUnlcok then
    self.ui.tex_Contidion.text = CheckCondition.GetUnlockInfoLua(self.orderCfg.pre_condition, self.orderCfg.pre_para1, self.orderCfg.pre_para2)
  end
  self:RefreshCouldProdunc(couldProdunc)
  self:RefreshWarehousNum()
end

function UINFactoryOrderListItem:RefreshWarehousNum()
  local itemWarehouseNum = PlayerDataCenter:GetItemCount(self.orderCfg.outPutItemId, false)
  self.item:SetNum(itemWarehouseNum, true)
end

function UINFactoryOrderListItem:RefreshCouldProdunc(couldProdunc)
  if not self.orderData:GetIsUnlock() then
    self.ui.obj_cannotProduce:SetActive(false)
  else
    self.ui.obj_cannotProduce:SetActive(not couldProdunc)
  end
end

function UINFactoryOrderListItem:OnClick()
  if not self.isUnlcok then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_OrderUnlock))
    return
  end
  self.callback(self)
end

function UINFactoryOrderListItem:OnDelete()
  base.OnDelete(self)
end

return UINFactoryOrderListItem
