---自动生成代码----start----
local StoryCmdResponseView = BaseClass( 'StoryCmdResponseView' , BaseView )
local M = StoryCmdResponseView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtSelect1 = self:AddBaseCom( GameUIText ,'txtSelect1')
  self.txtSelect2 = self:AddBaseCom( GameUIText ,'txtSelect2')
  self.txtSelect3 = self:AddBaseCom( GameUIText ,'txtSelect3')
  self.stateSelect1 =   self._binder:GetValue('stateSelect1')  
  self.stateSelect2 =   self._binder:GetValue('stateSelect2')  
  self.stateSelect3 =   self._binder:GetValue('stateSelect3')  
  self.rectRoleEffect1 =   self._binder:GetValue('rectRoleEffect1')  
  self.rectRoleEffect2 =   self._binder:GetValue('rectRoleEffect2')  
  self.rectRoleEffect3 =   self._binder:GetValue('rectRoleEffect3')  
  self.rectBgEffect1 =   self._binder:GetValue('rectBgEffect1')  
  self.rectBgEffect2 =   self._binder:GetValue('rectBgEffect2')  
  self.rectBgEffect3 =   self._binder:GetValue('rectBgEffect3')  
  self.rectMagnifier1 =   self._binder:GetValue('rectMagnifier1')  
  self.rectMagnifier2 =   self._binder:GetValue('rectMagnifier2')  
  self.rectMagnifier3 =   self._binder:GetValue('rectMagnifier3')  
  self.rectAnimPanel =   self._binder:GetValue('rectAnimPanel')  
  self.giftTrigger =   self._binder:GetValue('giftTrigger')  
  self.imgAnimItem = self:AddBaseCom( GameUIImage ,'imgAnimItem')


end

return StoryCmdResponseView
---自动生成代码----end----