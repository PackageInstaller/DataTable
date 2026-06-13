---自动生成代码----start----
local RoleSkillUIView = BaseClass( 'RoleSkillUIView' , BaseView )
local M = RoleSkillUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.toggleGroup = self:AddBaseCom( UIToggleGroup ,'toggleGroup')
  self.defultTg = self:AddBaseCom( UIToggle ,'defultTg')
  self.atkSkill =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','atkSkill')  
  self.awakeSkill =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','awakeSkill')  
  self.battleSkill1 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','battleSkill1')  
  self.battleSkill2 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','battleSkill2')  
  self.battleSkill3 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','battleSkill3')  
  self.battleSkill4 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','battleSkill4')  
  self.battleSkill5 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','battleSkill5')  
  self.battleSkill6 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','battleSkill6')  
  self.battleSkill7 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','battleSkill7')  
  self.levelUpBtn =   self._binder:GetValue('levelUpBtn')  
  self.battleSkill8 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','battleSkill8')  
  self.battleSkill9 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','battleSkill9')  
  self.tfTips =   self._binder:GetValue('tfTips')  
  self.labTipsLv = self:AddBaseCom( GameUIText ,'labTipsLv')
  self.atkOtaku1 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','atkOtaku1')  
  self.atkOtaku2 =   self:AddValue('UI.Ctrl.RoleDevelop.RoleSkillItemCtrl','UI.View.RoleDevelop.RoleSkillItemView','atkOtaku2')  
  self.labSkillLv = self:AddBaseCom( GameUIText ,'labSkillLv')
  self.stateBtn =   self._binder:GetValue('stateBtn')  
  self.labLocked = self:AddBaseCom( GameUIText ,'labLocked')
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.imgQuality = self:AddBaseCom( GameUIImage ,'imgQuality')


end

return RoleSkillUIView
---自动生成代码----end----