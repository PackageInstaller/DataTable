---自动生成代码----start----
local RoleProfileVoiceView = BaseClass( 'RoleProfileVoiceView' , BaseView )
local M = RoleProfileVoiceView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self:AddValue('UI.Ctrl.RoleDevelop.RoleProfileVoiceItemCtrl','UI.View.RoleDevelop.RoleProfileVoiceItemView','item')  
  self.voiceWordGo =   self._binder:GetValue('voiceWordGo')  
  self.voiceWords =   self._binder:GetValue('voiceWords')  


end

return RoleProfileVoiceView
---自动生成代码----end----