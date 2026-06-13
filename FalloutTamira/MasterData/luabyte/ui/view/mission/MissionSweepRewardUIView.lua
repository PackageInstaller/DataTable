---自动生成代码----start----
local MissionSweepRewardUIView = BaseClass( 'MissionSweepRewardUIView' , BaseView )
local M = MissionSweepRewardUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_back =   self._binder:GetValue('btn_back')  
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')
  self.expCtrl =   self:AddValue('UI.Ctrl.Battle.BattleEnd.BattleExpSliderCtrl','UI.View.Battle.BattleEnd.BattleExpSliderView','expCtrl')  


end

return MissionSweepRewardUIView
---自动生成代码----end----