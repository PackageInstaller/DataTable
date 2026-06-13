---自动生成代码----start----
local MissionOfferAwardDetailsItemView = BaseClass( 'MissionOfferAwardDetailsItemView' , BaseView )
local M = MissionOfferAwardDetailsItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uiState =   self._binder:GetValue('uiState')  
  self.txt_level = self:AddBaseCom( GameUIText ,'txt_level')
  self.itemPfb =   self._binder:GetValue('itemPfb')  
  self.doneRect =   self._binder:GetValue('doneRect')  
  self.btn_award =   self._binder:GetValue('btn_award')  


end

return MissionOfferAwardDetailsItemView
---自动生成代码----end----