---自动生成代码----start----
local CoordinateItemView = BaseClass( 'CoordinateItemView' , BaseView )
local M = CoordinateItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.headIcon = self:AddBaseCom( GameUIImage ,'headIcon')
  self.itemIcon = self:AddBaseCom( GameUIImage ,'itemIcon')
  self.timeText = self:AddBaseCom( GameUIText ,'timeText')
  self.infoBtn =   self._binder:GetValue('infoBtn')  
  self.star1 =   self._binder:GetValue('star1')  
  self.star2 =   self._binder:GetValue('star2')  
  self.star3 =   self._binder:GetValue('star3')  
  self.star4 =   self._binder:GetValue('star4')  
  self.selectState =   self._binder:GetValue('selectState')  
  self.surveyState =   self._binder:GetValue('surveyState')  
  self.node_stars =   self._binder:GetValue('node_stars')  
  self.node_only =   self._binder:GetValue('node_only')  


end

return CoordinateItemView
---自动生成代码----end----