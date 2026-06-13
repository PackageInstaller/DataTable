---自动生成代码----start----
local AchievementDetailView = BaseClass( 'AchievementDetailView' , BaseView )
local M = AchievementDetailView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.barText = self:AddBaseCom( GameUIText ,'barText')
  self.bar =   self._binder:GetValue('bar')  
  self.barValue = self:AddBaseCom( GameUIText ,'barValue')
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.scrollView = self:AddBaseCom( CircularScrollView ,'scrollView')
  self.barLine =   self._binder:GetValue('barLine')  


end

return AchievementDetailView
---自动生成代码----end----