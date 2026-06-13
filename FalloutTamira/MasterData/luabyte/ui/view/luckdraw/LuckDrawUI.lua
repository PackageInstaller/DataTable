---自动生成代码----start----
local LuckDrawUI = BaseClass( 'LuckDrawUI' , BaseView )
local M = LuckDrawUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tsBtn_once = self:AddBaseCom( TSButton ,'tsBtn_once')
  self.tsBtn_ten = self:AddBaseCom( TSButton ,'tsBtn_ten')
  self.ProbabilityBtn =   self._binder:GetValue('ProbabilityBtn')  
  self.trans_consume1 =   self._binder:GetValue('trans_consume1')  
  self.trans_consume2 =   self._binder:GetValue('trans_consume2')  


end

return LuckDrawUI
---自动生成代码----end----