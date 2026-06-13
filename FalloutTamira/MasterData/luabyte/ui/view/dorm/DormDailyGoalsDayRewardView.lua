---自动生成代码----start----
local DormDailyGoalsDayRewardView = BaseClass( 'DormDailyGoalsDayRewardView' , BaseView )
local M = DormDailyGoalsDayRewardView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state =   self._binder:GetValue('state')  
  self.btn = self:AddBaseCom( GameUIImage ,'btn')
  self.Text = self:AddBaseCom( GameUIText ,'Text')


end

return DormDailyGoalsDayRewardView
---自动生成代码----end----