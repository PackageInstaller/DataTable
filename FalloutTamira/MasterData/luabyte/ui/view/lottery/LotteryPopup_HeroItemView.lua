---自动生成代码----start----
local LotteryPopup_HeroItemView = BaseClass( 'LotteryPopup_HeroItemView' , BaseView )
local M = LotteryPopup_HeroItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.upPrefab =   self._binder:GetValue('upPrefab')  
  self.normalPrefab =   self._binder:GetValue('normalPrefab')  
  self.upParent =   self._binder:GetValue('upParent')  
  self.normalParent =   self._binder:GetValue('normalParent')  
  self.upScroll = self:AddBaseCom( UIScrollView ,'upScroll')
  self.normalScroll = self:AddBaseCom( UIScrollView ,'normalScroll')
  self.title =   self:AddValue('UI.Ctrl.Lottery.LotteryProbabilityTitleCtrl','UI.View.Lottery.LotteryPopup_TitleBgView','title')  


end

return LotteryPopup_HeroItemView
---自动生成代码----end----