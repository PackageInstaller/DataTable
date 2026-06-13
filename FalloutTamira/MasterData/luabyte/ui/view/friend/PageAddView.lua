---自动生成代码----start----
local PageAddView = BaseClass( 'PageAddView' , BaseView )
local M = PageAddView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.scrollView = self:AddBaseCom( CircularScrollView ,'scrollView')
  self.input = self:AddBaseCom( UIInput ,'input')
  self.nullTip =   self._binder:GetValue('nullTip')  
  self.inputCancelBtn =   self._binder:GetValue('inputCancelBtn')  
  self.findBtn =   self._binder:GetValue('findBtn')  


end

return PageAddView
---自动生成代码----end----