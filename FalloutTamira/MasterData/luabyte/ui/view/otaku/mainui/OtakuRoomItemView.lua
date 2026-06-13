---自动生成代码----start----
local OtakuRoomItemView = BaseClass( 'OtakuRoomItemView' , BaseView )
local M = OtakuRoomItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.roomState =   self._binder:GetValue('roomState')  
  self.typeState =   self._binder:GetValue('typeState')  
  self.numState =   self._binder:GetValue('numState')  
  self.upPanel =   self._binder:GetValue('upPanel')  
  self.numText = self:AddBaseCom( GameUIText ,'numText')
  self.maxText = self:AddBaseCom( GameUIText ,'maxText')
  self.lockItem =   self:AddValue('','UI.View.Otaku.MainUI.OtakuRoomLockView','lockItem')  
  self.barImage = self:AddBaseCom( GameUIImage ,'barImage')
  self.dotList =   self:AddValue('UI.Ctrl.Otaku.OtakuBridgeDotGroupCtrl','UI.View.Otaku.MainUI.OtakuBridgeDotGroupView','dotList')  
  self.buildBtn =   self._binder:GetValue('buildBtn')  
  self.name = self:AddBaseCom( GameUIText ,'name')
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.roleNumItem =   self._binder:GetValue('roleNumItem')  
  self.itemIcon = self:AddBaseCom( GameUIImage ,'itemIcon')


end

return OtakuRoomItemView
---自动生成代码----end----