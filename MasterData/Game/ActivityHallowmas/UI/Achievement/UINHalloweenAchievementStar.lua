local UINHalloweenAchievementStar = class("UINHalloweenAchievementStar", UIBaseNode)
local base = UIBaseNode

function UINHalloweenAchievementStar:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._starList = {
    self.ui.img_star
  }
end

function UINHalloweenAchievementStar:InitStarNum(star, num)
  local count = #self._starList
  for i = 1, count do
    local starItem = self._starList[i]
    starItem:SetActive(i <= star)
  end
  for i = count + 1, star do
    local starItem = self.ui.img_star:Instantiate()
    table.insert(self._starList, starItem)
    starItem:SetActive(true)
  end
  self.ui.tex_Num.text = tostring(num)
end

return UINHalloweenAchievementStar
