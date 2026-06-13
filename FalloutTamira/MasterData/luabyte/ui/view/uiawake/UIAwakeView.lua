---自动生成代码----start----
local UIAwakeView = BaseClass( 'UIAwakeView' , BaseView )
local M = UIAwakeView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.stateBtn1 =   self._binder:GetValue('stateBtn1')  
  self.ItemAttr =   self:AddValue('UI.Ctrl.UIAwake.ItemAttrCtrl','UI.View.UIAwake.ItemAttrView','ItemAttr')  
  self.labAttrTitle = self:AddBaseCom( GameUIText ,'labAttrTitle')
  self.imgQuality = self:AddBaseCom( GameUIImage ,'imgQuality')
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labGet = self:AddBaseCom( GameUIText ,'labGet')
  self.UIAwakenSkillCtrl1 =   self:AddValue('UI.Ctrl.UIAwake.UIAwakenSkillCtrl','UI.View.UIAwake.UIAwakenSkillView','UIAwakenSkillCtrl1')  
  self.UIAwakenSkillCtrl2 =   self:AddValue('UI.Ctrl.UIAwake.UIAwakenSkillCtrl','UI.View.UIAwake.UIAwakenSkillView','UIAwakenSkillCtrl2')  
  self.stateProp =   self._binder:GetValue('stateProp')  
  self.rawImgIcon = self:AddBaseCom( GameRawImage ,'rawImgIcon')
  self.labNum1 = self:AddBaseCom( GameUIText ,'labNum1')
  self.labNum2 = self:AddBaseCom( GameUIText ,'labNum2')
  self.roleAwakeRedpoint =   self._binder:GetValue('roleAwakeRedpoint')  
  self.btnMask = self:AddBaseCom( GameUIImage ,'btnMask')
  self.stateNum =   self._binder:GetValue('stateNum')  
  self.stateBtn =   self._binder:GetValue('stateBtn')  
  self.labLock = self:AddBaseCom( GameUIText ,'labLock')


end

return UIAwakeView
---自动生成代码----end----