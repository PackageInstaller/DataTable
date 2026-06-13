---自动生成代码----start----
local OtakuSettleHeroView = BaseClass( 'OtakuSettleHeroView' , BaseView )
local M = OtakuSettleHeroView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.scrollSettle = self:AddBaseCom( CircularScrollView ,'scrollSettle')
  self.txtSettleNum = self:AddBaseCom( GameUIText ,'txtSettleNum')
  self.txtSettleMaxNum = self:AddBaseCom( GameUIText ,'txtSettleMaxNum')


end

return OtakuSettleHeroView
---自动生成代码----end----