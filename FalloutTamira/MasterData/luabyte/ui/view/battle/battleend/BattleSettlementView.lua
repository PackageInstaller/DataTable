---自动生成代码----start----
local BattleSettlementView = BaseClass( 'BattleSettlementView' , BaseView )
local M = BattleSettlementView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.titleCtrl =   self:AddValue('UI.Ctrl.Battle.BattleEnd.BattleTitleCtrl','UI.View.Battle.BattleEnd.BattleTitleView','titleCtrl')  
  self.expCtrl =   self:AddValue('UI.Ctrl.Battle.BattleEnd.BattleExpSliderCtrl','UI.View.Battle.BattleEnd.BattleExpSliderView','expCtrl')  
  self.awardCtrl =   self:AddValue('UI.Ctrl.Battle.BattleEnd.AwardPanelCtrl','UI.View.Battle.BattleEnd.AwardPanelView','awardCtrl')  
  self.msgCtrl =   self:AddValue('UI.Ctrl.Battle.BattleEnd.MessageCtrl','UI.View.Battle.BattleEnd.MessageView','msgCtrl')  
  self.time = self:AddBaseCom( GameUIText ,'time')
  self.uiState =   self._binder:GetValue('uiState')  
  self.roleCtrl =   self:AddValue('UI.Ctrl.Battle.BattleEnd.BattleRoleCtrl','UI.View.Battle.BattleEnd.BattleRoleView','roleCtrl')  
  self.bossCtrl =   self:AddValue('UI.Ctrl.Battle.BattleEnd.BossWarEndCtrl','UI.View.Battle.BattleEnd.BossWarEndView','bossCtrl')  


end

return BattleSettlementView
---自动生成代码----end----