---自动生成代码----start----
local RoleBaseInfoView = BaseClass( 'RoleBaseInfoView' , BaseView )
local M = RoleBaseInfoView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rareImg = self:AddBaseCom( GameUIImage ,'rareImg')
  self.proImg = self:AddBaseCom( GameUIImage ,'proImg')
  self.enName = self:AddBaseCom( GameUIText ,'enName')
  self.chName = self:AddBaseCom( GameUIText ,'chName')
  self.curLv = self:AddBaseCom( GameUIText ,'curLv')
  self.limitLv = self:AddBaseCom( GameUIText ,'limitLv')
  self.breakStars =   self._binder:GetValue('breakStars')  
  self.awakeStars =   self._binder:GetValue('awakeStars')  
  self.uplvBtn =   self._binder:GetValue('uplvBtn')  
  self.breakBtn =   self._binder:GetValue('breakBtn')  
  self.awakeBtn =   self._binder:GetValue('awakeBtn')  
  self.infoBtn =   self._binder:GetValue('infoBtn')  
  self.attrBtn =   self._binder:GetValue('attrBtn')  
  self.attackType0 =   self._binder:GetValue('attackType0')  
  self.attackType1 =   self._binder:GetValue('attackType1')  
  self.attackType2 =   self._binder:GetValue('attackType2')  
  self.attackTypeName0 = self:AddBaseCom( GameUIText ,'attackTypeName0')
  self.attackTypeName1 = self:AddBaseCom( GameUIText ,'attackTypeName1')
  self.attackTypeName2 = self:AddBaseCom( GameUIText ,'attackTypeName2')
  self.m_animator =   self._binder:GetValue('m_animator')  
  self.starGroup =   self:AddValue('UI.Ctrl.RoleDevelop.RoleDevelopBaseInfoStarGroupCtrl','UI.View.RoleDevelop.RoleDevelopBaseInfoStarGroup','starGroup')  
  self.costItem =   self._binder:GetValue('costItem')  
  self.Attr1 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr1')  
  self.Attr2 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr2')  
  self.Attr3 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr3')  
  self.Attr4 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr4')  
  self.Attr5 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr5')  
  self.Attr6 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr6')  
  self.Attr7 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr7')  
  self.Attr8 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr8')  


end

return RoleBaseInfoView
---自动生成代码----end----