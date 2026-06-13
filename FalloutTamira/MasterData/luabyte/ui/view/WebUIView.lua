---自动生成代码----start----
local WebUIView = BaseClass( 'WebUIView' , BaseView )
local M = WebUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.webView =   self._binder:GetValue('webView')  
  self.closeBtn =   self._binder:GetValue('closeBtn')  


end

return WebUIView
---自动生成代码----end----