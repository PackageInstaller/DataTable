---自动生成代码----start----
local RestaurantCookItemPfbMidView = BaseClass( 'RestaurantCookItemPfbMidView' , BaseView )
local M = RestaurantCookItemPfbMidView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.tf =   self._binder:GetValue('tf')  
  self.btnTips = self:AddBaseCom( UIButton ,'btnTips')


end

return RestaurantCookItemPfbMidView
---自动生成代码----end----