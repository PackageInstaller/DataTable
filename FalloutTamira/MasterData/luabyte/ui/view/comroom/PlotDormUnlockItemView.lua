---自动生成代码----start----
local PlotDormUnlockItemView = BaseClass( 'PlotDormUnlockItemView' , BaseView )
local M = PlotDormUnlockItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_banner = self:AddBaseCom( GameUIImage ,'img_banner')
  self.txt_index = self:AddBaseCom( GameUIText ,'txt_index')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.itemSlip =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','itemSlip')  
  self.lockMask =   self._binder:GetValue('lockMask')  
  self.btn_enter = self:AddBaseCom( GameUIImage ,'btn_enter')


end

return PlotDormUnlockItemView
---自动生成代码----end----