---自动生成代码----start----
local MainPreheatSupplyItemView = BaseClass( 'MainPreheatSupplyItemView' , BaseView )
local M = MainPreheatSupplyItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_buy = self:AddBaseCom( GameUIImage ,'btn_buy')
  self.rectSellOut =   self._binder:GetValue('rectSellOut')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_num = self:AddBaseCom( GameUIText ,'txt_num')
  self.rectDiscount =   self._binder:GetValue('rectDiscount')  
  self.txt_discount = self:AddBaseCom( GameUIText ,'txt_discount')
  self.txt_timesL = self:AddBaseCom( GameUIText ,'txt_timesL')
  self.txt_timesR = self:AddBaseCom( GameUIText ,'txt_timesR')
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.quality =   self._binder:GetValue('quality')  
  self.img_costIcon = self:AddBaseCom( GameUIImage ,'img_costIcon')
  self.txt_costNum = self:AddBaseCom( GameUIText ,'txt_costNum')


end

return MainPreheatSupplyItemView
---自动生成代码----end----