---自动生成代码----start----
local BridgeCabinItemView = BaseClass( 'BridgeCabinItemView' , BaseView )
local M = BridgeCabinItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.txtCabin = self:AddBaseCom( GameUIText ,'txtCabin')
  self.txtNum = self:AddBaseCom( GameUIText ,'txtNum')
  self.txtLevel = self:AddBaseCom( GameUIText ,'txtLevel')
  self.txtSettle = self:AddBaseCom( GameUIText ,'txtSettle')


end

return BridgeCabinItemView
---自动生成代码----end----