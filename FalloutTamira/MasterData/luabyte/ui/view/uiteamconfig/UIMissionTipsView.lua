---自动生成代码----start----
local UIMissionTipsView = BaseClass( 'UIMissionTipsView' , BaseView )
local M = UIMissionTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.RawImage = self:AddBaseCom( GameRawImage ,'RawImage')
  self.btnMark =   self._binder:GetValue('btnMark')  


end

return UIMissionTipsView
---自动生成代码----end----