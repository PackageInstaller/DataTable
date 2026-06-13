---自动生成代码----start----
local BagNormalStateUI = BaseClass( 'BagNormalStateUI' , BaseView )
local M = BagNormalStateUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tab =   self._binder:GetValue('tab')  
  self.opLabelTf = self:AddBaseCom( GameUIText ,'opLabelTf')


end

return BagNormalStateUI
---自动生成代码----end----