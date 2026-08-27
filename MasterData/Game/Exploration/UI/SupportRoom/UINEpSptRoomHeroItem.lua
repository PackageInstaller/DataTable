local UINEpSptRoomHeroItem = class("UINEpSptRoomHeroItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")

function UINEpSptRoomHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.headItem = UINHeroHeadItem.New()
  self.headItem:Init(self.ui.obj_heroHeadItem)
  self._clickFunc = BindCallback(self, self._OnClickRoot)
end

function UINEpSptRoomHeroItem:_InitBasse(heroData, resloader, clickEvent)
  self.clickEvent = clickEvent
  self.headItem:InitHeroHeadItem(heroData, resloader, self._clickFunc)
  local half = heroData.rank % 2
  local rankImgIndex = (heroData.rank - half) / 2 - 1
  if 0 <= rankImgIndex then
    self.ui.img_Star.gameObject:SetActive(true)
    self.ui.img_Star:SetIndex(rankImgIndex)
    local vec = self.ui.img_Star.image.rectTransform.sizeDelta
    vec.x = self.ui.img_Star.image.sprite.rect.width
    self.ui.img_Star.image.rectTransform.sizeDelta = vec
  else
    self.ui.img_Star.gameObject:SetActive(false)
  end
  self.ui.img_Half.gameObject:SetActive(half == 1)
end

function UINEpSptRoomHeroItem:InitEpSptRoomHeroExItem(heroData, resloader, clickEvent)
  self:_InitBasse(heroData, resloader, clickEvent)
  self.ui.img_hP.fillAmount = 1
  self.ui.isBench:SetActive(false)
  self.fightingPower = heroData:GetFightingPower()
  self.ui.tex_Power.text = tostring(self.fightingPower)
  self._isHeroData = true
  self.heroData = heroData
  self._id = heroData.dataId
end

function UINEpSptRoomHeroItem:InitEpSptRoomHeroItem(dynHeroData, resloader, clickEvent)
  self.dynHeroData = dynHeroData
  local heroData = dynHeroData.heroData
  self:_InitBasse(heroData, resloader, clickEvent)
  local hpPer = dynHeroData.hpPer / 10000
  self.ui.img_hP.fillAmount = hpPer
  self.ui.isBench:SetActive(dynHeroData:IsBench())
  self.fightingPower = dynHeroData:GetFightingPower()
  self.ui.tex_Power.text = tostring(self.fightingPower)
  self._isHeroData = false
  self._id = dynHeroData.uid
end

function UINEpSptRoomHeroItem:SetEpSptRoomHeroItemSelect(select)
  self.ui.onSelect:SetActive(select)
end

function UINEpSptRoomHeroItem:SetEpSptRoomHeroItemHas(has)
  self.ui.has:SetActive(has)
  self.has = has
end

function UINEpSptRoomHeroItem:GetSupHeroItemPowerAndId()
  return self.fightingPower, self._id
end

function UINEpSptRoomHeroItem:ClickSupHeroItem()
  return self:_OnClickRoot()
end

function UINEpSptRoomHeroItem:_OnClickRoot()
  if self.has then
    return
  end
  if self.clickEvent ~= nil then
    local heroData = self._isHeroData and self.heroData or self.dynHeroData
    self.clickEvent(self, heroData, self.fightingPower, self._isHeroData)
  end
end

function UINEpSptRoomHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINEpSptRoomHeroItem
