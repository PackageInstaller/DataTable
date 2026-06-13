---自动生成代码----start----
local EncounterStageABItemView = BaseClass( 'EncounterStageABItemView' , BaseView )
local M = EncounterStageABItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state =   self._binder:GetValue('state')  
  self.img = self:AddBaseCom( GameRawImage ,'img')
  self.openView = self:AddBaseCom( UINewButton ,'openView')
  self.detail = self:AddBaseCom( UINewButton ,'detail')
  self.flag =   self._binder:GetValue('flag')  
  self.keyWord1 = self:AddBaseCom( UINewButton ,'keyWord1')
  self.finishState =   self._binder:GetValue('finishState')  


end

return EncounterStageABItemView
---自动生成代码----end----