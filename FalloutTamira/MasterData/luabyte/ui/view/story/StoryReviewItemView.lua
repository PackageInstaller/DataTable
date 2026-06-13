---自动生成代码----start----
local StoryReviewItemView = BaseClass( 'StoryReviewItemView' , BaseView )
local M = StoryReviewItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtName = self:AddBaseCom( GameUIText ,'txtName')
  self.txtDialogue = self:AddBaseCom( EmojiText ,'txtDialogue')
  self.layoutItem =   self._binder:GetValue('layoutItem')  
  self.fitterItem =   self._binder:GetValue('fitterItem')  


end

return StoryReviewItemView
---自动生成代码----end----