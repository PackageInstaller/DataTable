---自动生成代码----start----
local ChoppingBlock = BaseClass( 'ChoppingBlock' , BaseView )
local M = ChoppingBlock 
--desc

function M:__init(go)
  local trans = go.transform 
  self.spr =   self._binder:GetValue('spr')  
  self.toucher =   self._binder:GetValue('toucher')  
  self.knifeAnim =   self._binder:GetValue('knifeAnim')  
  self.knifeEffect =   self._binder:GetValue('knifeEffect')  


end

return ChoppingBlock
---自动生成代码----end----