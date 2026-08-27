local UIActivityDivergentMain = class("UIActivityDivergentMain", UIBaseWindow)
local base = UIBaseWindow
local UINActivityDivergentRewardFrame = require("Game.ActivityDivergent.UI.Reward.UINActivityDivergentRewardFrame")
local UINActivityDivergentMainNode = require("Game.ActivityDivergent.UI.Reward.UINActivityDivergentMainNode")
local UINActivityDivergentTaskNode = require("Game.ActivityDivergent.UI.Task.UINActivityDivergentTaskNode")
local UINActivityDivergentAllTaskCompleteNode = require("Game.ActivityDivergent.UI.Task.UINActivityDivergentAllTaskCompleteNode")
local cs_ResLoader = CS.ResLoader
local SkinEnum = require("Game.Skin.SkinEnum")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local poseType = "HeroList"

function UIActivityDivergentMain:OnInit()
  self._resloader = cs_ResLoader.Create()
  self._rewardFrameNode = UINActivityDivergentRewardFrame.New()
  self._rewardFrameNode:Init(self.ui.obj_RewardFrame)
  self._rewardFrameNode:Hide()
  self.__ShowDivergentRewardFrameCallback = BindCallback(self, self.__ShowDivergentRewardFrame)
  self._mainNode = UINActivityDivergentMainNode.New()
  self._mainNode:Init(self.ui.obj_MainNode)
  self._mainNode:Hide()
  self._taskNode = UINActivityDivergentTaskNode.New()
  self._taskNode:Init(self.ui.obj_TaskNode)
  self._taskNode:Hide()
  self._allTaskCompleteNode = UINActivityDivergentAllTaskCompleteNode.New()
  self._allTaskCompleteNode:Init(self.ui.obj_AllTaskCompleteNode)
  self._allTaskCompleteNode:Hide()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    self:SetFromWhichUI(eBaseWinFromWhere.home)
    homeUI:OpenOtherWin()
  end
  self._mainController = ControllerManager:GetController(ControllerTypeId.ActivityDivergent, true)
  UIUtil.AddButtonListener(self.ui.btn_CheckHero, self, self.__ShowDivergentHeroDetail)
  UIUtil.AddButtonListener(self.ui.btn_CheckModel, self, self.__ShowDivergentHeroModel)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.UseDivergentHero)
  UIUtil.AddButtonListener(self.ui.btn_SelectHero, self, self.__SelectDivergentHero)
  self.__OnShowDivergentUI = BindCallback(self, self.OnShowDivergentUI)
  self.__RefreshDivergentMainFunc = BindCallback(self, self.RefreshDivergentMain)
  MsgCenter:AddListener(eMsgEventId.ActivityDivergentChange, self.__RefreshDivergentMainFunc)
end

function UIActivityDivergentMain:InitDivergentMain(divergentData, enterSectorFunc, backCallback)
  self.divergentData = divergentData
  self._enterSectorFunc = enterSectorFunc
  self._backCallback = backCallback
  self.showingHeroId = 0
  if divergentData:GetIsSelectedDivergentHero() then
    self.showingHeroId = divergentData:GetDivergentCurrentHeroId()
  else
    self.showingHeroId = divergentData:GetDivergentDefaultHeroId()
  end
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):SetTopStatusVisible(true):SetTopStatusInfoFunc(function()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
      if window == nil then
        return
      end
      window:InitCommonInfo(ConfigData:GetTipContent(divergentData:GetDivergentMainCfg().rule_des), ConfigData:GetTipContent(divergentData:GetDivergentMainCfg().rule_title), nil)
    end)
  end):PushTopStatusDataToBackStack(true)
  self.ui.ani_center:Play("UI_AnotherHero_NormalIntro")
  self._rewardFrameNode:InitDivergentRewardFrame(divergentData, self.showingHeroId)
  self._mainNode:InitDivergentMainNode(divergentData, self.__ShowDivergentRewardFrameCallback)
  self._taskNode:InitDivergentTaskNode(divergentData)
  self._allTaskCompleteNode:InitDivergentAllTaskCompleteNode(divergentData)
  self:RefreshDivergentMain(true)
  local progressData = self.divergentData:GetDivergentHeroData(self.showingHeroId)
  if progressData ~= nil then
    local levelData = self.divergentData:GetDivergentHeroRewardLevelInStage(self.showingHeroId, 1)
    local stepGoodDatas = self.divergentData:GetDivergentHeroRewardGroupCfg(self.showingHeroId)[progressData.rewardStage]
    self._mainNode:SetDivergentScrollBar(levelData.reward_rank, -1)
  end
end

function UIActivityDivergentMain:RefreshDivergentMain(isSortTasks)
  local divergentHeroId = self.showingHeroId
  self:__LoadDivergentHero(divergentHeroId)
  local heroModelPreviewPic = self.divergentData:GetDivergentUiCfg(divergentHeroId).model_pic
  if not string.IsNullOrEmpty(heroModelPreviewPic) then
    local fullPath = PathConsts:GetActivityDivergentPath(heroModelPreviewPic)
    self._resloader:LoadABAssetAsync(fullPath, function(texture)
      if IsNull(self.transform) then
        return
      end
      if texture ~= nil then
        self.ui.img_HeroModel.texture = texture
      end
    end)
  end
  self.ui.blueDot_HeroSector:SetActive(not self.divergentData:GetDivergentHeroSectorChecked(divergentHeroId))
  local heroCfg = ConfigData.hero_data[divergentHeroId]
  self.ui.obj_Open:SetActive(self.divergentData:GetDivergentCurrentHeroId() ~= divergentHeroId)
  self.ui.tex_HeroName.text = LanguageUtil.GetLocaleText(heroCfg.name)
  local careerCfg = ConfigData.career[heroCfg.career]
  local campCfg = ConfigData.camp[heroCfg.camp]
  self.ui.img_Career.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  self.ui.img_Camp.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(PathConsts:GetCampPicPath(campCfg.icon), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_Camp.gameObject:SetActive(true)
    self.ui.img_Camp.texture = texture
  end)
  self._rewardFrameNode:RefreshDivergentRewardFrame(divergentHeroId)
  self._mainNode:RefreshDivergentMainNode(divergentHeroId, self.ui.ani_center)
  self._taskNode:RefreshDivergentTaskNode(divergentHeroId, isSortTasks)
  self._allTaskCompleteNode:RefreshDivergentAllTaskCompleteNode(divergentHeroId, self.ui.ani_center)
end

function UIActivityDivergentMain:__LoadDivergentHero(divergentHeroId)
  if self._currentLoadHeroId == divergentHeroId then
    return
  end
  local heroUiCfg = self.divergentData:GetDivergentUiCfg(divergentHeroId)
  if heroUiCfg == nil then
    return
  end
  if not IsNull(self.liveGo) then
    DestroyUnityObject(self.liveGo)
    self.liveGo = nil
  end
  if not IsNull(self.bigImgGameObject) then
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = nil
  end
  self._currentLoadHeroId = divergentHeroId
  local skinCtrl = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local modelCfg = skinCtrl:GetResModel(divergentHeroId, heroUiCfg.background_skin)
  local resName = modelCfg.src_id_pic
  if heroUiCfg.skin_type == 1 then
    self:__LoadHeroPic(divergentHeroId, heroUiCfg.background_skin)
  else
    self:__LoadLive2D(divergentHeroId, heroUiCfg.background_skin)
  end
end

function UIActivityDivergentMain:__LoadHeroPic(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType(poseType)
  end)
end

function UIActivityDivergentMain:__LoadLive2D(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  if not PlayerDataCenter.skinData:IsSkinL2dCouldShow(skinId) then
    self:__LoadPic(heroId, skinId)
    return
  end
  local resName = skinCfg.src_id_pic
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(resName), function(l2dModelAsset)
    if IsNull(l2dModelAsset) then
      return
    end
    self.liveGo = l2dModelAsset:Instantiate()
    self.liveGo.transform:SetParent(self.ui.heroHolder.transform)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroHolder, nil, true)
      self.heroCubismInteration:SetL2DPosType(poseType, false)
    end
  end)
end

function UIActivityDivergentMain:__ShowDivergentHeroDetail()
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfoState, function(win)
    if win == nil then
      return
    end
    win:InitHeroInfoState(self.showingHeroId)
  end)
end

function UIActivityDivergentMain:__ShowDivergentHeroModel()
  local heroUiCfg = self.divergentData:GetDivergentUiCfg(self.showingHeroId)
  if heroUiCfg == nil then
    return
  end
  local showCharacterSkinCtrl = ControllerManager:GetController(ControllerTypeId.ShowCharacterSkin, true)
  local skinId = heroUiCfg.background_skin
  showCharacterSkinCtrl:InitShowCharacterSkinCtrl(self.showingHeroId, skinId, nil, nil)
end

function UIActivityDivergentMain:UseDivergentHero()
  local sectorId = self.divergentData:GetDivergentHeroCfg(self.showingHeroId).test_stage
  if sectorId == nil then
    return
  end
  if self._enterSectorFunc == nil then
    return
  end
  if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
    return
  end
  self.divergentData:SetDivergentHeroSectorChecked(self.showingHeroId)
  self.ui.blueDot_HeroSector:SetActive(not self.divergentData:GetDivergentHeroSectorChecked(self.showingHeroId))
  self:OnHideDivergentUI()
  self._enterSectorFunc(sectorId, 1, nil, self.__OnShowDivergentUI, function()
    local sectorLevelWin = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
    if sectorLevelWin ~= nil then
      sectorLevelWin:SetCustomEnterFmtCallback(function(enterFmtData)
        if enterFmtData ~= nil then
          enterFmtData:SetFmtForbidSupport(true)
          enterFmtData:SetIsShowSupportHolder(true)
        end
      end)
    end
  end)
end

function UIActivityDivergentMain:OnHideDivergentUI()
  UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActivityDivergentMain, false)
  self:Hide()
end

function UIActivityDivergentMain:OnShowDivergentUI()
  self:Show()
end

function UIActivityDivergentMain:__SelectDivergentHero()
  local function confirmSelectFunc()
    self._mainController:ReqSwitchDivergentHero(self.divergentData:GetActId(), self.showingHeroId, function()
      local heroCfg = self.divergentData:GetDivergentHeroCfg(self.showingHeroId)
      
      if ControllerManager:GetController(ControllerTypeId.AvgPlay):IsAvgPlayed(heroCfg.avg_id) then
        return
      end
      local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
      avgCtrl:StartAvg(nil, heroCfg.avg_id, function()
        self.ui.ani_center:Play("UI_AnotherHero_UnLockStateIntro")
      end)
    end)
  end
  
  local selectingHeroCfg = ConfigData.hero_data[self.showingHeroId]
  if not self.divergentData:GetIsSelectedDivergentHero() then
    local msg = string.format(ConfigData:GetTipContent(9605), LanguageUtil.GetLocaleText(selectingHeroCfg.name))
    local msgWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    msgWindow:ShowTextBoxWithYesAndNo(msg, function()
      confirmSelectFunc()
    end)
    return
  end
  confirmSelectFunc()
end

function UIActivityDivergentMain:__ShowDivergentRewardFrame()
  self._rewardFrameNode:ShowDivergentRewardFrame()
end

function UIActivityDivergentMain:__BackAction()
  self:OnCloseWin()
  if self._backCallback ~= nil then
    self._backCallback(false)
  end
  self._rewardFrameNode:Delete()
  self._mainNode:Delete()
  self._taskNode:Delete()
  self._allTaskCompleteNode:Delete()
  self:Delete()
end

function UIActivityDivergentMain:OnDelete()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.ActivityDivergentChange, self.__RefreshDivergentMainFunc)
  base.OnDelete(self)
end

return UIActivityDivergentMain
