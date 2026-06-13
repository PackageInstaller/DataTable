---自动生成代码----start----
local PlotAtlasDrawPopupView = BaseClass( 'PlotAtlasDrawPopupView' , BaseView )
local M = PlotAtlasDrawPopupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_back =   self._binder:GetValue('btn_back')  
  self.node_list = self:AddBaseCom( CircularScrollView ,'node_list')
  self.drawItem =   self._binder:GetValue('drawItem')  
  self.btn_left =   self._binder:GetValue('btn_left')  
  self.btn_right =   self._binder:GetValue('btn_right')  


end

return PlotAtlasDrawPopupView
---自动生成代码----end----