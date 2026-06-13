---自动生成代码----start----
local MissionMonsterInfoUIView = BaseClass( 'MissionMonsterInfoUIView' , BaseView )
local M = MissionMonsterInfoUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.backBtn =   self._binder:GetValue('backBtn')  
  self.bossTag =   self._binder:GetValue('bossTag')  
  self.monName = self:AddBaseCom( GameUIText ,'monName')
  self.attackDesc = self:AddBaseCom( GameUIText ,'attackDesc')
  self.monDesc = self:AddBaseCom( GameUIText ,'monDesc')
  self.skillDesc = self:AddBaseCom( GameUIText ,'skillDesc')
  self.sliderAtk = self:AddBaseCom( UISlider ,'sliderAtk')
  self.sliderDef = self:AddBaseCom( UISlider ,'sliderDef')
  self.sliderHp = self:AddBaseCom( UISlider ,'sliderHp')
  self.sliderMdf = self:AddBaseCom( UISlider ,'sliderMdf')
  self.lvAtk = self:AddBaseCom( GameUIText ,'lvAtk')
  self.lvDef = self:AddBaseCom( GameUIText ,'lvDef')
  self.lvHp = self:AddBaseCom( GameUIText ,'lvHp')
  self.lvMdf = self:AddBaseCom( GameUIText ,'lvMdf')
  self.monItem =   self:AddValue('','UI.View.Mission.MissionMonsterInfoItemView','monItem')  
  self.monImg = self:AddBaseCom( GameRawImage ,'monImg')
  self.dayState =   self._binder:GetValue('dayState')  
  self.btn_day = self:AddBaseCom( GameUIImage ,'btn_day')
  self.btn_night = self:AddBaseCom( GameUIImage ,'btn_night')


end

return MissionMonsterInfoUIView
---自动生成代码----end----