---自动生成代码----start----
local GiftPackItemView = BaseClass( 'GiftPackItemView' , BaseView )
local M = GiftPackItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectItem =   self._binder:GetValue('rectItem')  
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labBuyNum = self:AddBaseCom( GameUIText ,'labBuyNum')
  self.imgCost = self:AddBaseCom( GameUIImage ,'imgCost')
  self.labCost = self:AddBaseCom( GameUIText ,'labCost')
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.tfNotBuy =   self._binder:GetValue('tfNotBuy')  
  self.tfTime =   self._binder:GetValue('tfTime')  
  self.labTime = self:AddBaseCom( GameUIText ,'labTime')
  self.tfContentCannot =   self._binder:GetValue('tfContentCannot')  
  self.labBuyLevel = self:AddBaseCom( GameUIText ,'labBuyLevel')
  self.tfBuyNum =   self._binder:GetValue('tfBuyNum')  
  self.redpoint =   self._binder:GetValue('redpoint')  
  self.ItemContent =   self._binder:GetValue('ItemContent')  
  self.item1 =   self:AddValue('','UI.View.Common.ItemPfbView','item1')  
  self.Sale =   self._binder:GetValue('Sale')  
  self.SaleText = self:AddBaseCom( GameUIText ,'SaleText')
  self.item2 =   self:AddValue('','UI.View.Common.ItemPfbView','item2')  
  self.item3 =   self:AddValue('','UI.View.Common.ItemPfbView','item3')  


end

return GiftPackItemView
---自动生成代码----end----