---自动生成代码----start----
local MailitemPrefabView = BaseClass( 'MailitemPrefabView' , BaseView )
local M = MailitemPrefabView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.title = self:AddBaseCom( GameUIText ,'title')
  self.valueText = self:AddBaseCom( GameUIText ,'valueText')
  self.timeText = self:AddBaseCom( GameUIText ,'timeText')
  self.fromText = self:AddBaseCom( GameUIText ,'fromText')
  self.reviewBtn = self:AddBaseCom( GameUIImage ,'reviewBtn')
  self.GetBtn = self:AddBaseCom( GameUIImage ,'GetBtn')
  self.Mask = self:AddBaseCom( GameUIImage ,'Mask')
  self.itemTip = self:AddBaseCom( GameUIImage ,'itemTip')
  self.ReadIcon =   self._binder:GetValue('ReadIcon')  
  self.UnreadIcon =   self._binder:GetValue('UnreadIcon')  
  self.mailView =   self._binder:GetValue('mailView')  


end

return MailitemPrefabView
---自动生成代码----end----