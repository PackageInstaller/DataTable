local UINCommonStars = class("UINCommonStars", UIBaseNode)
local base = UIBaseNode

function UINCommonStars:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.img_star.gameObject:SetActive(false)
  self.starGoList = {}
end

function UINCommonStars:RefreshStarsByNum(nowNum)
  if #self.starGoList == 0 then
    for i = 1, nowNum do
      local go = self.ui.img_star.gameObject:Instantiate()
      go:SetActive(true)
      table.insert(self.starGoList, go)
    end
  end
  local count = #self.starGoList
  if nowNum <= count then
    for i = 1, nowNum do
      self.starGoList[i].gameObject:SetActive(true)
    end
    for i = nowNum + 1, count do
      self.starGoList[i].gameObject:SetActive(false)
    end
  else
    for i = 1, count do
      self.starGoList[i].gameObject:SetActive(true)
    end
    for i = count + 1, nowNum do
      local go = self.ui.img_star.gameObject:Instantiate()
      go:SetActive(true)
      table.insert(self.starGoList, go)
    end
  end
end

function UINCommonStars:OnDelete()
end

return UINCommonStars
