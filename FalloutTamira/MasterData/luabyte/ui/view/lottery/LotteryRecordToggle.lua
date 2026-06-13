---自动生成代码----start----
local LotteryRecordToggle = BaseClass( 'LotteryRecordToggle' , BaseView )
local M = LotteryRecordToggle 
--desc

function M:__init(go)
  local trans = go.transform 
  self.checkText = self:AddBaseCom( GameUIText ,'checkText')
  self.toggleText = self:AddBaseCom( GameUIText ,'toggleText')
  self.btn =   self._binder:GetValue('btn')  
  self.check = self:AddBaseCom( GameUIImage ,'check')


end

return LotteryRecordToggle
---自动生成代码----end----