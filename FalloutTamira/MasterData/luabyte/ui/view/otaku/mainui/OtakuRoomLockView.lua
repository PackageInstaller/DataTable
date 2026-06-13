---自动生成代码----start----
local OtakuRoomLockView = BaseClass( 'OtakuRoomLockView' , BaseView )
local M = OtakuRoomLockView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state =   self._binder:GetValue('state')  
  self.text = self:AddBaseCom( GameUIText ,'text')


end

return OtakuRoomLockView
---自动生成代码----end----