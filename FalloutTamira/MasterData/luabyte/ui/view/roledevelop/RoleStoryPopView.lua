---自动生成代码----start----
local RoleStoryPopView = BaseClass( 'RoleStoryPopView' , BaseView )
local M = RoleStoryPopView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Mask =   self._binder:GetValue('Mask')  
  self.Title = self:AddBaseCom( GameUIText ,'Title')
  self.Text = self:AddBaseCom( GameUIText ,'Text')
  self.TextContent =   self._binder:GetValue('TextContent')  
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.Btn_Home = self:AddBaseCom( UIButton ,'Btn_Home')
  self.itemPfb =   self._binder:GetValue('itemPfb')  


end

return RoleStoryPopView
---自动生成代码----end----