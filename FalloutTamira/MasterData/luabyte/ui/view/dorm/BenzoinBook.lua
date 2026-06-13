---自动生成代码----start----
local BenzoinBook = BaseClass( 'BenzoinBook' , BaseView )
local M = BenzoinBook 
--desc

function M:__init(go)
  local trans = go.transform 
  self.DayItem1 =   self:AddValue('UI.Ctrl.Dorm.BenzoinBookDayItemCtrl','UI.View.Dorm.BenzoinBookDayItem','DayItem1')  
  self.DayItem2 =   self:AddValue('UI.Ctrl.Dorm.BenzoinBookDayItemCtrl','UI.View.Dorm.BenzoinBookDayItem','DayItem2')  
  self.DayItem3 =   self:AddValue('UI.Ctrl.Dorm.BenzoinBookDayItemCtrl','UI.View.Dorm.BenzoinBookDayItem','DayItem3')  
  self.DayItem4 =   self:AddValue('UI.Ctrl.Dorm.BenzoinBookDayItemCtrl','UI.View.Dorm.BenzoinBookDayItem','DayItem4')  
  self.DayItem5 =   self:AddValue('UI.Ctrl.Dorm.BenzoinBookDayItemCtrl','UI.View.Dorm.BenzoinBookDayItem','DayItem5')  
  self.DayItem6 =   self:AddValue('UI.Ctrl.Dorm.BenzoinBookDayItemCtrl','UI.View.Dorm.BenzoinBookDayItem','DayItem6')  
  self.DayItem7 =   self:AddValue('UI.Ctrl.Dorm.BenzoinBookDayItemCtrl','UI.View.Dorm.BenzoinBookDayItem','DayItem7')  
  self.DayText = self:AddBaseCom( GameUIText ,'DayText')
  self.DateImg = self:AddBaseCom( GameUIImage ,'DateImg')
  self.TitleText_1 = self:AddBaseCom( GameUIText ,'TitleText_1')
  self.ContentText = self:AddBaseCom( GameUIText ,'ContentText')
  self.mask = self:AddBaseCom( GameUIImage ,'mask')
  self.Content =   self._binder:GetValue('Content')  
  self.TitleText_2 = self:AddBaseCom( GameUIText ,'TitleText_2')
  self.EngText_1 = self:AddBaseCom( GameUIText ,'EngText_1')
  self.EngText_2 = self:AddBaseCom( GameUIText ,'EngText_2')
  self.RightBg =   self._binder:GetValue('RightBg')  


end

return BenzoinBook
---自动生成代码----end----