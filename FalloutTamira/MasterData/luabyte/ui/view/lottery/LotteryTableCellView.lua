---自动生成代码----start----
local LotteryTableCellView = BaseClass( 'LotteryTableCellView' , BaseView )
local M = LotteryTableCellView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.BtnPV = self:AddBaseCom( GameUIImage ,'BtnPV')
  self.Background = self:AddBaseCom( GameUIImage ,'Background')
  self.StartText = self:AddBaseCom( GameUIText ,'StartText')


end

return LotteryTableCellView
---自动生成代码----end----