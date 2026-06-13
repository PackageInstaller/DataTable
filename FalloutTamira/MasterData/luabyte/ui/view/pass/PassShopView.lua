---自动生成代码----start----
local PassShopView = BaseClass( 'PassShopView' , BaseView )
local M = PassShopView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.shopAnim =   self._binder:GetValue('shopAnim')  
  self.UIPassShopItemCtrl1 =   self:AddValue('UI.Ctrl.Pass.UIPassShopItemCtrl','UI.View.Pass.UIPassShopItemView','UIPassShopItemCtrl1')  
  self.UIPassShopItemCtrl2 =   self:AddValue('UI.Ctrl.Pass.UIPassShopItemCtrl','UI.View.Pass.UIPassShopItemView','UIPassShopItemCtrl2')  
  self.ItemPfbView =   self._binder:GetValue('ItemPfbView')  


end

return PassShopView
---自动生成代码----end----