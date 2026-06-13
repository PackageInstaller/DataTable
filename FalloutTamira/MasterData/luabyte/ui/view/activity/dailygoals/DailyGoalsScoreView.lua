---自动生成代码----start----
local DailyGoalsScoreView = BaseClass( 'DailyGoalsScoreView' , BaseView )
local M = DailyGoalsScoreView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.score = self:AddBaseCom( GameUIText ,'score')
  self.barValue = self:AddBaseCom( GameUIImage ,'barValue')
  self.item =   self:AddValue('','UI.View.Activity.DailyGoals.DailyGoalsScoreItemView','item')  


end

return DailyGoalsScoreView
---自动生成代码----end----