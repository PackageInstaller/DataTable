---自动生成代码----start----
local DormPlantStateView = BaseClass( 'DormPlantStateView' , BaseView )
local M = DormPlantStateView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.plantAward =   self._binder:GetValue('plantAward')  
  self.plantWater =   self._binder:GetValue('plantWater')  
  self.plantPests =   self._binder:GetValue('plantPests')  


end

return DormPlantStateView
---自动生成代码----end----