---自动生成代码----start----
local PlotAtlasProgressUIView = BaseClass( 'PlotAtlasProgressUIView' , BaseView )
local M = PlotAtlasProgressUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_back =   self._binder:GetValue('btn_back')  
  self.node_list = self:AddBaseCom( CircularScrollView ,'node_list')
  self.txt_number = self:AddBaseCom( GameUIText ,'txt_number')
  self.txt_cond = self:AddBaseCom( GameUIText ,'txt_cond')
  self.txt_enName = self:AddBaseCom( GameUIText ,'txt_enName')
  self.txt_cnName = self:AddBaseCom( GameUIText ,'txt_cnName')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.btn_info =   self._binder:GetValue('btn_info')  
  self.node_uiState =   self._binder:GetValue('node_uiState')  
  self.img_picture = self:AddBaseCom( GameRawImage ,'img_picture')
  self.txt_title = self:AddBaseCom( GameUIText ,'txt_title')


end

return PlotAtlasProgressUIView
---自动生成代码----end----