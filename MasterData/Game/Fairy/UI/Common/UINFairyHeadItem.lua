local UINFairyHeadItem = class("UINFairyHeadItem", UIBaseNode)
local base = UIBaseNode
local UINFairyQualityItem = require("Game.Fairy.UI.UINFairyQualityItem")

function UINFairyHeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_fairyHeadItem, self, self.__OnClick)
  self.fairyQuality = UINFairyQualityItem.New()
  self.fairyQuality:Init(self.ui.uINFairyQualityItem)
  self._showQuality = true
  self:SetFairyHeadItemLvShow(false)
end

function UINFairyHeadItem:SetFairyHeadItemLvShow(isShow)
  self._showLv = isShow
  if not IsNull(self.ui.level) then
    self.ui.level:SetActive(isShow)
  end
end

function UINFairyHeadItem:SetFairyHeadItemQualityShow(isShow)
  self._showQuality = isShow
  self.ui.uINFairyQualityItem:SetActive(isShow)
end

function UINFairyHeadItem:InitFairyHeadItem(fairyData, resloader, clickCallback)
  self.fairyData = fairyData
  self.resloader = resloader
  self.clickCallback = clickCallback
  if self._showQuality then
    self.fairyQuality:InitFairyQualityItem(fairyData:GetCurFairyQuality())
  end
  local headIconName = self.fairyData:GetFairyHeadIconStr()
  self.ui.img_Pic.sprite = AtlasUtil.GetSpriteFromAtlas("FairySmallHeadIcon", headIconName, self.resloader)
  if self._showLv and not IsNull(self.ui.tex_Level) then
    self.ui.tex_Level:SetIndex(0, tostring(fairyData:GetFairyCurLevel()))
  end
end

function UINFairyHeadItem:__OnClick()
  if self.clickCallback ~= nil then
    self.clickCallback(self.fairyData, self.ui.obj_introHold)
  end
end

function UINFairyHeadItem:OnDelete()
  base.OnDelete(self)
end

return UINFairyHeadItem
