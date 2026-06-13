---自动生成代码----start----
local LotteryRecordUI = BaseClass( 'LotteryRecordUI' , BaseView )
local M = LotteryRecordUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.History1 =   self:AddValue('UI.Ctrl.Lottery.LotteryRecordCellCtrl','UI.View.Lottery.LotteryRecordCell','History1')  
  self.History2 =   self:AddValue('UI.Ctrl.Lottery.LotteryRecordCellCtrl','UI.View.Lottery.LotteryRecordCell','History2')  
  self.History3 =   self:AddValue('UI.Ctrl.Lottery.LotteryRecordCellCtrl','UI.View.Lottery.LotteryRecordCell','History3')  
  self.History4 =   self:AddValue('UI.Ctrl.Lottery.LotteryRecordCellCtrl','UI.View.Lottery.LotteryRecordCell','History4')  
  self.History5 =   self:AddValue('UI.Ctrl.Lottery.LotteryRecordCellCtrl','UI.View.Lottery.LotteryRecordCell','History5')  
  self.togglesc = self:AddBaseCom( CircularScrollView ,'togglesc')
  self.LayoutCtrl =   self._binder:GetValue('LayoutCtrl')  
  self.CloseBtn =   self._binder:GetValue('CloseBtn')  
  self.toggleLeftArrow = self:AddBaseCom( GameUIImage ,'toggleLeftArrow')
  self.toggleRightArrow = self:AddBaseCom( GameUIImage ,'toggleRightArrow')
  self.History6 =   self:AddValue('UI.Ctrl.Lottery.LotteryRecordCellCtrl','UI.View.Lottery.LotteryRecordCell','History6')  
  self.History7 =   self:AddValue('UI.Ctrl.Lottery.LotteryRecordCellCtrl','UI.View.Lottery.LotteryRecordCell','History7')  
  self.History8 =   self:AddValue('UI.Ctrl.Lottery.LotteryRecordCellCtrl','UI.View.Lottery.LotteryRecordCell','History8')  
  self.History9 =   self:AddValue('UI.Ctrl.Lottery.LotteryRecordCellCtrl','UI.View.Lottery.LotteryRecordCell','History9')  
  self.History10 =   self:AddValue('UI.Ctrl.Lottery.LotteryRecordCellCtrl','UI.View.Lottery.LotteryRecordCell','History10')  
  self.LeftArrow = self:AddBaseCom( GameUIImage ,'LeftArrow')
  self.RightArrow = self:AddBaseCom( GameUIImage ,'RightArrow')
  self.TimeTitle = self:AddBaseCom( GameUIText ,'TimeTitle')
  self.TypeTitle = self:AddBaseCom( GameUIText ,'TypeTitle')
  self.HeroTitle = self:AddBaseCom( GameUIText ,'HeroTitle')
  self.Btn_Home = self:AddBaseCom( UIButton ,'Btn_Home')


end

return LotteryRecordUI
---自动生成代码----end----