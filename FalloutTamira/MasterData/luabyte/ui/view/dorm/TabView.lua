---自动生成代码----start----
local TabView = BaseClass( 'TabView' , BaseView )
local M = TabView 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.normal =   self._binder:GetValue('normal')  
  self.select =   self._binder:GetValue('select')  
  self.Lock =   self._binder:GetValue('Lock')  
  self.Text1 =   self._binder:GetValue('Text1')  
  self.Text2 =   self._binder:GetValue('Text2')  
end
return TabView
---自动生成代码----end----