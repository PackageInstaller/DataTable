---自动生成代码----start----
local OtakuManufacturingTabItemView = BaseClass( 'OtakuManufacturingTabItemView' , BaseView )
local M = OtakuManufacturingTabItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.normal =   self._binder:GetValue('normal')  
  self.select =   self._binder:GetValue('select')  
  self.barDots =   self:AddValue('UI.Ctrl.Otaku.OtakuBridgeDotGroupCtrl','UI.View.Otaku.MainUI.OtakuBridgeDotGroupView','barDots')  
  self.txt_roleNum = self:AddBaseCom( GameUIText ,'txt_roleNum')
  self.txt_totalNum = self:AddBaseCom( GameUIText ,'txt_totalNum')
  self.img_normal = self:AddBaseCom( GameUIImage ,'img_normal')
  self.txt_normal = self:AddBaseCom( GameUIText ,'txt_normal')
  self.img_select = self:AddBaseCom( GameUIImage ,'img_select')
  self.txt_select = self:AddBaseCom( GameUIText ,'txt_select')
  self.lock =   self._binder:GetValue('lock')  
  self.roleNum =   self._binder:GetValue('roleNum')  
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')


end

return OtakuManufacturingTabItemView
---自动生成代码----end----