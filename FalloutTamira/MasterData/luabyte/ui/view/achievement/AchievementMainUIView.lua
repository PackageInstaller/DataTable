---自动生成代码----start----
local AchievementMainUIView = BaseClass( 'AchievementMainUIView' , BaseView )
local M = AchievementMainUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.scrollView = self:AddBaseCom( CircularScrollView ,'scrollView')
  self.hideOff = self:AddBaseCom( UIToggle ,'hideOff')
  self.bar = self:AddBaseCom( GameUIImage ,'bar')
  self.barValue = self:AddBaseCom( GameUIText ,'barValue')
  self.barText = self:AddBaseCom( GameUIText ,'barText')
  self.state_receiveAll =   self._binder:GetValue('state_receiveAll')  


end

return AchievementMainUIView
---自动生成代码----end----