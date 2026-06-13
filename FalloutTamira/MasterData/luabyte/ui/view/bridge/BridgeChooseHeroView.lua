---自动生成代码----start----
local BridgeChooseHeroView = BaseClass( 'BridgeChooseHeroView' , BaseView )
local M = BridgeChooseHeroView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.mask =   self._binder:GetValue('mask')  
  self.heroList = self:AddBaseCom( CircularScrollView ,'heroList')
  self.confirm =   self._binder:GetValue('confirm')  
  self.cancel =   self._binder:GetValue('cancel')  
  self.uiState =   self._binder:GetValue('uiState')  


end

return BridgeChooseHeroView
---自动生成代码----end----