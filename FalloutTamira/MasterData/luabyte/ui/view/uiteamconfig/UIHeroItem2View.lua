---自动生成代码----start----
local UIHeroItem2View = BaseClass( 'UIHeroItem2View' , BaseView )
local M = UIHeroItem2View 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tfNomal =   self._binder:GetValue('tfNomal')  
  self.imgHero = self:AddBaseCom( GameUIImage ,'imgHero')
  self.imgJob = self:AddBaseCom( GameUIImage ,'imgJob')
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labLv = self:AddBaseCom( GameUIText ,'labLv')
  self.stateRarity =   self._binder:GetValue('stateRarity')  
  self.btn = self:AddBaseCom( GameUIImage ,'btn')
  self.imgNation = self:AddBaseCom( GameUIImage ,'imgNation')
  self.labLock = self:AddBaseCom( GameUIText ,'labLock')
  self.uiState =   self._binder:GetValue('uiState')  
  self.stateStar =   self:AddValue('UI.Ctrl.UITeamConfig.UICoreCtrl','UI.View.UITeamConfig.UICoreView','stateStar')  
  self.stateBreak =   self:AddValue('UI.Ctrl.UITeamConfig.UIBreakCtrl','UI.View.UITeamConfig.UIBreakView','stateBreak')  
  self.EffectPanel =   self._binder:GetValue('EffectPanel')  


end

return UIHeroItem2View
---自动生成代码----end----