---自动生成代码----start----
local OtakuSkillItemView = BaseClass( 'OtakuSkillItemView' , BaseView )
local M = OtakuSkillItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.node_line =   self._binder:GetValue('node_line')  


end

return OtakuSkillItemView
---自动生成代码----end----