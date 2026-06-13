---自动生成代码----start----
local ComPicUIView = BaseClass( 'ComPicUIView' , BaseView )
local M = ComPicUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rimgBigPic = self:AddBaseCom( GameRawImage ,'rimgBigPic')
  self.rectClose =   self._binder:GetValue('rectClose')  


end

return ComPicUIView
---自动生成代码----end----