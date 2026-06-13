---自动生成代码----start----
local DormClickStory = BaseClass( 'DormClickStory' , BaseView )
local M = DormClickStory 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_dialog =   self._binder:GetValue('txt_dialog')  


end

return DormClickStory
---自动生成代码----end----