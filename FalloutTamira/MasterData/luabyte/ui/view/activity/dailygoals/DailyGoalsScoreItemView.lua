---自动生成代码----start----
local DailyGoalsScoreItemView = BaseClass( 'DailyGoalsScoreItemView' , BaseView )
local M = DailyGoalsScoreItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.barValue = self:AddBaseCom( GameUIImage ,'barValue')
  self.value = self:AddBaseCom( GameUIText ,'value')
  self.state =   self._binder:GetValue('state')  
  self.btn =   self._binder:GetValue('btn')  
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.effect =   self._binder:GetValue('effect')  
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')


end

return DailyGoalsScoreItemView
---自动生成代码----end----