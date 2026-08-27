local UINHeroHeadItem = class("UINHeroHeadItem", UIBaseNode)
local base = UIBaseNode

function UINHeroHeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self.__OnClickRoot)
end

function UINHeroHeadItem:InitHeroHeadItem(heroData, resloader, clickEvent)
  self.heroData = heroData
  self.clickEvent = clickEvent
  self:SetHeroHeadIcon(heroData.heroCfg, heroData.skinId, heroData:GetGuideResName())
  self.ui.img_Career.sprite = CRH:GetSprite(heroData:GetCareerCfg().icon, CommonAtlasType.CareerCamp)
end

function UINHeroHeadItem:InitHeroHeadItemWithId(heroId, clickEvent)
  self.heroData = nil
  self.heroId = heroId
  self.clickEvent = clickEvent
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("heroCfg is NULL   id:" .. tostring(heroId))
  end
  self:SetHeroHeadIcon(heroCfg)
  local careerCfg = ConfigData.career[heroCfg.career]
  if careerCfg == nil then
    error("can't read careerCfg with id: " .. tostring(heroCfg.career))
    return
  end
  self.ui.img_Career.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
end

function UINHeroHeadItem:SetHeroHeadLock(bool)
  self.ui.obj_unlock:SetActive(bool)
end

function UINHeroHeadItem:TransparentHeroHeadItem(transparent)
  self.ui.canvasGroup.alpha = transparent and self.ui.transparentValue or 1
end

function UINHeroHeadItem:SetHeroHeadIcon(heroCfg, skinId, guideResName)
  local resName = guideResName
  if string.IsNullOrEmpty(resName) and (skinId or 0) ~= 0 then
    local skinCfg = ConfigData.skin[skinId]
    if skinCfg ~= nil and not string.IsNullOrEmpty(skinCfg.src_id_icon) then
      resName = skinCfg.src_id_icon
    end
  end
  if string.IsNullOrEmpty(resName) and heroCfg.fragment ~= nil then
    local itemCfg = ConfigData.item[heroCfg.fragment]
    if itemCfg ~= nil then
      resName = itemCfg.icon
    end
  end
  if string.IsNullOrEmpty(resName) ~= nil then
    self.ui.img_Pic.sprite = CRH:GetSprite(resName, CommonAtlasType.HeroHeadIcon)
  end
end

function UINHeroHeadItem:__OnClickRoot()
  if self.clickEvent ~= nil then
    if self.heroData ~= nil then
      self.clickEvent(self.heroData)
    elseif self.heroId ~= nil then
      self.clickEvent(self.heroId)
    end
  end
end

function UINHeroHeadItem:GetHeroHeadHeroData()
  return self.heroData
end

function UINHeroHeadItem:GetHeroHeadHeroId()
  return self.heroId
end

function UINHeroHeadItem:SetHeadHeroData(heroData)
  self.heroData = heroData
end

function UINHeroHeadItem:SetHpBarParent(hpCanvasTrans)
  if self.ui.HpBar ~= nil then
    self.ui.HpBar.transform:SetParent(hpCanvasTrans)
  end
end

function UINHeroHeadItem:SetHpBarActive(activeSelf)
  if self.ui.HpBar ~= nil then
    self.ui.HpBar:SetActive(activeSelf)
  end
end

function UINHeroHeadItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroHeadItem
