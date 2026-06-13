---自动生成代码----start----
local DormPersonalMainItemView = BaseClass( 'DormPersonalMainItemView' , BaseView )
local M = DormPersonalMainItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.img_banner = self:AddBaseCom( GameUIImage ,'img_banner')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.node_doing =   self._binder:GetValue('node_doing')  
  self.node_complete =   self._binder:GetValue('node_complete')  
  self.node_locked =   self._binder:GetValue('node_locked')  
  self.txt_index = self:AddBaseCom( GameUIText ,'txt_index')
  self.cs_gray =   self._binder:GetValue('cs_gray')  
  self.node_tipsBG =   self._binder:GetValue('node_tipsBG')  
  self.txt_tips = self:AddBaseCom( GameUIText ,'txt_tips')


end

return DormPersonalMainItemView
---自动生成代码----end----