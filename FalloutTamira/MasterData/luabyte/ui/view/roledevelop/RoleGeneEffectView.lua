---自动生成代码----start----
local RoleGeneEffectView = BaseClass( 'RoleGeneEffectView' , BaseView )
local M = RoleGeneEffectView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.effectItem =   self:AddValue('','UI.View.RoleDevelop.RoleGeneEffectItemView','effectItem')  
  self.dotItem =   self._binder:GetValue('dotItem')  


end

return RoleGeneEffectView
---自动生成代码----end----