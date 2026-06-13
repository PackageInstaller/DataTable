---自动生成代码----start----
local ConfirmSweepUIView = BaseClass( 'ConfirmSweepUIView' , BaseView )
local M = ConfirmSweepUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.numSlider =   self:AddValue('UI.Ctrl.Common.ComNumSliderCtrl','UI.View.Common.ComNumSliderView','numSlider')  
  self.btn_cancel =   self._binder:GetValue('btn_cancel')  
  self.btn_confirm =   self._binder:GetValue('btn_confirm')  
  self.btn_mask =   self._binder:GetValue('btn_mask')  


end

return ConfirmSweepUIView
---自动生成代码----end----