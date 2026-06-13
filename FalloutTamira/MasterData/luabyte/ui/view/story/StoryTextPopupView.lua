---自动生成代码----start----
local StoryTextPopupView = BaseClass( 'StoryTextPopupView' , BaseView )
local M = StoryTextPopupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uiState =   self._binder:GetValue('uiState')  
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.btn_confirm = self:AddBaseCom( UINewButton ,'btn_confirm')
  self.btn_mask =   self._binder:GetValue('btn_mask')  


end

return StoryTextPopupView
---自动生成代码----end----