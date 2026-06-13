---自动生成代码----start----
local ClothItemView = BaseClass( 'ClothItemView' , BaseView )
local M = ClothItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectItem =   self._binder:GetValue('rectItem')  
  self.imgIcon = self:AddBaseCom( GameRawImage ,'imgIcon')
  self.txtDes = self:AddBaseCom( GameUIText ,'txtDes')
  self.txtCost = self:AddBaseCom( GameUIText ,'txtCost')
  self.txtBuy = self:AddBaseCom( GameUIText ,'txtBuy')
  self.State =   self._binder:GetValue('State')  
  self.iconCost = self:AddBaseCom( GameUIImage ,'iconCost')


end

return ClothItemView
---自动生成代码----end----