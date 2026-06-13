---自动生成代码----start----
local OtakuChooseHeroItemView = BaseClass( 'OtakuChooseHeroItemView' , BaseView )
local M = OtakuChooseHeroItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.stateItem =   self._binder:GetValue('stateItem')  
  self.stateAddition =   self._binder:GetValue('stateAddition')  
  self.imgHero = self:AddBaseCom( GameUIImage ,'imgHero')
  self.txtHero = self:AddBaseCom( GameUIText ,'txtHero')
  self.txtSkill1 = self:AddBaseCom( GameUIText ,'txtSkill1')
  self.txtSkill2 = self:AddBaseCom( GameUIText ,'txtSkill2')
  self.txtRoomName = self:AddBaseCom( GameUIText ,'txtRoomName')
  self.txtRoomIndex = self:AddBaseCom( GameUIText ,'txtRoomIndex')
  self.stateSatiety =   self._binder:GetValue('stateSatiety')  
  self.sbarSatiety =   self._binder:GetValue('sbarSatiety')  
  self.stateSkill1 =   self._binder:GetValue('stateSkill1')  
  self.stateSkill2 =   self._binder:GetValue('stateSkill2')  
  self.skillIcon1 = self:AddBaseCom( GameUIImage ,'skillIcon1')
  self.skillIcon2 = self:AddBaseCom( GameUIImage ,'skillIcon2')
  self.typeState =   self._binder:GetValue('typeState')  
  self.skillLevelText = self:AddBaseCom( GameUIText ,'skillLevelText')
  self.SelectState =   self._binder:GetValue('SelectState')  


end

return OtakuChooseHeroItemView
---自动生成代码----end----