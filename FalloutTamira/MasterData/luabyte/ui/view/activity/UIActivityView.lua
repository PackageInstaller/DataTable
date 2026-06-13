---自动生成代码----start----
local UIActivityView = BaseClass( 'UIActivityView' , BaseView )
local M = UIActivityView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')


end

return UIActivityView
---自动生成代码----end----