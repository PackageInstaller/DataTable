---自动生成代码----start----
local PlantPopupView = BaseClass( 'PlantPopupView' , BaseView )
local M = PlantPopupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.plantName = self:AddBaseCom( GameUIText ,'plantName')
  self.plantState = self:AddBaseCom( GameUIText ,'plantState')
  self.plantGrow = self:AddBaseCom( GameUIText ,'plantGrow')
  self.plantSlider = self:AddBaseCom( GameUIImage ,'plantSlider')
  self.plantStage1 =   self._binder:GetValue('plantStage1')  
  self.plantStage2 =   self._binder:GetValue('plantStage2')  
  self.plantStage3 =   self._binder:GetValue('plantStage3')  
  self.plantTime = self:AddBaseCom( GameUIText ,'plantTime')
  self.plantTips = self:AddBaseCom( GameUIText ,'plantTips')
  self.node_list = self:AddBaseCom( CircularScrollView ,'node_list')
  self.plantEnName = self:AddBaseCom( GameUIText ,'plantEnName')


end

return PlantPopupView
---自动生成代码----end----