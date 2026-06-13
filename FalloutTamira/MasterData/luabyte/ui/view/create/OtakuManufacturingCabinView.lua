---自动生成代码----start----
local OtakuManufacturingCabinView = BaseClass( 'OtakuManufacturingCabinView' , BaseView )
local M = OtakuManufacturingCabinView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.makeList = self:AddBaseCom( CircularScrollView ,'makeList')
  self.img_makeIcon = self:AddBaseCom( GameUIImage ,'img_makeIcon')
  self.txt_makeName = self:AddBaseCom( GameUIText ,'txt_makeName')
  self.txt_makeTime = self:AddBaseCom( GameUIText ,'txt_makeTime')
  self.btn_make = self:AddBaseCom( UINewButton ,'btn_make')
  self.numberBar =   self:AddValue('UI.Ctrl.Common.ComNumBarCtrl','UI.View.Common.ComNumBarView','numberBar')  
  self.costItem1 =   self._binder:GetValue('costItem1')  
  self.costItem2 =   self._binder:GetValue('costItem2')  
  self.costItem3 =   self._binder:GetValue('costItem3')  
  self.tabItem =   self:AddValue('','UI.View.Create.OtakuManufacturingTabItemView','tabItem')  
  self.ctrlSettle =   self:AddValue('UI.Ctrl.Otaku.OtakuSettleHeroCtrl','UI.View.Otaku.OtakuSettleHeroView','ctrlSettle')  
  self.ctrlTitle =   self:AddValue('UI.Ctrl.Otaku.OtakuTitleCtrl','UI.View.Otaku.OtakuTitleView','ctrlTitle')  
  self.uiState =   self._binder:GetValue('uiState')  
  self.txt_makeNum = self:AddBaseCom( GameUIText ,'txt_makeNum')
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_time = self:AddBaseCom( GameUIText ,'txt_time')
  self.txt_num = self:AddBaseCom( GameUIText ,'txt_num')
  self.txt_normal = self:AddBaseCom( GameUIText ,'txt_normal')
  self.txt_stop = self:AddBaseCom( GameUIText ,'txt_stop')


end

return OtakuManufacturingCabinView
---自动生成代码----end----