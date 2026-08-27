local UINFmtHeroInfoItem = class("UINFmtHeroInfoItem", UIBaseNode)
local base = UIBaseNode
local UINFmtHeroHpBarItem = require("Game.Formation.UI.2DFormation.UINFmtHeroHpBarItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UIHeroUtil = require("Game.CommonUI.Hero.UIHeroUtil")
local cs_tweening = CS.DG.Tweening

function UINFmtHeroInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SpecIcon, self, self.OnFmtSpecIconClicked)
  self.potentialImgWidth = self.ui.img_Limit.sprite.textureRect.width
  self.limitInfoWith = self.ui.rect_limitInfo.sizeDelta.x
  self.ui.img_star.gameObject:SetActive(false)
  self.starList = {}
  self.ui.hPBar:SetActive(false)
  self.ui.img_Camp.gameObject:SetActive(false)
end

function UINFmtHeroInfoItem:InitFmtHeroInfo(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
  self.isVirtualData = self.enterFmtData:IsFmtCtrlVirtualFmtData()
end

function UINFmtHeroInfoItem:RefreshFmtheroInfo(heroData, position, onlyPos)
  local oldHeroData = self.heroData
  self.heroData = heroData
  if position ~= nil then
    self.transform.anchoredPosition = position
  end
  if onlyPos then
    return
  end
  self:__TryRefreshHeroStaticInfo(oldHeroData)
  self:__TryRefreshStar()
  self:__TryRefreshSupport()
  self:__TryRefreshPotential()
  self:__TryUpdFmtHeroInfoItemHp()
  self:InitRefreshReddotTip()
  self:RefreshLevelTip()
  self:SetFmtHeroInfoItemLv(self.heroData.level)
end

function UINFmtHeroInfoItem:__TryRefreshHeroStaticInfo(oldHeroData)
  if oldHeroData ~= self.heroData then
    self.ui.img_Career.sprite = CRH:GetSprite(self.heroData:GetCareerCfg().icon, CommonAtlasType.CareerCamp)
    self.ui.tex_Name.text = self.heroData:GetHeroName(true)
    local isShowCamp = self.enterFmtData:IsBondModule()
    if isShowCamp then
      self.ui.img_Camp.gameObject:SetActive(true)
      local campCfg = self.heroData:GetCampCfg()
      self.ui.img_Camp.sprite = CRH:GetSprite(campCfg.bond_icon, CommonAtlasType.CareerCamp)
    end
  end
end

function UINFmtHeroInfoItem:__TryRefreshStar()
  for k, v in ipairs(self.starList) do
    v.gameObject:SetActive(false)
    v:SetIndex(0)
  end
  local star = self.heroData.star
  local count = math.ceil(star / 2)
  local isHalf = star % 2 == 1
  for i = 1, count do
    local star = self.starList[i]
    if star == nil then
      star = self.ui.img_star.gameObject:Instantiate():GetComponent(typeof(CS.UiImageItemInfo))
      table.insert(self.starList, star)
    end
    star.gameObject:SetActive(true)
    if isHalf and i == count then
      star:SetIndex(1)
    end
  end
end

function UINFmtHeroInfoItem:__TryRefreshSupport(oldHeroData)
  self.ui.obj_isSupport:SetActive(self.heroData.isFriendSupport)
end

function UINFmtHeroInfoItem:__TryUpdFmtHeroInfoItemHp()
  if not self.enterFmtData:IsFmtInBattleDeploy() then
    return
  end
  if self.hpBarItem == nil then
    self.hpBarItem = UINFmtHeroHpBarItem.New()
    self.hpBarItem:Init(self.ui.hPBar)
    self.hpBarItem:Show()
  end
  local fmtDungeonDyncData = self.enterFmtData:GetFmtDungeonDyncData()
  local hpPer = fmtDungeonDyncData:GetDungeonDyncHeroHpPer(self.heroData)
  local maxHp = self.heroData:GetAttr(eHeroAttr.maxHp)
  self.hpBarItem:InitFmtHeroHpBarItem(hpPer, maxHp)
end

function UINFmtHeroInfoItem:SetFmtHeroInfoItemLv(level)
  self.ui.tex_HeroLevel:SetIndex(0, tostring(level))
  self.ui.tex_HeroLevel.text.color = UIHeroUtil.GetHeroLevelColor(level)
end

function UINFmtHeroInfoItem:__TryRefreshPotential()
  local potentialMaxNum = self.heroData:GetMaxPotential(true)
  local potential = self.heroData.potential
  potentialMaxNum = math.max(potential, potentialMaxNum)
  local size = self.ui.img_LimitUp_empty.rectTransform.sizeDelta
  size.x = self.potentialImgWidth * potentialMaxNum
  self.ui.img_LimitUp_empty.rectTransform.sizeDelta = size
  local size = self.ui.rect_limitInfo.sizeDelta
  size.x = self.limitInfoWith + (potentialMaxNum - 5) * self.potentialImgWidth * 0.25
  self.ui.rect_limitInfo.sizeDelta = size
  local vec = self.ui.img_Limit.rectTransform.sizeDelta
  vec.x = self.potentialImgWidth * potential
  self.ui.img_Limit.rectTransform.sizeDelta = vec
end

function UINFmtHeroInfoItem:SetChangeMarkState(flag)
  if not IsNull(self.ui.tween_CanChange) and not self.heroData.isFixedFmtHero then
    self.ui.tween_CanChange.gameObject:SetActive(flag)
    if flag then
      self.ui.tween_CanChange:DORestart()
    else
      self.ui.tween_CanChange:DOPause()
    end
  end
end

function UINFmtHeroInfoItem:SetFmtSpecialGameHeroActive(sepcShowType)
  self.__sepcShowType = sepcShowType
  self.ui.btn_SpecIcon.gameObject:SetActive(0 < sepcShowType)
  if 0 < sepcShowType then
    self.ui.img_SpecIcon:SetIndex(sepcShowType - 1)
    self.ui.btn_SpecIcon.enabled = sepcShowType == ExplorationEnum.SpecGameTypeAdapter.TD
  end
end

function UINFmtHeroInfoItem:OnFmtSpecIconClicked()
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

function UINFmtHeroInfoItem:FmtHeroAblePotential()
  if self.isVirtualData then
    return false
  end
  return self.__heroAblePotential
end

function UINFmtHeroInfoItem:RefreshLevelTip()
  self.__heroAblePotential = false
  self.ui.img_CanLevelUp.image.enabled = false
  if self.heroData == nil or self.isVirtualData then
    return
  end
  if self.heroData.isFriendSupport or self.heroData.isFixedFmtHero then
    return
  end
  if self.heroData:CanHeroUsePotential() and not self.heroData:IsHeroLongTrailLevel() then
    self.ui.img_CanLevelUp.image.enabled = true
    self.ui.img_CanLevelUp:SetIndex(1)
    self.__heroAblePotential = true
    return
  end
  if not self.heroData:AbleUpLevel() then
    return
  end
  local canLevelUp, _ = self.heroData:GenHeroCanQuickLevelUp()
  if canLevelUp and not self.heroData:IsHeroLongTrailLevel() then
    self.ui.img_CanLevelUp.image.enabled = true
    self.ui.img_CanLevelUp:SetIndex(0)
  end
end

function UINFmtHeroInfoItem:InitRefreshReddotTip()
  local ok, redNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroData.dataId, RedDotStaticTypeId.HeroStarUp)
  if ok then
    if self.__refreshAbleUpStar == nil then
      function self.__refreshAbleUpStar(node)
        self:RefreshReddotTip()
      end
      
      RedDotController:AddListener(redNode.nodePath, self.__refreshAbleUpStar)
    end
    self:RefreshReddotTip()
  end
end

function UINFmtHeroInfoItem:__RemoveRefreshReddotTip()
  if self.__refreshAbleUpStar ~= nil then
    local ok, redNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroData.dataId, RedDotStaticTypeId.HeroStarUp)
    if ok then
      RedDotController:RemoveListener(redNode.nodePath, self.__refreshAbleUpStar)
    end
    self.__refreshAbleUpStar = nil
  end
end

function UINFmtHeroInfoItem:RefreshReddotTip()
  local isShow = false
  if self.heroData ~= nil and not self.isVirtualData then
    local ok, redNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroData.dataId, RedDotStaticTypeId.HeroStarUp)
    if ok and redNode:GetRedDotCount() > 0 then
      isShow = true
    end
  end
  if self.heroData.isFriendSupport or self.heroData.isFixedFmtHero then
    isShow = false
  end
  if isShow and self.heroData:AbleUpgradeStar() then
    if self.extraStar == nil then
      self.extraStar = self.ui.img_star.gameObject:Instantiate():GetComponent(typeof(CS.UiImageItemInfo))
    end
    if self.heroData:IsHalfStar() then
      local index = 1
      for i = 1, #self.starList do
        if not self.starList[i].gameObject.activeSelf then
          index = i - 1
          break
        end
        if i == #self.starList then
          index = i
        end
      end
      local parentTr = self.starList[index].transform
      self.extraStar.transform:SetParent(parentTr)
      self.extraStar.transform.localPosition = Vector3.zero
      self.extraStar:SetIndex(0)
    else
      self.extraStar.transform:SetParent(self.ui.img_star.transform.parent)
      self.extraStar.transform:SetAsLastSibling()
      self.extraStar:SetIndex(1)
    end
    if self.extraStarTween ~= nil then
      self.extraStarTween:Rewind()
      self.extraStarTween:Kill()
      self.extraStarTween = nil
    end
    self.extraStar.gameObject:SetActive(true)
    self.extraStarTween = self.extraStar.image:DOFade(0.2, 0.5):SetLoops(-1, cs_tweening.LoopType.Yoyo)
  else
    if self.extraStarTween ~= nil then
      self.extraStarTween:Rewind()
      self.extraStarTween:Kill()
      self.extraStarTween = nil
    end
    if self.extraStar ~= nil then
      self.extraStar.gameObject:SetActive(false)
    end
  end
end

function UINFmtHeroInfoItem:OnDelete()
  self:__RemoveRefreshReddotTip()
  if self.extraStarTween ~= nil then
    self.extraStarTween:Rewind()
    self.extraStarTween:Kill()
    self.extraStarTween = nil
  end
  if self.hpBarItem ~= nil then
    self.hpBarItem:Delete()
  end
  base.OnDelete(self)
end

return UINFmtHeroInfoItem
