---自动生成代码----start----
local UISkillClassView = BaseClass( 'UISkillClassView' , BaseView )
local M = UISkillClassView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labSkillLv = self:AddBaseCom( GameUIText ,'labSkillLv')
  self.uiState =   self._binder:GetValue('uiState')  
  self.labLockTips = self:AddBaseCom( GameUIText ,'labLockTips')
  self.btn = self:AddBaseCom( GameUIImage ,'btn')


end

return UISkillClassView
---自动生成代码----end----