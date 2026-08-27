local base = require("Game.Fairy.UI.ListFilter.UINFairySortKindItem")
local UINFairyQkLvFiltItem = class("UINFairyQkLvFiltItem", base)

function UINFairyQkLvFiltItem:OnInit()
  base.OnInit(self)
end

function UINFairyQkLvFiltItem:InitFairyQkLvFiltItem(kindType, index, onSelectFunc)
  base.InitFairySortKindItem(self, kindType, index, onSelectFunc)
end

function UINFairyQkLvFiltItem:SetSelectUIActive()
  self.ui.obj_OnSelect:SetActive(self.select)
  self.ui.img_Star.gameObject:SetActive(self.isStarType)
end

function UINFairyQkLvFiltItem:OnDelete()
  base.OnDelete(self)
end

return UINFairyQkLvFiltItem
