local UIHeroInfoState = class("UIHeroInfoState", UIBaseWindow)
local base = UIBaseWindow
local UINSupportHeroAth = require("Game.Formation.UI.SupportHeroList.UINSupportHeroAth")
local UINAthSuitMainItem = require("Game.Arithmetic.AthMain.UINAthSuitMainItem")
local UINHeroTag = require("Game.Hero.NewUI.State.UINHeroTag")
local UINHeroAttrItem = require("Game.Formation.UI.Common.UINHeroAttrItem")
local UINSupportHeroSkill = require("Game.Formation.UI.SupportHeroList.UINSupportHeroSkill")
local HeroInfoData = require("Game.Lottery.Data.HeroInfoData")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local cs_Shadow = CS.UnityEngine.UI.Shadow
local cs_tweening = CS.DG.Tweening
local cs_DOTween = cs_tweening.DOTween
local cs_ResLoader = CS.ResLoader

function UIHeroInfoState:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickReturn)
  UIUtil.AddButtonListener(self.ui.btn_ShowIntro, self, self.OnClickFackerTalent)
  self.resloader = cs_ResLoader.Create()
  self.startList = {}
  table.insert(self.startList, self.ui.img_star)
  self.ui.img_star.gameObject:SetActive(false)
  self.tagPool = UIItemPool.New(UINHeroTag, self.ui.tagItem)
  self.ui.tagItem:SetActive(false)
  self.attrPool = UIItemPool.New(UINHeroAttrItem, self.ui.attriItem)
  self.ui.attriItem:SetActive(false)
  self.athPool = UIItemPool.New(UINSupportHeroAth, self.ui.athItem)
  self.ui.athItem:SetActive(false)
  self.athSuitPool = UIItemPool.New(UINAthSuitMainItem, self.ui.suitItem)
  self.ui.suitItem:SetActive(false)
  self.skillItemList = {}
  for i, skillItemObj in ipairs(self.ui.skillItemArr) do
    local item = UINSupportHeroSkill.New()
    item:Init(skillItemObj)
    table.insert(self.skillItemList, item)
  end
  for _, tween in ipairs(self.ui.tweens) do
    tween:DOPlay()
  end
  self.ui.tex_tips.text = ConfigData:GetTipContent(317)
  self._onDescribeChange = BindCallback(self, self._OnSupportHeroDescribeChange)
  MsgCenter:AddListener(eMsgEventId.DescribeSettingChange, self._onDescribeChange)
end

function UIHeroInfoState:InitHeroInfoState(heroId)
  self.heroId = heroId
  self.heroInfo = HeroInfoData.New()
  self.heroInfo:InitData(self.heroId)
  self.heroInfo:GenMaxTalent()
  self.heroInfo:GenSpecWeaopn()
  self:RefreshHeroBase()
  self:RefreshHeroDetail()
  self:RefreshHeroSkill()
  self:RefreshTalentState()
end

function UIHeroInfoState:RefreshHeroBase()
  local heroCfg = self.heroInfo.heroCfg
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(heroCfg.name)
  self.ui.tex_ENName.text = heroCfg.name_en
  self.ui.efficiency:SetActive(false)
  self.ui.img_Carrer:SetIndex(heroCfg.career - 1)
  self.ui.tex_Level:SetIndex(0, tostring(self.heroInfo.heroData.level))
  local rare = self.heroInfo.rankCfg.rare
  self.ui.img_Quality.color = HeroRareColor[rare]
  local campCfg = ConfigData.camp[self.heroInfo.camp]
  self.ui.img_Camp.gameObject:SetActive(false)
  self.resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campCfg.icon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_Camp.gameObject:SetActive(true)
    self.ui.img_Camp.texture = texture
  end)
  self:LoadHeroModel()
  local tags = self.heroInfo.heroData:GetHeroTag()
  self.tagPool:HideAll()
  for _, tagId in ipairs(tags) do
    local item = self.tagPool:GetOne()
    item:InitTag(tagId)
  end
end

function UIHeroInfoState:LoadHeroModel()
  if self.heroInfo == nil then
    return
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  self.bigImgResloader = cs_ResLoader.Create()
  local picName = self.heroInfo:GetResPicName()
  local resPath = PathConsts:GetCharacterLive2DPath(picName)
  local isLocked = HeroCubismInteration.JudgeL2DLocked(self.heroInfo.skinId)
  local isHaveL2D = PlayerDataCenter.skinData:IsHaveL2d(self.heroInfo.skinId)
  if isHaveL2D and not isLocked then
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgResloader:LoadABAssetAsync(resPath, function(l2dModelAsset)
      self.bigImgGameObject = l2dModelAsset:Instantiate(self.ui.heroHolder.transform)
      self.bigImgGameObject.transform:SetLayer(LayerMask.UI)
      local cs_CubismInterationController = self.bigImgGameObject.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
      if cs_CubismInterationController ~= nil then
        self.heroCubismInteration = HeroCubismInteration.New()
        local heroId = self.heroInfo.heroId
        local skinId = self.heroInfo.skinId
        self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
        self.heroCubismInteration:SetInterationOpenWait(false)
        self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
        self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.cav_heroHolder, nil, true)
        self.heroCubismInteration:SetL2DPosType("HeroSkin", false)
      end
    end)
  else
    resPath = PathConsts:GetCharacterBigImgPrefabPath(picName)
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgResloader:LoadABAssetAsync(resPath, function(prefab)
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroSkin")
      if self.heroInfo:GetHeroInfoIsNotHaveLegalSkin() then
        local rawImage = self.bigImgGameObject:FindComponent(eUnityComponentID.RawImage)
        rawImage.material = CS.UnityEngine.Object.Instantiate(self.ui.mat_heroPicPaperCut)
      end
      self:UpdateHeroShadow()
    end)
  end
end

function UIHeroInfoState:UpdateHeroShadow()
  if IsNull(self.bigImgGameObject) then
    return
  end
  self.shadow = self.bigImgGameObject:GetComponent(typeof(cs_Shadow))
  if self.shadow == nil then
    self.shadow = self.bigImgGameObject:AddComponent(typeof(cs_Shadow))
  end
  self.shadow.effectColor = Color.New(0, 0, 0, 0.25)
  self.shadow.effectDistance = Vector2.zero
  local OverDis = Vector2.New(-12, -14)
  self.sdTween = cs_DOTween.To(function()
    return self.shadow.effectDistance
  end, function(x)
    self.shadow.effectDistance = x
  end, OverDis, 1):SetEase(CS.DG.Tweening.Ease.OutExpo):SetLink(self.shadow.gameObject)
end

function UIHeroInfoState:RefreshHeroDetail()
  local starCount = self.heroInfo.heroData.star / 2
  local isHalfStar = self.heroInfo.heroData:IsHalfStar()
  for i = 1, #self.startList do
    local starItem = self.startList[i]
    if i < starCount then
      starItem:SetIndex(0)
    elseif i == starCount then
      starItem:SetIndex(isHalfStar and 1 or 0)
    else
      starItem.gameObject:SetActive(false)
    end
  end
  for i = #self.startList, starCount do
    local starItem = self.ui.img_star.gameObject:Instantiate():GetComponent(typeof(CS.UiImageItemInfo))
    table.insert(self.startList, starItem)
    starItem.gameObject:SetActive(true)
    if i < starCount then
      starItem:SetIndex(0)
    else
      starItem:SetIndex(isHalfStar and 1 or 0)
    end
  end
  local potentialImgWidth = self.ui.img_Breakthrough.sprite.textureRect.width
  local vec = self.ui.img_Breakthrough.rectTransform.sizeDelta
  vec.x = potentialImgWidth * self.heroInfo.heroData.potential
  self.ui.img_Breakthrough.rectTransform.sizeDelta = vec
  self.attrPool:HideAll()
  for k, attrId in ipairs(ConfigData.game_config.supportDetailAttr) do
    local attrValue = self.heroInfo.heroData:GetAttr(attrId)
    local item = self.attrPool:GetOne()
    item:InitHeroAttrItem(attrId, attrValue, nil)
  end
  self.ui.suitList:SetActive(false)
  local athSlotList = self.heroInfo.heroData:GetAthSlotList(true)
  for index, space in ipairs(athSlotList) do
    local item = self.athPool:GetOne()
    item:InitAth(index, space)
  end
  local weaponId, weaponData = self.heroInfo.heroData:GetSpecWeaponData()
  if weaponId then
    self.ui.obj_SpecWeapon:SetActive(true)
    local heroId = self.heroInfo.heroData.dataId
    self.resloader:LoadABAssetAsync(PathConsts:GetSpecWeaponPicPath(heroId), function(texture)
      if IsNull(self.transform) then
        return
      end
      if not texture then
        error("specWeapon icon texture not exit")
        return
      end
      self.ui.img_SpecWeapon.texture = texture
    end)
    self.ui.obj_WeaponUnlock:SetActive(false)
    if weaponData then
      self.ui.img_ArmaLvbg:SetActive(true)
      local step = weaponData:GetSpecWeaponCurStep()
      self.ui.tex_SpecWeaponState.text = LanguageUtil.GetRomanNumber(step)
      self.ui.tex_SpecWeaponLv.text = "LV." .. tostring(weaponData:GetSpecWeaponCurLevel())
    else
      self.ui.img_ArmaLvbg:SetActive(false)
      self.ui.obj_WeaponUnlock:SetActive(true)
    end
  else
    self.ui.obj_SpecWeapon:SetActive(false)
  end
end

function UIHeroInfoState:RefreshHeroSkill()
  local skillDataList = {}
  for i, skillData in ipairs(self.heroInfo.heroData.skillList) do
    if not skillData:IsCommonAttack() then
      skillData:UpdateSkill(skillData:GetMaxLevel())
      table.insert(skillDataList, skillData)
    end
  end
  for i = 1, #self.skillItemList do
    local item = self.skillItemList[i]
    if i > #skillDataList then
      item:Hide()
    else
      item:Show()
      item:InitSupportHeroSkill(skillDataList[i], self.resloader)
    end
  end
end

function UIHeroInfoState:RefreshTalentState()
  self.ui.btn_ShowIntro.gameObject:SetActive(true)
  local talentData = self.heroInfo.heroData:GetHeroDataTalent()
  if talentData == nil then
    self.ui.talentHolder:SetActive(false)
    return
  end
  self.ui.talentHolder:SetActive(true)
  local level = talentData:GetHeroTalentTotalLevel()
  local stage, stageDes = ConfigData:GetTalentStage(level)
  self.ui.img_Talent:SetIndex(stage - 1)
  self.ui.tex_TalentStage.text = stageDes
end

function UIHeroInfoState:OnClickFackerTalent()
  if self.heroInfo.heroData:GetHeroDataTalent() == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroTalent, function(win)
    if win == nil then
      return
    end
    self:Hide()
    win:InitHeroTalentMain(self.heroInfo.heroData, function()
      self:Show()
    end)
  end)
end

function UIHeroInfoState:_OnClickReturn()
  for _, tween in ipairs(self.ui.tweens) do
    tween:DOKill()
  end
  self:Delete()
end

function UIHeroInfoState:_OnSupportHeroDescribeChange()
  if self.skillItemList == nil then
    return
  end
  for _, item in ipairs(self.skillItemList) do
    item:UpdateLevelDescribe()
  end
end

function UIHeroInfoState:OnDeleteEntity()
  base.OnDeleteEntity(self)
  self.tagPool:DeleteAll()
  self.attrPool:DeleteAll()
  self.athPool:DeleteAll()
  self.athSuitPool:DeleteAll()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.heroLoader ~= nil then
    self.heroLoader:Put2Pool()
    self.heroLoader = nil
  end
  if self.Live2DResloader ~= nil then
    self.Live2DResloader:Put2Pool()
    self.Live2DResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
  end
  if not IsNull(self.l2dModelIns) then
    HeroCubismInteration.DestroyInterationInstance(self.l2dModelIns)
  end
  MsgCenter:RemoveListener(eMsgEventId.DescribeSettingChange, self._onDescribeChange)
end

return UIHeroInfoState
