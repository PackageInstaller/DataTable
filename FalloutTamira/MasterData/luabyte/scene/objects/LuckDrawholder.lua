---自动生成代码----start----
local LuckDrawholder = BaseClass( 'LuckDrawholder' , BaseView )
local M = LuckDrawholder 
--desc

function M:__init(go)
  local trans = go.transform 
  self.luckDrawTimeLine =   self._binder:GetValue('luckDrawTimeLine')  
  self.luckDrawCtrl =   self._binder:GetValue('luckDrawCtrl')  
  self.GiftBox_end =   self._binder:GetValue('GiftBox_end')  
  self.GiftBox_return =   self._binder:GetValue('GiftBox_return')  


end

return LuckDrawholder
---自动生成代码----end----