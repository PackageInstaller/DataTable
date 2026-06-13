---自动生成代码----start----
local OtakuSynthesisUIView = BaseClass( 'OtakuSynthesisUIView' , BaseView )
local M = OtakuSynthesisUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.titleBar =   self:AddValue('UI.Ctrl.Otaku.OtakuTitleCtrl','UI.View.Otaku.OtakuTitleView','titleBar')  
  self.itemLoop = self:AddBaseCom( CircularScrollView ,'itemLoop')
  self.settleBar =   self:AddValue('UI.Ctrl.Otaku.OtakuSettleHeroCtrl','UI.View.Otaku.OtakuSettleHeroView','settleBar')  
  self.currency =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','currency')  
  self.btn_compose = self:AddBaseCom( UINewButton ,'btn_compose')
  self.numSlider =   self:AddValue('UI.Ctrl.Common.ComNumSliderCtrl','UI.View.Common.ComNumSliderView','numSlider')  
  self.itemTab =   self._binder:GetValue('itemTab')  
  self.uiState =   self._binder:GetValue('uiState')  
  self.img_itemIcon = self:AddBaseCom( GameUIImage ,'img_itemIcon')
  self.txt_itemNum = self:AddBaseCom( GameUIText ,'txt_itemNum')
  self.btn_buff =   self._binder:GetValue('btn_buff')  
  self.img_buffIcon = self:AddBaseCom( GameUIImage ,'img_buffIcon')
  self.txt_buffName = self:AddBaseCom( GameUIText ,'txt_buffName')
  self.costItem1 =   self._binder:GetValue('costItem1')  
  self.costItem2 =   self._binder:GetValue('costItem2')  
  self.costItem3 =   self._binder:GetValue('costItem3')  
  self.costItem4 =   self._binder:GetValue('costItem4')  
  self.buffTips =   self._binder:GetValue('buffTips')  
  self.satiety =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','satiety')  
  self.effect =   self._binder:GetValue('effect')  
  self.node_mask =   self._binder:GetValue('node_mask')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_num = self:AddBaseCom( GameUIText ,'txt_num')


end

return OtakuSynthesisUIView
---自动生成代码----end----