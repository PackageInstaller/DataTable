---自动生成代码----start----
local PlotReviewChapterItemView = BaseClass( 'PlotReviewChapterItemView' , BaseView )
local M = PlotReviewChapterItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_enter =   self._binder:GetValue('btn_enter')  
  self.img_icon = self:AddBaseCom( GameRawImage ,'img_icon')
  self.txt_enName = self:AddBaseCom( GameUIText ,'txt_enName')
  self.txt_index = self:AddBaseCom( GameUIText ,'txt_index')
  self.txt_chName = self:AddBaseCom( GameUIText ,'txt_chName')
  self.txt_enTitle = self:AddBaseCom( GameUIText ,'txt_enTitle')
  self.img_prog = self:AddBaseCom( GameUIImage ,'img_prog')
  self.txt_prog = self:AddBaseCom( GameUIText ,'txt_prog')
  self.redPoint =   self._binder:GetValue('redPoint')  


end

return PlotReviewChapterItemView
---自动生成代码----end----