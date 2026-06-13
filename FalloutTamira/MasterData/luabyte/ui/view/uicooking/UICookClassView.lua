---自动生成代码----start----
local UICookClassView = BaseClass( 'UICookClassView' , BaseView )
local M = UICookClassView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.state =   self._binder:GetValue('state')  
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')


end

return UICookClassView
---自动生成代码----end----