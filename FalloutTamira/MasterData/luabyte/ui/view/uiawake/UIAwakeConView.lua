---自动生成代码----start----
local UIAwakeConView = BaseClass( 'UIAwakeConView' , BaseView )
local M = UIAwakeConView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.stateCondition =   self._binder:GetValue('stateCondition')  
  self.stateNum =   self._binder:GetValue('stateNum')  
  self.stateOpen1 =   self._binder:GetValue('stateOpen1')  
  self.RawImageHero = self:AddBaseCom( GameRawImage ,'RawImageHero')
  self.UIAwakeBtnCtrl =   self:AddValue('UI.Ctrl.UIAwake.UIAwakeBtnCtrl','UI.View.UIAwake.UIAwakeBtnView','UIAwakeBtnCtrl')  
  self.imgNum = self:AddBaseCom( GameUIImage ,'imgNum')
  self.stateBtn =   self._binder:GetValue('stateBtn')  
  self.btnAwake = self:AddBaseCom( UINewButton ,'btnAwake')
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')
  self.RawImageBg = self:AddBaseCom( GameRawImage ,'RawImageBg')
  self.ComItemSlipCtrl =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','ComItemSlipCtrl')  
  self.stateOpen2 =   self._binder:GetValue('stateOpen2')  
  self.stateItem1 =   self._binder:GetValue('stateItem1')  
  self.stateItem2 =   self._binder:GetValue('stateItem2')  
  self.stateItem3 =   self._binder:GetValue('stateItem3')  
  self.stateItem4 =   self._binder:GetValue('stateItem4')  
  self.stateItem5 =   self._binder:GetValue('stateItem5')  
  self.stateItem6 =   self._binder:GetValue('stateItem6')  
  self.stateItem7 =   self._binder:GetValue('stateItem7')  
  self.stateItem8 =   self._binder:GetValue('stateItem8')  
  self.stateItem9 =   self._binder:GetValue('stateItem9')  
  self.labBtn1 = self:AddBaseCom( GameUIText ,'labBtn1')
  self.labBtn2 = self:AddBaseCom( GameUIText ,'labBtn2')
  self.labDesc1 = self:AddBaseCom( GameUIText ,'labDesc1')
  self.labDesc2 = self:AddBaseCom( GameUIText ,'labDesc2')
  self.btnGo = self:AddBaseCom( GameUIImage ,'btnGo')
  self.btnBack = self:AddBaseCom( UINewButton ,'btnBack')


end

return UIAwakeConView
---自动生成代码----end----