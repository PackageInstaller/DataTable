---自动生成代码----start----
local PassTaskView = BaseClass( 'PassTaskView' , BaseView )
local M = PassTaskView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.taskTab =   self._binder:GetValue('taskTab')  
  self.taskloop = self:AddBaseCom( CircularScrollView ,'taskloop')
  self.btn_quickGet = self:AddBaseCom( UINewButton ,'btn_quickGet')
  self.quickGetLock =   self._binder:GetValue('quickGetLock')  
  self.tipsState =   self._binder:GetValue('tipsState')  


end

return PassTaskView
---自动生成代码----end----