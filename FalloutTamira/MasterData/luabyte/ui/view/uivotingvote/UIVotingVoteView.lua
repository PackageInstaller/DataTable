---自动生成代码----start----
local UIVotingVoteView = BaseClass( 'UIVotingVoteView' , BaseView )
local M = UIVotingVoteView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnOk = self:AddBaseCom( UINewButton ,'btnOk')
  self.btnCancel = self:AddBaseCom( UINewButton ,'btnCancel')
  self.IconHero = self:AddBaseCom( GameRawImage ,'IconHero')
  self.ComNumSliderCtrl =   self:AddValue('UI.Ctrl.Common.ComNumSliderCtrl','UI.View.Common.ComNumSliderView','ComNumSliderCtrl')  
  self.btnClose =   self._binder:GetValue('btnClose')  
  self.textName = self:AddBaseCom( GameUIText ,'textName')
  self.textTicket = self:AddBaseCom( GameUIText ,'textTicket')
  self.ComTopCurrencyUI =   self._binder:GetValue('ComTopCurrencyUI')  
  self.PropertyBar =   self._binder:GetValue('PropertyBar')  


end

return UIVotingVoteView
---自动生成代码----end----