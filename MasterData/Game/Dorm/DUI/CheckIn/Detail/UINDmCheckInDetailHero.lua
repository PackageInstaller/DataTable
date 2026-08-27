local UINDmCheckInDetailHero = class("UINDmCheckInDetailHero", UIBaseNode)
local base = UIBaseNode

function UINDmCheckInDetailHero:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINDmCheckInDetailHero:InitDmCheckInDetailHero(heroData, inCurRoom, inOtherRoom, clickFunc)
  self.clickFunc = clickFunc
  self.heroData = heroData
  self.ui.img_HeroIcon.sprite = CRH:GetHeroSkinSprite(heroData.dataId, heroData.skinId)
  self:UpdDmCheckInDetailHeroState(inCurRoom, inOtherRoom)
end

function UINDmCheckInDetailHero:UpdDmCheckInDetailHeroState(inCurRoom, inOtherRoom)
  self.ui.inOtherRoom:SetActive(inOtherRoom)
  self.ui.inCurRoom:SetActive(inCurRoom)
end

function UINDmCheckInDetailHero:_OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self, self.heroData)
  end
end

function UINDmCheckInDetailHero:OnDelete()
  base.OnDelete(self)
end

return UINDmCheckInDetailHero
