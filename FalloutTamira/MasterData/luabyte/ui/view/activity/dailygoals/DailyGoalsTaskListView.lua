---自动生成代码----start----
local DailyGoalsTaskListView = BaseClass( 'DailyGoalsTaskListView' , BaseView )
local M = DailyGoalsTaskListView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.parent =   self._binder:GetValue('parent')  
  self.item =   self:AddValue('','UI.View.Activity.DailyGoals.DailyGoalsTaskItemView','item')  


end

return DailyGoalsTaskListView
---自动生成代码----end----