---自动生成代码----start----
local BattlesettlementOfferRewardsView = BaseClass( 'BattlesettlementOfferRewardsView' , BaseView )
local M = BattlesettlementOfferRewardsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_second = self:AddBaseCom( GameUIText ,'txt_second')
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.roleCtrl =   self:AddValue('UI.Ctrl.Battle.BattleEnd.BattleRoleCtrl','UI.View.Battle.BattleEnd.BattleRoleView','roleCtrl')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.entryItem1 =   self:AddValue('','UI.View.Mission.MissionOfferRewardsItemView','entryItem1')  
  self.entryItem2 =   self:AddValue('','UI.View.Mission.MissionOfferRewardsItemView','entryItem2')  
  self.entryItem3 =   self:AddValue('','UI.View.Mission.MissionOfferRewardsItemView','entryItem3')  
  self.txt_level = self:AddBaseCom( GameUIText ,'txt_level')
  self.img_fill = self:AddBaseCom( GameUIImage ,'img_fill')
  self.txt_valueL = self:AddBaseCom( GameUIText ,'txt_valueL')
  self.txt_valueR = self:AddBaseCom( GameUIText ,'txt_valueR')


end

return BattlesettlementOfferRewardsView
---自动生成代码----end----