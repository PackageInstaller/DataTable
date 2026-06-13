---自动生成代码----start----
local LotteryUI = BaseClass( 'LotteryUI' , BaseView )
local M = LotteryUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tsBtn_ten = self:AddBaseCom( TSButton ,'tsBtn_ten')
  self.tsBtn_once = self:AddBaseCom( TSButton ,'tsBtn_once')
  self.trans_consume2 =   self._binder:GetValue('trans_consume2')  
  self.trans_consume1 =   self._binder:GetValue('trans_consume1')  
  self.trans_consume1 =   self._binder:GetValue('trans_consume1')  
  self.trans_consume2 =   self._binder:GetValue('trans_consume2')  
  self.item1 =   self:AddValue('','UI.View.Lottery.LotteryItemView1View','item1')  
  self.item3 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView3','item3')  
  self.tab =   self._binder:GetValue('tab')  
  self.ProbabilityBtn =   self._binder:GetValue('ProbabilityBtn')  
  self.item2 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView2','item2')  
  self.BtnRecord =   self._binder:GetValue('BtnRecord')  
  self.tableView =   self:AddValue('UI.Ctrl.Lottery.LotteryTable','UI.View.Lottery.LotteryTableView','tableView')  
  self.item4 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView4','item4')  
  self.tsBtn_once_state =   self._binder:GetValue('tsBtn_once_state')  
  self.tsBtn_ten_state =   self._binder:GetValue('tsBtn_ten_state')  
  self.tsBtn_once_text = self:AddBaseCom( GameUIText ,'tsBtn_once_text')
  self.tsBtn_ten_text = self:AddBaseCom( GameUIText ,'tsBtn_ten_text')
  self.tsBtn_once_locktext = self:AddBaseCom( GameUIText ,'tsBtn_once_locktext')
  self.tsBtn_ten_locktext = self:AddBaseCom( GameUIText ,'tsBtn_ten_locktext')
  self.item5 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView5','item5')  
  self.item6 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView6','item6')  
  self.item7 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView7','item7')  
  self.item8 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView8','item8')  
  self.item9 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView9','item9')  
  self.BtnTipBtn =   self._binder:GetValue('BtnTipBtn')  
  self.item10 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView10','item10')  
  self.item11 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView11','item11')  
  self.item12 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView12','item12')  
  self.item13 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView13','item13')  
  self.item14 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView14','item14')  
  self.item15 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView15','item15')  
  self.item16 =   self:AddValue('','UI.View.Lottery.LotteryTypeItemView16','item16')  
  self.tgl_skip = self:AddBaseCom( UIToggle ,'tgl_skip')


end

return LotteryUI
---自动生成代码----end----