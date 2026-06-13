---自动生成代码----start----
local LotteryPopupView = BaseClass( 'LotteryPopupView' , BaseView )
local M = LotteryPopupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.BG = self:AddBaseCom( GameUIImage ,'BG')
  self.titlePrefab =   self:AddValue('UI.Ctrl.Lottery.LotteryProbabilityTitleCtrl','UI.View.Lottery.LotteryPopup_TitleBgView','titlePrefab')  
  self.ProbabilityHero =   self:AddValue('UI.Ctrl.Lottery.LotteryProbabilityHeroCtrl','UI.View.Lottery.LotteryPopup_HeroItemView','ProbabilityHero')  
  self.ProbabilityItem =   self:AddValue('UI.Ctrl.Lottery.LotteryProbabilityNormalItemCtrl','UI.View.Lottery.LotteryPopup_TextItemView','ProbabilityItem')  
  self.layout =   self._binder:GetValue('layout')  
  self.tiptext = self:AddBaseCom( GameUIText ,'tiptext')
  self.Btn_Home = self:AddBaseCom( UIButton ,'Btn_Home')
  self.ProbabilitySpItem =   self:AddValue('UI.Ctrl.Lottery.LotteryProbabilitySpItemCtrl','UI.View.Lottery.LotteryPopup_ItemItemView','ProbabilitySpItem')  


end

return LotteryPopupView
---自动生成代码----end----