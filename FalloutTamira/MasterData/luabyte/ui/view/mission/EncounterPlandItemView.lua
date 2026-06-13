---自动生成代码----start----
local EncounterPlandItemView = BaseClass( 'EncounterPlandItemView' , BaseView )
local M = EncounterPlandItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.heroItem =   self._binder:GetValue('heroItem')  
  self.null =   self._binder:GetValue('null')  
  self.delateBtn =   self._binder:GetValue('delateBtn')  


end

return EncounterPlandItemView
---自动生成代码----end----