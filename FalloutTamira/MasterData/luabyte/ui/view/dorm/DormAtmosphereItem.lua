---自动生成代码----start----
local DormAtmosphereItem = BaseClass( 'DormAtmosphereItem' , BaseView )
local M = DormAtmosphereItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.maxNum = self:AddBaseCom( GameUIText ,'maxNum')
  self.curNum = self:AddBaseCom( GameUIText ,'curNum')
  self.Scrollbar =   self._binder:GetValue('Scrollbar')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.Atmosphere = self:AddBaseCom( GameUIImage ,'Atmosphere')
  self.AtmosphereRedPoint =   self._binder:GetValue('AtmosphereRedPoint')  


end

return DormAtmosphereItem
---自动生成代码----end----