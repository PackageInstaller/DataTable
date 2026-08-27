local UIN_HBHeroHeroListHeroItem = class("UIN_HBHeroHeroListHeroItem", UIBaseNode)
local base = UIBaseNode
local cs_DoTweenLoopType = CS.DG.Tweening.LoopType

function UIN_HBHeroHeroListHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_HeroItem, self, self.__OnClick)
end

function UIN_HBHeroHeroListHeroItem:InitHBHeroHeadItem(onClickHeroItem)
  self.onClickHeroItem = onClickHeroItem
end

function UIN_HBHeroHeroListHeroItem:RefreshHBHeroHeadItem(heroId)
  self.heroId = heroId
  local heroData
  if PlayerDataCenter:ContainsHeroData(heroId) then
    heroData = PlayerDataCenter:GetHeroData(heroId)
  end
  local model, name, campName
  if heroData ~= nil then
    _, model, _, _ = heroData:GetHeroArchiveInfo()
    name = heroData:GetName()
    campName = LanguageUtil.GetLocaleText(heroData:GetCampCfg().name)
  else
    model = self.ui.str_lockedName or "NaN"
    name = self.ui.str_lockedModel or "NaN"
    campName = "???"
  end
  self.ui.tex_HeroName.text = name
  self.ui.text_HeroModel.text = model
  self:SetHeroHeadIcon(heroData, heroId)
  return name, campName
end

function UIN_HBHeroHeroListHeroItem:SetHeroHeadIcon(heroData, heroId)
  if heroData ~= nil then
    local resName = heroData:GetHeroHeadResName()
    if string.IsNullOrEmpty(resName) ~= nil then
      self.ui.img_HeroPic.sprite = CRH:GetSprite(resName, CommonAtlasType.HeroHeadIcon)
      self.ui.img_HeroPic.color = Color.white
    end
    return
  end
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg ~= nil then
    local itemCfg = ConfigData.item[heroCfg.fragment]
    if itemCfg ~= nil then
      local resName = itemCfg.icon
      if string.IsNullOrEmpty(resName) ~= nil then
        self.ui.img_HeroPic.sprite = CRH:GetSprite(resName, CommonAtlasType.HeroHeadIcon)
        self.ui.img_HeroPic.color = Color.black
      end
    end
  end
end

function UIN_HBHeroHeroListHeroItem:__OnClick()
  AudioManager:PlayAudioById(1222)
  if self.onClickHeroItem ~= nil then
    self.onClickHeroItem(self.heroId)
  end
end

function UIN_HBHeroHeroListHeroItem:HBHeroHeadPlayBlinkTween(order)
  self:ClearHBHeroItemTween()
  self.ui.cg_HeroItem:DOFade(0, 0.1):From():SetDelay(order * 0.05)
  self.ui.img_corver:DOFade(1, 0.05):From():SetDelay((order + 1) * 0.05):SetLoops(3, cs_DoTweenLoopType.Yoyo)
end

function UIN_HBHeroHeroListHeroItem:ClearHBHeroItemTween()
  self.ui.cg_HeroItem:DOComplete()
  self.ui.img_corver:DOComplete()
end

function UIN_HBHeroHeroListHeroItem:OnDelete()
  self:ClearHBHeroItemTween()
  base.OnDelete(self)
end

return UIN_HBHeroHeroListHeroItem
