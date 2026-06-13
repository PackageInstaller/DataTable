---自动生成代码----start----
local UIDetailView = BaseClass( 'UIDetailView' , BaseView )
local M = UIDetailView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labDesc = self:AddBaseCom( GameUIText ,'labDesc')
  self.uiState =   self._binder:GetValue('uiState')  


end

return UIDetailView
---自动生成代码----end----