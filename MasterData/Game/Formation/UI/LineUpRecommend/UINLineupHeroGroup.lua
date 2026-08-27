local UINLineupHeroGroup = class("UINLineupHeroGroup", UIBaseNode)
local base = UIBaseNode
local UINLineupHeroItem = require("Game.Formation.UI.LineUpRecommend.UINLineupHeroItem")

function UINLineupHeroGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.heroItemPool = UIItemPool.New(UINLineupHeroItem, self.ui.obj_heroItem)
  self.ui.obj_heroItem:SetActive(false)
end

function UINLineupHeroGroup:InitLineupHeroGroup(heroInfoList, resLoader, type, startCount, endCount)
  self.ui.tex_Recommend:SetIndex(type)
  self.heroItemPool:HideAll()
  for i = startCount, endCount do
    local item = self.heroItemPool:GetOne()
    item:InitLineupHeroItem(heroInfoList[i], resLoader)
  end
end

function UINLineupHeroGroup:OnDelete()
  self.heroItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINLineupHeroGroup
