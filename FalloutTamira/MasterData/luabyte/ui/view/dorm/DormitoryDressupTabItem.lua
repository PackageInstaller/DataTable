---自动生成代码----start----
local DormitoryDressupTabItem = BaseClass( 'DormitoryDressupTabItem' , BaseView )
local M = DormitoryDressupTabItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ClickTarget =   self._binder:GetValue('ClickTarget')  
  self.Text = self:AddBaseCom( GameUIText ,'Text')
  self.UIState =   self._binder:GetValue('UIState')  
  self.Redpoint =   self._binder:GetValue('Redpoint')  


end

return DormitoryDressupTabItem
---自动生成代码----end----