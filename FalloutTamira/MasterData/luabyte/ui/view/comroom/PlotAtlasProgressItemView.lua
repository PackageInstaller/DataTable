---自动生成代码----start----
local PlotAtlasProgressItemView = BaseClass( 'PlotAtlasProgressItemView' , BaseView )
local M = PlotAtlasProgressItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.node_lock =   self._binder:GetValue('node_lock')  
  self.btn_enter =   self._binder:GetValue('btn_enter')  
  self.node_select =   self._binder:GetValue('node_select')  
  self.redPoint =   self._binder:GetValue('redPoint')  


end

return PlotAtlasProgressItemView
---自动生成代码----end----