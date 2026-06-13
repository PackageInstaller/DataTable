---自动生成代码----start----
local PassShopItemView = BaseClass( 'PassShopItemView' , BaseView )
local M = PassShopItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_headIcon = self:AddBaseCom( GameUIImage ,'img_headIcon')
  self.btn_buyState =   self._binder:GetValue('btn_buyState')  
  self.txt_present = self:AddBaseCom( GameUIText ,'txt_present')
  self.txt_original = self:AddBaseCom( GameUIText ,'txt_original')
  self.discountTips =   self._binder:GetValue('discountTips')  
  self.txt_rate = self:AddBaseCom( GameUIText ,'txt_rate')
  self.shopItem =   self:AddValue('','UI.View.Pass.PassShopGiftPackItemView','shopItem')  
  self.txt_showTitle = self:AddBaseCom( GameUIText ,'txt_showTitle')


end

return PassShopItemView
---自动生成代码----end----