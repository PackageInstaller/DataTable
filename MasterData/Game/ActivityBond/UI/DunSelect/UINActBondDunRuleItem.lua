local base = UIBaseNode
local UINActBondDunRuleItem = class("UINActBondDunRuleItem", base)

function UINActBondDunRuleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActBondDunRuleItem:ActBond_RuleItemInit(buffId)
  local dunBuffCfg = ConfigData.dungeon_buff[buffId]
  self.ui.Img_Icon.sprite = CRH:GetSprite(dunBuffCfg.icon, CommonAtlasType.ExplorationIcon)
  self.ui.Tex_Des.text = LanguageUtil.GetLocaleText(dunBuffCfg.describe)
end

function UINActBondDunRuleItem:OnDelete()
  base.OnDelete(self)
end

return UINActBondDunRuleItem
