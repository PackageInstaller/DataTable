---自动生成代码----start----
local UIRoleCoreView = BaseClass( 'UIRoleCoreView' , BaseView )
local M = UIRoleCoreView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.touchMask =   self._binder:GetValue('touchMask')  
  self.stateCore =   self._binder:GetValue('stateCore')  
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.imgNum = self:AddBaseCom( GameUIImage ,'imgNum')
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labDesc = self:AddBaseCom( EmojiText ,'labDesc')
  self.Core1 =   self:AddValue('UI.Ctrl.RoleDevelop.UICoreItemCtrl','UI.View.RoleDevelop.UICoreItemView','Core1')  
  self.Core2 =   self:AddValue('UI.Ctrl.RoleDevelop.UICoreItemCtrl','UI.View.RoleDevelop.UICoreItemView','Core2')  
  self.Core3 =   self:AddValue('UI.Ctrl.RoleDevelop.UICoreItemCtrl','UI.View.RoleDevelop.UICoreItemView','Core3')  
  self.Core4 =   self:AddValue('UI.Ctrl.RoleDevelop.UICoreItemCtrl','UI.View.RoleDevelop.UICoreItemView','Core4')  
  self.Core5 =   self:AddValue('UI.Ctrl.RoleDevelop.UICoreItemCtrl','UI.View.RoleDevelop.UICoreItemView','Core5')  
  self.Core6 =   self:AddValue('UI.Ctrl.RoleDevelop.UICoreItemCtrl','UI.View.RoleDevelop.UICoreItemView','Core6')  
  self.imgNum2 = self:AddBaseCom( GameUIImage ,'imgNum2')
  self.btnActive = self:AddBaseCom( UINewButton ,'btnActive')
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')
  self.stateIcon =   self._binder:GetValue('stateIcon')  
  self.labName2 = self:AddBaseCom( GameUIText ,'labName2')
  self.imgQuality = self:AddBaseCom( GameUIImage ,'imgQuality')


end

return UIRoleCoreView
---自动生成代码----end----