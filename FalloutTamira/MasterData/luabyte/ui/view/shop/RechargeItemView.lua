---自动生成代码----start----
local RechargeItemView = BaseClass( 'RechargeItemView' , BaseView )
local M = RechargeItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectDouble =   self._binder:GetValue('rectDouble')  
  self.txtPrice = self:AddBaseCom( GameUIText ,'txtPrice')
  self.txtDesc = self:AddBaseCom( GameUIText ,'txtDesc')
  self.txtExtra = self:AddBaseCom( GameUIText ,'txtExtra')
  self.rectItem =   self._binder:GetValue('rectItem')  
  self.bg = self:AddBaseCom( GameUIImage ,'bg')
  self.txtGift = self:AddBaseCom( GameUIText ,'txtGift')
  self.UIState =   self._binder:GetValue('UIState')  


end

return RechargeItemView
---自动生成代码----end----