---自动生成代码----start----
local DormTaskItem = BaseClass( 'DormTaskItem' , BaseView )
local M = DormTaskItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ContentText = self:AddBaseCom( GameUIText ,'ContentText')
  self.ExpSlider = self:AddBaseCom( GameUIImage ,'ExpSlider')
  self.Number = self:AddBaseCom( GameUIText ,'Number')
  self.GoBtn =   self._binder:GetValue('GoBtn')  
  self.Finished =   self._binder:GetValue('Finished')  


end

return DormTaskItem
---自动生成代码----end----