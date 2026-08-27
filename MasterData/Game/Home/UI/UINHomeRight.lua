local UINHomeRight = class("UINHomeRight", UIBaseNode)
local base = UIBaseNode
local CS_SystemInfo = CS.UnityEngine.SystemInfo
local CS_BatteryStatus = CS.UnityEngine.BatteryStatus
local CS_Tweening = CS.DG.Tweening
local CS_DoTween = CS_Tweening.DOTween
local cs_MessageCommon = CS.MessageCommon
local UINHomeGeneralBtn = require("Game.Home.UI.UINHomeGeneralBtn")
local UINHomeLotteryBtn = require("Game.Home.UI.UINHomeLotteryBtn")
local JumpManager = require("Game.Jump.JumpManager")
local NoticeData = require("Game.Notice.NoticeData")
local SectorEnum = require("Game.Sector.SectorEnum")
local CS_ClientConsts = CS.ClientConsts
local UINHomeActivityEntryList = require("Game.Home.UI.Side.UINHomeActivityEntryList")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UINHomeRight:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_openRightSide, self, self._SwitchUnfoldState)
  UIUtil.AddButtonListener(self.ui.btn_Exproation, self, self.OnClickEpBtn)
  UIUtil.AddButtonListener(self.ui.btn_Oasis, self, self.OnClickOasisBtn)
  UIUtil.AddButtonListener(self.ui.btn_Achievement, self, self.OnClickAchievementBtn)
  UIUtil.AddButtonListener(self.ui.btn_Shop, self, self.OnClickshopBtn)
  UIUtil.AddButtonListener(self.ui.btn_Factor, self, self.OnClickFactoryBtn)
  UIUtil.AddButtonListener(self.ui.btn_Warehouse, self, self.OnClickWarehouseBtn)
  UIUtil.AddButtonListener(self.ui.btn_Dorm, self, self.OnClickDormBtn)
  UIUtil.AddButtonListener(self.ui.btn_FairyEntrance, self, self.OnClickFairyBtn)
  UIUtil.AddButtonListener(self.ui.btn_Lottery, self, self.OnClickLotteryBtn)
  UIUtil.AddButtonListener(self.ui.btn_HeroList, self, self.OnClickHeroListBtn)
  UIUtil.AddButtonListener(self.ui.btn_HandBook, self, self.OnClickHandBookBtn)
  if not IsNull(self.ui.btn_MileStone) then
    UIUtil.AddButtonListener(self.ui.btn_MileStone, self, self.OnClickMileStoneBtn)
  end
  if not IsNull(self.ui.btn_Formation) then
    UIUtil.AddButtonListener(self.ui.btn_Formation, self, self.OnClickFmtBtn)
  end
  self.__OnLimitItemOut = BindCallback(self, self.OnLimitItemOut)
  MsgCenter:AddListener(eMsgEventId.UpdateWareHouseLimitTime, self.__OnLimitItemOut)
  self.__RefreshStaminaLimitTime = BindCallback(self, self.RefreshStaminaLimitTime)
  MsgCenter:AddListener(eMsgEventId.UpdateStaminaLimitTime, self.__RefreshStaminaLimitTime)
  self.__RefreshBatteryAndTime = BindCallback(self, self.RefreshBatteryAndTime)
  self._seqFoldDic = {}
  self._seqUnFoldDic = {}
  self.isUnfold = false
  self.ui.pageListLength = self.ui.tran_PageList.rect.width
  self.ui.rectLength = self.ui.tran_ListRect.rect.width
  self.ui.fullHandleLength = self.ui.tran_Handle.rect.width
  self.sectorActivityEntry = UINHomeActivityEntryList.New()
  self.sectorActivityEntry:Init(self.ui.obj_ActivityEntry)
  local isUnlock = PlayerDataCenter.sectorStage:IsStageComplete(ConfigData.game_config.guideFirstTipsEnd)
  self.ui.img_TipsGuide:SetActive(not isUnlock)
  PlayerDataCenter:CheckHaseLimitTimeItem()
  local isHasMin15LimitTimeItem = PlayerDataCenter:GetIsHasMin15LimitTime()
  self:OnLimitItemOut(isHasMin15LimitTimeItem)
end

function UINHomeRight:OnHomeShow()
  if self.BatteryTimerId ~= nil then
    TimerManager:StopTimer(self.BatteryTimerId)
    self.BatteryTimerId = nil
  end
  self.BatteryTimerId = TimerManager:StartTimer(1, self.__RefreshBatteryAndTime, nil, false, false, true)
  self:RefreshEpBtn()
  self:RefreshOasisBtn()
  self:RefreshAchievementBtn()
  self:RefreshshopBtn()
  self:RefreshFactoryBtn()
  self:RefreshWarehouseBtn()
  self:RefreshDormBtn()
  self:RefreshFairyBtn()
  self:RefreshLotteryBtn()
  self:RefreshHeroListBtn()
  self:RefreshHandBooktn()
  self:RefreshMileStoneBtn()
  self:RefreshFmtBtn()
  self.sectorActivityEntry:InitHomeActivityEntryList()
  if CS_ClientConsts.IsAudit then
    self.sectorActivityEntry:Hide()
  end
  for k, seq in pairs(self._seqFoldDic) do
    seq:Restart()
  end
end

function UINHomeRight:InitHomeRightNode(homeUI)
  self.homeUI = homeUI
  self.bind = homeUI.bind
  self.homeController = homeUI.homeController
  self:RefreshVersionInfo()
end

function UINHomeRight:RefreshBatteryAndTime()
  local batteryLevel = CS_SystemInfo.batteryLevel
  local batteryStatus = CS_SystemInfo.batteryStatus
  if batteryLevel == nil or batteryLevel < 0 then
    batteryLevel = 1
  end
  self.ui.img_CurBattery.fillAmount = batteryLevel
  if batteryStatus == CS_BatteryStatus.Charging then
    self.ui.obj_recharge:SetActive(true)
  else
    self.ui.obj_recharge:SetActive(false)
  end
  self.ui.tex_Clock.text = GR.GetLocalSystemTimeStr()
end

function UINHomeRight:RefreshVersionInfo()
  local hasHotUpdateVer = CS.ClientConsts.GameVersionStr
  local VerApp = CS.ClientConsts.GetGameVersionApp()
  self.ui.tex_Version:SetIndex(0, VerApp, hasHotUpdateVer)
end

function UINHomeRight:OnLimitItemOut(isHas)
  if self.ui.obj_GiftTimeLimit.activeSelf ~= isHas then
    self.ui.obj_GiftTimeLimit:SetActive(isHas)
  end
end

function UINHomeRight:OnClickEpBtn(doNotOpenEpStages)
  if self.epBtn.isUnlock then
    if self.homeController ~= nil then
      self.homeController:SetIsBlockAddAutoShowGuide(true)
    end
    if ExplorationManager:HasUncompletedEp() and JumpManager:GetSectorJumpId() == nil then
      local lastSelectSector = PlayerDataCenter.sectorStage:GetSelectSectorId()
      local whiteDayctrl = ControllerManager:GetController(ControllerTypeId.WhiteDay)
      local isSuccess = whiteDayctrl ~= nil and whiteDayctrl:TryEnterWDSector(lastSelectSector)
      if isSuccess then
        return
      end
      local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
      isSuccess = win23Ctrl ~= nil and win23Ctrl:TryEnterWTSector(lastSelectSector)
      if isSuccess then
        return
      end
    end
    self.doNotOpenEpStages = doNotOpenEpStages
    self.homeUI:SetTo(AreaConst.Sector)
    UIUtil.AddOneCover("enterSectorTimeLine")
    self.bind.sectorPlayableDirector:Play()
    self.sectorBtnClicked = true
    AudioManager:PlayAudioById(1112)
  else
    AudioManager:PlayAudioById(1087)
    self.epBtn:ShowUnlockDes()
  end
end

function UINHomeRight:RefreshEpBtn()
  if self.epBtn == nil then
    self.epBtn = UINHomeGeneralBtn.New()
    self.epBtn:Init(self.ui.btn_Exproation.gameObject)
    self.homeController:AddRedDotEvent(function()
      local redCount = 0
      local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
      if actFrameCtrl == nil then
        return
      end
      for _, pageIndex in pairs(SectorEnum.ePageIndex) do
        local isCurHave, isCurBlue
        isCurHave, isCurBlue = actFrameCtrl:GetSectorPageReddot(pageIndex)
        if isCurHave and not isCurBlue then
          redCount = redCount + 1
        end
      end
      self.epBtn:RefreshRedDot(redCount, false)
    end, RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector)
    UIUtil.AddButtonListener(self.epBtn.ui.btn_ContinueEp, self, function()
      self.homeController:ResetShowHeroVoiceImme()
      SectorStageDetailHelper.ContinueUncompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
    end)
    UIUtil.AddButtonListener(self.epBtn.ui.btn_AddEpPoint, self, BindCallback(self, self.QickBuyStamina))
    UIUtil.AddButtonListener(self.epBtn.ui.btn_pountInfo, self, BindCallback(self, self.ShowStaminaDetail))
    self.bind.sectorPlayableDirector:stopped("+", function(director)
      if self.bind.sectorPlayableDirector == director then
        if not self.sectorBtnClicked then
          self.bind.sectorPlayableDirector.initialTime = 0
          return
        end
        self.sectorBtnClicked = false
        UIManager:DeleteWindow(UIWindowTypeID.Home)
        ControllerManager:GetController(ControllerTypeId.SectorController, true):InitSectorCtrl(function(sectorCtrl)
          if self.homeUI.enterSectorJumpCallback ~= nil then
            local jumpId = JumpManager:GetSectorJumpId()
            sectorCtrl:SetJumpInCallback(self.homeUI.enterSectorJumpCallback)
            sectorCtrl:SetFrom(AreaConst.Home, nil, jumpId)
            self.homeUI.enterSectorJumpCallback = nil
          elseif SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep) and not self.doNotOpenEpStages then
            sectorCtrl:SetFrom(AreaConst.Exploration)
          else
            sectorCtrl:SetFrom(AreaConst.Home)
          end
          UIUtil.CloseOneCover("enterSectorTimeLine")
        end)
      end
    end)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration)
  self.epBtn:RefeshUnlockInfo(isUnlock, unlockDes)
  if isUnlock then
    self:_SetExplorationTween()
  end
  self:RefreshContinueEp()
  self:RefreshStamina()
  self:RefreshStaminaLimitTime()
end

function UINHomeRight:RefreshCurEpStage()
  local sectorId, stageIndex, differIdex = PlayerDataCenter.sectorStage:GetEpStageCfg4Home()
  self.epBtn.ui.tex_ProgressLevel.text = ConfigData:GetSectorInfoMsg(sectorId, stageIndex, differIdex)
end

function UINHomeRight:RefreshNormalStage(stageId)
  local stageCfg = ConfigData.sector_stage[stageId]
  local sectorId = stageCfg.sector
  local difficultyId = stageCfg.difficulty
  local stageIndex = 0
  local difflist = ConfigData.sector_stage.sectorDiffDic[sectorId][difficultyId]
  for index, id in ipairs(difflist) do
    if id == stageId then
      stageIndex = index
    end
  end
  self.epBtn.ui.tex_CurLevel.text = ConfigData:GetSectorInfoMsg(sectorId, stageIndex, difficultyId, stageId)
end

function UINHomeRight:RefreshEndlessStage(stageId)
  local eDynConfigData = require("Game.ConfigData.eDynConfigData")
  local endlessLevelDic = ConfigData.endless.levelDic[stageId]
  local sectorId = endlessLevelDic.sectorId
  local depth = endlessLevelDic.index * 10
  local sectorCfg = ConfigData.sector[sectorId]
  package.loaded[eDynConfigData] = nil
  self.epBtn.ui.tex_CurLevel.text = ConfigData:GetEndlessInfoMsg(sectorCfg, depth)
end

function UINHomeRight:RefreshChallengeStage(moduleId)
  self.epBtn.ui.tex_CurLevel.text = ConfigData:GetChallengeInfoMsg(moduleId)
end

function UINHomeRight:RefreshContinueEp()
  local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
  self.epBtn.ui.btn_ContinueEp.gameObject:SetActive(hasHasUncompletedEp)
  self.epBtn.ui.obj_ProgressLevel:SetActive(not hasHasUncompletedEp)
  self.epBtn.ui.obj_curLevel:SetActive(hasHasUncompletedEp)
  if hasHasUncompletedEp then
    local isEndless = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless
    local isChallenge = moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge or moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge
    if isEndless then
      self:RefreshEndlessStage(stageId)
    elseif isChallenge then
      self:RefreshChallengeStage(moduleId)
    else
      self:RefreshNormalStage(stageId)
    end
  else
    self:RefreshCurEpStage()
  end
end

function UINHomeRight:RefreshStamina()
  local ceiling = PlayerDataCenter.stamina:GetStaminaCeiling()
  local stamina, remainSecond = PlayerDataCenter.stamina:GetCurrentStamina()
  self.epBtn.ui.tex_EpPoint.text = tostring(stamina)
  self.epBtn.ui.tex_EpPointLimit.text = "/" .. tostring(ceiling)
end

function UINHomeRight:RefreshStaminaLimitTime(limitDay, limitHour, limitMinute, isHasMin1Day)
  if self.StaminaLimitTimer ~= nil then
    TimerManager:StopTimer(self.StaminaLimitTimer)
    self.StaminaLimitTimer = nil
  end
  if limitDay == nil or limitHour == nil or limitMinute == nil or isHasMin1Day == nil then
    limitDay, limitHour, limitMinute, isHasMin1Day = PlayerDataCenter:GetEarliestOverdueStaminaLimitTime()
  end
  self:RefreshStaminaLimitTimeInfo(limitDay, limitHour, isHasMin1Day)
  self.StaminaLimitTimer = TimerManager:StartTimer(60, self.__RefreshStaminaLimitTime, nil, false, false, true)
end

function UINHomeRight:RefreshStaminaLimitTimeInfo(limitDay, limitHour, isHasMin1Day)
  self.ui.Img_TimeLimit:SetActive(0 <= limitHour)
  if limitHour == 0 then
    limitHour = 1
  end
  if isHasMin1Day then
    self.ui.Tex_TimeLimit.text = tostring(limitHour) .. "h"
  else
    self.ui.Tex_TimeLimit.text = tostring(limitDay) .. "d"
  end
end

function UINHomeRight:QickBuyStamina()
  JumpManager:Jump(JumpManager.eJumpTarget.BuyStamina)
end

function UINHomeRight:ShowStaminaDetail()
  if GuideManager.inGuide then
    return
  end
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  if self.parentWindowType ~= nil then
    window:ParentWindowType(self.parentWindowType)
  end
  window:InitCommonItemDetail(ConfigData.item[ConstGlobalItem.SKey])
end

function UINHomeRight:_SetExplorationTween()
  self.epBtn.ui.canvas_Explore.alpha = 0
  local seq, isFirst = self:_CreateTweenSequence(self.epBtn)
  if not isFirst then
    return
  end
  seq:SetDelay(0.35)
  seq:OnComplete(function()
    if not self.epBtn.ui.canvas_Explore.gameObject.activeInHierarchy then
      self.epBtn.ui.canvas_Explore.alpha = 1
      return
    end
    self.epBtn.ui.anim_Explore:Rewind()
    self.epBtn.ui.anim_Explore:Play()
  end)
end

function UINHomeRight:OnClickOasisBtn()
  if self.oasisBtn.isUnlock then
    CS.RenderManager.Instance:SetUnityShadow(true)
    self.homeUI:SetIsUnfold(false, true)
    self.homeUI:OpenOtherCoverWin()
    CS.OasisCameraController.Instance:ResetOasisView()
    TimerManager:StartTimer(0.2, function()
      self.homeUI:HideBordGirl()
      self.homeController:HideWarfarEffect()
    end, nil, true)
    self.homeUI:SetTo(AreaConst.Oasis)
    self:_ClearOasisTlCo()
    self.homeController:IsEnterOasis(true)
    local vcam2 = CS.UnityEngine.GameObject.Find("Cinemachine/HomeToOasis/CM vcam/CM vcam 2 Oasis")
    self.__tlOasisCo = TimelineUtil.Play(self.bind.oasisPlayableDirector, function()
      vcam2:SetActive(true)
    end)
    UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
    AudioManager:PlayAudioById(1016)
    
    local function homeClicked()
      self.homeController:IsEnterOasis(false)
      UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
      self:_ClearOasisTlCo()
      self.homeController.oasisController:OnExitOasis()
      AudioManager:PlayAudioById(1017)
      self.__tlOasisCo = TimelineUtil.Rewind(self.bind.oasisPlayableDirector, function()
        CS.RenderManager.Instance:SetUnityShadow(false)
        UIManager:ShowWindow(UIWindowTypeID.Home)
        self.homeUI:ShowBordGirl()
        self.homeUI:OnShow(true)
        self.homeController:OnUpdate(true)
        self.homeUI:SetFrom2Home(AreaConst.Oasis, true)
        UIManager:HideWindow(UIWindowTypeID.ClickContinue)
        vcam2:SetActive(false)
      end)
    end
    
    self.homeController.oasisController.backToHomeEvent = BindCallback(self, homeClicked)
  else
    AudioManager:PlayAudioById(1087)
    self.oasisBtn:ShowUnlockDes()
  end
end

function UINHomeRight:RefreshOasisBtn()
  if self.oasisBtn == nil then
    self.oasisBtn = UINHomeGeneralBtn.New()
    self.oasisBtn:Init(self.ui.btn_Oasis.gameObject)
    self.homeController:AddRedDotEvent(self.oasisBtn:GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BuildingBug)
  self.oasisBtn:RefeshUnlockInfo(isUnlock, unlockDes)
  if isUnlock and not ConfigData.game_config.isHomeMianBlockOasisBtnTween then
    self:_SetOasisBtnTween()
  end
  self:RefreshBuiltRate()
end

function UINHomeRight:RefreshBuiltRate()
  local rate = PlayerDataCenter.AllBuildingData:GetOasisBuiltRate()
  rate = math.floor(rate * 100)
  self.oasisBtn.ui.tex_OasisDevRate:SetIndex(0, tostring(rate))
end

function UINHomeRight:_SetOasisBtnTween()
  local seq, isFirst = self:_CreateTweenSequence(self.oasisBtn)
  if not isFirst then
    return
  end
  local aniComponents = self.oasisBtn.ui.aniComponents
  self:_SetComLocalMove(aniComponents[1].transform, Vector3.New(10, -10, 0))
  seq:Append(aniComponents[1].transform:DOLocalMove(Vector3.New(10, -10, 0), 0.35):SetRelative(true))
  self:_SetComImageAlpha(aniComponents[1], 0)
  seq:Join(aniComponents[1]:DOFade(1, 0.35))
  self:_SetComLocalMove(aniComponents[2].transform, Vector3.New(10, -10, 0))
  seq:Append(aniComponents[2].transform:DOLocalMove(Vector3.New(10, -10, 0), 0.35):SetRelative(true))
  self:_SetComImageAlpha(aniComponents[2], 0)
  seq:Join(aniComponents[2]:DOFade(1, 0.35))
  self:_SetComImageAlpha(aniComponents[3], 0)
  seq:SetDelay(0.35)
  seq:Restart()
  seq:OnComplete(function()
    aniComponents[3]:DOFade(0.4, 1):SetLink(aniComponents[3].gameObject)
    aniComponents[3].transform:DOLocalRotate(Vector3.New(23, 10, -360), 100, CS_Tweening.RotateMode.FastBeyond360):SetLoops(-1):SetLink(aniComponents[3].gameObject)
  end)
end

function UINHomeRight:OnClickAchievementBtn()
  if self.achievementBtn.isUnlock then
    UIManager:ShowWindowAsync(UIWindowTypeID.AchievementSystem, function(win)
      if win ~= nil then
        self.homeUI:OpenOtherWin()
        win:SetFromWhichUI(eBaseWinFromWhere.home)
        win:InitAchievement(nil)
      end
    end)
  end
end

function UINHomeRight:RefreshAchievementBtn()
  if self.achievementBtn == nil then
    self.achievementBtn = UINHomeGeneralBtn.New()
    self.achievementBtn:Init(self.ui.btn_Achievement.gameObject)
    self.homeController:AddRedDotEvent(self.achievementBtn:GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.AchivLevel)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  self.achievementBtn:RefeshUnlockInfo(isUnlock)
  self.achievementBtn.gameObject:SetActive(isUnlock)
end

function UINHomeRight:OnClickshopBtn()
  if self.shopBtn.isUnlock then
    UIManager:ShowWindowAsync(UIWindowTypeID.ShopMain, function(window)
      if window ~= nil then
        window:SetFromWhichUI(eBaseWinFromWhere.home)
        window:InitShop()
        self.homeUI:OpenOtherWin()
      end
    end)
  else
    AudioManager:PlayAudioById(1087)
    self.shopBtn:ShowUnlockDes()
  end
end

function UINHomeRight:RefreshshopBtn()
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  local giftController = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  local shopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
  if self.shopBtn == nil then
    self.shopBtn = UINHomeGeneralBtn.New()
    self.shopBtn:Init(self.ui.btn_Shop.gameObject)
    self.shopBtn:RefeshUnlockInfo(isUnlock, unlockDes)
    
    local function RefreshShopReddot(reddotNum)
      local isHaveNewGift = not isUnlock or giftController:IsHaveNewGiftInShop() or shopController:GetIsHaveNewSkinGoodItemInShop() or shopController:GetIsHaveNewVowSkinGoodItemInShop()
      local reddotCount = reddotNum
      if reddotCount == 0 then
        self.shopBtn:RefreshRedDot(reddotCount)
        self.shopBtn.ui.obj_NewGift:SetActive(isHaveNewGift)
        if isHaveNewGift == false and giftController:CheckHaveLimitGift() then
          self.shopBtn.ui.obj_GiftTimeLimit:SetActive(true)
        else
          self.shopBtn.ui.obj_GiftTimeLimit:SetActive(false)
        end
        return
      end
      local blueCount = 0
      local shopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
      for _, shopId in ipairs(ConfigData.shop.id_sort_list) do
        if shopController:IsShopBlueReddot(shopId) then
          local ok, tempNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
          local tempCount = ok and tempNode:GetRedDotCount() or 0
          blueCount = blueCount + tempCount
        end
      end
      local isRedDot = reddotCount ~= blueCount
      self.shopBtn.ui.obj_GiftTimeLimit:SetActive(false)
      self.shopBtn.ui.obj_NewGift:SetActive(not isRedDot and isHaveNewGift)
      if not isHaveNewGift or isRedDot then
        self.shopBtn:RefreshRedDot(reddotCount, not isRedDot)
      end
    end
    
    self.homeController:AddRedDotEvent(RefreshShopReddot, RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow)
    shopController:IsHaveNewSkinGoodItemInShop(function(isHaveNew)
      if IsNull(self.gameObejct) then
        return
      end
      if isHaveNew then
        local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow)
        RefreshShopReddot(node:GetRedDotCount())
      end
    end)
  else
    self.shopBtn:RefeshUnlockInfo(isUnlock, unlockDes)
    local isHaveNewGift = isUnlock and (giftController:IsHaveNewGiftInShop() or shopController:GetIsHaveNewSkinGoodItemInShop() or shopController:GetIsHaveNewVowSkinGoodItemInShop())
    local ok, tempNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow)
    local reddotCount = ok and tempNode:GetRedDotCount() or 0
    local blueCount = 0
    local shopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
    for _, shopId in ipairs(ConfigData.shop.id_sort_list) do
      if shopController:IsShopBlueReddot(shopId) then
        local ok, tempNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId)
        local tempCount = ok and tempNode:GetRedDotCount() or 0
        blueCount = blueCount + tempCount
      end
    end
    local isRedDot = reddotCount ~= blueCount
    self.shopBtn.ui.obj_NewGift:SetActive(not isRedDot and isHaveNewGift)
    if not isHaveNewGift or isRedDot then
      self.shopBtn:RefreshRedDot(reddotCount, not isRedDot)
    end
    if isHaveNewGift == false and giftController:CheckHaveLimitGift() and reddotCount == 0 then
      self.shopBtn.ui.obj_GiftTimeLimit:SetActive(true)
    else
      self.shopBtn.ui.obj_GiftTimeLimit:SetActive(false)
    end
  end
  self.epBtn.ui.btn_AddEpPoint.gameObject:SetActive(isUnlock)
end

function UINHomeRight:OnClickFactoryBtn()
  if self.factoryBtn.isUnlock then
    self.homeUI:SetTo(AreaConst.FactoryDorm)
    UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
    self.bind.factorydormPlayableDirector:Play()
    self.factoryBtnClicked = true
  else
    AudioManager:PlayAudioById(1087)
    self.factoryBtn:ShowUnlockDes()
  end
end

function UINHomeRight:RefreshFactoryEnergy()
  if self.factoryBtn ~= nil and self.factoryBtn.isUnlock then
    local factoryEnergyItemId = ConfigData.game_config.factoryEnergyItemId
    local totalCeiling = PlayerDataCenter.playerBonus:GetWarehouseCapcity(factoryEnergyItemId)
    local totalValue = PlayerDataCenter:GetItemCount(factoryEnergyItemId)
    if totalCeiling <= totalValue then
      NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.FactoryEnergyFull, {
        jumpType = JumpManager.eJumpTarget.Factory,
        argList = nil
      }, nil, nil))
    else
      NoticeManager:DeleteNoticeByType(NoticeManager.eNoticeType.FactoryEnergyFull)
    end
    local rate = totalValue / totalCeiling
    self.factoryBtn.ui.tex_energy.text = tostring(totalValue)
    self.factoryBtn.ui.img_fill.fillAmount = rate
    local ok, factoryNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Factory, RedDotStaticTypeId.FactoryEnerage)
    if ok then
      if totalCeiling <= totalValue then
        factoryNode:SetRedDotCount(1)
      else
        factoryNode:SetRedDotCount(0)
      end
    end
  end
end

function UINHomeRight:RefreshFactoryBtn()
  if self.factoryBtn == nil then
    self.factoryBtn = UINHomeGeneralBtn.New()
    self.factoryBtn:Init(self.ui.btn_Factor.gameObject)
    self.homeController:AddRedDotEvent(self.factoryBtn:GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Factory)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
  self.factoryBtn:RefeshUnlockInfo(isUnlock, unlockDes)
  if isUnlock then
    self:RefreshFactoryEnergy()
  end
  self.bind.factorydormPlayableDirector:stopped("+", function(director)
    if self.bind.factorydormPlayableDirector == director then
      if not self.factoryBtnClicked then
        self.bind.factorydormPlayableDirector.initialTime = 0
        return
      end
      self.factoryBtnClicked = false
      UIManager:DeleteWindow(UIWindowTypeID.Home)
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      ControllerManager:GetController(ControllerTypeId.Factory, true):OpenFactory()
    end
  end)
end

function UINHomeRight:OnClickWarehouseBtn()
  if self.warehouseBtn.isUnlock then
    UIManager:ShowWindowAsync(UIWindowTypeID.Warehouse, function(window)
      if window == nil then
        return
      end
      window:SetFromWhichUI(eBaseWinFromWhere.home)
      self.homeUI:OpenOtherWin()
      window:InitWarehouse()
    end)
  else
    AudioManager:PlayAudioById(1087)
    self.warehouseBtn:ShowUnlockDes()
  end
end

function UINHomeRight:RefreshWarehouseBtn()
  if self.warehouseBtn == nil then
    self.warehouseBtn = UINHomeGeneralBtn.New()
    self.warehouseBtn:Init(self.ui.btn_Warehouse.gameObject)
    self.homeController:AddRedDotEvent(self.warehouseBtn:GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Warehouse)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Backpack_ui)
  self.warehouseBtn:RefeshUnlockInfo(isUnlock, unlockDes)
end

function UINHomeRight:OnClickDormBtn()
  if self.dormBtn.isUnlock then
    ControllerManager:GetController(ControllerTypeId.Dorm, true):EnterDorm()
  else
    local openCfg = ConfigData.system_open[proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm]
    if openCfg ~= nil and openCfg.screening then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(170))
    else
      AudioManager:PlayAudioById(1087)
      self.dormBtn:ShowUnlockDes()
    end
  end
end

function UINHomeRight:RefreshDormBtn()
  if self.dormBtn == nil then
    self.dormBtn = UINHomeGeneralBtn.New()
    self.dormBtn:Init(self.ui.btn_Dorm.gameObject)
    self.homeController:AddRedDotEvent(self.dormBtn:GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  self.dormBtn:RefeshUnlockInfo(isUnlock, unlockDes)
end

function UINHomeRight:OnClickFairyBtn()
  if self.fairyBtn.isUnlock then
    ControllerManager:GetController(ControllerTypeId.Fairy, true):EnterFairyLobby()
  else
    AudioManager:PlayAudioById(1087)
    self.fairyBtn:ShowUnlockDes()
  end
end

function UINHomeRight:RefreshFairyBtn()
  if self.fairyBtn == nil then
    self.fairyBtn = UINHomeGeneralBtn.New()
    self.fairyBtn:Init(self.ui.btn_FairyEntrance.gameObject)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_fairy)
  self.fairyBtn:RefeshUnlockInfo(isUnlock, unlockDes)
  if IsNull(self.fairyBtn.ui.Tex_Count) then
    return
  end
  local fairyLotteryPoolData = PlayerDataCenter.allLtrData:GetFairyLtrPoolDataList()[1]
  if fairyLotteryPoolData == nil then
    error("can't get fairyLotteryPoolData, pls check lotter pool info.")
    self.fairyBtn.ui.Tex_Count.text = "0"
    return
  end
  local ltrCfg = fairyLotteryPoolData:GetLtrPoolDataCfg()
  local lotteryCostItemId1 = ltrCfg.costId1
  self.fairyBtn.ui.Tex_Count.text = tostring(PlayerDataCenter:GetItemCount(lotteryCostItemId1))
end

function UINHomeRight:OnClickLotteryBtn(defaultSelectPoolId, defaltSelectGroupId)
  if self.lotteryBtn.isUnlock then
    local ctrl = ControllerManager:GetController(ControllerTypeId.Lottery, true)
    ctrl:InitLottery(function(win)
      win:SetFromWhichUI(eBaseWinFromWhere.home)
      self.homeUI:OpenOtherWin()
    end, defaultSelectPoolId, defaltSelectGroupId)
  else
    AudioManager:PlayAudioById(1087)
    self.lotteryBtn:ShowUnlockDes()
  end
end

function UINHomeRight:RefreshLotteryBtn()
  if self.lotteryBtn == nil then
    self.lotteryBtn = UINHomeLotteryBtn.New()
    self.lotteryBtn:Init(self.ui.btn_Lottery.gameObject)
    self.lotteryBtn:InitHomeLotteryBtn()
    self.homeController:AddRedDotEvent(self.lotteryBtn:GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery)
  self.lotteryBtn:RefeshUnlockInfo(isUnlock, unlockDes)
  if isUnlock then
    self.lotteryBtn.costItemNumDic = {}
    self:InitLotteryCostItem()
    self:_SetLotteryTween()
  else
    self.lotteryBtn.ui.obj_costItem1:SetActive(false)
    self.lotteryBtn.ui.obj_costItem2:SetActive(false)
  end
end

function UINHomeRight:InitLotteryCostItem()
  self.lotteryBtn.ui.obj_costItem1:SetActive(false)
  self.lotteryBtn.ui.obj_costItem2:SetActive(false)
  local itemCfg1 = ConfigData.item[ConstGlobalItem.LotteryTicket1]
  if itemCfg1 == nil then
    error("Can't find itemCfg by Id:" .. tostring(ConstGlobalItem.LotteryTicket1))
    return
  end
  self.lotteryBtn.ui.obj_costItem1:SetActive(true)
  self.lotteryBtn.ui.cost1_img_Icon.sprite = CRH:GetSprite(itemCfg1.small_icon)
  self.lotteryBtn.ui.cost1_tex_Count.text = PlayerDataCenter:GetItemCount(ConstGlobalItem.LotteryTicket1)
  self.lotteryBtn.costItemNumDic[ConstGlobalItem.LotteryTicket1] = self.lotteryBtn.ui.cost1_tex_Count
  local itemCfg2 = ConfigData.item[ConstGlobalItem.LotteryTicket2]
  if itemCfg2 == nil then
    error("Can't find itemCfg by Id:" .. tostring(ConstGlobalItem.LotteryTicket2))
    return
  end
  self.lotteryBtn.ui.obj_costItem2:SetActive(true)
  self.lotteryBtn.ui.cost2_img_Icon.sprite = CRH:GetSprite(itemCfg2.small_icon)
  self.lotteryBtn.ui.cost2_tex_Count.text = PlayerDataCenter:GetItemCount(ConstGlobalItem.LotteryTicket2)
  self.lotteryBtn.costItemNumDic[ConstGlobalItem.LotteryTicket2] = self.lotteryBtn.ui.cost2_tex_Count
end

function UINHomeRight:RefreshLotteryCost(fromeAuto)
  if self.lotteryBtn.costItemNumDic ~= nil then
    for itemId, textComponent in pairs(self.lotteryBtn.costItemNumDic) do
      if fromeAuto then
        if PlayerDataCenter.allEffectorData:IsAutoGenerateResource(itemId) then
          local num = tostring(PlayerDataCenter:GetItemCount(itemId))
          if textComponent.text ~= num then
            textComponent.text = num
          end
        end
      else
        local num = tostring(PlayerDataCenter:GetItemCount(itemId))
        if textComponent.text ~= num then
          textComponent.text = num
        end
      end
    end
  end
end

function UINHomeRight:_SetLotteryTween()
  local seq, isFirst = self:_CreateTweenSequence(self.lotteryBtn, true)
  if not isFirst then
    return
  end
  local aniComponents = self.lotteryBtn.ui.aniComponents
  self:_SetComLocalMove(aniComponents[1], Vector3.New(100, 100, 0))
  seq:Append(aniComponents[1]:DOLocalMove(Vector3.New(100, 100, 0), 2):SetRelative(true))
  self:_SetComLocalMove(aniComponents[3], Vector3.New(100, 100, 0))
  seq:Join(aniComponents[3]:DOLocalMove(Vector3.New(100, 100, 0), 1):SetRelative(true))
  seq:Insert(1, aniComponents[2].transform:DOScale(Vector3.New(0.8, 0.8, 1), 2):From())
  self:_SetComImageAlpha(aniComponents[2], 0)
  seq:Join(aniComponents[2]:DOFade(1, 2))
  seq:Rewind()
end

function UINHomeRight:OnClickHeroListBtn()
  if self.heroListBtn.isUnlock then
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroList, function(win)
      if win == nil then
        return
      end
      TimerManager:StartTimer(1, self.homeUI.OpenOtherWin, self.homeUI, true, true, true)
    end, nil, eBaseWinFromWhere.home)
  else
    AudioManager:PlayAudioById(1087)
    self.heroListBtn:ShowUnlockDes()
  end
end

function UINHomeRight:RefreshHeroListBtn()
  if self.heroListBtn == nil then
    self.heroListBtn = UINHomeGeneralBtn.New()
    self.heroListBtn:Init(self.ui.btn_HeroList.gameObject)
    self.homeController:AddRedDotEvent(self.heroListBtn:GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
    self.homeController:AddBlueDotEvent(self.heroListBtn:GetBlueDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup)
  self.heroListBtn:RefeshUnlockInfo(isUnlock, unlockDes)
  self:RefreshCollectRate()
end

function UINHomeRight:RefreshCollectRate()
  local totalCount = ConfigData.hero_data.totalShowHeroCount
  local haveCount = PlayerDataCenter.heroCount - PlayerDataCenter.hideHeroCount
  local collectRate = 0
  collectRate = math.ceil(haveCount / totalCount * 100)
  local strCollRate = tostring(collectRate)
  self.heroListBtn.ui.tex_bigCollect.text = strCollRate
  self.heroListBtn.ui.tex_smallCollect.text = strCollRate
  self:_SetHeroListBtnTween(collectRate)
end

function UINHomeRight:OnClickHandBookBtn()
  if self.handBookBtn.isUnlock then
    local handBookCtrl = ControllerManager:GetController(ControllerTypeId.HandBook, true)
    handBookCtrl:OpenHandBookMain(eBaseWinFromWhere.home)
    self.homeUI:OpenOtherWin()
  else
    AudioManager:PlayAudioById(1087)
    self.handBookBtn:ShowUnlockDes()
  end
end

function UINHomeRight:RefreshHandBooktn()
  if CS.ClientConsts.IsAudit then
    self.ui.btn_HandBook.gameObject:SetActive(false)
    return
  end
  if self.handBookBtn == nil then
    self.handBookBtn = UINHomeGeneralBtn.New()
    self.handBookBtn:Init(self.ui.btn_HandBook.gameObject)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HandBook)
  self.handBookBtn:RefeshUnlockInfo(isUnlock, unlockDes)
end

function UINHomeRight:OnClickMileStoneBtn()
  if self.msBtn.isUnlock then
    local msData = PlayerDataCenter.inforData:GetMilestoneData()
    self.homeUI:OpenOtherWin()
    UIManager:ShowWindowAsync(UIWindowTypeID.MailStoneMian, function(win)
      if win == nil then
        return
      end
      win:SetFromWhichUI(eBaseWinFromWhere.home)
      win:InitMilestoneMain(msData)
    end)
  else
    AudioManager:PlayAudioById(1087)
    self.msBtn:ShowUnlockDes()
  end
end

function UINHomeRight:RefreshMileStoneBtn()
  if IsNull(self.ui.btn_MileStone) then
    return
  end
  if self.msBtn == nil then
    self.msBtn = UINHomeGeneralBtn.New()
    self.msBtn:Init(self.ui.btn_MileStone.gameObject)
    self.homeController:AddRedDotEvent(self.msBtn:GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Milestone)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MileStones)
  self.msBtn:RefeshUnlockInfo(isUnlock, unlockDes)
end

function UINHomeRight:OnClickFmtBtn()
  if self.fmtBtn.isUnlock then
    local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
    fmtCtrl:EnterFormationScene()
  else
    AudioManager:PlayAudioById(1087)
    self.fmtBtn:ShowUnlockDes()
  end
end

function UINHomeRight:RefreshFmtBtn()
  if IsNull(self.ui.btn_Formation) then
    return
  end
  if CS.ClientConsts.IsAudit then
    self.ui.btn_Formation.gameObject:SetActive(false)
    return
  end
  if self.fmtBtn == nil then
    self.fmtBtn = UINHomeGeneralBtn.New()
    self.fmtBtn:Init(self.ui.btn_Formation.gameObject)
  end
  local isUnlock, unlockDes = self.homeController:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_main_formation)
  self.fmtBtn:RefeshUnlockInfo(isUnlock, unlockDes)
end

function UINHomeRight:SetHomeHandBookBtn(active)
  self.ui.btn_HandBook.enabled = active
end

function UINHomeRight:_SetHeroListBtnTween(collectRate)
  local seq = self._seqUnFoldDic[self.heroListBtn]
  if self.collectRate ~= collectRate then
    self.heroListBtn.ui.img_Collect.fillAmount = 0
    self.heroListBtn.ui.img_Angle.localRotation = Quaternion.Euler(0, 0, 0)
    if seq ~= nil then
      seq:Kill()
      self._seqUnFoldDic[self.heroListBtn] = nil
    end
    seq = self:_CreateTweenSequence(self.heroListBtn, true)
    seq:Append(self.heroListBtn.ui.img_Collect:DOFillAmount(collectRate / 100, 1.25, CS_Tweening.RotateMode.FastBeyond360):SetEase(CS_Tweening.Ease.OutExpo))
    seq:Join(self.heroListBtn.ui.img_Angle:DOLocalRotate(Vector3.New(0, 0, -collectRate / 100 * 360), 1.25, CS_Tweening.RotateMode.FastBeyond360):SetEase(CS_Tweening.Ease.OutExpo))
    self.collectRate = collectRate
  end
  seq:Restart()
end

function UINHomeRight:_ClearOasisTlCo()
  if self.__tlOasisCo ~= nil then
    TimelineUtil.StopTlCo(self.__tlOasisCo)
    self.__tlOasisCo = nil
  end
end

function UINHomeRight:_SwitchUnfoldState()
  self.homeUI:SwitchUnfold()
end

local SCALE_CLOSE = Vector3.New(-1, 1, 1)

function UINHomeRight:SetUnfoldBtnState(isUnfold)
  if isUnfold then
    self.ui.btn_openRightSide.transform.localScale = SCALE_CLOSE
  else
    self.ui.btn_openRightSide.transform.localScale = Vector3.one
  end
end

function UINHomeRight:UpdateHomeRightUnfoldRate(rate)
  if self.heroListBtn ~= nil then
    self.heroListBtn.ui.bIGNode.alpha = rate
    self.heroListBtn.ui.sMALLNode.alpha = 1 - rate
  end
  if self.handBookBtn ~= nil then
    self.handBookBtn.ui.cg_btn_HandBook.alpha = rate
  end
  if self.fmtBtn ~= nil then
    self.fmtBtn.ui.cg_btn_Fmt.alpha = rate
  end
  local posX = (self.ui.rectLength - self.ui.pageListLength) * rate
  self:RefreshScrollbarHandle(posX)
end

function UINHomeRight:OnHomeRightIsUnfold(isUnfold)
  if self.isUnfold == isUnfold then
    return
  end
  if isUnfold then
    for k, seq in pairs(self._seqUnFoldDic) do
      seq:Restart()
    end
  else
    for k, seq in pairs(self._seqUnFoldDic) do
      seq:Pause()
      seq:Rewind()
    end
  end
  self.isUnfold = isUnfold
  self:SetUnfoldBtnState(isUnfold)
end

function UINHomeRight:_CreateTweenSequence(key, isUnfold)
  local tab = isUnfold == true and self._seqUnFoldDic or self._seqFoldDic
  local seq = tab[key]
  local isFirst = false
  if seq == nil then
    seq = CS_DoTween.Sequence()
    seq:SetAutoKill(false)
    tab[key] = seq
    isFirst = true
  end
  return seq, isFirst
end

function UINHomeRight:_SetComLocalMove(com, pos)
  local pos1 = com.localPosition
  com.localPosition = pos1 - pos
end

function UINHomeRight:_SetComImageAlpha(com, alpha)
  local col = com.color
  com.color = Color.New(col.r, col.g, col.b, alpha)
end

function UINHomeRight:OnHomeHide()
  if self.BatteryTimerId ~= nil then
    TimerManager:StopTimer(self.BatteryTimerId)
    self.BatteryTimerId = nil
  end
  if self.StaminaLimitTimer ~= nil then
    TimerManager:StopTimer(self.StaminaLimitTimer)
    self.StaminaLimitTimer = nil
  end
end

function UINHomeRight:RefreshScrollbarHandle(x)
  local ratio = (self.ui.pageListLength + x) / self.ui.rectLength
  self.ui.tran_Handle.sizeDelta = Vector2.New(self.ui.fullHandleLength * ratio, 8)
end

function UINHomeRight:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateWareHouseLimitTime, self.__OnLimitItemOut)
  MsgCenter:RemoveListener(eMsgEventId.UpdateStaminaLimitTime, self.__RefreshStaminaLimitTime)
  TimerManager:StopTimer(self.BatteryTimerId)
  TimerManager:StopTimer(self.StaminaLimitTimer)
  if self.lotteryBtn ~= nil then
    self.lotteryBtn:Delete()
    self.lotteryBtn = nil
  end
  self.sectorActivityEntry:Delete()
  for k, seq in pairs(self._seqFoldDic) do
    seq:Kill()
  end
  self._seqFoldDic = nil
  for k, seq in pairs(self._seqUnFoldDic) do
    seq:Kill()
  end
  self._seqUnFoldDic = nil
  base.OnDelete(self)
end

return UINHomeRight
