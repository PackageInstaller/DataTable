---自动生成代码----start----
local UITurntableThrowView = BaseClass( 'UITurntableThrowView' , BaseView )
local M = UITurntableThrowView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tfMask =   self._binder:GetValue('tfMask')  
  self.btn = self:AddBaseCom( UIButton ,'btn')
  self.btnImg = self:AddBaseCom( GameUIImage ,'btnImg')


end

return UITurntableThrowView
---自动生成代码----end----