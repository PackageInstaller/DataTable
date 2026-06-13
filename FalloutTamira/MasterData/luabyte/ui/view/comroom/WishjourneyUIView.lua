---自动生成代码----start----
local WishjourneyUIView = BaseClass( 'WishjourneyUIView' , BaseView )
local M = WishjourneyUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.coordinate0 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate0')  
  self.coordinate1 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate1')  
  self.coordinate10 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate10')  
  self.coordinate11 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate11')  
  self.coordinate12 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate12')  
  self.coordinate13 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate13')  
  self.coordinate14 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate14')  
  self.coordinate15 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate15')  
  self.coordinate2 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate2')  
  self.coordinate3 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate3')  
  self.coordinate4 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate4')  
  self.coordinate5 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate5')  
  self.coordinate6 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate6')  
  self.coordinate7 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate7')  
  self.coordinate8 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate8')  
  self.coordinate9 =   self:AddValue('UI.Ctrl.ComRoom.CoordinateItemCtrl','UI.View.ComRoom.CoordinateItemView','coordinate9')  
  self.refreshBtn =   self._binder:GetValue('refreshBtn')  
  self.consumeIcon = self:AddBaseCom( GameUIImage ,'consumeIcon')
  self.consumeNum = self:AddBaseCom( GameUIText ,'consumeNum')
  self.ctrlTitle =   self:AddValue('UI.Ctrl.Otaku.OtakuTitleCtrl','UI.View.Otaku.OtakuTitleView','ctrlTitle')  


end

return WishjourneyUIView
---自动生成代码----end----