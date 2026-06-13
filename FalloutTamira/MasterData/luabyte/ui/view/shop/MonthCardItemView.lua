---自动生成代码----start----
local MonthCardItemView = BaseClass( 'MonthCardItemView' , BaseView )
local M = MonthCardItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectItem =   self._binder:GetValue('rectItem')  
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.txtDes = self:AddBaseCom( GameUIText ,'txtDes')
  self.txtCost = self:AddBaseCom( GameUIText ,'txtCost')
  self.txtDays = self:AddBaseCom( GameUIText ,'txtDays')
  self.rectTips =   self._binder:GetValue('rectTips')  
  self.rectDays =   self._binder:GetValue('rectDays')  
  self.rectSoldout =   self._binder:GetValue('rectSoldout')  


end

return MonthCardItemView
---自动生成代码----end----