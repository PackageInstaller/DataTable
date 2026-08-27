local UINWhiteDay2048RankItem = class("UINWhiteDay2048RankItem", UIBaseNode)

function UINWhiteDay2048RankItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.normalColor = self.ui.tex_Name.color
end

function UINWhiteDay2048RankItem:Init2048RankItem(rankingData, index, isMine)
  self.ui.tex_Name.text = tostring(rankingData.name)
  self.ui.tex_Score.text = tostring(rankingData.score)
  self.ui.tex_Rank.text = tostring(index)
  self.ui.img_MyRank:SetActive(isMine)
  local color
  if isMine then
    color = Color.white
  else
    color = self.ui.normalColor
  end
  self.ui.tex_Name.color = color
  self.ui.tex_Score.color = color
  self.ui.tex_Rank.color = color
  if 3 < index then
    self.ui.img_Crown.image.enabled = false
    return
  end
  self.ui.img_Crown.image.enabled = true
  self.ui.img_Crown:SetIndex(index - 1)
end

return UINWhiteDay2048RankItem
