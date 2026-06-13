---自动生成代码----start----
local LotteryPopup_ItemItemView = BaseClass( 'LotteryPopup_ItemItemView' , BaseView )
local M = LotteryPopup_ItemItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.upPrefab =   self:AddValue('','UI.View.Common.ItemPfbView','upPrefab')  
  self.normalPrefab =   self:AddValue('','UI.View.Common.ItemPfbView','normalPrefab')  
  self.upParent =   self._binder:GetValue('upParent')  
  self.normalParent =   self._binder:GetValue('normalParent')  
  self.upScroll = self:AddBaseCom( UIScrollView ,'upScroll')
  self.normalScroll = self:AddBaseCom( UIScrollView ,'normalScroll')
  self.title =   self:AddValue('UI.Ctrl.Lottery.LotteryProbabilityTitleCtrl','UI.View.Lottery.LotteryPopup_TitleBgView','title')  


end

return LotteryPopup_ItemItemView
---自动生成代码----end----