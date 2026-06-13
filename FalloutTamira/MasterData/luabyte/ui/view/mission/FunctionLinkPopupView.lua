---自动生成代码----start----
local FunctionLinkPopupView = BaseClass( 'FunctionLinkPopupView' , BaseView )
local M = FunctionLinkPopupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.img_banner = self:AddBaseCom( GameRawImage ,'img_banner')
  self.btn_close =   self._binder:GetValue('btn_close')  
  self.btn_goto =   self._binder:GetValue('btn_goto')  


end

return FunctionLinkPopupView
---自动生成代码----end----