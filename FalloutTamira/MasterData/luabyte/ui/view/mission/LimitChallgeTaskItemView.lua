---自动生成代码----start----
local LimitChallgeTaskItemView = BaseClass( 'LimitChallgeTaskItemView' , BaseView )
local M = LimitChallgeTaskItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.itemPfb =   self._binder:GetValue('itemPfb')  
  self.img_head = self:AddBaseCom( GameUIImage ,'img_head')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.btn_award =   self._binder:GetValue('btn_award')  
  self.uiState =   self._binder:GetValue('uiState')  


end

return LimitChallgeTaskItemView
---自动生成代码----end----