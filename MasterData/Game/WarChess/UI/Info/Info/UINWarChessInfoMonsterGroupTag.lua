local base = require("Game.WarChess.UI.Info.Info.UINWarChessInfoInfoBase")
local UINWarChessInfoMonsterGroupTag = class("UINWarChessInfoMonsterGroupTag", base)

function UINWarChessInfoMonsterGroupTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessInfoMonsterGroupTag:InitEnemyTagItem(tagTex, color)
  self.ui.tex_tag.text = tagTex
  if color ~= nil then
    self.ui.image_tag.color = color
  end
end

function UINWarChessInfoMonsterGroupTag:OnDelete()
  base.OnDelete(self)
end

return UINWarChessInfoMonsterGroupTag
