---自动生成代码----start----
local TargetRewardUIView = BaseClass( 'TargetRewardUIView' , BaseView )
local M = TargetRewardUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rewardItem =   self:AddValue('','UI.View.Mission.MissionRewardItemView','rewardItem')  
  self.closeBtn =   self._binder:GetValue('closeBtn')  


end

return TargetRewardUIView
---自动生成代码----end----