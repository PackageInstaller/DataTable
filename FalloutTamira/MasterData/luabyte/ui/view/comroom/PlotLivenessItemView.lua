---自动生成代码----start----
local PlotLivenessItemView = BaseClass( 'PlotLivenessItemView' , BaseView )
local M = PlotLivenessItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_subs =   self._binder:GetValue('btn_subs')  
  self.btn_finish =   self._binder:GetValue('btn_finish')  
  self.btn_award =   self._binder:GetValue('btn_award')  
  self.txt_value = self:AddBaseCom( GameUIText ,'txt_value')
  self.img_subs = self:AddBaseCom( GameUIImage ,'img_subs')
  self.img_finish = self:AddBaseCom( GameUIImage ,'img_finish')
  self.img_award = self:AddBaseCom( GameUIImage ,'img_award')


end

return PlotLivenessItemView
---自动生成代码----end----