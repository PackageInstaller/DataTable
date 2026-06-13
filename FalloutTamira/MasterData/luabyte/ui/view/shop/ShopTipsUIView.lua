---自动生成代码----start----
local ShopTipsUIView = BaseClass( 'ShopTipsUIView' , BaseView )
local M = ShopTipsUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectBgClose =   self._binder:GetValue('rectBgClose')  
  self.rectClose =   self._binder:GetValue('rectClose')  
  self.txtContent = self:AddBaseCom( GameUIText ,'txtContent')
  self.txtTitle = self:AddBaseCom( GameUIText ,'txtTitle')


end

return ShopTipsUIView
---自动生成代码----end----