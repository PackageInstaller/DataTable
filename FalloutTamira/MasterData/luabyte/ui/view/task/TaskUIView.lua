---自动生成代码----start----
local TaskUIView = BaseClass( 'TaskUIView' , BaseView )
local M = TaskUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectGuideBook =   self._binder:GetValue('rectGuideBook')  
  self.rectDailyBook =   self._binder:GetValue('rectDailyBook')  
  self.rectWeeklyBook =   self._binder:GetValue('rectWeeklyBook')  
  self.rectChallengeBook =   self._binder:GetValue('rectChallengeBook')  
  self.recGuideLabel =   self._binder:GetValue('recGuideLabel')  
  self.rectDailyLabel =   self._binder:GetValue('rectDailyLabel')  
  self.rectWeeklyLabel =   self._binder:GetValue('rectWeeklyLabel')  
  self.rectChallengeLabel =   self._binder:GetValue('rectChallengeLabel')  
  self.rectGuideTab =   self._binder:GetValue('rectGuideTab')  
  self.rectDailyTab =   self._binder:GetValue('rectDailyTab')  
  self.rectWeeklyTab =   self._binder:GetValue('rectWeeklyTab')  
  self.rectChallengeTab =   self._binder:GetValue('rectChallengeTab')  
  self.animTask =   self._binder:GetValue('animTask')  
  self.rectBack =   self._binder:GetValue('rectBack')  
  self.rectHome =   self._binder:GetValue('rectHome')  
  self.viewGuideTask =   self:AddValue('','UI.View.Task.GuideTaskUIView','viewGuideTask')  
  self.viewDailyTask =   self:AddValue('','UI.View.Task.DailyTaskUIView','viewDailyTask')  
  self.viewWeeklyTask =   self:AddValue('','UI.View.Task.WeeklyTaskUIView','viewWeeklyTask')  
  self.viewChallengeTask =   self:AddValue('','UI.View.Task.ChallengeTaskUIView','viewChallengeTask')  
  self.LabelGroup =   self._binder:GetValue('LabelGroup')  


end

return TaskUIView
---自动生成代码----end----