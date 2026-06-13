---自动生成代码----start----
local ResCopyActivityItemView = BaseClass( 'ResCopyActivityItemView' , BaseView )
local M = ResCopyActivityItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_lValue = self:AddBaseCom( GameUIText ,'txt_lValue')
  self.txt_rValue = self:AddBaseCom( GameUIText ,'txt_rValue')
  self.txt_label = self:AddBaseCom( GameUIText ,'txt_label')
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.btn_leave = self:AddBaseCom( UINewButton ,'btn_leave')
  self.uiState =   self._binder:GetValue('uiState')  


end

return ResCopyActivityItemView
---自动生成代码----end----