---自动生成代码----start----
local EncounterPlandView = BaseClass( 'EncounterPlandView' , BaseView )
local M = EncounterPlandView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.hero1 =   self:AddValue('','UI.View.Mission.EncounterPlandItemView','hero1')  
  self.hero2 =   self:AddValue('','UI.View.Mission.EncounterPlandItemView','hero2')  
  self.hero3 =   self:AddValue('','UI.View.Mission.EncounterPlandItemView','hero3')  
  self.hero4 =   self:AddValue('','UI.View.Mission.EncounterPlandItemView','hero4')  
  self.hero5 =   self:AddValue('','UI.View.Mission.EncounterPlandItemView','hero5')  
  self.hero6 =   self:AddValue('','UI.View.Mission.EncounterPlandItemView','hero6')  
  self.hero7 =   self:AddValue('','UI.View.Mission.EncounterPlandItemView','hero7')  
  self.hero8 =   self:AddValue('','UI.View.Mission.EncounterPlandItemView','hero8')  
  self.friendHero =   self:AddValue('','UI.View.Mission.EncounterPlandItemView','friendHero')  
  self.deleteBtn =   self._binder:GetValue('deleteBtn')  
  self.selected =   self._binder:GetValue('selected')  
  self.bg = self:AddBaseCom( GameUIImage ,'bg')
  self.entry1 =   self:AddValue('UI.Ctrl.Mission.EncounterStageEntryItemCtrl','UI.View.Mission.EncounterStageEntryItemView','entry1')  
  self.entry2 =   self:AddValue('UI.Ctrl.Mission.EncounterStageEntryItemCtrl','UI.View.Mission.EncounterStageEntryItemView','entry2')  
  self.entry3 =   self:AddValue('UI.Ctrl.Mission.EncounterStageEntryItemCtrl','UI.View.Mission.EncounterStageEntryItemView','entry3')  
  self.lockArea =   self._binder:GetValue('lockArea')  
  self.unlockBtn = self:AddBaseCom( GameUIImage ,'unlockBtn')


end

return EncounterPlandView
---自动生成代码----end----