---自动生成代码----start----
local BridgeCmdSkillView = BaseClass( 'BridgeCmdSkillView' , BaseView )
local M = BridgeCmdSkillView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.skillList = self:AddBaseCom( CircularScrollView ,'skillList')
  self.itemList = self:AddBaseCom( CircularScrollView ,'itemList')
  self.upLevelBtn =   self._binder:GetValue('upLevelBtn')  
  self.skillIcon = self:AddBaseCom( GameUIImage ,'skillIcon')
  self.skillName = self:AddBaseCom( GameUIText ,'skillName')
  self.skillLevel = self:AddBaseCom( GameUIText ,'skillLevel')
  self.heroBtn =   self._binder:GetValue('heroBtn')  
  self.heroIcon = self:AddBaseCom( GameUIImage ,'heroIcon')
  self.heroName = self:AddBaseCom( GameUIText ,'heroName')
  self.leftName = self:AddBaseCom( GameUIText ,'leftName')
  self.leftLevel = self:AddBaseCom( GameUIText ,'leftLevel')
  self.leftDesc = self:AddBaseCom( GameUIText ,'leftDesc')
  self.rightName = self:AddBaseCom( GameUIText ,'rightName')
  self.rightLevel = self:AddBaseCom( GameUIText ,'rightLevel')
  self.rightDesc = self:AddBaseCom( GameUIText ,'rightDesc')
  self.skillNode =   self._binder:GetValue('skillNode')  
  self.upLevelText = self:AddBaseCom( GameUIText ,'upLevelText')
  self.itemPanel =   self._binder:GetValue('itemPanel')  
  self.txt_upTips = self:AddBaseCom( GameUIText ,'txt_upTips')
  self.txt_storages = self:AddBaseCom( GameUIText ,'txt_storages')
  self.currency =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','currency')  
  self.node_right =   self._binder:GetValue('node_right')  
  self.heroMask =   self._binder:GetValue('heroMask')  


end

return BridgeCmdSkillView
---自动生成代码----end----