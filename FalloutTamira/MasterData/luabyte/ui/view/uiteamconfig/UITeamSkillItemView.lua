---自动生成代码----start----
local UITeamSkillItemView = BaseClass( 'UITeamSkillItemView' , BaseView )
local M = UITeamSkillItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.labLv = self:AddBaseCom( GameUIText ,'labLv')
  self.btn = self:AddBaseCom( GameUIImage ,'btn')
  self.tfAddSkill =   self._binder:GetValue('tfAddSkill')  
  self.tfNodeLevel =   self._binder:GetValue('tfNodeLevel')  


end

return UITeamSkillItemView
---自动生成代码----end----