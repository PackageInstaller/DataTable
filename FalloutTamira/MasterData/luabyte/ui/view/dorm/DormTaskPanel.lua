---自动生成代码----start----
local DormTaskPanel = BaseClass( 'DormTaskPanel' , BaseView )
local M = DormTaskPanel 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Task = self:AddBaseCom( GameUIImage ,'Task')
  self.ContentText = self:AddBaseCom( GameUIText ,'ContentText')
  self.ExpSlider = self:AddBaseCom( UISlider ,'ExpSlider')
  self.Number = self:AddBaseCom( GameUIText ,'Number')
  self.RedPoint =   self._binder:GetValue('RedPoint')  


end

return DormTaskPanel
---自动生成代码----end----