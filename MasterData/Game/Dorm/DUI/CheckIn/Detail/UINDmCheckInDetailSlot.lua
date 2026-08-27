local UINDmCheckInDetailSlot = class("UINDmCheckInDetailSlot", UIBaseNode)
local base = UIBaseNode

function UINDmCheckInDetailSlot:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_IconBtn, self, self._OnClickRoot)
end

function UINDmCheckInDetailSlot:InitDmCheckInDetailSlot(index, heroId, clickFunc)
  self.index = index
  self.clickFunc = clickFunc
  self:UpdDmCheckInDetailSlot(heroId)
end

function UINDmCheckInDetailSlot:UpdDmCheckInDetailSlot(heroId)
  self.heroId = heroId
  if heroId == nil then
    self.ui.HeroAvator.gameObject:SetActive(false)
    self.ui.addOrEmpty.gameObject:SetActive(true)
    self.ui.img_tir.enabled = false
    self.ui.tex_can.enabled = false
    self.ui.addOrEmpty:SetIndex(1)
    return
  end
  if heroId == 0 then
    self.ui.HeroAvator.gameObject:SetActive(false)
    self.ui.addOrEmpty.gameObject:SetActive(true)
    self.ui.img_tir.enabled = true
    self.ui.tex_can.enabled = true
    self.ui.addOrEmpty:SetIndex(0)
    return
  end
  self.ui.HeroAvator.gameObject:SetActive(true)
  self.ui.addOrEmpty.gameObject:SetActive(false)
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  if heroData ~= nil then
    self.ui.img_HeroIcon.sprite = CRH:GetHeroSkinSprite(heroData.dataId, heroData.skinId)
  end
end

function UINDmCheckInDetailSlot:_OnClickRoot()
  if self.heroId == nil or self.heroId == 0 then
    return
  end
  if self.clickFunc ~= nil then
    self.clickFunc(self.index)
  end
end

function UINDmCheckInDetailSlot:OnDelete()
  base.OnDelete(self)
end

return UINDmCheckInDetailSlot
