local UINRankingItem = class("UINRankingItem", UIBaseNode)
local base = UIBaseNode

function UINRankingItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINRankingItem:InitWithRankData(rankingData, index, isMine)
  self.ui.tex_UserName.text = tostring(rankingData.name)
  self.ui.tex_Sccore.text = tostring(rankingData.score)
  self.ui.tex_Ranking.text = tostring(index)
  self.ui.img_Frame:SetIndex(isMine and 1 or 0)
  if 3 < index then
    self.ui.img_Crown.image.enabled = false
    return
  end
  self.ui.img_Crown.image.enabled = true
  self.ui.img_Crown:SetIndex(index - 1)
end

function UINRankingItem:OnDelete()
  base.OnDelete(self)
end

return UINRankingItem
