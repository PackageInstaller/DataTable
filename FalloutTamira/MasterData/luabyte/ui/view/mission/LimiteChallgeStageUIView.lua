---自动生成代码----start----
local LimiteChallgeStageUIView = BaseClass( 'LimiteChallgeStageUIView' , BaseView )
local M = LimiteChallgeStageUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.itemContainer =   self._binder:GetValue('itemContainer')  
  self.stageInfo =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimitStageInfoViewCtrl','UI.View.Mission.LimitStageInfoView','stageInfo')  
  self.clickArea =   self._binder:GetValue('clickArea')  
  self.item0 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item0')  
  self.item1 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item1')  
  self.item2 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item2')  
  self.item3 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item3')  
  self.item4 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item4')  
  self.item5 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item5')  
  self.item6 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item6')  
  self.item7 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item7')  
  self.item8 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item8')  
  self.item9 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item9')  
  self.item10 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item10')  
  self.item11 =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimiteChallgeStageItemCtrl','UI.View.Mission.LimiteChallgeStageItemView','item11')  
  self.scrollView = self:AddBaseCom( UIScrollView ,'scrollView')
  self.taskBtn =   self._binder:GetValue('taskBtn')  
  self.skillBtn =   self._binder:GetValue('skillBtn')  
  self.resetBtn =   self._binder:GetValue('resetBtn')  
  self.shopBtn =   self._binder:GetValue('shopBtn')  
  self.cycleTimeLabel = self:AddBaseCom( GameUIText ,'cycleTimeLabel')
  self.txt_curGameScore = self:AddBaseCom( GameUIText ,'txt_curGameScore')
  self.txt_curSeasonScore = self:AddBaseCom( GameUIText ,'txt_curSeasonScore')
  self.img_timer = self:AddBaseCom( GameUIImage ,'img_timer')
  self.txt_timerLabel = self:AddBaseCom( GameUIText ,'txt_timerLabel')


end

return LimiteChallgeStageUIView
---自动生成代码----end----