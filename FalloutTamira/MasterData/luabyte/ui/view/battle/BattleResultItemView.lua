---自动生成代码----start----
local BattleResultItemView = BaseClass( 'BattleResultItemView' , BaseView )
local M = BattleResultItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.text = self:AddBaseCom( GameUIText ,'text')
  self.btn =   self._binder:GetValue('btn')  


end

return BattleResultItemView
---自动生成代码----end----