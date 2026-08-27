local UINDailyDgListItemBossTag = class("UINDailyDgListItemBossTag", UIBaseNode)
local base = UIBaseNode

function UINDailyDgListItemBossTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINDailyDgListItemBossTag:InitDailyDgListItemBossTag(monsterTagCfg)
  self.ui.tex_BossTag.text = LanguageUtil.GetLocaleText(monsterTagCfg.tag)
  self.ui.img_Tag.color = self.ui.tagColorList[monsterTagCfg.color]
end

function UINDailyDgListItemBossTag:OnDelete()
  base.OnDelete(self)
end

return UINDailyDgListItemBossTag
