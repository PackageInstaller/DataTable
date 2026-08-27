local UINHeroCardItem = class("UINHeroCardItem", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UIHeroUtil = require("Game.CommonUI.Hero.UIHeroUtil")
local VowEnum = require("Game.VowSystem.Data.VowEnum")
local cs_Object = CS.UnityEngine.Object

function UINHeroCardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_HeroItem, self, self.OnItemClicked)
  UIUtil.AddButtonListener(self.ui.btn_SpecIcon, self, self.OnSpecIconClicked)
  self.ui.img_OnSelect.gameObject:SetActive(false)
  self.ui.img_star.gameObject:SetActive(false)
  self.ui.obj_isBench:SetActive(false)
  self:SetRedDotActive(false)
  self:SetBlueDotActive(false)
  self.ui.starArr = {}
  for i = 1, ConfigData.hero_rank.maxStar / 2 do
    local go = self.ui.img_star.gameObject:Instantiate()
    go:SetActive(true)
    local imgItemInfo = go:GetComponent(typeof(CS.UiImageItemInfo))
    table.insert(self.ui.starArr, imgItemInfo)
  end
  self:SetEfficiencyActive(false)
  self.ui.potentialImgWidth = self.ui.img_LimitUp.sprite.textureRect.width
  local mat = cs_Object.Instantiate(self.ui.img_Hero.material)
  self.ui.img_Hero.material = mat
  self.ui.img_Camp.material = cs_Object.Instantiate(self.ui.img_Camp.material)
end

function UINHeroCardItem:InitHeroCardItem(heroData, resloader, clickedAction)
  self.heroData = heroData
  self.resloader = resloader
  self.onClickedAction = clickedAction
  self.__initTexture = true
  self.ui.talent:SetActive(false)
  self.ui.img_SpecWeapon:SetActive(false)
  self:RefreshHeroCardItem()
  self:SetEffectMask()
end

function UINHeroCardItem:RefreshHeroCardItem()
  if self.heroData == nil then
    return
  end
  self.ui.obj_Locked:SetActive(self.heroData.isLockedHero)
  if self.heroData.isLockedHero then
    self:RefreshFragMerge()
  end
  self:__SetStarUI(self.heroData.star)
  self:__SetHeroLevel(self.heroData.level)
  self:__SetPotential(self.heroData)
  self.ui.tex_HeroID:SetIndex(0, tostring(self.heroData.dataId))
  self.ui.tex_Name.text = self.heroData:GetHeroName(true)
  self.ui.img_Quality.color = HeroRareColor[self.heroData.rare]
  self.ui.img_QualityLight.color = HeroRareColor[self.heroData.rare]
  self.ui.img_Career.sprite = CRH:GetSprite(self.heroData:GetCareerCfg().icon, CommonAtlasType.CareerCamp)
  if self.__initTexture then
    self.__initTexture = false
    self.ui.img_Hero.enabled = false
    self:UpdateSkin()
    local campIcon = LanguageUtil.GetLocaleText(self.heroData:GetCampCfg().icon)
    if campIcon ~= nil then
      self.ui.img_Camp.enabled = false
      self:__SetTexture(PathConsts:GetCampPicPath(campIcon), self.ui.img_Camp)
    end
  end
  local isVowed = self.heroData:GetHeroIsVowed()
  self.ui.obj_vowFrame:SetActive(isVowed)
  self:RefreshSpecialFocus(self.heroData.isFriendSupport, self.heroData.isOfficialSupport)
  self:RefreshTalentState()
  self:RefreshSpecWeaponState()
end

function UINHeroCardItem:SetEffectMask()
  local uiPartrans = self.transform:Find("Card/Img_VowFrame/FXP_vowcard_open")
  if IsNull(uiPartrans) then
    return
  end
  local uiPar = uiPartrans:GetComponent(typeof(CS.Coffee.UIExtensions.UIParticle))
  if IsNull(uiPar) then
    return
  end
  local mask2D
  local obj = self.transform.parent
  while not IsNull(obj.gameObject) and obj.gameObject.name ~= "UIRoot" do
    mask2D = obj:GetComponent(typeof(CS.UnityEngine.UI.RectMask2D))
    if not IsNull(mask2D) then
      break
    end
    obj = obj.transform.parent
  end
  if IsNull(mask2D) then
    return
  end
  local rect = mask2D.canvasRect
  uiPar:SetClipRect(rect, true)
end

function UINHeroCardItem:RefreshSpecialFocus(isFriendSupport, isOfficialSupport)
  local maskIndex = 0
  if not isFriendSupport and not isOfficialSupport and PlayerDataCenter.favorHeroData:IsFavorHero(self.heroData.dataId) then
    maskIndex = 1
  end
  self.ui.img_heroNameMask:SetIndex(maskIndex)
end

function UINHeroCardItem:UpdateSkin()
  self:__SetTexture(PathConsts:GetCharacterPicPath(self.heroData:GetResPicName(), self.heroData:GetSkinResFromWhere()), self.ui.img_Hero, function()
    if self.heroData.isLockedHero or self.heroData:GetHeroIsNotHaveLegalSkin() then
      self.ui.img_Hero.material:SetFloat("_CoverColorRate", 1.0)
    else
      self.ui.img_Hero.material:SetFloat("_CoverColorRate", 0.0)
    end
  end)
end

function UINHeroCardItem:OnItemClicked()
  if self.onClickedAction ~= nil then
    self.onClickedAction(self.heroData)
  end
end

function UINHeroCardItem:SetRedDotActive(active)
  self.ui.redDot:SetActive(active)
end

function UINHeroCardItem:SetBlueDotActive(active)
  self.ui.blueDot:SetActive(active)
end

function UINHeroCardItem:SetSelectActive(active, isbench, isFavor)
  self.ui.img_OnSelect.gameObject:SetActive(active)
  if active then
    self.ui.img_OnSelect.color = isbench and self.ui.col_SubSelect or self.ui.col_Select
    self.ui.obj_isBench:SetActive(isbench)
    if self.ui.img_selectIcon ~= nil then
      if isFavor then
        self.ui.img_selectIcon:SetIndex(1)
      else
        self.ui.img_selectIcon:SetIndex(0)
      end
    end
  end
end

function UINHeroCardItem:SetEfficiencyActive(active)
  self.ui.obj_efficiency:SetActive(active)
  if active then
    self.ui.tex_Efficiency.text = tostring(self.heroData:GetFightingPower())
  end
end

function UINHeroCardItem:RefreshFightPower()
  if self.heroData.isLockedHero then
    return
  end
  self.ui.tex_Efficiency.text = tostring(self.heroData:GetFightingPower())
end

function UINHeroCardItem:SetSpecialGameHeroActive(sepcShowType)
  self.__sepcShowType = sepcShowType
  self.ui.btn_SpecIcon.gameObject:SetActive(0 < sepcShowType)
  if 0 < sepcShowType then
    self.ui.img_SpecIcon:SetIndex(sepcShowType - 1)
    self.ui.btn_SpecIcon.enabled = sepcShowType == ExplorationEnum.SpecGameTypeAdapter.TD
  end
end

function UINHeroCardItem:ShowTalentStage(talentLevel)
  if ConfigData.buildinConfig.HeroTalentForbid then
    return
  end
  self.ui.talent:SetActive(true)
  local stage = ConfigData:GetTalentStage(talentLevel)
  self.ui.img_Talent:SetIndex(stage - 1)
end

function UINHeroCardItem:RefreshTalentState()
  local talent = self.heroData:GetHeroDataTalent()
  if talent == nil then
    return
  end
  self:ShowTalentStage(talent:GetHeroTalentTotalLevel())
end

function UINHeroCardItem:RefreshSpecWeaponState()
  local weaponId = PlayerDataCenter.allSpecWeaponData:GetHeroSpecWeaponId(self.heroData.dataId)
  if weaponId == nil then
    return
  end
  self.ui.img_SpecWeapon:SetActive(true)
  local specWeaponData = self.heroData:GetHeroDataSpecWeapon(weaponId)
  if specWeaponData == nil then
    self.ui.img_SpecWeaponFade.alpha = 0.6
    self.ui.img_SpecWeaponLV:SetIndex(0)
    return
  end
  local step = specWeaponData:GetSpecWeaponCurStep()
  self.ui.img_SpecWeaponLV:SetIndex(step)
  self.ui.img_SpecWeaponFade.alpha = step == 0 and 0.6 or 1
end

function UINHeroCardItem:OnSpecIconClicked()
  if self.__sepcShowType == ExplorationEnum.SpecGameTypeAdapter.TD then
    local infoStr = ""
    local specCfg = ConfigData.skill_adapter.td_adapter[self.heroData.dataId]
    if specCfg ~= nil then
      infoStr = LanguageUtil.GetLocaleText(specCfg.adapter_desc)
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
      if window == nil then
        return
      end
      window:InitCommonInfo(infoStr, ConfigData:GetTipContent(950))
      window:SetCommonInfoFontSize(ConfigData.buildinConfig.SpecHeroInfoFontSize)
    end)
  end
end

function UINHeroCardItem:RefreshFragMerge()
  if self.heroData:IsHeroNotMergeable() then
    self.ui.obj_canUnlock:SetActive(false)
    self.ui.obj_chipCount:SetActive(false)
    return
  end
  self.ui.obj_canUnlock:SetActive(true)
  self.ui.obj_chipCount:SetActive(true)
  local couldMerge, curFrage, mergeNeedFrage = self.heroData:GetIsCouldMerge()
  self.ui.obj_canUnlock:SetActive(couldMerge)
  if couldMerge then
    self.ui.tex_ChipCount:SetIndex(0, tostring(curFrage), tostring(mergeNeedFrage))
  else
    self.ui.tex_ChipCount:SetIndex(1, tostring(curFrage), tostring(mergeNeedFrage))
  end
end

function UINHeroCardItem:__SetStarUI(starCount)
  local count = math.ceil(starCount / 2)
  local isHalf = starCount % 2
  for i = 1, count do
    self.ui.starArr[i].gameObject:SetActive(true)
    self.ui.starArr[i]:SetIndex(0)
    if i == count and isHalf == 1 then
      self.ui.starArr[i]:SetIndex(1)
    end
  end
  for i = count + 1, #self.ui.starArr do
    self.ui.starArr[i].gameObject:SetActive(false)
  end
end

function UINHeroCardItem:__SetPotential(heroData)
  local potentialMaxNum = heroData:GetMaxPotential(true)
  local size = self.ui.img_LimitUp_empty.rectTransform.sizeDelta
  size.x = self.ui.potentialImgWidth * potentialMaxNum
  self.ui.img_LimitUp_empty.rectTransform.sizeDelta = size
  local potential = heroData.potential
  local vec = self.ui.img_LimitUp.rectTransform.sizeDelta
  vec.x = self.ui.potentialImgWidth * potential
  self.ui.img_LimitUp.rectTransform.sizeDelta = vec
end

function UINHeroCardItem:__SetHeroLevel(levelNum)
  self.ui.obj_TrimTex:SetActive(levelNum < 10)
  self.ui.tex_Level.text = tostring(levelNum)
  self.ui.tex_Level.color = UIHeroUtil.GetHeroLevelColor(levelNum)
end

function UINHeroCardItem:__SetTexture(path, rawImageGo, callback)
  local heroData = self.heroData
  self.resloader:LoadABAssetAsync(path, function(texture)
    if IsNull(self.transform) then
      return
    end
    if heroData ~= self.heroData then
      return
    end
    rawImageGo.texture = texture
    rawImageGo.enabled = true
    if callback ~= nil then
      callback()
    end
  end)
end

function UINHeroCardItem:OnDelete()
  DestroyUnityObject(self.ui.img_Hero.material)
  DestroyUnityObject(self.ui.img_Camp.material)
  self.resloader = nil
  base.OnDelete(self)
end

return UINHeroCardItem
