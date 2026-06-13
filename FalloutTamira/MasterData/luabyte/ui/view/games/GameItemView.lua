---自动生成代码----start----
local GameItemView = BaseClass( 'GameItemView' , BaseView )
local M = GameItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.normal = self:AddBaseCom( GameUIImage ,'normal')
  self.game =   self._binder:GetValue('game')  


end

return GameItemView
---自动生成代码----end----