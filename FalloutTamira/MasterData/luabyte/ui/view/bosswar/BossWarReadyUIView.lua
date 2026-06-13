---自动生成代码----start----
local BossWarReadyUIView = BaseClass( 'BossWarReadyUIView' , BaseView )
local M = BossWarReadyUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_map = self:AddBaseCom( GameUIImage ,'btn_map')
  self.btn_monster =   self._binder:GetValue('btn_monster')  
  self.btn_words = self:AddBaseCom( UINewButton ,'btn_words')
  self.btn_battle = self:AddBaseCom( UINewButton ,'btn_battle')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_blood = self:AddBaseCom( GameUIText ,'txt_blood')
  self.txt_lNum = self:AddBaseCom( GameUIText ,'txt_lNum')
  self.txt_rNum = self:AddBaseCom( GameUIText ,'txt_rNum')
  self.txt_recLevel = self:AddBaseCom( GameUIText ,'txt_recLevel')
  self.txt_index = self:AddBaseCom( GameUIText ,'txt_index')
  self.img_map = self:AddBaseCom( GameRawImage ,'img_map')
  self.lvState =   self._binder:GetValue('lvState')  
  self.img_head = self:AddBaseCom( GameUIImage ,'img_head')
  self.txt_times = self:AddBaseCom( GameUIText ,'txt_times')
  self.wordsState =   self._binder:GetValue('wordsState')  
  self.txt_tips = self:AddBaseCom( GameUIText ,'txt_tips')
  self.img_barFill = self:AddBaseCom( GameUIImage ,'img_barFill')
  self.img_hpBar = self:AddBaseCom( GameUIImage ,'img_hpBar')


end

return BossWarReadyUIView
---自动生成代码----end----