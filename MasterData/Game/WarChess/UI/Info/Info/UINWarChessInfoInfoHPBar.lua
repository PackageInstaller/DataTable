local base = require("Game.WarChess.UI.Info.Info.UINWarChessInfoInfoBase")
local UINWarChessInfoInfoHPBar = class("UINWarChessInfoInfoHPBar", base)

function UINWarChessInfoInfoHPBar:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessInfoInfoHPBar:SetWCIIHPBar(isMonster, rate)
  if isMonster then
    self.ui.img_light:SetIndex(1)
    self.ui.img_HP.color = self.ui.hp_monster
  else
    self.ui.img_light:SetIndex(0)
    self.ui.img_HP.color = self.ui.hp_hero
  end
  if 1 <= rate then
    self:Hide()
  else
    self:Show()
  end
  self.ui.img_HP.fillAmount = rate
end

function UINWarChessInfoInfoHPBar:OnDelete()
  base.OnDelete(self)
end

return UINWarChessInfoInfoHPBar
