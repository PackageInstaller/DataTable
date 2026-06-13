---自动生成代码----start----
local LimitBreakLimitSkillItem = BaseClass( 'LimitBreakLimitSkillItem' , BaseView )
local M = LimitBreakLimitSkillItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_head = self:AddBaseCom( GameUIImage ,'img_head')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.btn_award =   self._binder:GetValue('btn_award')  
  self.uiState =   self._binder:GetValue('uiState')  
  self.img_quality = self:AddBaseCom( GameUIImage ,'img_quality')


end

return LimitBreakLimitSkillItem
---自动生成代码----end----