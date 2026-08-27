local UINSkillAllLevelDesItem = class("UINSkillAllLevelDesItem", UIBaseNode)
local base = UIBaseNode

function UINSkillAllLevelDesItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSkillAllLevelDesItem:InitDes(level, des, nowLevel)
  if nowLevel == level then
    self.ui.tex_SkillLevel:SetIndex(1, tostring(level))
    self.ui.tex_SkillContent:SetIndex(1, des)
  else
    self.ui.tex_SkillLevel:SetIndex(0, tostring(level))
    self.ui.tex_SkillContent:SetIndex(0, des)
  end
end

function UINSkillAllLevelDesItem:OnDelete()
  base.OnDelete(self)
end

return UINSkillAllLevelDesItem
