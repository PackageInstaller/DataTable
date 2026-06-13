---自动生成代码----start----
local LotteryRecordCell = BaseClass( 'LotteryRecordCell' , BaseView )
local M = LotteryRecordCell 
--desc

function M:__init(go)
  local trans = go.transform 
  self.time = self:AddBaseCom( GameUIText ,'time')
  self.poolName = self:AddBaseCom( GameUIText ,'poolName')
  self.item = self:AddBaseCom( GameUIText ,'item')
  self.State =   self._binder:GetValue('State')  
  self.New = self:AddBaseCom( GameUIImage ,'New')


end

return LotteryRecordCell
---自动生成代码----end----