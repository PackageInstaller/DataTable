---自动生成代码----start----
local UIAttrView = BaseClass( 'UIAttrView' , BaseView )
local M = UIAttrView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labNum1 = self:AddBaseCom( GameUIText ,'labNum1')
  self.labNum2 = self:AddBaseCom( GameUIText ,'labNum2')
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.tfAdd =   self._binder:GetValue('tfAdd')  


end

return UIAttrView
---自动生成代码----end----