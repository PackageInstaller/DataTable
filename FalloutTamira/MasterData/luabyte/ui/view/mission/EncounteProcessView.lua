---自动生成代码----start----
local EncounteProcessView = BaseClass( 'EncounteProcessView' , BaseView )
local M = EncounteProcessView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.trans_clear =   self._binder:GetValue('trans_clear')  
  self.trans_unclear =   self._binder:GetValue('trans_unclear')  
  self.trans_leftPass =   self._binder:GetValue('trans_leftPass')  
  self.trans_righPass =   self._binder:GetValue('trans_righPass')  


end

return EncounteProcessView
---自动生成代码----end----