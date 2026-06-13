---自动生成代码----start----
local UIDayEnergyItemView = BaseClass( 'UIDayEnergyItemView' , BaseView )
local M = UIDayEnergyItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labTimer = self:AddBaseCom( GameUIText ,'labTimer')
  self.btn = self:AddBaseCom( UINewButton ,'btn')
  self.ItemPfbUI =   self._binder:GetValue('ItemPfbUI')  
  self.labLock = self:AddBaseCom( GameUIText ,'labLock')
  self.btnState =   self._binder:GetValue('btnState')  


end

return UIDayEnergyItemView
---自动生成代码----end----