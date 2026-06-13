---自动生成代码----start----
local RoleSkillItemView = BaseClass( 'RoleSkillItemView' , BaseView )
local M = RoleSkillItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.skillName = self:AddBaseCom( GameUIText ,'skillName')
  self.skillLv = self:AddBaseCom( GameUIText ,'skillLv')
  self.toggle = self:AddBaseCom( UIToggle ,'toggle')
  self.tfTips =   self._binder:GetValue('tfTips')  
  self.tfLock =   self._binder:GetValue('tfLock')  


end

return RoleSkillItemView
---自动生成代码----end----