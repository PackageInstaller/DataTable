---自动生成代码----start----
local ComPopupMopUpTipsView = BaseClass( 'ComPopupMopUpTipsView' , BaseView )
local M = ComPopupMopUpTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.node_content =   self._binder:GetValue('node_content')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')


end

return ComPopupMopUpTipsView
---自动生成代码----end----