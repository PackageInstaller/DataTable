---自动生成代码----start----
local BossWarMissionItemView = BaseClass( 'BossWarMissionItemView' , BaseView )
local M = BossWarMissionItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uiState =   self._binder:GetValue('uiState')  
  self.txt_index = self:AddBaseCom( GameUIText ,'txt_index')
  self.img_head = self:AddBaseCom( GameUIImage ,'img_head')
  self.txt_level = self:AddBaseCom( GameUIText ,'txt_level')
  self.txt_openTips = self:AddBaseCom( GameUIText ,'txt_openTips')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_blood = self:AddBaseCom( GameUIText ,'txt_blood')
  self.txt_lNum = self:AddBaseCom( GameUIText ,'txt_lNum')
  self.txt_rNum = self:AddBaseCom( GameUIText ,'txt_rNum')
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.img_level = self:AddBaseCom( GameUIImage ,'img_level')
  self.img_bloodBar = self:AddBaseCom( GameUIImage ,'img_bloodBar')
  self.img_barFill = self:AddBaseCom( GameUIImage ,'img_barFill')
  self.grayGroup =   self._binder:GetValue('grayGroup')  


end

return BossWarMissionItemView
---自动生成代码----end----