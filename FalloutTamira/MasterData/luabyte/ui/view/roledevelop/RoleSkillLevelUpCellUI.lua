---自动生成代码----start----
local RoleSkillLevelUpCellUI = BaseClass( 'RoleSkillLevelUpCellUI' , BaseView )
local M = RoleSkillLevelUpCellUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.select =   self._binder:GetValue('select')  
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.nowLevelText = self:AddBaseCom( GameUIText ,'nowLevelText')
  self.nextLevelText = self:AddBaseCom( GameUIText ,'nextLevelText')
  self.name = self:AddBaseCom( GameUIText ,'name')


end

return RoleSkillLevelUpCellUI
---自动生成代码----end----