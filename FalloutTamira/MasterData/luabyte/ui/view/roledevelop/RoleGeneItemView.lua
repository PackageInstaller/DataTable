---自动生成代码----start----
local RoleGeneItemView = BaseClass( 'RoleGeneItemView' , BaseView )
local M = RoleGeneItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.star =   self._binder:GetValue('star')  
  self.redPoint =   self._binder:GetValue('redPoint')  
  self.tfSelect =   self._binder:GetValue('tfSelect')  
  self.imgBg = self:AddBaseCom( GameUIImage ,'imgBg')


end

return RoleGeneItemView
---自动生成代码----end----