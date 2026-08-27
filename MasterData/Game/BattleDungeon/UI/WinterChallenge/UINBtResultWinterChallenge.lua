local UINBtResultWinterChallenge = class("UINBtResultWinterChallenge", UIBaseNode)
local base = UIBaseNode

function UINBtResultWinterChallenge:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBtResultWinterChallenge:InitBtResultWinterChallenge(scoreAdd, scoreAll)
  self.ui.tex_ScoreAdd:SetIndex(0, tostring(scoreAdd))
  self.ui.tex_ScoreAll.text = tostring(scoreAll)
  self.ui.tex_ScoreAll:StartScrambleTypeWriter()
end

function UINBtResultWinterChallenge:OnDelete()
  base.OnDelete(self)
end

return UINBtResultWinterChallenge
