---自动生成代码----start----
local BridgeUpgradeItemView = BaseClass( 'BridgeUpgradeItemView' , BaseView )
local M = BridgeUpgradeItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.img_nowLv1 = self:AddBaseCom( GameUIImage ,'img_nowLv1')
  self.img_nowLv2 = self:AddBaseCom( GameUIImage ,'img_nowLv2')
  self.img_nextLv1 = self:AddBaseCom( GameUIImage ,'img_nextLv1')
  self.img_nextLv2 = self:AddBaseCom( GameUIImage ,'img_nextLv2')


end

return BridgeUpgradeItemView
---自动生成代码----end----