---自动生成代码----start----
local SelfChatItemView = BaseClass( 'SelfChatItemView' , BaseView )
local M = SelfChatItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtSelfDialogue = self:AddBaseCom( GameUIText ,'txtSelfDialogue')


end

return SelfChatItemView
---自动生成代码----end----