---自动生成代码----start----
local DormDailyGoalsTaskItemView = BaseClass( 'DormDailyGoalsTaskItemView' , BaseView )
local M = DormDailyGoalsTaskItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.title = self:AddBaseCom( GameUIText ,'title')
  self.value = self:AddBaseCom( GameUIText ,'value')
  self.awardBtn =   self._binder:GetValue('awardBtn')  
  self.goBtn =   self._binder:GetValue('goBtn')  
  self.rewardScroll = self:AddBaseCom( CircularScrollView ,'rewardScroll')
  self.state =   self._binder:GetValue('state')  


end

return DormDailyGoalsTaskItemView
---自动生成代码----end----