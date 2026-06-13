---自动生成代码----start----
local PlotAtlasDrawItemView = BaseClass( 'PlotAtlasDrawItemView' , BaseView )
local M = PlotAtlasDrawItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_icon = self:AddBaseCom( GameRawImage ,'img_icon')
  self.txt_chTitle1 = self:AddBaseCom( GameUIText ,'txt_chTitle1')
  self.txt_chTitle2 = self:AddBaseCom( GameUIText ,'txt_chTitle2')
  self.txt_chTitle3 = self:AddBaseCom( GameUIText ,'txt_chTitle3')
  self.txt_chTitle4 = self:AddBaseCom( GameUIText ,'txt_chTitle4')
  self.txt_chTitle5 = self:AddBaseCom( GameUIText ,'txt_chTitle5')
  self.txt_desc1 = self:AddBaseCom( GameUIText ,'txt_desc1')
  self.txt_desc3 = self:AddBaseCom( GameUIText ,'txt_desc3')
  self.txt_desc4 = self:AddBaseCom( GameUIText ,'txt_desc4')
  self.txt_desc5 = self:AddBaseCom( GameUIText ,'txt_desc5')
  self.attrItem =   self:AddValue('','UI.View.ComRoom.PlotAtlasDrawAttrItemView','attrItem')  
  self.node_attr =   self._binder:GetValue('node_attr')  
  self.node_intro =   self._binder:GetValue('node_intro')  
  self.node_info =   self._binder:GetValue('node_info')  
  self.node_anim =   self._binder:GetValue('node_anim')  


end

return PlotAtlasDrawItemView
---自动生成代码----end----