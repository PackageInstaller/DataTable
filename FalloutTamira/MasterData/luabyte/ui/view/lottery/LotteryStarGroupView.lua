---自动生成代码----start----
local LotteryStarGroupView = BaseClass( 'LotteryStarGroupView' , BaseView )
local M = LotteryStarGroupView 
--desc

function M:__init(go)
--require
  local LotteryStartView = require( 'UI.View.Lottery.LotteryStartView')
--declare
  local trans = go.transform 
  self.view_Star1 = LotteryStartView.New(self._binder:GetGo('view_Star1'))
  self.view_Star2 = LotteryStartView.New(self._binder:GetGo('view_Star2'))
  self.view_Star3 = LotteryStartView.New(self._binder:GetGo('view_Star3'))
  self.view_Star4 = LotteryStartView.New(self._binder:GetGo('view_Star4'))
  self.view_Star5 = LotteryStartView.New(self._binder:GetGo('view_Star5'))
end
return LotteryStarGroupView
---自动生成代码----end----