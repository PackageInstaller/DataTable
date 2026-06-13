---自动生成代码----start----
local MainPreheatSupplyUIView = BaseClass( 'MainPreheatSupplyUIView' , BaseView )
local M = MainPreheatSupplyUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')
  self.btn_back = self:AddBaseCom( GameUIImage ,'btn_back')
  self.currency =   self._binder:GetValue('currency')  


end

return MainPreheatSupplyUIView
---自动生成代码----end----