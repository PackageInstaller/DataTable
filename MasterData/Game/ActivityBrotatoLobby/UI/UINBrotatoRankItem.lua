local UINBrotatoRankItem = class("UINBrotatoRankItem", UIBaseNode)
local base = UIBaseNode

function UINBrotatoRankItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBrotatoRankItem:InitWithRankData(rankingData, index, isMine)
  local colorIndex = index
  if 3 < colorIndex then
    colorIndex = 4
  end
  local color_img = self.ui.color_img[colorIndex]
  local color_tex = self.ui.color_text[colorIndex]
  self.ui.tex_PlayerName.text = tostring(rankingData.name)
  self.ui.tex_Score.text = tostring(rankingData.score)
  self.ui.tex_Rank.text = tostring(index)
  self.ui.tex_PlayerName.color = color_tex
  self.ui.tex_Score.color = color_tex
  self.ui.tex_Rank.color = color_tex
  self.ui.img_Bottom.color = color_img
  self.ui.obj_NowTag:SetActive(isMine)
end

function UINBrotatoRankItem:OnDelete()
  base.OnDelete(self)
end

return UINBrotatoRankItem
