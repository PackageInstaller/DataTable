---自动生成代码----start----
local RoleProfileVoiceItemView = BaseClass( 'RoleProfileVoiceItemView' , BaseView )
local M = RoleProfileVoiceItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.playBtn = self:AddBaseCom( GameUIImage ,'playBtn')
  self.wave =   self._binder:GetValue('wave')  
  self.triangle =   self._binder:GetValue('triangle')  
  self.bar = self:AddBaseCom( GameUIImage ,'bar')
  self.anim =   self._binder:GetValue('anim')  
  self.voiceName = self:AddBaseCom( GameUIText ,'voiceName')
  self.lockDesc = self:AddBaseCom( GameUIText ,'lockDesc')
  self.voiceName2 = self:AddBaseCom( GameUIText ,'voiceName2')
  self.UIState =   self._binder:GetValue('UIState')  
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.imgNum1 = self:AddBaseCom( GameUIImage ,'imgNum1')
  self.imgNum2 = self:AddBaseCom( GameUIImage ,'imgNum2')


end

return RoleProfileVoiceItemView
---自动生成代码----end----