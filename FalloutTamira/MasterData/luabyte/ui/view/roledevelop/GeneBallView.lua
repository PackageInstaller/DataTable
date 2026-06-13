---自动生成代码----start----
local GeneBallView = BaseClass( 'GeneBallView' , BaseView )
local M = GeneBallView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.IconPlane =   self._binder:GetValue('IconPlane')  
  self.RoleGeneLv =   self._binder:GetValue('RoleGeneLv')  
  self.LvValue =   self._binder:GetValue('LvValue')  
  self.BarImage =   self._binder:GetValue('BarImage')  
  self.star =   self._binder:GetValue('star')  


end

return GeneBallView
---自动生成代码----end----