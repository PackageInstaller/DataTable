---自动生成代码----start----
local CreateAccountUIView = BaseClass( 'CreateAccountUIView' , BaseView )
local M = CreateAccountUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.inputName = self:AddBaseCom( UIInput ,'inputName')
  self.rectRandom =   self._binder:GetValue('rectRandom')  
  self.rectConfirm =   self._binder:GetValue('rectConfirm')  
  self.animTrigger =   self._binder:GetValue('animTrigger')  
  self.txtTips = self:AddBaseCom( GameUIText ,'txtTips')
  self.btn_confirm =   self._binder:GetValue('btn_confirm')  
  self.btn_cancel =   self._binder:GetValue('btn_cancel')  
  self.namefileld = self:AddBaseCom( UIInput ,'namefileld')
  self.btn_random =   self._binder:GetValue('btn_random')  
  self.txt_limitTips = self:AddBaseCom( GameUIText ,'txt_limitTips')
  self.txt_curName = self:AddBaseCom( GameUIText ,'txt_curName')
  self.node_uiState =   self._binder:GetValue('node_uiState')  


end

return CreateAccountUIView
---自动生成代码----end----