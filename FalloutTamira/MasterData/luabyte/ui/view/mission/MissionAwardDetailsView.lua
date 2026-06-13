---自动生成代码----start----
local MissionAwardDetailsView = BaseClass( 'MissionAwardDetailsView' , BaseView )
local M = MissionAwardDetailsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.backBtn =   self._binder:GetValue('backBtn')  
  self.firstGo =   self._binder:GetValue('firstGo')  
  self.normalGo =   self._binder:GetValue('normalGo')  
  self.randomGo =   self._binder:GetValue('randomGo')  
  self.firstItem =   self:AddValue('','UI.View.Mission.MissionAwardDetailsItemView','firstItem')  
  self.normalItem =   self:AddValue('','UI.View.Mission.MissionAwardDetailsItemView','normalItem')  
  self.randomItem =   self:AddValue('','UI.View.Mission.MissionAwardDetailsItemView','randomItem')  
  self.titleTips =   self._binder:GetValue('titleTips')  
  self.txt_first = self:AddBaseCom( GameUIText ,'txt_first')
  self.txt_normal = self:AddBaseCom( GameUIText ,'txt_normal')
  self.txt_random = self:AddBaseCom( GameUIText ,'txt_random')


end

return MissionAwardDetailsView
---自动生成代码----end----