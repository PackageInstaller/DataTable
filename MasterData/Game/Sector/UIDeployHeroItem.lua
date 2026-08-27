local UIDeployHeroItem = class("UIDeployHeroItem", UIBaseNode)
local base = UIBaseNode

function UIDeployHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Hero, self, self.OnClickButton)
  self.ui.star:SetActive(false)
  self.ui.stars = {}
  for i = 1, ConfigData.hero_rank.maxStar do
    local go = self.ui.star:Instantiate()
    go:SetActive(true)
    table.insert(self.ui.stars, go)
  end
end

function UIDeployHeroItem:InitHeroData(index, heroData, resloader, clickEvent)
  self.posIndex = index
  self.heroData = heroData
  local isNull = heroData == nil
  self.ui.img_Add:SetActive(isNull)
  self.ui.heroContent:SetActive(not isNull)
  self.clickEvent = clickEvent
  if isNull then
    self.ui.img_Hero.texture = nil
  else
    resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroData:GetResPicName()), function(texture)
      if IsNull(self.transform) then
        return
      end
      if self.heroData ~= heroData then
        return
      end
      self.ui.img_Hero.texture = texture
    end)
    self.ui.img_Career.sprite = CRH:GetSprite(heroData:GetCareerCfg().icon, CommonAtlasType.CareerCamp)
    self.ui.tex_Name.text = heroData:GetName()
    self:SetStarUI(heroData.star)
    self.ui.tex_Level:SetIndex(0, tostring(heroData.level))
  end
end

function UIDeployHeroItem:SetStarUI(star)
  for i = 1, star do
    self.ui.stars[i]:SetActive(true)
  end
  for i = star + 1, #self.ui.stars do
    self.ui.stars[i]:SetActive(false)
  end
end

function UIDeployHeroItem:SetRedDotActive(active)
  self.ui.redDotHero:SetActive(active)
end

function UIDeployHeroItem:OnClickButton()
  if self.clickEvent ~= nil then
    self.clickEvent(self)
  end
end

function UIDeployHeroItem:SetSelectState(active)
  self.onSelect = active
  self.ui.img_OnSelect.gameObject:SetActive(active)
end

function UIDeployHeroItem:OnDelete()
  base.OnDelete()
end

return UIDeployHeroItem
