local UINHeroTalentNodeDetailCondition = class("UINHeroTalentNodeDetailCondition", UIBaseNode)
local base = UIBaseNode

function UINHeroTalentNodeDetailCondition:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHeroTalentNodeDetailCondition:RefreshDetailCondition(textDes, unlock)
  self.ui.tex_Condition.text = textDes
  self.ui.img_Root:SetIndex(unlock and 0 or 1)
end

return UINHeroTalentNodeDetailCondition
