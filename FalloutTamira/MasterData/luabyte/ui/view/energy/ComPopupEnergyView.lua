---自动生成代码----start----
local ComPopupEnergyView = BaseClass( 'ComPopupEnergyView' , BaseView )
local M = ComPopupEnergyView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.node_mask =   self._binder:GetValue('node_mask')  
  self.tgl_change = self:AddBaseCom( UINewToggle ,'tgl_change')
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.txt_recTime = self:AddBaseCom( GameUIText ,'txt_recTime')
  self.txt_energy = self:AddBaseCom( GameUIText ,'txt_energy')
  self.node_usePanel =   self._binder:GetValue('node_usePanel')  
  self.node_buyPanel =   self._binder:GetValue('node_buyPanel')  
  self.btn_useCancel =   self._binder:GetValue('btn_useCancel')  
  self.btn_useConfirm =   self._binder:GetValue('btn_useConfirm')  
  self.btn_buyCancel =   self._binder:GetValue('btn_buyCancel')  
  self.btn_buyConfirm =   self._binder:GetValue('btn_buyConfirm')  
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.numSlider =   self:AddValue('UI.Ctrl.Common.ComNumSliderCtrl','UI.View.Common.ComNumSliderView','numSlider')  
  self.txt_costName = self:AddBaseCom( GameUIText ,'txt_costName')
  self.txt_costCount = self:AddBaseCom( GameUIText ,'txt_costCount')
  self.img_costIcon = self:AddBaseCom( GameUIImage ,'img_costIcon')
  self.txt_buyCount = self:AddBaseCom( GameUIText ,'txt_buyCount')
  self.txt_buyTimes = self:AddBaseCom( GameUIText ,'txt_buyTimes')
  self.node_unselect =   self._binder:GetValue('node_unselect')  
  self.node_select =   self._binder:GetValue('node_select')  
  self.node_loopList = self:AddBaseCom( CircularScrollView ,'node_loopList')
  self.node_layout =   self._binder:GetValue('node_layout')  
  self.img_energy = self:AddBaseCom( GameUIImage ,'img_energy')


end

return ComPopupEnergyView
---自动生成代码----end----