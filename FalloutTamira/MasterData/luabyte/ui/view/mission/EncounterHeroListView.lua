---自动生成代码----start----
local EncounterHeroListView = BaseClass( 'EncounterHeroListView' , BaseView )
local M = EncounterHeroListView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.scrollView = self:AddBaseCom( CircularScrollView ,'scrollView')
  self.friendScrollView = self:AddBaseCom( CircularScrollView ,'friendScrollView')
  self.myHeroList =   self._binder:GetValue('myHeroList')  
  self.friendHeroList =   self._binder:GetValue('friendHeroList')  
  self.btnRefFri = self:AddBaseCom( UIButton ,'btnRefFri')
  self.labRefTimer = self:AddBaseCom( GameUIText ,'labRefTimer')
  self.heroTab =   self._binder:GetValue('heroTab')  
  self.friendAndMineState =   self._binder:GetValue('friendAndMineState')  
  self.helpNumState =   self._binder:GetValue('helpNumState')  
  self.labHelpNum = self:AddBaseCom( GameUIText ,'labHelpNum')


end

return EncounterHeroListView
---自动生成代码----end----