local UINSnakeGameRankItem = class("UINSnakeGameRankItem", UIBaseNode)

function UINSnakeGameRankItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSnakeGameRankItem:InitSnakeRankItem(rankingData, index, isMine)
  self.ui.tex_PlayerName.text = tostring(rankingData.name)
  self.ui.tex_Score.text = tostring(rankingData.score)
  self.ui.tex_Rank.text = tostring(index)
  if 3 < index then
    self.ui.obj_icon:SetActive(false)
    self.ui.tex_Rank.color = Color.white
    self.ui.img_item.color = self.ui.color_other
  else
    self.ui.obj_icon:SetActive(true)
    self.ui.tex_Rank.color = Color.black
    self.ui.img_item.color = self.ui.color_array[index]
  end
end

return UINSnakeGameRankItem
