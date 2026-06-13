---自动生成代码----start----
local UIKitChenPopView = BaseClass( 'UIKitChenPopView' , BaseView )
local M = UIKitChenPopView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.btn_cancle =   self._binder:GetValue('btn_cancle')  
  self.btn_confirm =   self._binder:GetValue('btn_confirm')  
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.ComNumSliderCtrl =   self:AddValue('UI.Ctrl.Common.ComNumSliderCtrl','UI.View.Common.ComNumSliderView','ComNumSliderCtrl')  


end

return UIKitChenPopView
---自动生成代码----end----