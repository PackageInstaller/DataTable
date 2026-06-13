---自动生成代码----start----
local EncounterEntryTipsView = BaseClass( 'EncounterEntryTipsView' , BaseView )
local M = EncounterEntryTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.title = self:AddBaseCom( GameUIText ,'title')
  self.text = self:AddBaseCom( GameUIText ,'text')
  self.mask =   self._binder:GetValue('mask')  
  self.tips =   self._binder:GetValue('tips')  


end

return EncounterEntryTipsView
---自动生成代码----end----