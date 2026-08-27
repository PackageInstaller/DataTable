local UINActCommonMonsterCardSiftingKindItem = class("UINActCommonMonsterCardSiftingKindItem", UIBaseNode)
local base = UIBaseNode
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
local eActMonsterCardEnum = require("Game.ActivityFrame.ActivityMonsterCard.eActMonsterCardEnum")

function UINActCommonMonsterCardSiftingKindItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_kindItem, self, self.__OnKindItemClick)
  self.select = false
  self:SetSelectUIActive()
end

function UINActCommonMonsterCardSiftingKindItem:InitSiftingKindItem(kindType, id, onSelectFunc)
  self.kindType = kindType
  self.id = id
  self.onSelectFunc = onSelectFunc
  if kindType == eActMonsterCardEnum.siftingType.label then
    local labelCfg = ConfigData.activity_monster_card_label[id]
    self.ui.tex_KindName.text = LanguageUtil.GetLocaleText(labelCfg.name)
  elseif kindType == eActMonsterCardEnum.siftingType.quality then
    local qualityName = ConfigData:GetTipContent(ItemQualityColorName[id])
    self.ui.tex_KindName.text = tostring(qualityName)
  end
  self.ui.img_Star.gameObject:SetActive(false)
end

function UINActCommonMonsterCardSiftingKindItem:__OnKindItemClick()
  self.select = not self.select
  self:SetSelectUIActive()
  if self.onSelectFunc ~= nil then
    self.onSelectFunc(self.kindType, self.id, self.select)
  end
end

function UINActCommonMonsterCardSiftingKindItem:SetSelectUIActive()
  self.ui.obj_OnSelect:SetActive(self.select)
  self.ui.img_Star.gameObject:SetActive(self.isStarType)
  local selColor = self.select and Color.black or Color.white
  self.ui.tex_KindName.color = selColor
  self.ui.img_Star.color = selColor
end

function UINActCommonMonsterCardSiftingKindItem:SetSelectState(flag)
  self.select = flag
  self:SetSelectUIActive()
end

function UINActCommonMonsterCardSiftingKindItem:OnDelete()
  base.OnDelete(self)
end

return UINActCommonMonsterCardSiftingKindItem
