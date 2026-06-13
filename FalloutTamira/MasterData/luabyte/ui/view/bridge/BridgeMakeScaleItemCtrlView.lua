---自动生成代码----start----
local BridgeMakeScaleItemCtrlView = BaseClass( 'BridgeMakeScaleItemCtrlView' , BaseView )
local M = BridgeMakeScaleItemCtrlView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_left = self:AddBaseCom( GameUIText ,'txt_left')
  self.txt_right = self:AddBaseCom( GameUIText ,'txt_right')


end

return BridgeMakeScaleItemCtrlView
---自动生成代码----end----