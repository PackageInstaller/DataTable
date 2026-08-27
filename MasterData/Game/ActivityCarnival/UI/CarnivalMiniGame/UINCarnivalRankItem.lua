local UINCarnivalRankItem = class("UINCarnivalRankItem", UIBaseNode)
local base = UIBaseNode

function UINCarnivalRankItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCarnivalRankItem:InitCarnivalItem(rankingData, index, isMine)
  self.ui.tex_PlayerName.text = tostring(rankingData.name)
  self.ui.tex_Score.text = tostring(rankingData.score)
  self.ui.tex_Rank.text = tostring(index)
  self.ui.rankItem:SetIndex(isMine and 0 or 1)
  if 3 < index then
    self.ui.img_Crown.gameObject:SetActive(false)
  else
    self.ui.img_Crown.gameObject:SetActive(true)
    self.ui.img_Crown:SetIndex(index - 1)
  end
end

return UINCarnivalRankItem
