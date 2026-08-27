local UINLtrSkillItem = class("UINLtrSkillItem", UIBaseNode)
local base = UIBaseNode

function UINLtrSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLtrSkillItem:InitLtrSkillItem(skillData)
  self.ui.img_icon.sprite = CRH:GetSprite(skillData:GetIcon(), CommonAtlasType.SkillIcon)
  local skillTag = skillData:GetSkillTag()
  self.ui.img_type:SetIndex(skillTag)
  self.ui.img_typeLine:SetIndex(skillTag)
  self.ui.img_type.image.color = eBattleSkillTypeColor[skillData:GetBattleSkillTypeColor()]
end

function UINLtrSkillItem:OnDelete()
  base.OnDelete(self)
end

return UINLtrSkillItem
