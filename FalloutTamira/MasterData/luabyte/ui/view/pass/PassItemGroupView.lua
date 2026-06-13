---自动生成代码----start----
local PassItemGroupView = BaseClass( 'PassItemGroupView' , BaseView )
local M = PassItemGroupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_passLv = self:AddBaseCom( GameUIText ,'txt_passLv')
  self.itemPfb =   self:AddValue('UI.Ctrl.Pass.PassRewardGroupItemCtrl','UI.View.Pass.PassRewardGroupItemView','itemPfb')  


end

return PassItemGroupView
---自动生成代码----end----