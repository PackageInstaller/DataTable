local base = require("Game.CommonUI.FloatWin.UINFloatUINode")
local UINActCommonMonsterCardCardInfoNodeTag = class("UINActCommonMonsterCardCardInfoNodeTag", base)

function UINActCommonMonsterCardCardInfoNodeTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActCommonMonsterCardCardInfoNodeTag:ACMCCINRefreshTagName(name)
  self.ui.Tex_TagName.text = name
end

function UINActCommonMonsterCardCardInfoNodeTag:OnDelete()
  base.OnDelete(self)
end

return UINActCommonMonsterCardCardInfoNodeTag
