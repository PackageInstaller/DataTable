---自动生成代码----start----
local ComHeroItemView = BaseClass( 'ComHeroItemView' , BaseView )
local M = ComHeroItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectClickArea =   self._binder:GetValue('rectClickArea')  
  self.rectPrivateTab =   self._binder:GetValue('rectPrivateTab')  
  self.rectGroupTab =   self._binder:GetValue('rectGroupTab')  
  self.rectOfficalTab =   self._binder:GetValue('rectOfficalTab')  
  self.txtTabNameCN = self:AddBaseCom( GameUIText ,'txtTabNameCN')
  self.txtTabNameEN = self:AddBaseCom( GameUIText ,'txtTabNameEN')
  self.imgRoleIcon = self:AddBaseCom( GameUIImage ,'imgRoleIcon')
  self.imgOfficalIcon = self:AddBaseCom( GameUIImage ,'imgOfficalIcon')
  self.rectCheckmark =   self._binder:GetValue('rectCheckmark')  
  self.rectRename =   self._binder:GetValue('rectRename')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.redpoint =   self._binder:GetValue('redpoint')  


end

return ComHeroItemView
---自动生成代码----end----