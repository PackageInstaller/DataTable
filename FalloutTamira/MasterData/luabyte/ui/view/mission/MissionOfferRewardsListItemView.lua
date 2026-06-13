---自动生成代码----start----
local MissionOfferRewardsListItemView = BaseClass( 'MissionOfferRewardsListItemView' , BaseView )
local M = MissionOfferRewardsListItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_numL = self:AddBaseCom( GameUIText ,'txt_numL')
  self.txt_numR = self:AddBaseCom( GameUIText ,'txt_numR')
  self.tipsRect =   self._binder:GetValue('tipsRect')  
  self.doneRect =   self._binder:GetValue('doneRect')  
  self.selectRect =   self._binder:GetValue('selectRect')  


end

return MissionOfferRewardsListItemView
---自动生成代码----end----