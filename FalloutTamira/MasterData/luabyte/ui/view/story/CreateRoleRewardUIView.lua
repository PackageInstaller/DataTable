---自动生成代码----start----
local CreateRoleRewardUIView = BaseClass( 'CreateRoleRewardUIView' , BaseView )
local M = CreateRoleRewardUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')
  self.btn_confirm =   self._binder:GetValue('btn_confirm')  


end

return CreateRoleRewardUIView
---自动生成代码----end----