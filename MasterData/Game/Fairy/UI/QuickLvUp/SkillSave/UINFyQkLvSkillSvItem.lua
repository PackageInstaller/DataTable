local base = require("Game.Fairy.UI.UINFairySkillItem")
local UINFyQkLvSkillSvItem = class("UINFyQkLvSkillSvItem", base)

function UINFyQkLvSkillSvItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.LuaUIBindingTable(self.ui.UINFairySkillItem.transform, self.ui)
  base.OnInit(self)
end

function UINFyQkLvSkillSvItem:InitFyQkLvSkillSvItem(skillData, resloader, clickFunc)
  base.InitFairySkillItem(self, skillData, resloader, clickFunc)
  local isOwn = skillData:IsFySkillMine()
  local isNew = skillData:IsFySkillNew()
  local showTag = isNew or isOwn
  self.ui.obj_Tag:SetActive(showTag)
  if showTag then
    self.ui.Tex_Tag:SetIndex(isNew and 0 or 1)
    self.ui.img_Tag.color = isOwn and self.ui.tagColor[1] or self.ui.tagColor[2]
  end
end

function UINFyQkLvSkillSvItem:OnDelete()
  base.OnDelete(self)
end

return UINFyQkLvSkillSvItem
