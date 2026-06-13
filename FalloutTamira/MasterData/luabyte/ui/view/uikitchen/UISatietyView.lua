---自动生成代码----start----
local UISatietyView = BaseClass( 'UISatietyView' , BaseView )
local M = UISatietyView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uiState =   self._binder:GetValue('uiState')  
  self.labNum1 = self:AddBaseCom( GameUIText ,'labNum1')
  self.labNum2 = self:AddBaseCom( GameUIText ,'labNum2')


end

return UISatietyView
---自动生成代码----end----