---自动生成代码----start----
local LotteryTypeItemView2 = BaseClass( 'LotteryTypeItemView2' , BaseView )
local M = LotteryTypeItemView2 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ssrCountTf = self:AddBaseCom( GameUIText ,'ssrCountTf')
  self.TipsBg =   self._binder:GetValue('TipsBg')  
  self.SsrLogo = self:AddBaseCom( GameUIImage ,'SsrLogo')


end

return LotteryTypeItemView2
---自动生成代码----end----