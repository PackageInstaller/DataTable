---自动生成代码----start----
local DormPuzzleActivityView = BaseClass( 'DormPuzzleActivityView' , BaseView )
local M = DormPuzzleActivityView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.EnvelopeBtn = self:AddBaseCom( GameUIImage ,'EnvelopeBtn')
  self.EnvelopeText = self:AddBaseCom( GameUIText ,'EnvelopeText')
  self.Puzzle1 =   self:AddValue('','UI.View.Dorm.DormPuzzleItemView','Puzzle1')  
  self.Puzzle2 =   self:AddValue('','UI.View.Dorm.DormPuzzleItemView','Puzzle2')  
  self.Puzzle3 =   self:AddValue('','UI.View.Dorm.DormPuzzleItemView','Puzzle3')  
  self.Puzzle4 =   self:AddValue('','UI.View.Dorm.DormPuzzleItemView','Puzzle4')  
  self.Puzzle5 =   self:AddValue('','UI.View.Dorm.DormPuzzleItemView','Puzzle5')  
  self.Puzzle6 =   self:AddValue('','UI.View.Dorm.DormPuzzleItemView','Puzzle6')  
  self.Puzzle7 =   self:AddValue('','UI.View.Dorm.DormPuzzleItemView','Puzzle7')  
  self.Puzzle8 =   self:AddValue('','UI.View.Dorm.DormPuzzleItemView','Puzzle8')  
  self.Puzzle9 =   self:AddValue('','UI.View.Dorm.DormPuzzleItemView','Puzzle9')  
  self.Btn1 =   self:AddValue('','UI.View.Dorm.DormPuzzleRewardItemView','Btn1')  
  self.Btn2 =   self:AddValue('','UI.View.Dorm.DormPuzzleRewardItemView','Btn2')  
  self.Btn3 =   self:AddValue('','UI.View.Dorm.DormPuzzleRewardItemView','Btn3')  
  self.Btn4 =   self:AddValue('','UI.View.Dorm.DormPuzzleRewardItemView','Btn4')  
  self.Btn5 =   self:AddValue('','UI.View.Dorm.DormPuzzleRewardItemView','Btn5')  
  self.Btn6 =   self:AddValue('','UI.View.Dorm.DormPuzzleRewardItemView','Btn6')  
  self.Mask = self:AddBaseCom( GameUIImage ,'Mask')
  self.ShopBtn = self:AddBaseCom( GameUIImage ,'ShopBtn')
  self.EnvelopeImage = self:AddBaseCom( GameUIImage ,'EnvelopeImage')
  self.EnvelopeBtnAnimator =   self._binder:GetValue('EnvelopeBtnAnimator')  


end

return DormPuzzleActivityView
---自动生成代码----end----