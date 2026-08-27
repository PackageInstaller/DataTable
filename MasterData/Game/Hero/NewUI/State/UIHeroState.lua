local UIHeroState = class("UIHeroState", UIBaseWindow)
local base = UIBaseWindow
local UIAttrUtil = require("Game.CommonUI.Hero.Attr.UIAttrUtil")
local UINHeroScoreItem = require("Game.Hero.NewUI.State.UINHeroScoreItem")
local UINHeroStateSkillItem = require("Game.Hero.NewUI.State.UINHeroStateSkillItem")
local UINHeroTag = require("Game.Hero.NewUI.State.UINHeroTag")
local UINAthHeroInfo = require("Game.Arithmetic.AthHeroInfo.UINAthHeroInfo")
local UIHeroStateShowL2D = require("Game.Hero.NewUI.State.UIHeroStateShowL2D")
local JumpManager = require("Game.Jump.JumpManager")
local ShopUtil = require("Game.Shop.ShopUtil")
local UIHeroUtil = require("Game.CommonUI.Hero.UIHeroUtil")
local SkinEnum = require("Game.Skin.SkinEnum")
local CampEnum = require("Game.Common.Camp.CampEnum")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local HeroLookTargetController = require("Game.Hero.Live2D.HeroLookTargetController")
local cs_ResLoader = CS.ResLoader
local CS_Screen = CS.UnityEngine.Screen
local cs_Shadow = CS.UnityEngine.UI.Shadow
local cs_tweening = CS.DG.Tweening
local cs_DOTween = cs_tweening.DOTween
local CS_coroutine = require("XLua.Common.cs_coroutine")
local cs_MessageCommon = CS.MessageCommon
local CS_EventTriggerListener = CS.EventTriggerListener
local VowEnum = require("Game.VowSystem.Data.VowEnum")
local HeroEnum = require("Game.PlayerData.Hero.HeroEnum")

function UIHeroState:InitAllTween()
  self.allTweens = self.transform:GetComponentsInChildren(typeof(cs_tweening.DOTweenAnimation))
end

function UIHeroState:PlayAllDOTween()
  for i = 0, self.allTweens.Length - 1 do
    local tween = self.allTweens[i]
    tween:DORestart(false)
  end
end

function UIHeroState:OnInit()
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  self.campPos = self.ui.group_img_Camp.transform.localPosition
  self.heroPos = self.ui.group_hero.transform.localPosition
  self.resloader = nil
  self.StarList = {}
  self.heroId = nil
  self.heroData = nil
  self.heroDataList = nil
  self.bigImgResloader = nil
  self.levelUpWin = nil
  self.starUpWin = nil
  self.skillUgradeWin = nil
  UIUtil.SetTopStatus(self, self.Return, nil)
  UIUtil.AddButtonListener(self.ui.btn_LimitUp, self, self.OnClickLimitUp)
  UIUtil.AddButtonListener(self.ui.btn_QuickLevelUp, self, self._OnClickQuickLvUp)
  self.ui.btn_QuickLevelUp.responseOnceByPress = false
  self.ui.btn_QuickLevelUp.onPress:AddListener(BindCallback(self, self.OnPressQuickLvUp))
  self.ui.btn_QuickLevelUp.onPressUp:AddListener(BindCallback(self, self.OnPressUpQuickLvUp))
  self.ui.btn_QuickLevelUp.onPressDown:AddListener(BindCallback(self, self.OnPressDownQuickLvUp))
  UIUtil.AddButtonListener(self.ui.btn_StarUp, self, self.OnClickStarUP)
  UIUtil.AddButtonListener(self.ui.btn_Friendship, self, self.OnClickFriendship)
  UIUtil.AddButtonListener(self.ui.btn_Skill, self, self.OnClickSillUpgrade)
  UIUtil.AddButtonListener(self.ui.btn_Attri, self, self.OnClickAttribute)
  UIUtil.AddButtonListener(self.ui.btn_Skin, self, self.OnClickSkin)
  UIUtil.AddButtonListener(self.ui.btn_Data, self, self.OnClickHeroInformation)
  UIUtil.AddButtonListener(self.ui.btn_CharTask, self, self.OnClickHeroTask)
  UIUtil.AddButtonListener(self.ui.btn_Arma, self, self.OnClickSpecWeapon)
  UIUtil.AddButtonListener(self.ui.btn_Favor, self, self.__OnClickFavorBtn)
  UIUtil.AddButtonListener(self.ui.btn_VowEntrance, self, self.__OnClickVowEntrance)
  UIUtil.AddButtonListener(self.ui.btn_VowStory, self, self.__OnClickVowStory)
  UIUtil.AddButtonListener(self.ui.btn_Vow, self, self.__OnClickVow)
  UIUtil.AddButtonListener(self.ui.btn_UIHide, self, self.OnClickShowSkinL2D)
  self.__OnExitShowSkinL2DModeCallback = BindCallback(self, self.OnExitShowSkinL2DMode)
  self.__addAllTouch = BindCallback(self, self.AddAllTouch)
  self.__removeAllTouch = BindCallback(self, self.RemoveAllTouch)
  self.__startTouch = BindCallback(self, self.StartTouch)
  self.__inTouching = BindCallback(self, self.InTouching)
  self.__endTouch = BindCallback(self, self.EndTouch)
  self:InitAllTween()
  self:AddAllTouch()
  self.potentialImgWidth = self.ui.img_Breakthrough.sprite.textureRect.width
  self.__SwitchHeroState = BindCallback(self, self.SwitchHeroState)
  self.__CanClick = BindCallback(self, function()
    return not self.isStartSwipe and not self.couldNotOpenOther
  end)
  table.insert(self.StarList, self.ui.img_star)
  self.__refresh = BindCallback(self, self.Refresh)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__refresh)
  self.__onItemUpdate = BindCallback(self, self.OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  self.__onFriendshipDataUpdate = BindCallback(self, self.OnFriendshipDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__onFriendshipDataUpdate)
  self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  self.__OnSkinChange = BindCallback(self, self.OnSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroLive2dChange, self.__OnSkinChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinUpgrade, self.__OnSkinChange)
  self.__OnSpecWeaponChange = BindCallback(self, self.OnSpecWeaponChange)
  MsgCenter:AddListener(eMsgEventId.SpecWeaponLvUp, self.__OnSpecWeaponChange)
  MsgCenter:AddListener(eMsgEventId.SpecWeaponUnlock, self.__OnSpecWeaponChange)
  self.__OnHeroVowStateChange = BindCallback(self, self.OnHeroVowStateChange)
  MsgCenter:AddListener(eMsgEventId.UpdateHeroVow, self.__OnHeroVowStateChange)
  MsgCenter:AddListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnSkinChange)
  self.tagPool = UIItemPool.New(UINHeroTag, self.ui.obj_tagItem)
  self.ui.obj_tagItem:SetActive(false)
  self.scorePool = UIItemPool.New(UINHeroScoreItem, self.ui.obj_scoreItem)
  self.ui.obj_scoreItem:SetActive(false)
  self.skillPool = UIItemPool.New(UINHeroStateSkillItem, self.ui.obj_skillItem)
  self.ui.obj_skillItem:SetActive(false)
  self.ui.logicPreviewNode:SetActive(false)
  local isStarUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank)
  self:UnlockStarup(isStarUpUnlock)
  local isFriendshipUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
  self:UnlockFriendship(isFriendshipUnlock)
  local isTrainingPlanUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TrainingPlan)
  self:UnlockHeroTask(isTrainingPlanUnlock)
  self:RefreshUnlockHeroInfo()
  self.athNode = UINAthHeroInfo.New()
  self.athNode:Init(self.ui.algorithm)
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = true
  self:__SetEventTriggerListener(true)
end

function UIHeroState:UnlockStarup(bool)
  self.ui.btn_StarUp.gameObject:SetActive(bool)
end

function UIHeroState:UnlockFriendship(bool)
  self.ui.btn_Friendship.gameObject:SetActive(bool)
end

function UIHeroState:UnlockHeroTask(bool)
  self.ui.btn_CharTask.gameObject:SetActive(bool)
end

function UIHeroState:RefreshUnlockHeroInfo()
  local isShow = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroInformation)
  if self.heroData ~= nil and isShow then
    isShow = not self.heroData:GetIsNotShowInfo()
  end
  self.ui.btn_Data.gameObject:SetActive(isShow)
end

function UIHeroState:InitHeroState(heroData, heroDataList, returnFunc, isHideSkin)
  self.resloader = cs_ResLoader.Create()
  self.heroDataList = heroDataList
  local heroCfg = heroData.heroCfg
  self.heroId = heroData.dataId
  self.heroData = heroData
  self.returnFunc = returnFunc
  self.heroName = LanguageUtil.GetLocaleText(heroCfg.name)
  self:RefreshHeroFixedInfo()
  self:LoadSkin()
  self.athNode:InitAthHeroInfo(self.heroData, self.resloader)
  self.athNode:SetShowAthWindowParam(self.bigImgResloader, self.__addAllTouch, self.__removeAllTouch, self.__SwitchHeroState, self.__CanClick)
  self:InitRedDotEvent()
  self:Refresh()
  AudioManager:PlayAudioById(1061)
  self.isHideSkin = isHideSkin or false
  self:RefreshSkinBtnState()
  self:RefreshSkinVowFlag()
  if GuideManager:TryTriggerGuide(eGuideCondition.InHeroStateUI) then
  end
  self:TryTipVowStory()
end

function UIHeroState:Refresh()
  self:UpdateLevel()
  self:UpdateRareInfo()
  self:UpdateStarNum()
  self:UpdateAbilityScore()
  self:UpdateSkill()
  self:UpdateTagInfo()
  self:UpdateChipCount()
  self:UpdateFriendShipLevel()
  self:UpdateEfficiency()
  self:RefreshRedDot()
  self:RefreshSpecWeaponState()
  self:UpdateAthData()
  self:UpdateHeroAttri()
  self:UpdatePotential()
  self:_RefreshQuickLvUp()
  self:RefreshUnlockHeroInfo()
  self:RefreshFavorHero()
  self:RefreshHeroVow()
  self:RefreshHeroFriendTipLevel()
  self:RefershHeroVowChangeName()
  self:RefreshShowLive2dBtn()
end

function UIHeroState:LoadSkin()
  if self.heroData == nil then
    return
  end
  if self.oldHeroDataId ~= self.heroData.dataId or self.oldHeroSkinId ~= self.heroData.skinId then
    if self.bigImgResloader ~= nil then
      self.bigImgResloader:Put2Pool()
      self.l2dBinding = nil
    end
    self.oldHeroDataId = self.heroData.dataId
    self.oldHeroSkinId = self.heroData.skinId
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  if self.heroStateShowL2D ~= nil then
    self.heroStateShowL2D:OnSwitchHero()
  end
  self.bigImgResloader = cs_ResLoader.Create()
  local picName = self.heroData:GetResPicName()
  local resPath = PathConsts:GetCharacterLive2DPath(picName, SkinEnum.fromWhere.heroInfoAndHandbook)
  local showLive2d = PlayerDataCenter.skinData:GetLive2dSwitchState(self.heroData.dataId, self.heroData.skinId)
  local isLocked = HeroCubismInteration.JudgeL2DLocked(self.heroData.skinId)
  if CS.ResManager.Instance:ContainsAsset(resPath) and showLive2d and not isLocked then
    HeroCubismInteration.DestroyInterationInstance(self.bigImgGameObject)
    self.bigImgResloader:LoadABAssetAsync(resPath, function(l2dModelAsset)
      self.bigImgGameObject = l2dModelAsset:Instantiate(self.ui.heroHolder.transform)
      self.bigImgGameObject.transform:SetLayer(LayerMask.UI)
      local cs_CubismInterationController = self.bigImgGameObject.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
      if cs_CubismInterationController ~= nil then
        self.heroCubismInteration = HeroCubismInteration.New()
        if self.heroStateShowL2D == nil then
          self.heroStateShowL2D = UIHeroStateShowL2D.New()
          self.heroStateShowL2D:Init(self.ui.obj_ShowSkinLive2d)
        end
        self.heroStateShowL2D:InitUIHeroStateShowL2D(self.heroCubismInteration, cs_CubismInterationController, self.__OnExitShowSkinL2DModeCallback)
        local heroId = self.heroData.dataId
        local skinId = self.heroData.skinId
        self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), true)
        
        function self.heroCubismInteration._controller.CheckGlobalPlayTimeInterval()
          return true
        end
        
        self.heroCubismInteration:SetInterationOpenWait(false)
        self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
        self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroHolder, 1, true)
        self.heroCubismInteration:SetL2DPosType("HeroList", false)
        self.cs_CubismInterationController = cs_CubismInterationController
      end
      self.l2dBinding = {}
      UIUtil.LuaUIBindingTable(self.bigImgGameObject, self.l2dBinding)
    end)
  else
    self.l2dBinding = nil
    resPath = PathConsts:GetCharacterBigImgPrefabPath(picName, SkinEnum.fromWhere.heroInfoAndHandbook)
    HeroCubismInteration.DestroyInterationInstance(self.bigImgGameObject)
    self.bigImgResloader:LoadABAssetAsync(resPath, function(prefab)
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroList")
      self:UpdateHeroShadow()
    end)
  end
end

function UIHeroState:InitRedDotEvent()
  self:RefreshRedDot()
  
  function self.__onheroCardStarRedDotEvent(node)
    if self.heroId ~= nil and self.heroId == node:GetParentNodeId() then
      self.ui.obj_RedDot_StarUp:SetActive(node:GetRedDotCount() > 0)
    end
  end
  
  RedDotController:AddListener(RedDotDynPath.HeroCardStartUpPath, self.__onheroCardStarRedDotEvent)
  
  function self.__onheroCardFriendshipRedDotEvent(node)
    if self.heroId ~= nil and self.heroId == node:GetParentNodeId() then
      self.ui.obj_RedDot_FriendShip:SetActive(node:GetRedDotCount() > 0)
    end
  end
  
  RedDotController:AddListener(RedDotDynPath.HeroCardFriendshipPath, self.__onheroCardFriendshipRedDotEvent)
  
  function self.__onheroCardHeroTaskRedDotEvent(node)
    if self.heroId ~= nil and self.heroId == node:GetParentNodeId() then
      self.ui.obj_RedDot_CharTask:SetActive(node:GetRedDotCount() > 0)
    end
  end
  
  RedDotController:AddListener(RedDotDynPath.HeroCardHeroTaskPath, self.__onheroCardHeroTaskRedDotEvent)
  
  function self.__onheroCardHeroInfoRedDotEvent(node)
    if self.heroId ~= nil and self.heroId == node:GetParentNodeId() then
      self.ui.obj_RedDot_HeroInfo:SetActive(node:GetRedDotCount() > 0)
    end
  end
  
  RedDotController:AddListener(RedDotDynPath.HeroCardHeroInfomationPath, self.__onheroCardHeroInfoRedDotEvent)
  
  function self.__onheroCardHeroSkinBlueDotEvent(node)
    if self.heroId ~= nil and self.heroId == node:GetParentNodeId() then
      self.ui.obj_blueDot_HeroSkin:SetActive(node:GetBlueDotCount() > 0)
    end
  end
  
  RedDotController:AddListener(RedDotDynPath.HeroCardHeroSkinPath, self.__onheroCardHeroSkinBlueDotEvent)
  self:UpdateBlueDot()
end

function UIHeroState:UpdateBlueDot()
  if self.heroData == nil then
    return
  end
  local isSkillLevelUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
  if isSkillLevelUpUnlock then
    local blueDotUpgradeSkill = self.heroData:AbleUpgradeSkill()
    self.ui.obj_blueDot_SkillUp:SetActive(blueDotUpgradeSkill)
  else
    self.ui.obj_blueDot_SkillUp:SetActive(false)
  end
  local limitUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
  local buleDotUpPontential = limitUpUnlock and self.heroData:AblePotential()
  self.ui.herolevle_blueDot:SetActive(false)
  self.ui.btn_LimitUp.gameObject:SetActive(limitUpUnlock)
  self.ui.img_LimitUpIcon.enabled = not self.heroData:IsFullPotential()
  local ok, heroFriendshipSkillNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroFriendship)
  if ok and heroFriendshipSkillNode:GetRedDotCount() > 0 then
    self.ui.obj_blueDot_FriendShip:SetActive(false)
  else
    self.ui.obj_blueDot_FriendShip:SetActive(PlayerDataCenter.allFriendshipData:GetCouldUpgradeForestLine(self.heroId))
  end
  local ok, heroSkinNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroSkin)
  if ok and 0 < heroSkinNode:GetBlueDotCount() then
    self.ui.obj_blueDot_HeroSkin:SetActive(true)
  else
    self.ui.obj_blueDot_HeroSkin:SetActive(false)
  end
end

function UIHeroState:RefreshRedDot()
  local ok, heroStarUpNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroStarUp)
  self.ui.obj_RedDot_StarUp:SetActive(ok and heroStarUpNode:GetRedDotCount() > 0)
  local ok, heroFriendshipSkillNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroFriendship)
  self.ui.obj_RedDot_FriendShip:SetActive(ok and heroFriendshipSkillNode:GetRedDotCount() > 0)
  local ok, heroTaskNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroTask)
  self.ui.obj_RedDot_CharTask:SetActive(ok and heroTaskNode:GetRedDotCount() > 0)
  local ok, heroInfoNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.heroId, RedDotStaticTypeId.HeroInfomation)
  self.ui.obj_RedDot_HeroInfo:SetActive(ok and heroInfoNode:GetRedDotCount() > 0)
  self:UpdateBlueDot()
end

function UIHeroState:RemoveRedDotEvent()
  RedDotController:RemoveListener(RedDotDynPath.HeroCardStartUpPath, self.__onheroCardStarRedDotEvent)
  RedDotController:RemoveListener(RedDotDynPath.HeroCardFriendshipPath, self.__onheroCardFriendshipRedDotEvent)
  RedDotController:RemoveListener(RedDotDynPath.HeroCardHeroTaskPath, self.__onheroCardHeroTaskRedDotEvent)
  RedDotController:RemoveListener(RedDotDynPath.HeroCardHeroInfomationPath, self.__onheroCardHeroInfoRedDotEvent)
  RedDotController:RemoveListener(RedDotDynPath.HeroCardHeroSkinPath, self.__onheroCardHeroSkinBlueDotEvent)
end

function UIHeroState:UpdateAbilityScore()
  local rank = self.heroData.rank
  local scoreCfgs = ConfigData.hero_score
  local heroStarCfg = ConfigData.hero_star[self.heroId][rank]
  table.sort(scoreCfgs, function(a, b)
    return a.sortId < b.sortId
  end)
  setmetatable(heroStarCfg.atrGrowthDic, {
    __index = heroStarCfg.atrBaseDic
  })
  self.scorePool:HideAll()
  for index, cfg in ipairs(scoreCfgs) do
    local growthNum = heroStarCfg.atrGrowthDic[cfg.attribute_id]
    local scoreItem = self.scorePool:GetOne(true)
    scoreItem:initScoreItem(cfg, growthNum)
  end
  setmetatable(heroStarCfg.atrGrowthDic, {})
end

function UIHeroState:UpdateStarNum()
  local num = self.heroData.rankCfg.star
  local count = math.ceil(num / 2)
  local isHalf = num % 2 == 1
  for _, starGameObject in ipairs(self.StarList) do
    starGameObject.gameObject:SetActive(false)
  end
  for i = 1, count do
    if self.StarList[i] ~= nil then
      self.StarList[i].gameObject:SetActive(true)
      self.StarList[i]:SetIndex(0)
    else
      local imgItemInfo = self.ui.img_star.gameObject:Instantiate():GetComponent(typeof(CS.UiImageItemInfo))
      table.insert(self.StarList, imgItemInfo)
      imgItemInfo.gameObject:SetActive(true)
    end
  end
  if isHalf then
    self.StarList[count]:SetIndex(1)
  end
end

function UIHeroState:UpdateRareInfo()
  local rare = self.heroData.rankCfg.rare
  self.ui.img_Quality.color = HeroRareColor[rare]
end

function UIHeroState:UpdateTagInfo()
  local tags = self.heroData:GetHeroTag()
  self.tagPool:HideAll()
  for index, value in ipairs(tags) do
    local item = self.tagPool:GetOne(true)
    item:InitTag(value)
  end
end

function UIHeroState:UpdateLevel()
  local level = self.heroData.level
  local potentialCfg = ConfigData.hero_potential[self.heroData.dataId]
  local level_max = potentialCfg[self.heroData.potential].level_max
  if 999 < level then
    warn("level Num is out off MaxSize 999")
  end
  self.ui.texInfo_Level:SetIndex(0, UIHeroUtil.GetHeroLevelColorHexStr(level), tostring(level_max))
  self.ui.tex_Lv.color = UIHeroUtil.GetHeroLevelColor(level)
  local isShake = self.heroData:CanHeroUsePotential()
  self.ui.obj_Shake:SetActive(isShake)
end

function UIHeroState:UpdateSkill()
  self.skillPool:HideAll()
  for k, skillData in ipairs(self.heroData.skillList) do
    if skillData.type ~= eHeroSkillType.LifeSkill and not skillData:IsCommonAttack() then
      local item = self.skillPool:GetOne(true)
      item:InitSkillItem(skillData, self.resloader)
    end
  end
end

function UIHeroState:RefreshSpecWeaponState()
  self.ui.blueDot_Arma:SetActive(false)
  local unlock = PlayerDataCenter.allSpecWeaponData:IsUnlockSpecWeaponSystem()
  unlock = unlock and PlayerDataCenter.allSpecWeaponData:ContainHeroSpecWeapon(self.heroData.dataId)
  self.ui.btn_Arma.gameObject:SetActive(unlock)
  if not unlock then
    return
  end
  local weaponId = PlayerDataCenter.allSpecWeaponData:GetHeroSpecWeaponId(self.heroData.dataId)
  local weaponData = self.heroData:GetHeroDataSpecWeapon(weaponId)
  if weaponData == nil then
    PlayerDataCenter.allSpecWeaponData:CreateOrUpdateHeroWeapon(self.heroData, weaponId, 0, 0)
    weaponData = self.heroData:GetHeroDataSpecWeapon(weaponId)
  end
  if unlock and weaponData ~= nil then
    local step = weaponData:GetSpecWeaponCurStep()
    self.ui.obj_ArmaLock:SetActive(step == 0)
    self.ui.tex_ArmaLevel.gameObject:SetActive(0 < step)
    self.ui.obj_ArmaLvbg.gameObject:SetActive(0 < step)
    self.ui.tex_ArmaLevel.text = "LV." .. tostring(weaponData:GetSpecWeaponCurLevel())
    self.ui.tex_Arma_stage.text = LanguageUtil.GetRomanNumber(step)
    if self.heroData.camp == CampEnum.eCampTaype.entropy then
      self.ui.tex_Arma:SetIndex(1)
    else
      self.ui.tex_Arma:SetIndex(0)
    end
  end
  self:RefreshhSpecWeaponBlueDot(unlock, weaponData)
end

function UIHeroState:RefreshhSpecWeaponBlueDot(unlockSpecWeapon, weaponData)
  local isShowBlue = unlockSpecWeapon and weaponData ~= nil and weaponData:IsSpecWeaponCouldUprage()
  self.ui.blueDot_Arma:SetActive(isShowBlue)
end

function UIHeroState:OnClickLimitUp()
  if not self:__CanClick() then
    return
  end
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
    local tip = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
    cs_MessageCommon.ShowMessageTips(tip)
    return
  end
  local unlock70 = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_potential_2_70)
  local curVersionMaxLevelAbove70 = ConfigData.game_config.heroMaxLevel >= 70
  local unableUp = not unlock70 and self.heroData.level >= 60 and curVersionMaxLevelAbove70
  if unableUp then
    local tip = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_potential_2_70)
    cs_MessageCommon.ShowMessageTips(tip)
    return
  end
  if self.heroData:IsFullPotential() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(172))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotential, function(window)
    if window == nil then
      return
    end
    window:InitPotential(self.heroData)
    local parWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
    if parWin == nil then
      return
    end
    window:SetHeroPotentialCloseEvent(function()
      parWin:AddAllTouch()
    end)
    parWin:RemoveAllTouch()
    parWin.levelUpWin = window
  end)
end

function UIHeroState:OnClickLevelUP()
  if not self:__CanClick() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroLevelUp, function(windows)
    if windows == nil then
      error("Can't open " .. self.heroId .. "'s levelUp window")
      return
    end
    self:RemoveAllTouch()
    windows:InitHeroLevelUp(self.heroData, self.resloader, self.__addAllTouch, self.__SwitchHeroState)
    if windows.winTween ~= nil then
      windows.winTween:Complete()
    end
    self.levelUpWin = windows
    windows.closeEvent = BindCallback(self, function()
      self:UpdateBlueDot()
      self:UpdateEfficiency()
    end)
    if not self.heroData:IsFullLevel() and self.heroData:IsReachLevelLimit() and not GuideManager.inGuide and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotential, function(window)
        window:InitPotential(self.heroData)
      end)
    end
    self:__HideParent()
  end)
end

function UIHeroState:_RefreshQuickLvUp()
  self._canQuickLvUp = self.heroData:GenHeroCanQuickLevelUp()
  self.ui.btn_QuickLevelUp.gameObject:SetActive(false)
  self.ui.obj_FullLevel:SetActive(false)
  local unlock70 = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_potential_2_70)
  local curVersionMaxLevelAbove70 = ConfigData.game_config.heroMaxLevel >= 70
  local unableUp = not unlock70 and self.heroData.level >= 60 and curVersionMaxLevelAbove70
  if self.heroData:IsFullLevel() and not unableUp then
    self.ui.obj_FullLevel:SetActive(true)
    return
  end
  self.ui.btn_QuickLevelUp.gameObject:SetActive(true)
  self.ui.btn_QuickLevelUp.enabled = true
  self.ui.img_QuickLevelUp.color = self.ui.col_LvUpCanClick
  self.ui.obj_showLv:SetActive(false)
  self.ui.obj_showLimit:SetActive(false)
  if self.heroData:IsReachLevelLimit() then
    self.ui.obj_showLimit:SetActive(true)
    if not (FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) and self.heroData:AblePotential()) or unableUp then
      self.ui.img_QuickLevelUp.color = self.ui.col_LvUpUnClick
    end
    return
  end
  self.ui.obj_showLv:SetActive(true)
  local nextLevelExp = ConfigData.hero_level[self.heroData.level].exp
  local hasExp = PlayerDataCenter:GetItemCount(ConstGlobalItem.HeroExp)
  local canLv = nextLevelExp <= hasExp
  local hasExpStr = LanguageUtil.GetNum2UnitStr(hasExp, 1)
  local nextLevelExpStr = LanguageUtil.GetNum2UnitStr(nextLevelExp, 1)
  self.ui.tex_LevelUpExp:SetIndex(canLv == true and 0 or 1, hasExpStr, nextLevelExpStr)
  if not self._canQuickLvUp then
    self.ui.img_QuickLevelUp.color = self.ui.col_LvUpUnClick
  end
end

function UIHeroState:_OnClickQuickLvUp()
  if not self._canClickQuickLv then
    return
  end
  if not self:__CanClick() then
    return
  end
  if self.heroData:IsFullLevel() and not not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_potential_2_70) then
    return
  end
  if self._canQuickLvUp then
    if self._lvUpCompleteFunc == nil then
      self._lvUpCompleteFunc = BindCallback(self, self._QuickLvUpComplete)
    end
    self.networkCtrl:CS_HERO_Upgrade(self.heroId, self.heroData.level + 1, self._lvUpCompleteFunc)
    return
  end
  if self.heroData:IsReachLevelLimit() then
    self:OnClickLimitUp()
  else
    self:_OpenUseExpPacket()
  end
end

function UIHeroState:OnPressDownQuickLvUp()
  self._addLevel = 0
  self._canClickQuickLv = true
end

function UIHeroState:OnPressQuickLvUp()
  if not self:__CanClick() then
    return
  end
  if self.heroData.level + self._addLevel >= self.heroData:GetLevelLimit() then
    return
  end
  local needExp = self.heroData:GetExpToTargetLevel(self.heroData.level + self._addLevel)
  local totalExp = PlayerDataCenter:GetItemCount(ConstGlobalItem.HeroExp)
  if needExp > totalExp then
    local selectItemId
    if self._addLevel == 0 then
      self:_OpenUseExpPacket()
    else
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(44))
    end
  else
    self._addLevel = self._addLevel + 1
    local level = self.heroData.level + self._addLevel
    local level_max = self.heroData:GetLevelLimit()
    self.ui.texInfo_Level:SetIndex(0, UIHeroUtil.GetHeroLevelColorHexStr(level), tostring(level_max))
    self.ui.tex_Lv.color = UIHeroUtil.GetHeroLevelColor(level)
    self._canClickQuickLv = false
    if self.heroData.level + self._addLevel < self.heroData:GetLevelLimit() then
      local nextLevelExp = ConfigData.hero_level[self.heroData.level + self._addLevel].exp
      local hasExp = totalExp - needExp
      local canLv = nextLevelExp <= hasExp
      local hasExpStr = LanguageUtil.GetNum2UnitStr(hasExp, 1)
      local nextLevelExpStr = LanguageUtil.GetNum2UnitStr(nextLevelExp, 1)
      self.ui.tex_LevelUpExp:SetIndex(canLv == true and 0 or 1, hasExpStr, nextLevelExpStr)
    end
    if level >= level_max then
      self:OnPressUpQuickLvUp()
    else
      AudioManager:PlayAudioById(1023)
    end
  end
end

function UIHeroState:OnPressUpQuickLvUp()
  if self._addLevel > 0 then
    self.networkCtrl:CS_HERO_Upgrade(self.heroId, self.heroData.level + self._addLevel, self._lvUpCompleteFunc)
    self._addLevel = 0
  end
end

function UIHeroState:_OpenUseExpPacket()
  local selectItemId
  local list = {}
  table.insertto(list, ConfigData.item.fixedPacketMappingDic[ConstGlobalItem.HeroExp] or table.emptytable)
  table.insertto(list, ConfigData.item.selectPacketMappingDic[ConstGlobalItem.HeroExp] or table.emptytable)
  if 0 < #list then
    for _, expPacketid in ipairs(list) do
      if 0 < PlayerDataCenter:GetItemCount(expPacketid) then
        selectItemId = expPacketid
        break
      end
    end
  end
  if selectItemId == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
      if window == nil then
        return
      end
      window:InitCommonItemDetail(ConfigData.item[ConstGlobalItem.HeroExp])
    end)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonUseGift, function(window)
      if window == nil then
        return
      end
      window:InitCommonUseGift(ConfigData.item[selectItemId])
    end)
  end
end

function UIHeroState:_QuickLvUpComplete(objList)
  if objList.Count ~= 1 then
    error("objList.Count error" .. tostring(objList.count))
    return
  end
  local resDic = objList[0]
  local diffData = resDic[self.heroId]
  if diffData == nil then
    return
  end
  local oldLv = diffData.oldLevel
  local curLv = self.heroData.level
  local HeroExpDiffData = {
    oldLevel = oldLv,
    oldRate = diffData.oldExp / ConfigData.hero_level[oldLv].exp,
    level = curLv,
    rate = self.heroData.curExp / ConfigData.hero_level[curLv].exp
  }
  AudioManager:PlayAudioById(1023)
end

function UIHeroState:OnClickStarUP()
  if not self:__CanClick() then
    return
  end
  if self.heroData:IsFullRank() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroStarUp, function(windows)
    if windows == nil then
      error("Can't open " .. self.heroId .. "'s starUP window")
      return
    end
    self:RemoveAllTouch()
    windows:InitHeroStarUp(self.resloader, function()
      self:UpdateEfficiency()
      self:AddAllTouch()
    end, self.__SwitchHeroState)
    windows:SwitchHero(self.heroData)
    self.starUpWin = windows
  end)
end

function UIHeroState:OnClickFriendship()
  if not self:__CanClick() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShip, function(windows)
    if windows == nil then
      error("Can't open " .. self.heroId .. "'s FriendShip window")
      return
    end
    self:RemoveAllTouch()
    windows:InitFriendshipSkillUpgrade(self.heroData, self.resloader, function()
      self:AddAllTouch()
      self:UpdateEfficiency()
      self:UpdateBlueDot()
      local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
      if win ~= nil and not win.active then
        win:Show()
      end
    end, self.__SwitchHeroState)
    self:__HideParent()
  end)
end

function UIHeroState:OnClickSillUpgrade()
  if not self:__CanClick() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkillUpgrade, function(windows)
    if windows == nil then
      error("Can't open " .. self.heroId .. "'s levelUp window")
      return
    end
    self:RemoveAllTouch()
    windows:InitSkillUpgrade(self.heroData, self.resloader, self.__addAllTouch, self.__SwitchHeroState)
    self.skillUgradeWin = windows
    windows.closeEvent = BindCallback(self, function()
      self:UpdateBlueDot()
      self:UpdateSkill()
      self:UpdateEfficiency()
    end)
    self:__HideParent()
  end)
end

function UIHeroState:OnClickAttribute()
  if self.attrOutLineWindow ~= nil then
    self:RemoveAllTouch()
    self.attrOutLineWindow:Show()
  end
end

function UIHeroState:OnClickSkin()
  local callbackCount = 0
  local needStoreList = ShopUtil.GetSkinShopIdList()
  if 0 < #needStoreList then
    self:ReqShopDetailLoop(callbackCount, needStoreList)
  else
    self:__OpenSkinWin()
  end
end

function UIHeroState:ReqShopDetailLoop(index, idList)
  local shopCtr = ControllerManager:GetController(ControllerTypeId.Shop)
  local shopId = idList[index + 1]
  shopCtr:GetShopData(shopId, function(shopData)
    index = index + 1
    if index == #idList then
      self:__OpenSkinWin()
    else
      self:ReqShopDetailLoop(index, idList)
    end
  end)
end

function UIHeroState:__OpenSkinWin()
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkin, function(window)
    if window == nil then
      return
    end
    local parWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
    local SkinEnum = require("Game.Skin.SkinEnum")
    window:SetSkinFromWhere(SkinEnum.fromWhere.heroInfoAndHandbook)
    window:InitSkin(self.heroData.dataId, self.__SwitchHeroState, self.heroDataList, function()
      local parWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
      if parWin ~= nil and not parWin.active then
        parWin:Show()
      end
    end)
    self:__HideParent()
  end)
end

function UIHeroState:OnClickHeroTask()
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroTask, function(window)
    if window ~= nil then
      self:RemoveAllTouch()
      window:InitHeroTask(self.heroData, self.resloader, self.bigImgResloader, function()
        self:AddAllTouch()
      end)
      window:SetHeroTaskName(ConfigData:GetTipContent(394))
    end
  end)
end

function UIHeroState:OnClickHeroInformation()
  self:OpenHeroInformation()
end

function UIHeroState:OpenHeroInformation(openCallback)
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfomation, function(window)
    if window ~= nil then
      self:RemoveAllTouch()
      window:InitHeroInformation(self.heroData, function()
        self:AddAllTouch()
        self:UpdateBlueDot()
        local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
        if win ~= nil and not win.active then
          win:Show()
        end
      end, self.__SwitchHeroState)
      self:__HideParent()
      if openCallback ~= nil then
        openCallback(window)
      end
    end
  end)
end

function UIHeroState:OnClickSpecWeapon()
  local weaponId = PlayerDataCenter.allSpecWeaponData:GetHeroSpecWeaponId(self.heroData.dataId)
  local weaponData = self.heroData:GetHeroDataSpecWeapon(weaponId)
  if weaponData == nil then
    return
  end
  if weaponData:IsSpecWeaponCouldUprage() then
    PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetSpeacWeaponLooked(weaponId)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SpecWeapon, function(win)
    if win == nil then
      return
    end
    win:InitUISpecWeapon(weaponData, self.heroData, function()
      local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
      if win ~= nil and not win.active then
        win:UpdateSkill()
        win:Show()
      end
    end)
    UIManager:HideWindow(UIWindowTypeID.HeroState)
  end)
end

function UIHeroState:OnItemUpdate()
  self:UpdateChipCount()
  self:_RefreshQuickLvUp()
  self:UpdateLevel()
  self:RefreshSpecWeaponState()
end

function UIHeroState:OnFriendshipDataUpdate()
  self:UpdateFriendShipLevel()
  self:UpdateHeroAttri()
  self:UpdateEfficiency()
  self:RefreshSpecWeaponState()
  self:RefreshHeroVow()
  self:RefreshHeroFriendTipLevel()
  self:RefreshHeroFixedInfo()
  self:RefershHeroVowChangeName()
end

function UIHeroState:OnAthDataUpdate()
  self.athNode:RefreshAthHeroInfoChart()
  self:UpdateHeroAttri()
  self:UpdateEfficiency()
end

function UIHeroState:UpdateChipCount()
  local isFullRank = self.heroData:IsFullRank()
  self.ui.starUPNormal:SetActive(not isFullRank)
  self.ui.tex_RankMax.gameObject:SetActive(isFullRank)
  if not isFullRank then
    local fragCount = self.heroData:GetHeroFragCount()
    local needFrag = self.heroData:StarNeedFrag()
    self.ui.tex_ChipCount.text = tostring(fragCount or 0) .. "/" .. tostring(needFrag or 0)
  end
end

function UIHeroState:UpdateFriendShipLevel()
  local level = PlayerDataCenter.allFriendshipData:GetLevel(self.heroId)
  if level < 10 then
    self.ui.tex_FriendShipLevel:SetIndex(0, tostring(level))
  else
    self.ui.tex_FriendShipLevel:SetIndex(1, tostring(level))
  end
end

function UIHeroState:UpdateHeroShadow()
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
  end, OverDis, 1):SetEase(cs_tweening.Ease.OutExpo):SetLink(self.shadow.gameObject)
end

function UIHeroState:UpdateAthData()
  self.athNode:InitAthHeroInfo(self.heroData, self.resloader)
  self.athNode:SetShowAthWindowParam(self.bigImgResloader, self.__addAllTouch, self.__removeAllTouch, self.__SwitchHeroState, self.__CanClick)
end

function UIHeroState:UpdateHeroAttri()
  local attrDataList
  local attrOutLineWindow = self.attrOutLineWindow
  if attrOutLineWindow == nil then
    attrOutLineWindow, attrDataList = UIAttrUtil.ShowAttrOutLineWindow(self.heroData, self.ui.logicPreviewNode)
    attrOutLineWindow:Hide()
    self.attrOutLineWindow = attrOutLineWindow
  else
    attrDataList = UIAttrUtil.GetAttrDataListForShow(self.heroData)
  end
  local heroName = self.heroData:GetHeroName(true)
  UIAttrUtil.UpdateAttrData(heroName, attrDataList, attrOutLineWindow)
end

function UIHeroState:UpdateEfficiency()
  self.ui.tex_Efficiency.text = tostring(self.heroData:GetFightingPower())
end

function UIHeroState:UpdatePotential()
  local potentialMaxNum = self.heroData:GetMaxPotential()
  local size = self.ui.img_Breakthrough_empty.rectTransform.sizeDelta
  size.x = self.potentialImgWidth * potentialMaxNum
  self.ui.img_Breakthrough_empty.rectTransform.sizeDelta = size
  local vec = self.ui.img_Breakthrough.rectTransform.sizeDelta
  vec.x = self.potentialImgWidth * self.heroData.potential
  self.ui.img_Breakthrough.rectTransform.sizeDelta = vec
end

function UIHeroState:OnSkinChange(heroId, skinId)
  if heroId == self.heroId then
    if self.active then
      self:LoadSkin()
    else
      self.isChangSkinWhenShow = true
    end
  end
end

function UIHeroState:OnSpecWeaponChange()
  self:RefreshSpecWeaponState()
  self:UpdateEfficiency()
  self:UpdateHeroAttri()
end

function UIHeroState:OnHeroVowStateChange(heroId)
  if heroId ~= self.heroData.dataId then
    return
  end
  self:RefreshHeroVow()
  self:RefreshHeroFriendTipLevel()
  self:RefreshHeroFixedInfo()
  self:RefershHeroVowChangeName()
end

function UIHeroState:RefreshHeroFixedInfo()
  local heroName = self.heroData:GetHeroName(true)
  self.ui.tex_Name.text = heroName
  self.ui.tex_ENName.text = self.heroData.heroCfg.name_en
  self.ui.img_Carrer:SetIndex(self.heroData.heroCfg.career - 1)
  local campIcon = LanguageUtil.GetLocaleText(self.heroData:GetCampCfg().icon)
  self.resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campIcon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_Camp.texture = texture
  end)
  if self.attrOutLineWindow ~= nil then
    self.attrOutLineWindow:UpdateSkillName(heroName)
  end
end

function UIHeroState:StartTouch(go, eventData)
  if GuideManager.inGuide or self.isAutoMoving then
    return
  end
  if self.chageCoroutine ~= nil then
    CS_coroutine.stop(self.chageCoroutine)
    self.chageCoroutine = nil
  end
  if self.backCoroutine ~= nil then
    CS_coroutine.stop(self.backCoroutine)
    self.backCoroutine = nil
  end
  self.screenWidth = CS_Screen.width * 0.3
  self.touchStartPointX = eventData.position.x
  self.touchCurrentPointX = self.touchStartPointX
end

function UIHeroState:InTouching(go, eventData)
  if self.touchStartPointX == nil then
    return
  end
  self.touchCurrentPointX = eventData.position.x
  self.swipeRate = (self.touchCurrentPointX - self.touchStartPointX) / self.screenWidth
  if math.abs(self.swipeRate) > 0 then
    self.isStartSwipe = true
  end
  self:OnSwipe()
end

function UIHeroState:EndTouch(go, eventData)
  if self.touchStartPointX == nil then
    return
  end
  local lastPointX = self.touchCurrentPointX
  self.isStartSwipe = false
  self.touchStartPointX = nil
  self.touchCurrentPointX = nil
  if self.swipeRate == nil then
    return
  end
  if math.abs(self.swipeRate) < self.ui.float_SwitchRateThreshold then
    if math.abs(eventData.position.x - lastPointX) > self.ui.float_SpeedThreshold then
      self:ChangeHero()
    else
      self:ReturnBack()
    end
  else
    self:ChangeHero()
    self.swipeRate = 0
  end
end

function UIHeroState:RemoveAllTouch()
  self.swipeRate = nil
  self.isStartSwipe = false
end

function UIHeroState:AddAllTouch()
  self:PlayAllDOTween()
  self.swipeRate = nil
  self.isStartSwipe = false
end

function UIHeroState:OnSwipe()
  local absSwipeRate = math.abs(self.swipeRate)
  if self.l2dBinding == nil then
    self.ui.group_img_Camp.alpha = 1 - absSwipeRate * self.ui.float_campRate
    self.ui.group_hero.alpha = 1 - absSwipeRate * self.ui.float_HeroRate
  end
  self.ui.group_img_Camp.transform.localPosition = Vector2.New(self.campPos.x + self.screenWidth * (self.swipeRate * self.ui.float_campRate), self.campPos.y)
  self.ui.group_hero.transform.localPosition = Vector2.New(self.heroPos.x + self.screenWidth * (self.swipeRate * self.ui.float_HeroRate), self.heroPos.y)
end

function UIHeroState:ReturnBack()
  self.isAutoMoving = true
  local totalCostTime = self.ui.float_backTime
  local updateCostTime = 0.005
  local orgAlpha1 = self.ui.group_img_Camp.alpha
  local orgAlpha2 = self.ui.group_hero.alpha
  local orgPos1 = self.ui.group_img_Camp.transform.localPosition
  local orgPos2 = self.ui.group_hero.transform.localPosition
  self.backCoroutine = CS_coroutine.start(function()
    local times = math.ceil(totalCostTime / updateCostTime)
    for i = 1, times do
      self.ui.group_img_Camp.alpha = orgAlpha1 + (1 - orgAlpha1) / times * i
      self.ui.group_hero.alpha = orgAlpha2 + (1 - orgAlpha2) / times * i
      self.ui.group_img_Camp.transform.localPosition = Vector2.Lerp(orgPos1, self.campPos, i / times)
      self.ui.group_hero.transform.localPosition = Vector2.Lerp(orgPos2, self.heroPos, i / times)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(updateCostTime))
    end
    self.isAutoMoving = false
  end)
end

function UIHeroState:EaseOutQuint(start, _end, value)
  value = value - 1
  _end = _end - start
  return _end * (value * value * value * value * value + 1) + start
end

function UIHeroState:ChangeHero()
  self.isAutoMoving = true
  self.couldNotOpenOther = true
  AudioManager:PlayAudioById(1063)
  local fadeTotalCostTime = self.ui.float_fadeTime
  local fadeUpdateCostTime = 0.01
  local newTotalCostTime = self.ui.float_showTime
  local newUpdateCostTime = 0.01
  local orgAlpha1 = self.ui.group_img_Camp.alpha
  local orgAlpha2 = self.ui.group_hero.alpha
  local orgPos1 = self.ui.group_img_Camp.transform.localPosition
  local orgPos2 = self.ui.group_hero.transform.localPosition
  self.chageCoroutine = CS_coroutine.start(function()
    local times = math.ceil(fadeTotalCostTime / fadeUpdateCostTime)
    local flag = 1
    if self.swipeRate > 0 then
      flag = 1
    elseif self.swipeRate < 0 then
      flag = -1
    end
    for i = 1, times do
      self.ui.group_img_Camp.alpha = orgAlpha1 + -orgAlpha1 / times * i
      self.ui.group_hero.alpha = orgAlpha2 + -orgAlpha2 / times * i
      coroutine.yield(CS.UnityEngine.WaitForSeconds(fadeUpdateCostTime))
    end
    self:ChangeHeroData(flag)
    self.isAutoMoving = false
    self.couldNotOpenOther = false
    times = math.ceil(newTotalCostTime / newUpdateCostTime)
    for i = 1, times do
      self.ui.group_img_Camp.alpha = i / times
      self.ui.group_hero.alpha = i / times
      self.ui.group_img_Camp.transform.localPosition = self:EaseOutQuint(Vector2.New(self.campPos.x + self.screenWidth * -flag * self.ui.float_campRate, orgPos1.y), self.campPos, math.sqrt(i / times))
      self.ui.group_hero.transform.localPosition = self:EaseOutQuint(Vector2.New(self.heroPos.x + self.screenWidth * -flag * self.ui.float_HeroRate, orgPos2.y), self.heroPos, math.sqrt(i / times))
      coroutine.yield(CS.UnityEngine.WaitForSeconds(newUpdateCostTime))
    end
  end)
end

function UIHeroState:ChangeHeroData(flag, shiftFunc)
  local index = table.indexof(self.heroDataList, self.heroData)
  if not index then
    return
  end
  if flag < 0 then
    index = index + 1
    if index > #self.heroDataList then
      index = 1
    end
  else
    index = index - 1
    if index <= 0 then
      index = #self.heroDataList
    end
  end
  if not self:ChangeHeroByIndex(index, shiftFunc) then
    self:ChangeHeroData(flag, shiftFunc)
  end
end

function UIHeroState:ChangeHeroByIndex(index, shiftFunc)
  local heroData = self.heroDataList[index]
  local heroCfg = heroData.heroCfg
  self.heroId = heroData.dataId
  self.heroData = heroData
  if shiftFunc ~= nil and shiftFunc(heroData) then
    return false
  end
  self.heroName = LanguageUtil.GetLocaleText(heroCfg.name)
  self:RefreshHeroFixedInfo()
  if not self.active then
    self.isRefreshHeroWhenShow = true
    return true
  end
  self:LoadSkin()
  self:Refresh()
  self:RefreshSkinVowFlag()
  return true
end

function UIHeroState:SwitchHeroState(flag, shiftFunc)
  self:ChangeHeroData(-flag, shiftFunc)
  return self.heroData, self.bigImgResloader
end

function UIHeroState:OnShow()
  base.OnShow(self)
  if self.isRefreshHeroWhenShow then
    self:Refresh()
    self:LoadSkin()
  elseif self.isChangSkinWhenShow then
    self:LoadSkin()
  elseif self.l2dBinding ~= nil then
    local interation = self.l2dBinding.renderController.transform:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if interation ~= nil then
      interation:RestartBodyAnimation()
    end
  end
  self:RefreshSkinVowFlag()
  self.isRefreshHeroWhenShow = false
  self.isChangSkinWhenShow = false
end

function UIHeroState:RegistFromeWindowTypeID(UIWindowTypeID)
  self.formWindowTypeID = UIWindowTypeID
end

function UIHeroState:Return()
  if self.returnFunc ~= nil then
    self.returnFunc()
  end
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
  self:Delete()
end

function UIHeroState:RefreshSkinBtnState()
  if self.isHideSkin then
    self.ui.btn_Skin.gameObject:SetActive(false)
  else
    self.ui.btn_Skin.gameObject:SetActive(FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Skin))
  end
end

function UIHeroState:RefreshSkinVowFlag()
  if self.heroData == nil then
    return
  end
  local vowFlag = false
  local vowCfg = self.heroData:GetVowCfg()
  if vowCfg ~= nil and vowCfg.vow_skin ~= 0 then
    vowFlag = not PlayerDataCenter.skinData:IsHaveSkin(vowCfg.vow_skin)
  end
  self.ui.obj_VowBlueDot:SetActive(vowFlag)
end

function UIHeroState:__HideParent()
  TimerManager:StartTimer(1, function()
    local parWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
    if parWin ~= nil then
      parWin:Hide()
    end
  end, nil, true, true, true)
end

function UIHeroState:__OnClickFavorBtn()
  if PlayerDataCenter.favorHeroData == nil then
    return
  end
  local heroId = self.heroData.dataId
  local isFavorHero = PlayerDataCenter.favorHeroData:IsFavorHero(heroId)
  if isFavorHero then
    PlayerDataCenter.favorHeroData:SetIsFavorHero(heroId, false)
    self.ui.img_Favor:SetIndex(0)
  else
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(558))
    PlayerDataCenter.favorHeroData:SetIsFavorHero(heroId, true)
    self.ui.img_Favor:SetIndex(1)
  end
  PlayerDataCenter.favorHeroData:ApplyFavorHeroBuffDic()
  PlayerDataCenter.favorHeroData:CleanFavorHeroBuffDic()
  MsgCenter:Broadcast(eMsgEventId.UpdateHero, {
    [heroId] = false
  }, false)
end

function UIHeroState:RefreshFavorHero()
  if PlayerDataCenter.favorHeroData:IsFavorHero(self.heroData.dataId) then
    self.ui.img_Favor:SetIndex(1)
  else
    self.ui.img_Favor:SetIndex(0)
  end
end

function UIHeroState:__OnClickVowEntrance()
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  if not vowSystemCtrl:GetVowIsUnlock() then
    self.ui.btn_VowEntrance.gameObject:SetActive(false)
    self.ui.btn_Vow.gameObject:SetActive(false)
    return
  end
  local vowState = self.heroData:GetHeroVowState()
  if vowState == VowEnum.EVowState.NoData or vowState == VowEnum.EVowState.CanNotVow then
    return
  end
  if vowState == VowEnum.EVowState.CanVow then
    vowSystemCtrl:TryVowHero(self.heroData.dataId)
  else
    vowSystemCtrl:CheckVowCard(self.heroData.dataId)
  end
end

function UIHeroState:__OnClickVowStory()
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  if not vowSystemCtrl:GetVowIsUnlock() then
    return
  end
  vowSystemCtrl:TryShowVowAvg(self.heroData.dataId)
  self.ui.fXP_vowstory_open:SetActive(false)
end

function UIHeroState:__OnClickVow()
  if CloseCustomBename then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(393))
    return
  end
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  local isOpen, tip = vowSystemCtrl:GetVowChangeNameIsUnlock()
  if not isOpen and not string.IsNullOrEmpty(tip) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(tip)
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.VowChangeNameDialog, function(windows)
    if windows == nil then
      error("Can't open " .. self.heroId .. "'s changeName window")
      return
    end
    self:RemoveAllTouch()
    windows:OpenChangeHeroNameDialog(self.heroId)
  end)
end

function UIHeroState:RefreshHeroVow()
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  if not vowSystemCtrl:GetVowIsUnlock() then
    self.ui.btn_VowEntrance.gameObject:SetActive(false)
    self.ui.btn_VowStory.gameObject:SetActive(false)
    return
  end
  local vowState = self.heroData == nil and VowEnum.EVowState.NoData or self.heroData:GetHeroVowState()
  local isHideVowBtn = vowState == VowEnum.EVowState.NoData or vowState == VowEnum.EVowState.CanNotVow
  self.ui.btn_VowEntrance.gameObject:SetActive(not isHideVowBtn)
  if vowState == VowEnum.EVowState.Vowed then
    self.ui.tex_VowEntrance:SetIndex(1)
  else
    self.ui.tex_VowEntrance:SetIndex(0)
  end
  self:RefreshHeroVowStory()
end

function UIHeroState:RefreshHeroVowStory()
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  if not vowSystemCtrl:GetVowIsUnlock() then
    self.ui.btn_VowStory.gameObject:SetActive(false)
    return
  end
  local vowCfg = self.heroData:GetVowCfg()
  local vowState = self.heroData == nil and VowEnum.EVowState.NoData or self.heroData:GetHeroVowState()
  local conList = vowCfg.vow_story_condition
  local isHideVowBtn = vowState == VowEnum.EVowState.NoData or vowState == VowEnum.EVowState.CanNotVow
  local isShowVowStoryBtn = 0 < #conList and conList[1] == 1 and not isHideVowBtn
  self.ui.btn_VowStory.gameObject:SetActive(isShowVowStoryBtn)
  if not isShowVowStoryBtn then
    return
  end
  local skinId = conList[2]
  local isHaveSkin = PlayerDataCenter.skinData:IsHaveSkin(skinId)
  local isShow = vowState == VowEnum.EVowState.Vowed and isHaveSkin
  self.vowStoryOpen = isShow
  self.ui.obj_VowStoryOpen:SetActive(isShow)
  self.ui.obj_VowStoryClose:SetActive(not isShow)
  self.ui.fXP_vowstory_open:SetActive(false)
  if not isShow then
    return
  end
  local isChecked = vowSystemCtrl:GetVowStoryIsCheck(self.heroData.dataId)
  self.ui.fXP_vowstory_open:SetActive(not isChecked)
end

function UIHeroState:TryTipVowStory()
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  if not vowSystemCtrl:GetVowIsUnlock() then
    return
  end
  local isStoryChecked = vowSystemCtrl:GetVowStoryIsCheck(self.heroId)
  if isStoryChecked then
    return
  end
  local checked = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetHeroVowStoryTip(self.heroId)
  if checked then
    return
  end
  local isVowed = self.heroData:GetHeroIsVowed()
  local vowCfg = self.heroData:GetVowCfg()
  local conList = vowCfg.vow_story_condition
  if #conList == 0 or conList[1] == 0 then
    return
  end
  local skinId = conList[2]
  local isHaveSkin = PlayerDataCenter.skinData:IsHaveSkin(skinId)
  local isShow = isVowed and isHaveSkin
  if not isShow then
    return
  end
  local heroName = LanguageUtil.GetLocaleText(self.heroData.heroCfg.name)
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(23020, heroName), function()
    vowSystemCtrl:TryShowVowAvg(self.heroData.dataId)
  end, nil)
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetHeroVowStoryTip(self.heroId)
end

function UIHeroState:RefreshHeroFriendTipLevel()
  self.ui.obj_FriendLevelTip:SetActive(false)
  self.ui.obj_VowTip:SetActive(false)
  local tipState = self.heroData:GetHeroFriendLevel()
  if tipState == HeroEnum.StateTip.NoTip then
    return
  elseif tipState == HeroEnum.StateTip.FrameTip then
    self.ui.obj_FriendLevelTip:SetActive(true)
    self.ui.tex_FriendLevelTip:SetIndex(0)
  elseif tipState == HeroEnum.StateTip.BeforeVowTip then
    self.ui.obj_FriendLevelTip:SetActive(true)
    self.ui.tex_FriendLevelTip:SetIndex(1)
  else
    self.ui.obj_VowTip:SetActive(true)
  end
  if self.friendTipTimer ~= nil then
    TimerManager:StopTimer(self.friendTipTimer)
    self.friendTipTimer = nil
  end
  self.friendTipTimer = TimerManager:StartTimer(3, function()
    self.ui.obj_FriendLevelTip:SetActive(false)
    self.ui.obj_VowTip:SetActive(false)
    self.friendTipTimer = nil
  end, self, true)
end

function UIHeroState:RefershHeroVowChangeName()
  local vowState = self.heroData == nil and VowEnum.EVowState.NoData or self.heroData:GetHeroVowState()
  self.ui.btn_Vow.gameObject:SetActive(vowState == VowEnum.EVowState.Vowed)
end

function UIHeroState:RefreshShowLive2dBtn()
  local picName = self.heroData:GetResPicName()
  local resPath = PathConsts:GetCharacterLive2DPath(picName, SkinEnum.fromWhere.heroInfoAndHandbook)
  local showLive2d = PlayerDataCenter.skinData:GetLive2dSwitchState(self.heroData.dataId, self.heroData.skinId)
  local isLocked = HeroCubismInteration.JudgeL2DLocked(self.heroData.skinId)
  local active = CS.ResManager.Instance:ContainsAsset(resPath) and showLive2d and not isLocked
  self.ui.btn_UIHide.gameObject:SetActive(active)
end

function UIHeroState:OnClickShowSkinL2D()
  if self._isInPreview then
    return
  end
  if self.heroCubismInteration == nil then
    return
  end
  self._isInPreview = true
  self:__SetEventTriggerListener(false)
  if self.heroStateShowL2D ~= nil then
    local heroId = self.heroData.dataId
    local skinId = self.heroData.skinId
    local loginType = TimeUtil.GetLoginType(heroId, skinId)
    self.heroStateShowL2D:EnterShowMode(loginType)
  end
end

function UIHeroState:OnExitShowSkinL2DMode()
  self:__SetEventTriggerListener(true)
  self._isInPreview = false
end

function UIHeroState:__SetEventTriggerListener(isTrigger)
  local setValue = isTrigger and "+" or "-"
  local eventTigger = CS_EventTriggerListener.Get(self.ui.dragHand)
  eventTigger:onDrag("-", self.__inTouching)
  eventTigger:onEndDrag("-", self.__endTouch)
  eventTigger:onBeginDrag("-", self.__startTouch)
  eventTigger:onDrag(setValue, self.__inTouching)
  eventTigger:onEndDrag(setValue, self.__endTouch)
  eventTigger:onBeginDrag(setValue, self.__startTouch)
end

function UIHeroState:Delete()
  if self.formWindowTypeID ~= nil then
    local win = UIManager:GetWindow(self.formWindowTypeID)
    if win ~= nil and not win.active then
      win.active = true
      win.gameObject:SetActive(true)
    end
  end
  if not IsNull(self.bigImgGameObject) then
    HeroCubismInteration.DestroyInterationInstance(self.bigImgGameObject)
  end
  base.Delete(self)
end

function UIHeroState:OnDelete()
  self.ui.canvasGroup.blocksRaycasts = false
  self.ui.canvasGroup.interactable = false
  self:RemoveAllTouch()
  if self.chageCoroutine ~= nil then
    CS_coroutine.stop(self.chageCoroutine)
    self.chageCoroutine = nil
  end
  if self.backCoroutine ~= nil then
    CS_coroutine.stop(self.backCoroutine)
    self.backCoroutine = nil
  end
  if self.heroStateShowL2D ~= nil then
    self.heroStateShowL2D:Delete()
    self.heroStateShowL2D = nil
  end
  self:__SetEventTriggerListener(false)
  self:RemoveRedDotEvent()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__refresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__onFriendshipDataUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnSkinChange)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroLive2dChange, self.__OnSkinChange)
  MsgCenter:RemoveListener(eMsgEventId.SpecWeaponLvUp, self.__OnSpecWeaponChange)
  MsgCenter:RemoveListener(eMsgEventId.SpecWeaponUnlock, self.__OnSpecWeaponChange)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHeroVow, self.__OnHeroVowStateChange)
  MsgCenter:RemoveListener(eMsgEventId.HeroSkinLimitTimeOut, self.__OnSkinChange)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinUpgrade, self.__OnSkinChange)
  if self.levelUpWin ~= nil then
    self.levelUpWin:Delete()
  end
  if self.skillUgradeWin ~= nil then
    self.skillUgradeWin:Delete()
  end
  if self.friendTipTimer ~= nil then
    TimerManager:StopTimer(self.friendTipTimer)
    self.friendTipTimer = nil
  end
  if self.sdTween ~= nil then
    self.sdTween:Kill()
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  if self.attrOutLineWindow ~= nil then
    self.attrOutLineWindow:Hide()
    self.attrOutLineWindow:OnDelete()
  end
  self.athNode:Delete()
  base.OnDelete(self)
end

return UIHeroState
