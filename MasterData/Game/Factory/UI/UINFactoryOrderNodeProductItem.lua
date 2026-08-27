local UINFactoryOrderNodeProductItem = class("UINFactoryOrderNodeProductItem", UIBaseNode)
local base = UIBaseNode
local UINFactoryOrderNodeProductMat = require("Game.Factory.UI.UINFactoryOrderNodeProductMat")
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local FactoryHelper = require("Game.Factory.FactoryHelper")

function UINFactoryOrderNodeProductItem:OnInit()
  self.outPutItemId = nil
  self.matItemDic = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.matItemPool = UIItemPool.New(UINFactoryOrderNodeProductMat, self.ui.matItem)
  self.ui.matItem:SetActive(false)
end

function UINFactoryOrderNodeProductItem:InitProductItem(orderCfg, isFinal)
  self.orderCfg = orderCfg
  self.matItemDic = {}
  self.outPutItemId = orderCfg.outPutItemId
  local itemCfg = ConfigData.item[self.outPutItemId]
  if isFinal then
    if self.item == nil then
      self.item = UINBaseItem.New()
      self.item:Init(self.ui.uINBaseItem)
    end
    self.item:InitBaseItem(itemCfg)
  else
    local output_matItem = UINFactoryOrderNodeProductMat.New()
    output_matItem:Init(self.ui.finalMatItem)
    output_matItem:InitProductOut(itemCfg)
  end
  self.matItemPool:HideAll()
  local count = 0
  for index, itemId in ipairs(orderCfg.materialOrder) do
    count = count + 1
    local matItem = self.matItemPool:GetOne()
    local matItemCfg = ConfigData.item[itemId]
    matItem:InitProductMat(matItemCfg, count)
    self.matItemDic[itemId] = matItem
  end
  for i = count + 1, 3 do
    local emptyMatItem = self.matItemPool:GetOne()
    emptyMatItem:InitProductMat(nil, i)
  end
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(self.orderCfg.name)
end

function UINFactoryOrderNodeProductItem:SetOutPut(num, isShowUse)
  self.ui.tex_outputCount.text = tostring(num * self.orderCfg.outPutItemNum)
  self.ui.tex_CostTime.text = FactoryHelper.ConvertTime2DisplayMode(num * self.orderCfg.time_cost)
  if isShowUse then
    self.ui.tex_outputCount.color = Color.New(1, 1, 1, 0.6)
  else
    self.ui.tex_outputCount.color = Color.white
  end
  for itemId, matItem in pairs(self.matItemDic) do
    matItem:SetCost(self.orderCfg.raw_material[itemId] * num, isShowUse)
  end
end

function UINFactoryOrderNodeProductItem:OnDelete()
  base.OnDelete(self)
end

return UINFactoryOrderNodeProductItem
