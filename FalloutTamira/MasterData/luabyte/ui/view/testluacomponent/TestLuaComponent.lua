---自动生成代码----start----
local TestLuaComponent = BaseClass( 'TestLuaComponent' , BaseView )
local M = TestLuaComponent 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.sRect_test = self:AddComponent( UIScrollView ,self._binder:GetValue('sRect_test'))
  self.img_closeBtn = self:AddComponent( UIImage ,self._binder:GetValue('img_closeBtn'))
end
return TestLuaComponent
---自动生成代码----end----