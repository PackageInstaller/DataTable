---自动生成代码----start----
local MailUiView = BaseClass( 'MailUiView' , BaseView )
local M = MailUiView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.NoMail =   self._binder:GetValue('NoMail')  
  self.sc = self:AddBaseCom( CircularScrollView ,'sc')
  self.closeBtn = self:AddBaseCom( GameUIImage ,'closeBtn')
  self.getAllBtn = self:AddBaseCom( GameUIImage ,'getAllBtn')
  self.deleteAllBtn = self:AddBaseCom( GameUIImage ,'deleteAllBtn')
  self.tipText = self:AddBaseCom( GameUIText ,'tipText')


end

return MailUiView
---自动生成代码----end----