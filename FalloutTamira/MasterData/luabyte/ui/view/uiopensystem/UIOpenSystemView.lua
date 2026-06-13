---自动生成代码----start----
local UIOpenSystemView = BaseClass( 'UIOpenSystemView' , BaseView )
local M = UIOpenSystemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnMark =   self._binder:GetValue('btnMark')  
  self.UIOpenItemCtrl =   self:AddValue('UI.Ctrl.UIOpenSystem.UIOpenItemCtrl','UI.View.UIOpenSystem.UIOpenItemView','UIOpenItemCtrl')  


end

return UIOpenSystemView
---自动生成代码----end----