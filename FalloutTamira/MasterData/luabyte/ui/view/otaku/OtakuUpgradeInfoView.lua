---自动生成代码----start----
local OtakuUpgradeInfoView = BaseClass( 'OtakuUpgradeInfoView' , BaseView )
local M = OtakuUpgradeInfoView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.cabinList = self:AddBaseCom( CircularScrollView ,'cabinList')
  self.costList = self:AddBaseCom( CircularScrollView ,'costList')
  self.currency =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','currency')  
  self.btn_upgrade =   self._binder:GetValue('btn_upgrade')  
  self.barDots =   self:AddValue('UI.Ctrl.Otaku.OtakuBridgeDotGroupCtrl','UI.View.Otaku.MainUI.OtakuBridgeDotGroupView','barDots')  
  self.roomUiState =   self._binder:GetValue('roomUiState')  
  self.itemBigList = self:AddBaseCom( CircularScrollView ,'itemBigList')
  self.labCookTimer = self:AddBaseCom( GameUIText ,'labCookTimer')
  self.upItem =   self:AddValue('','UI.View.Bridge.BridgeCabinUpgradeItemView','upItem')  
  self.upNode =   self._binder:GetValue('upNode')  
  self.txt_lvTips = self:AddBaseCom( GameUIText ,'txt_lvTips')
  self.cabinParent =   self._binder:GetValue('cabinParent')  
  self.layGroupCook =   self._binder:GetValue('layGroupCook')  
  self.makeScale =   self:AddValue('','UI.View.Bridge.BridgeMakeScaleItemCtrlView','makeScale')  
  self.gridKitChen = self:AddBaseCom( CircularScrollView ,'gridKitChen')


end

return OtakuUpgradeInfoView
---自动生成代码----end----