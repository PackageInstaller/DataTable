local UINSGMiniGameRankItem = class("UINSGMiniGameRankItem", UIBaseNode)
local base = UIBaseNode

function UINSGMiniGameRankItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSGMiniGameRankItem:InitSGMiniGameRankItem(info, index)
  self.ui.tex_PlayerName.text = info.name
  self.ui.tex_Rank.text = string.format("%02d", index)
  self.ui.tex_Score.text = info.score
end

function UINSGMiniGameRankItem:OnDelete()
end

return UINSGMiniGameRankItem
