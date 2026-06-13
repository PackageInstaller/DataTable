---自动生成代码----start----
local ComVideoUIView = BaseClass( 'ComVideoUIView' , BaseView )
local M = ComVideoUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rimgBigVideo = self:AddBaseCom( GameRawImage ,'rimgBigVideo')
  self.rectClose =   self._binder:GetValue('rectClose')  
  self.rectPlay =   self._binder:GetValue('rectPlay')  


end

return ComVideoUIView
---自动生成代码----end----