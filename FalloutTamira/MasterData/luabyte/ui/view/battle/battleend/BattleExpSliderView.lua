---自动生成代码----start----
local BattleExpSliderView = BaseClass( 'BattleExpSliderView' , BaseView )
local M = BattleExpSliderView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.expSlider = self:AddBaseCom( UISlider ,'expSlider')
  self.expText = self:AddBaseCom( GameUIText ,'expText')
  self.lvSlider = self:AddBaseCom( GameUIImage ,'lvSlider')
  self.lv = self:AddBaseCom( GameUIText ,'lv')
  self.headItem1 =   self:AddValue('UI.Ctrl.Battle.BattleEnd.HeadItemCtrl','UI.View.Battle.BattleEnd.HeadItemView','headItem1')  
  self.headItem2 =   self:AddValue('UI.Ctrl.Battle.BattleEnd.HeadItemCtrl','UI.View.Battle.BattleEnd.HeadItemView','headItem2')  
  self.headItem3 =   self:AddValue('UI.Ctrl.Battle.BattleEnd.HeadItemCtrl','UI.View.Battle.BattleEnd.HeadItemView','headItem3')  
  self.headItem4 =   self:AddValue('UI.Ctrl.Battle.BattleEnd.HeadItemCtrl','UI.View.Battle.BattleEnd.HeadItemView','headItem4')  
  self.lvUpGroup =   self._binder:GetValue('lvUpGroup')  


end

return BattleExpSliderView
---自动生成代码----end----