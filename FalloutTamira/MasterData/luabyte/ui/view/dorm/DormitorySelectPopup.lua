---自动生成代码----start----
local DormitorySelectPopup = BaseClass( 'DormitorySelectPopup' , BaseView )
local M = DormitorySelectPopup 
--desc

function M:__init(go)
  local trans = go.transform 
  self.HeroItem =   self:AddValue('','UI.View.Dorm.DormItem','HeroItem')  
  self.Content =   self._binder:GetValue('Content')  


end

return DormitorySelectPopup
---自动生成代码----end----