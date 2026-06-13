---自动生成代码----start----
local MonthCardRewardUIView = BaseClass( 'MonthCardRewardUIView' , BaseView )
local M = MonthCardRewardUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.rectClose =   self._binder:GetValue('rectClose')  
  self.txtRemainDays = self:AddBaseCom( GameUIText ,'txtRemainDays')


end

return MonthCardRewardUIView
---自动生成代码----end----