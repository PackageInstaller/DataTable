---自动生成代码----start----
local AchievementContentItemView = BaseClass( 'AchievementContentItemView' , BaseView )
local M = AchievementContentItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.name = self:AddBaseCom( GameUIText ,'name')
  self.desc = self:AddBaseCom( GameUIText ,'desc')
  self.reward1 =   self:AddValue('','UI.View.Achievement.AchievementRewardView','reward1')  
  self.reward2 =   self:AddValue('','UI.View.Achievement.AchievementRewardView','reward2')  
  self.rewardBtn =   self._binder:GetValue('rewardBtn')  
  self.state0 =   self._binder:GetValue('state0')  
  self.state1 =   self._binder:GetValue('state1')  
  self.state2 =   self._binder:GetValue('state2')  
  self.num = self:AddBaseCom( GameUIText ,'num')
  self.day = self:AddBaseCom( GameUIText ,'day')


end

return AchievementContentItemView
---自动生成代码----end----