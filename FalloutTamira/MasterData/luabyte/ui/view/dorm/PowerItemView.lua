---自动生成代码----start----
local PowerItemView = BaseClass( 'PowerItemView' , BaseView )
local M = PowerItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.DesText = self:AddBaseCom( GameUIText ,'DesText')
  self.PowerText = self:AddBaseCom( GameUIText ,'PowerText')
  self.CanvansGroup =   self._binder:GetValue('CanvansGroup')  


end

return PowerItemView
---自动生成代码----end----