---自动生成代码----start----
local EncounteMainUIView = BaseClass( 'EncounteMainUIView' , BaseView )
local M = EncounteMainUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_backPic = self:AddBaseCom( GameRawImage ,'img_backPic')
  self.txt_showTime = self:AddBaseCom( GameUIText ,'txt_showTime')
  self.node_loopList = self:AddBaseCom( CircularScrollView ,'node_loopList')
  self.state_bg =   self._binder:GetValue('state_bg')  
  self.img_cycle_num =   self:AddValue('UI.Ctrl.Mission.EncounterTitleCtrl','UI.View.Mission.EncounterTitleView','img_cycle_num')  
  self.openTimeTrans =   self._binder:GetValue('openTimeTrans')  
  self.battle_progress =   self._binder:GetValue('battle_progress')  
  self.reward_progressTf = self:AddBaseCom( GameUIText ,'reward_progressTf')
  self.reward_area =   self._binder:GetValue('reward_area')  
  self.word_icon = self:AddBaseCom( GameUIImage ,'word_icon')
  self.word_txt = self:AddBaseCom( GameUIText ,'word_txt')
  self.word_area =   self._binder:GetValue('word_area')  


end

return EncounteMainUIView
---自动生成代码----end----