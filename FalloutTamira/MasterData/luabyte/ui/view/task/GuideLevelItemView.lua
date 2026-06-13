---自动生成代码----start----
local GuideLevelItemView = BaseClass( 'GuideLevelItemView' , BaseView )
local M = GuideLevelItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectLevelItem =   self._binder:GetValue('rectLevelItem')  
  self.txtLevelValue = self:AddBaseCom( GameUIText ,'txtLevelValue')
  self.txtLevel = self:AddBaseCom( GameUIText ,'txtLevel')
  self.rectLock =   self._binder:GetValue('rectLock')  
  self.rectUnlocked =   self._binder:GetValue('rectUnlocked')  
  self.rectSelect =   self._binder:GetValue('rectSelect')  
  self.rectComplete =   self._binder:GetValue('rectComplete')  


end

return GuideLevelItemView
---自动生成代码----end----