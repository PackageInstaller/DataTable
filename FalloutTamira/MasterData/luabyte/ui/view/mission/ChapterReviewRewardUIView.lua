---自动生成代码----start----
local ChapterReviewRewardUIView = BaseClass( 'ChapterReviewRewardUIView' , BaseView )
local M = ChapterReviewRewardUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.title = self:AddBaseCom( GameUIText ,'title')
  self.tips = self:AddBaseCom( GameUIText ,'tips')
  self.itemPfb =   self._binder:GetValue('itemPfb')  
  self.getBtn =   self._binder:GetValue('getBtn')  
  self.recivedTag =   self._binder:GetValue('recivedTag')  
  self.closeBtn =   self._binder:GetValue('closeBtn')  


end

return ChapterReviewRewardUIView
---自动生成代码----end----