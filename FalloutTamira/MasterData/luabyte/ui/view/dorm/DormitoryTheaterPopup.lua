---自动生成代码----start----
local DormitoryTheaterPopup = BaseClass( 'DormitoryTheaterPopup' , BaseView )
local M = DormitoryTheaterPopup 
--desc

function M:__init(go)
  local trans = go.transform 
  self.mask =   self._binder:GetValue('mask')  
  self.TaskText = self:AddBaseCom( GameUIText ,'TaskText')


end

return DormitoryTheaterPopup
---自动生成代码----end----