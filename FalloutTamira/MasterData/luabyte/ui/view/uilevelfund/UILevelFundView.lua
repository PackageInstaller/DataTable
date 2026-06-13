---自动生成代码----start----
local UILevelFundView = BaseClass( 'UILevelFundView' , BaseView )
local M = UILevelFundView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')
  self.btnRecharge = self:AddBaseCom( GameUIImage ,'btnRecharge')
  self.labRecharge = self:AddBaseCom( GameUIText ,'labRecharge')
  self.btnState =   self._binder:GetValue('btnState')  
  self.btnGetAll = self:AddBaseCom( UINewButton ,'btnGetAll')
  self.rechargeState =   self._binder:GetValue('rechargeState')  
  self.PropertyBar =   self._binder:GetValue('PropertyBar')  


end

return UILevelFundView
---自动生成代码----end----