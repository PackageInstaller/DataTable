---自动生成代码----start----
local WishjourneySelectItemView = BaseClass( 'WishjourneySelectItemView' , BaseView )
local M = WishjourneySelectItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ScrollView = self:AddBaseCom( CircularScrollView ,'ScrollView')
  self.ok =   self._binder:GetValue('ok')  
  self.mask =   self._binder:GetValue('mask')  


end

return WishjourneySelectItemView
---自动生成代码----end----