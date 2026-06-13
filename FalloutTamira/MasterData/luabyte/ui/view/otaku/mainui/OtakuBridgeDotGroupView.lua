---自动生成代码----start----
local OtakuBridgeDotGroupView = BaseClass( 'OtakuBridgeDotGroupView' , BaseView )
local M = OtakuBridgeDotGroupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.slider = self:AddBaseCom( UISlider ,'slider')
  self.state =   self._binder:GetValue('state')  


end

return OtakuBridgeDotGroupView
---自动生成代码----end----