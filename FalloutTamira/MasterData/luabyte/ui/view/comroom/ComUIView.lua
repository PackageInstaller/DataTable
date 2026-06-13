---自动生成代码----start----
local ComUIView = BaseClass( 'ComUIView' , BaseView )
local M = ComUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.comHeroScroll = self:AddBaseCom( CircularScrollView ,'comHeroScroll')
  self.comChatScroll = self:AddBaseCom( LoopListView ,'comChatScroll')
  self.typeFilterTabs =   self._binder:GetValue('typeFilterTabs')  
  self.rectBack =   self._binder:GetValue('rectBack')  
  self.rectSelect1 =   self._binder:GetValue('rectSelect1')  
  self.rectSelect2 =   self._binder:GetValue('rectSelect2')  
  self.rectSelect3 =   self._binder:GetValue('rectSelect3')  
  self.rectSend =   self._binder:GetValue('rectSend')  
  self.rectChatSelect =   self._binder:GetValue('rectChatSelect')  
  self.txtSelect1 = self:AddBaseCom( GameUIText ,'txtSelect1')
  self.txtSelect2 = self:AddBaseCom( GameUIText ,'txtSelect2')
  self.txtSelect3 = self:AddBaseCom( GameUIText ,'txtSelect3')
  self.rectSendSelect =   self._binder:GetValue('rectSendSelect')  
  self.txtSelection = self:AddBaseCom( GameUIText ,'txtSelection')
  self.cgChatScroll =   self._binder:GetValue('cgChatScroll')  
  self.rectSendChatBox =   self._binder:GetValue('rectSendChatBox')  
  self.chatTypeTabs =   self._binder:GetValue('chatTypeTabs')  


end

return ComUIView
---自动生成代码----end----