---自动生成代码----start----
local PageListView = BaseClass( 'PageListView' , BaseView )
local M = PageListView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.numText = self:AddBaseCom( GameUIText ,'numText')
  self.maxText = self:AddBaseCom( GameUIText ,'maxText')
  self.scrollView = self._binder:GetValue('scrollView')  
  self.nullTip =   self._binder:GetValue('nullTip')  


end

return PageListView
---自动生成代码----end----