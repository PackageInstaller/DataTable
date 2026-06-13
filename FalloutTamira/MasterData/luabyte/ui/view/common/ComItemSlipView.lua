---自动生成代码----start----
local ComItemSlipView = BaseClass( 'ComItemSlipView' , BaseView )
local M = ComItemSlipView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uiState =   self._binder:GetValue('uiState')  
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.txt_value = self:AddBaseCom( GameUIText ,'txt_value')


end

return ComItemSlipView
---自动生成代码----end----