---自动生成代码----start----
local RoleListView = BaseClass( 'RoleListView' , BaseView )
local M = RoleListView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnOpen = self:AddBaseCom( UIButton ,'btnOpen')
  self.btnClose = self:AddBaseCom( UIButton ,'btnClose')
  self.grid1 = self:AddBaseCom( CircularScrollView ,'grid1')
  self.grid2 = self:AddBaseCom( CircularScrollView ,'grid2')
  self.tf1 =   self._binder:GetValue('tf1')  
  self.tf2 =   self._binder:GetValue('tf2')  
  self.tabList =   self._binder:GetValue('tabList')  


end

return RoleListView
---自动生成代码----end----