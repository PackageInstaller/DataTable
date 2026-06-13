---自动生成代码----start----
local RoleSkillItemAreaView = BaseClass( 'RoleSkillItemAreaView' , BaseView )
local M = RoleSkillItemAreaView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_costIcon = self:AddBaseCom( GameUIImage ,'img_costIcon')
  self.txt_costNum = self:AddBaseCom( GameUIText ,'txt_costNum')
  self.txt_skillType = self:AddBaseCom( GameUIText ,'txt_skillType')
  self.img_skillIcon = self:AddBaseCom( GameUIImage ,'img_skillIcon')
  self.txt_skillName = self:AddBaseCom( GameUIText ,'txt_skillName')
  self.txt_skillDesc = self:AddBaseCom( EmojiText ,'txt_skillDesc')
  self.node_cost =   self._binder:GetValue('node_cost')  
  self.node_line =   self._binder:GetValue('node_line')  
  self.img_advence = self:AddBaseCom( GameUIImage ,'img_advence')


end

return RoleSkillItemAreaView
---自动生成代码----end----