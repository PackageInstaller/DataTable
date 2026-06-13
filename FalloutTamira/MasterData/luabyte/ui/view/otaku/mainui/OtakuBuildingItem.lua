---自动生成代码----start----
local OtakuBuildingItem = BaseClass( 'OtakuBuildingItem' , BaseView )
local M = OtakuBuildingItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.roomText1 = self:AddBaseCom( GameUIText ,'roomText1')
  self.roomText2 = self:AddBaseCom( GameUIText ,'roomText2')
  self.time =   self._binder:GetValue('time')  
  self.BuildingState =   self._binder:GetValue('BuildingState')  
  self.BuildFinishState =   self._binder:GetValue('BuildFinishState')  


end

return OtakuBuildingItem
---自动生成代码----end----