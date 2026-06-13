---自动生成代码----start----
local ComTextTipsView = BaseClass( 'ComTextTipsView' , BaseView )
local M = ComTextTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_title = self:AddBaseCom( GameUIText ,'txt_title')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.mask =   self._binder:GetValue('mask')  
  self.content =   self._binder:GetValue('content')  
  self.uiState =   self._binder:GetValue('uiState')  
  self.skillName_text = self:AddBaseCom( GameUIText ,'skillName_text')
  self.skillIcon_image = self:AddBaseCom( GameUIImage ,'skillIcon_image')
  self.describe_text = self:AddBaseCom( GameUIText ,'describe_text')
  self.cost_text = self:AddBaseCom( GameUIText ,'cost_text')
  self.txt_AppendEffect = self:AddBaseCom( GameUIText ,'txt_AppendEffect')
  self.cost_Parent =   self._binder:GetValue('cost_Parent')  
  self.appendPanel =   self._binder:GetValue('appendPanel')  

  self.isAlign = self:GetBaseValue('isAlign')
end

return ComTextTipsView
---自动生成代码----end----