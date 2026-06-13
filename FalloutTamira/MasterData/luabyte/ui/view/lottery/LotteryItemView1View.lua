---自动生成代码----start----
local LotteryItemView1View = BaseClass( 'LotteryItemView1View' , BaseView )
local M = LotteryItemView1View 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ssrCountTf = self:AddBaseCom( GameUIText ,'ssrCountTf')
  self.ssrNeedTime = self:AddBaseCom( GameUIText ,'ssrNeedTime')
  self.drawTimes = self:AddBaseCom( GameUIText ,'drawTimes')


end

return LotteryItemView1View
---自动生成代码----end----