---自动生成代码----start----
local LimitStageInfoView = BaseClass( 'LimitStageInfoView' , BaseView )
local M = LimitStageInfoView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_map = self:AddBaseCom( GameRawImage ,'btn_map')
  self.enemyBtn =   self._binder:GetValue('enemyBtn')  
  self.missionName = self:AddBaseCom( GameUIText ,'missionName')
  self.battleBtn =   self._binder:GetValue('battleBtn')  
  self.alreadyChooseTxt = self:AddBaseCom( GameUIText ,'alreadyChooseTxt')
  self.item =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimitStageInfoItemCtrl','UI.View.Mission.LimitStageInfoItemView','item')  
  self.itemContainer =   self._binder:GetValue('itemContainer')  
  self.starLabel = self:AddBaseCom( GameUIText ,'starLabel')
  self.passLabel =   self._binder:GetValue('passLabel')  
  self.starOn =   self._binder:GetValue('starOn')  
  self.starOff =   self._binder:GetValue('starOff')  
  self.tips =   self._binder:GetValue('tips')  


end

return LimitStageInfoView
---自动生成代码----end----