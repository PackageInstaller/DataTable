---自动生成代码----start----
local EncounterStageUIView = BaseClass( 'EncounterStageUIView' , BaseView )
local M = EncounterStageUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_zoneIcon = self:AddBaseCom( GameUIImage ,'img_zoneIcon')
  self.txt_zoneName = self:AddBaseCom( GameUIText ,'txt_zoneName')
  self.txt_zoneDesc = self:AddBaseCom( GameUIText ,'txt_zoneDesc')
  self.btn_ready =   self._binder:GetValue('btn_ready')  
  self.btn_tips =   self._binder:GetValue('btn_tips')  
  self.txt_seasonEntry = self:AddBaseCom( GameUIText ,'txt_seasonEntry')
  self.zomeItem =   self:AddValue('UI.Ctrl.Mission.EncounteZoneItemCtrl','UI.View.Mission.EncounteZoneItemView','zomeItem')  
  self.routeA =   self:AddValue('UI.Ctrl.Mission.EncounterStageABItemCtrl','UI.View.Mission.EncounterStageABItemView','routeA')  
  self.routeB =   self:AddValue('UI.Ctrl.Mission.EncounterStageABItemCtrl','UI.View.Mission.EncounterStageABItemView','routeB')  
  self.txt_seasonEntryDes = self:AddBaseCom( GameUIText ,'txt_seasonEntryDes')
  self.txt_recommandLv = self:AddBaseCom( GameUIText ,'txt_recommandLv')
  self.trans_lv =   self._binder:GetValue('trans_lv')  
  self.entryArea =   self._binder:GetValue('entryArea')  
  self.btn_Encounter = self:AddBaseCom( UINewButton ,'btn_Encounter')
  self.btn_EncounterExit = self:AddBaseCom( UINewButton ,'btn_EncounterExit')
  self.garrisonItem1 =   self:AddValue('','UI.View.ComRoom.JourneyHeroItemView','garrisonItem1')  
  self.garrisonItem2 =   self:AddValue('','UI.View.ComRoom.JourneyHeroItemView','garrisonItem2')  
  self.garrisonItem3 =   self:AddValue('','UI.View.ComRoom.JourneyHeroItemView','garrisonItem3')  
  self.garrisonItem4 =   self:AddValue('','UI.View.ComRoom.JourneyHeroItemView','garrisonItem4')  
  self.garrisonItem5 =   self:AddValue('','UI.View.ComRoom.JourneyHeroItemView','garrisonItem5')  
  self.garrisonItem6 =   self:AddValue('','UI.View.ComRoom.JourneyHeroItemView','garrisonItem6')  
  self.garrsionState =   self._binder:GetValue('garrsionState')  


end

return EncounterStageUIView
---自动生成代码----end----