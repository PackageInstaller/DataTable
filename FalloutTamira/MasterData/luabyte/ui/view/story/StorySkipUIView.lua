---自动生成代码----start----
local StorySkipUIView = BaseClass( 'StorySkipUIView' , BaseView )
local M = StorySkipUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtTitle = self:AddBaseCom( GameUIText ,'txtTitle')
  self.txtDesc = self:AddBaseCom( GameUIText ,'txtDesc')
  self.rectConfirm =   self._binder:GetValue('rectConfirm')  
  self.rectCancel =   self._binder:GetValue('rectCancel')  


end

return StorySkipUIView
---自动生成代码----end----