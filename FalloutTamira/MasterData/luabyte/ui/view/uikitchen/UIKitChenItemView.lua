---自动生成代码----start----
local UIKitChenItemView = BaseClass( 'UIKitChenItemView' , BaseView )
local M = UIKitChenItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.labSatiety = self:AddBaseCom( GameUIText ,'labSatiety')
  self.ItemPfbView =   self:AddValue('','UI.View.Common.ItemPfbView','ItemPfbView')  
  self.ScrollView = self:AddBaseCom( UIScrollView ,'ScrollView')
  self.uiState =   self._binder:GetValue('uiState')  


end

return UIKitChenItemView
---自动生成代码----end----