---自动生成代码----start----
local DailyGoalsDayRewardView = BaseClass( 'DailyGoalsDayRewardView' , BaseView )
local M = DailyGoalsDayRewardView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.curNum = self:AddBaseCom( GameUIText ,'curNum')
  self.allNum = self:AddBaseCom( GameUIText ,'allNum')
  self.barValue = self:AddBaseCom( GameUIImage ,'barValue')
  self.state =   self._binder:GetValue('state')  
  self.btn = self:AddBaseCom( GameUIImage ,'btn')


end

return DailyGoalsDayRewardView
---自动生成代码----end----