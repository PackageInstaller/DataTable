---自动生成代码----start----
local UIPassShopItemView = BaseClass( 'UIPassShopItemView' , BaseView )
local M = UIPassShopItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ItemPfbView =   self._binder:GetValue('ItemPfbView')  
  self.discountTips =   self._binder:GetValue('discountTips')  
  self.txt_present = self:AddBaseCom( GameUIText ,'txt_present')
  self.txt_original = self:AddBaseCom( GameUIText ,'txt_original')
  self.btn_buyState =   self._binder:GetValue('btn_buyState')  
  self.itemSlip =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','itemSlip')  
  self.txt_title = self:AddBaseCom( GameUIText ,'txt_title')
  self.itemPfbSlip =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','itemPfbSlip')  
  self.uiState =   self._binder:GetValue('uiState')  
  self.txt_titleEn = self:AddBaseCom( GameUIText ,'txt_titleEn')


end

return UIPassShopItemView
---自动生成代码----end----