---自动生成代码----start----
local MissionRewardItemView = BaseClass( 'MissionRewardItemView' , BaseView )
local M = MissionRewardItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.number = self:AddBaseCom( GameUIText ,'number')
  self.targetNum = self:AddBaseCom( GameUIText ,'targetNum')
  self.rewardItem =   self._binder:GetValue('rewardItem')  
  self.btn_get =   self._binder:GetValue('btn_get')  
  self.itemState =   self._binder:GetValue('itemState')  


end

return MissionRewardItemView
---自动生成代码----end----