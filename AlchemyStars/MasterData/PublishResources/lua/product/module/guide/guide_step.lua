_class("UIGuideInfo", Object)

function UIGuideInfo:Constructor()
  self.x = nil
  self.y = nil
  self.w = nil
  self.h = nil
  self.owner = nil
  self.btn = nil
  self.scrollRect = nil
  self.cfg = nil
  self.guideStep = nil
end

local abs = math.abs

local function Approximately(f0, f1)
  return abs(f0 - f1) < 1.0E-6
end

_class("GuideStep", Object)

function GuideStep:Constructor(guide, data, last)
  self.guide = guide
  self.data = data
  local cfgGuideWarnId = self:GetGuideOneParam()
  self.btnGuideCfg = cfgGuideWarnId and Cfg.cfg_guide_warn[cfgGuideWarnId]
  if cfgGuideWarnId and not self.btnGuideCfg then
    Log.debug("[GuideDebug]GuideStep,can't find cfgGuideWarnId " .. cfgGuideWarnId)
  end
  self.last = last
  self.delay = nil
  self.btn = nil
  self.owner = nil
  self.done = false
  self.autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
  self:InitCheckStepDone()
  self:AddListener()
end

function GuideStep:InitCheckStepDone()
  self.checkStepDone = {}
  for _, value in pairs(GuideType) do
    self.checkStepDone[value] = false
  end
end

function GuideStep:ResetCheckStep()
  self:InitCheckStepDone()
end

function GuideStep:AddListener()
  self.autoBinder:BindEvent(GameEventType.FinishGuideStep, self, self.FinishGuideStep)
  self.autoBinder:BindEvent(GameEventType.ForceFinishGuideStep, self, self.ForceFinishGuideStep)
  self.autoBinder:BindEvent(GameEventType.GuideTaskState, self, self.GuideTaskState)
  self.autoBinder:BindEvent(GameEventType.UIClose, self, self.UIClose)
  self.autoBinder:BindEvent(GameEventType.UIOpen, self, self.UIOpen)
  self.autoBinder:BindEvent(GameEventType.HomelandInteractPointUIRefresh, self, self.OnHomelandInteractPointUIRefresh)
end

function GuideStep:RemoveListener(isDispose)
  if isDispose then
    self.autoBinder:UnBindAllEvents()
  end
end

function GuideStep:FinishGuideStep(guideType)
  if self.data.guideType == guideType and self.guide.currStep == self and self.show then
    self.checkStepDone[guideType] = true
  end
end

function GuideStep:ForceFinishGuideStep(guideType)
  if self.data.guideType == guideType and self.guide.currStep == self and self.show then
    self.checkStepDone[guideType] = true
    if self.checkStepDone[guideType] then
      self:Done()
    end
  end
end

function GuideStep:GuideTaskState(id, state)
  if self.guide.currStep == self and self.show and self.btnGuideCfg and self.btnGuideCfg.completeRule == GuideCompleteType.TaskState and self.btnGuideCfg.completeRuleParam[1] == id and self.btnGuideCfg.completeRuleParam[2] == state then
    self.checkStepDone[self.data.guideType] = true
  end
end

function GuideStep:IsDone()
  return self.done
end

function GuideStep:IsLockScreen()
  return true
end

function GuideStep:HasTargetGuide()
  return self.data.targetMissionId
end

function GuideStep:IsBack()
  return self.data.backStep
end

function GuideStep:GetSpecialBtn(controller, btn)
  if btn == GuideBtnType.UIMapNodeItem then
    return controller, controller:GetNodeByNodeId(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIWidgetBattlePet then
    return controller, controller:GetPetBattleBtnByPetTempId(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIWidgetPetSkill then
    return controller, controller:GetPetSkillBtn()
  elseif btn == GuideBtnType.UIBattleTeamStateEnter then
    return controller, controller:GetTeamStateBtn()
  elseif btn == GuideBtnType.UIWidgetBattlePetWeak then
    return controller, controller:GetPetBattleBtnByPetTempId(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIWidgetBattlePetPress then
    return controller, controller:GetPetBattleBtnByPetTempId(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIHeartItem then
    return controller, controller:GetHeartItem(self.btnGuideCfg.areaArgs[1]), nil, controller:GetGuideScroll()
  elseif btn == GuideBtnType.UIConsumableMaterialItem then
    return controller, controller:GetMaterialItem(self.btnGuideCfg.areaArgs[1]), nil, controller:GetGuideScroll()
  elseif btn == GuideBtnType.UITeamItem then
    return controller, controller:GetTeamItem(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIPetItem then
    return controller, controller:GetPetItem(self.btnGuideCfg.areaArgs[1]), nil, controller:GetScroll()
  elseif btn == GuideBtnType.UIQuestStoryListItem then
    return controller, controller:GetQuestStoryListItem(self.btnGuideCfg.areaArgs[1]), nil, controller:GetQuestStoryScroll()
  elseif btn == GuideBtnType.UIQuestStoryDetailItemGet then
    return controller, controller:GetQuestStoryDetailItemGet()
  elseif btn == GuideBtnType.UIQuestStoryDetailItemGoto then
    return controller, controller:GetQuestStoryDetailItemGoto()
  elseif btn == GuideBtnType.UIQuestTypeBtnItem then
    return controller, controller:GetQuestTypeBtn(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIQuestGrowthLook then
    return controller, controller:GetQuestGrowthTypeLook()
  elseif btn == GuideBtnType.UIDrawCardAwardItem then
    return controller, controller:GetOneBtn(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIResEntry then
    return controller, controller:GetEntryCell(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIDrawCardBack then
    return controller, controller:GetTopButtonBack()
  elseif btn == GuideBtnType.UITurnInfo then
    return controller, controller:GetTurnInfoBg()
  elseif btn == GuideBtnType.UIShopMainTab then
    return controller, controller:GetMainTab(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIShopSecretGood then
    return controller, controller:GetSecretGood(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIBattleCollect then
    return controller, controller:GetUIBattleCollect()
  elseif btn == GuideBtnType.UIBattleRound then
    return controller, controller:GetUIBattleLimitRound()
  elseif btn == GuideBtnType.UITrapSkillIcon then
    return controller, controller:GetUITrapSkillIcon(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UITrapSkillBtn then
    return controller, controller:GetUITrapSkillBtn()
  elseif btn == GuideBtnType.UIResDetailGOBtn then
    return controller, controller:GetItem(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIExtRoot then
    return controller, controller:GetItem(self.btnGuideCfg.areaArgs[1]), nil, controller:GetScroll()
  elseif btn == GuideBtnType.UIAircraft3DUI then
    return controller, self:GetAircraftMain():GetBtnGuide(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIAircraftFireIcon then
    return controller, controller:GetFireIcon()
  elseif btn == GuideBtnType.UIAircraftLightIcon then
    return controller, controller:GetStarIcon()
  elseif btn == GuideBtnType.UIAircraftRoomLB then
    return controller, controller:GetRoomLeftBottom()
  elseif btn == GuideBtnType.UIAircraftRoomBtnFacility then
    return controller, controller:GetRoomInfoBtnFacility()
  elseif btn == GuideBtnType.UIAircraftRoomBtnSettle then
    return controller, controller:GetRoomInfoBtnSettle()
  elseif btn == GuideBtnType.UIAircraftRoomAddCell then
    return controller, controller:GetRoomInfoAddCell(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIAircraftEnterBuildIcon then
    return controller, controller:GetPetPrefabCell(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIQuestGrowthAward then
    return controller, controller:GetQuestGrowthAward(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIResEntryBtn then
    return controller, controller:GetResEntryBtn()
  elseif btn == GuideBtnType.UIMazsEntryBtn then
    return controller, controller:GetMazeEntryBtn()
  elseif btn == GuideBtnType.UIExtEntryBtn then
    return controller, controller:GetExtEntryBtn()
  elseif btn == GuideBtnType.UIMazeHp then
  elseif btn == GuideBtnType.UIMazeLight then
    return controller, controller:GetLightItemBg()
  elseif btn == GuideBtnType.UIAircraftLevelUp then
    return controller, controller:GetRoomInfoBtnLevelUp()
  elseif btn == GuideBtnType.UIResDouble then
    return controller, controller:GetResItem()
  elseif btn == GuideBtnType.UIBattleChangeLeader then
    return controller, controller:GetChangeLeaderBtn()
  elseif btn == GuideBtnType.UIChangeLeader then
    return controller, controller:GetBtn(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UITowerHome then
    return controller, controller:GetBtn(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIShengWuPackItem then
    return controller, controller:GetBtn()
  elseif btn == GuideBtnType.UIGoChainPreview then
    return controller, controller:GetChainPreviewGOBtn()
  elseif btn == GuideBtnType.UITowerEntry then
    return controller, controller:GetTowerBtn()
  elseif btn == GuideBtnType.UIQuestSideGotoBtn then
    return controller, controller:GetQuestSideTypeGotoBtn(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UITeamChangeItemHP then
    return controller, controller:GetPetItemHP(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIBattleItemHP then
    return controller, controller:GetPetBattleBtnHp(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIBattleSpeed then
    return controller, controller:GetSpeedBtn()
  elseif btn == GuideBtnType.UIAirBackBtn then
    return controller, controller:GetBackBtn()
  elseif btn == GuideBtnType.UIWeChatRole then
    return controller, controller:GetWeChatRoleBtn(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UITeamHelpPetIcon then
    return controller, controller:GetTeamItemHelpPetIcon(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UITeamItemHelpPet then
    return controller, controller:GetHelpPetItem(), nil, controller:GetScroll()
  elseif btn == GuideBtnType.UIDispatchMapTaskBG then
    return controller, controller:GetTaskBtn(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIDispatchDetailItem then
    return controller, controller:GetCurrentItemGameObject(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIDispatchDetailItemExtraReward then
    return controller, controller:GetCurrentItemExtraRewardItem()
  elseif btn == GuideBtnType.UIAircraftDecorateListItem then
    return controller, controller:GetTabItem(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIAircraftDecorateFurnitureItem then
    return controller, controller:GetFurnitureItemByID(self.btnGuideCfg.areaArgs[1]), nil, controller:GetScrollRect()
  elseif btn == GuideBtnType.UIAircraftRoomDecorateBtn then
    return controller, controller:GetRoomInfoDecorateBtn()
  elseif btn == GuideBtnType.UIDiscoveryGuideToNode then
    return controller, controller:GuideToMission(self.btnGuideCfg.areaArgs[1])
  elseif btn == GuideBtnType.UIDispatchRoomInfo then
    return controller, controller:GetRoomInfoGameobject()
  elseif btn == GuideBtnType.UIAirHomeBtn then
    return controller, controller:GetHomeBtn()
  elseif btn == GuideBtnType.UIMiniGameGuest then
    return controller, controller:GuideGameGuest()
  elseif btn == GuideBtnType.UIMiniGameOrderformItem then
    return controller, controller:GuideOrderformItem()
  elseif btn == GuideBtnType.UITacticDiffBtn then
    return controller, controller:GetGuideBtn()
  elseif btn == GuideBtnType.UIHomeLandShopOrderTag then
    return controller, controller:GetOrderTagBtn()
  elseif btn == GuideBtnType.UIHomeLandShopOrderSubmitBtn then
    return controller, controller:GetOrderSubmitBtn()
  elseif btn == GuideBtnType.UIHomeLandShopShopTag then
    return controller, controller:GetShopTagBtn()
  elseif btn == GuideBtnType.UIHomeLandShopShopBuyBtn then
    return controller, controller:GetShopBuyBtn()
  elseif btn == GuideBtnType.UIHomeLandDomitoryMember then
    return controller, controller:GetFirstMember()
  elseif btn == GuideBtnType.UIHomeDomitorySettle then
    return controller, controller:GetFirstPet()
  elseif btn == GuideBtnType.UIInteractPointController then
    return controller, controller:GetInteractBtn(self.btnGuideCfg.areaArgs)
  elseif btn == GuideBtnType.UIForgeItem then
    return controller, controller:GeForgeItem()
  elseif btn == GuideBtnType.UIForgeSequenceItem then
    return controller, controller:GeForgeFirstSquenceItemBg()
  elseif btn == GuideBtnType.UIForgeSequenceItemGet then
    return controller, controller:GeForgeFirstSquenceBtnGet()
  elseif btn == GuideBtnType.UIForgeSequenceItemSpeedBtn then
    return controller, controller:GeForgeFirstSquenceItemSpeedBtn()
  elseif btn == GuideBtnType.UIHomelandBuild then
    return controller, controller:GetGuideItem()
  elseif btn == GuideBtnType.DiffStage1 then
    return controller, controller:GetFirstStage()
  elseif btn == GuideBtnType.DiffStage2 then
    return controller, controller:GetSecondStage()
  elseif btn == GuideBtnType.UIForgeSpecialTag then
    return controller, controller:GetSpecialTagItem()
  elseif btn == GuideBtnType.UIForgeSpecialLandTag then
    return controller, controller:GetLandTagItem()
  elseif btn == GuideBtnType.UIEditSpecialTag then
    return controller, controller:GetSpecialTag()
  elseif btn == GuideBtnType.UIEditSpecialLand then
    return controller, controller:GetSpecialLand()
  elseif btn == GuideBtnType.UIN20MiniGameGuest then
    return controller, controller:GuideGameGuest()
  elseif btn == GuideBtnType.UIN20MiniGameOrderformItem then
    return controller, controller:GuideOrderformItem()
  elseif btn == GuideBtnType.UISailingChapter then
    return controller, controller:GetGuideArea()
  elseif btn == GuideBtnType.UIFeatureScanControllerStep1 then
    return controller, controller:GuideStepGetElement1()
  elseif btn == GuideBtnType.UIFeatureScanControllerStep2 then
    return controller, controller:GuideStepGetElement2()
  elseif btn == GuideBtnType.UIN25VampireTalentTreeFirstItem then
    return controller, controller:GuideSecondItemTalent()
  elseif btn == GuideBtnType.UIN25VampireTalentTreeFirstItemTalent then
    return controller, controller:GuideFirstItemTalent()
  elseif btn == GuideBtnType.UIBattleMultiSkillIndex1 then
    return controller, controller:GetPetMultiSkillIndexBtn(1)
  elseif btn == GuideBtnType.UIBattleMultiSkillIndex2 then
    return controller, controller:GetPetMultiSkillIndexBtn(2)
  elseif btn == GuideBtnType.UIN27PostInnerGameControllerFirstOrder then
    return controller, controller:GetFirstOrderWidghtForGuide()
  elseif btn == GuideBtnType.UIN27PostInnerGameControllerFirstItem then
    return controller, controller:GetFirstItemForGuide()
  elseif btn == GuideBtnType.UIActivityN29DetectiveMapController then
    return controller, controller:GetFirstItemForGuide()
  elseif btn == GuideBtnType.UIN29DetectivePersonController then
    return controller, controller:GetFirstGuidePerson()
  elseif btn == GuideBtnType.UIN29DetectiveReasoningOption1 then
    return controller, controller:GetOptionGo(3)
  elseif btn == GuideBtnType.UIN29DetectiveReasoningOption2 then
    return controller, controller:GetOptionGo(1)
  elseif btn == GuideBtnType.UIN29DetectiveReasoningOption4 then
    return controller, controller:GetOptionGo(4)
  elseif btn == GuideBtnType.UIBattleMultiSkillIndex3 then
    return controller, controller:GetPetMultiSkillIndexBtn(3)
  elseif btn == GuideBtnType.UIN32MultiLineMainFirstFolder then
    return controller, controller:GetFirstFolderBtn()
  elseif btn == GuideBtnType.UIN32MultiLineMapControllerFirstDialog then
    return controller, controller:GetFirstDialogBtn()
  elseif btn == GuideBtnType.UIActivityN33DateMainControllerBtn1 then
    return controller, controller:GetFirstDialogBtn()
  elseif btn == GuideBtnType.UIActivityN33DateMainControllerBtn2 then
    return controller, controller:GetSecondDialogBtn()
  elseif btn == GuideBtnType.UIActivityN33DateMainControllerBtn3 then
    return controller, controller:GetThirdDialogBtn()
  elseif btn == GuideBtnType.UIActivityN33DateMainControllerBtn4 then
    return controller, controller:GetFourthDialogBtn()
  elseif btn == GuideBtnType.UIActivityN33DateMainControllerBtn5 then
    return controller, controller:GetFifthDialogBtn()
  elseif btn == GuideBtnType.UIActivityN33DateMainControllerBtn6 then
    return controller, controller:GetSixthDialogBtn()
  elseif btn == GuideBtnType.UIActivityN33DateMainControllerBtn7 then
    return controller, controller:GetSeventhDialogBtn()
  elseif btn == GuideBtnType.UISeasonS1CollectionTab then
    return controller, controller:GetGuideItem()
  elseif btn == GuideBtnType.UIEliminateController1 then
    return controller, controller:GetGuideEliminate()
  elseif btn == GuideBtnType.UIEliminateController2 then
    return controller, controller:GetGuideIntro()
  elseif btn == GuideBtnType.UICN7N36PostSelectItem then
    return controller, controller:GetGuideItem()
  elseif btn == GuideBtnType.UICN7N36PostSelectItemBtn then
    return controller, controller:GetGuideItemBtn()
  elseif btn == GuideBtnType.UITalent_Get_1P_2N_Icon then
    return controller, controller:Get_1P_2N_Icon()
  elseif btn == GuideBtnTypeShare.UISeasonMazeScene_M_Card then
    return controller, controller:GetMiddleCard()
  elseif btn == GuideBtnTypeShare.UISeasonMazeBead_First_Bead then
    return controller, controller:GetGuideItem()
  end
end

function GuideStep:GetBtn()
  local UI = GameGlobal.UIStateManager()
  local controller = UI:GetController(self.btnGuideCfg.guideController)
  local widgets = self.btnGuideCfg.guideUI
  local btn = self.btnGuideCfg.guideArea
  local go, parent, scrollRect, owner
  local special = tonumber(btn)
  if special then
    owner, go, parent, scrollRect = self:GetSpecialBtn(controller, special)
  elseif not widgets or #widgets <= 0 then
    go = controller:GetGameObject(btn)
    parent = controller:View():GetGameObject().transform:Find("UICanvas").transform
  else
    local deep = #widgets
    if self.btnGuideCfg.guideController == "UISideEnterCenterController" and widgets[1] == "UISideEnterCenterTabPage" then
      go, owner = controller:GetCurContentWigetObject()
    else
      go, owner = controller:GetGameObjectInCustomWidget(widgets[1], btn)
    end
    if 1 < deep then
      for i = 2, deep do
        owner = owner:GetCustomWidget(widgets[i])
      end
      if owner then
        go = owner:GetGameObject(btn)
      end
    end
    if owner then
      parent = owner:View():GetGameObject().transform.parent
    end
  end
  if go then
    self.btn = go
    self.owner = owner or controller
    self.parent = parent
    self.isController = not self.btnGuideCfg.guideUI
    self.scrollRect = scrollRect
  end
end

function GuideStep:IsBtnVisible()
  local controller = self.btnGuideCfg.guideController
  local UI = GameGlobal.UIStateManager()
  if not UI:IsShow(controller) then
    return false
  end
  if self:IsLockScreen() and not UI:IsTopUI(controller) then
    return false
  end
  if UI:IsShow("UIHomeShowAwards") then
    return false
  end
  if not self.btn or tolua.isnull(self.btn) then
    local btn = self:GetBtn()
    if not btn then
      return false
    end
    self.btn = btn
  end
  if not self.btn or not self.btn.activeInHierarchy then
    return false
  end
  return true
end

function GuideStep:CanShow()
  local canShow = false
  if self.data.guideType == GuideType.Button then
    if self:IsBtnVisible() then
      if self.data.delay then
        if not self.delay then
          self.delay = GameGlobal:GetInstance():GetCurrentRealTime()
        elseif GameGlobal:GetInstance():GetCurrentRealTime() - self.delay >= self.data.delay * 1000 then
          canShow = true
        end
      else
        canShow = true
      end
    elseif self.delay then
      self.delay = nil
    end
  elseif self.data.guideType == GuideType.StoryBanner or self.data.guideType == GuideType.Circle then
    if self.data.delay then
      if not self.delay then
        self.delay = GameGlobal:GetInstance():GetCurrentRealTime()
      elseif GameGlobal:GetInstance():GetCurrentRealTime() - self.delay >= self.data.delay * 1000 then
        canShow = true
      end
    else
      canShow = true
    end
  else
    canShow = true
  end
  local triggerShow = true
  local triggerIds = self.data.triggerId
  if triggerIds then
    local show = false
    for index, triggerId in ipairs(triggerIds) do
      local activeTriggerId = self.guide.manager.activatedGuideTrigger[triggerId]
      show = activeTriggerId and activeTriggerId == 1
      if show == true then
        break
      end
    end
    triggerShow = show
  end
  local targetGuideDone = true
  local targetMissionId = self.data.targetMissionId
  if targetMissionId then
    targetGuideDone = not self.guide.manager:IsGuideMissionDone(targetMissionId)
  end
  return canShow and triggerShow and targetGuideDone
end

function GuideStep:CreateUI(guideInfo)
  self.ui = GameGlobal.GuideMessageBoxMng():OpenGuideBox("UIGuideMessageBox", guideInfo)
end

function GuideStep:GetCamera()
  local camera
  if self.btnGuideCfg and tonumber(self.btnGuideCfg.guideArea) == GuideBtnType.UIAircraft3DUI then
    camera = self:GetAircraftMain():GetMainCamera()
  else
    camera = GameGlobal.UIStateManager():GetControllerCamera(self.btnGuideCfg.guideController)
  end
  return camera
end

function GuideStep:GetAircraftMain()
  if not self.main then
    self.main = GameGlobal.GetModule(AircraftModule):GetClientMain()
  end
  return self.main
end

function GuideStep:GetUIGuideInfo(specialCfgWarnId)
  local UI = GameGlobal.UIStateManager()
  local sx, sy, w, h, position, scale
  local pos = self.btn.transform.position
  local camera = self:GetCamera()
  local screenPos = camera:WorldToScreenPoint(pos)
  local sw = ResolutionManager.ScreenWidth()
  local rw = ResolutionManager.RealWidth()
  local factor = rw / sw
  sx, sy = screenPos.x * factor, screenPos.y * factor
  local rectTransform = self.btn:GetComponent("RectTransform")
  local forceSize = self.btnGuideCfg.ForceSize
  local sizeX, sizeY = rectTransform.rect.width, rectTransform.rect.height
  if forceSize then
    w, h = forceSize[1], forceSize[2]
  else
    w, h = sizeX, sizeY
  end
  local pivot = rectTransform.pivot
  if pivot.x == 0 then
    sx = sx + sizeX * 0.5
  elseif pivot.x == 1 then
    sx = sx - sizeX * 0.5
  end
  if pivot.y == 0 then
    sy = sy + sizeY * 0.5
  elseif pivot.y == 1 then
    sy = sy - sizeY * 0.5
  end
  scale = self.btn.transform.localScale
  local changed = false
  if not self.uiGuideInfo then
    self.uiGuideInfo = UIGuideInfo:New()
    changed = true
  elseif self.uiGuideInfo.sx ~= sx or self.uiGuideInfo.sy ~= sy or self.uiGuideInfo.w ~= w or self.uiGuideInfo.h ~= h or self.uiGuideInfo.pos ~= position then
    changed = true
  end
  self.uiGuideInfo.sx = sx
  self.uiGuideInfo.sy = sy
  self.uiGuideInfo.scale = scale
  self.uiGuideInfo.w = w
  self.uiGuideInfo.h = h
  self.uiGuideInfo.pos = position
  self.uiGuideInfo.owner = self.owner
  self.uiGuideInfo.btn = self.btn
  self.uiGuideInfo.scrollRect = self.scrollRect
  local cfgGuideWarnId
  if specialCfgWarnId then
    cfgGuideWarnId = specialCfgWarnId
  else
    cfgGuideWarnId = self:GetGuideOneParam()
  end
  self.uiGuideInfo.cfg = self.data
  self.uiGuideInfo.btnGuideCfg = Cfg.cfg_guide_warn[cfgGuideWarnId]
  self.uiGuideInfo.guideStep = self
  self.uiGuideInfo.isAircraft3DUI = self.btnGuideCfg and tonumber(self.btnGuideCfg.guideArea) == GuideBtnType.UIAircraft3DUI
  return self.uiGuideInfo, changed
end

function GuideStep:GetGuideOneParam()
  return self.data and self.data.guideParam and self.data.guideParam[1]
end

function GuideStep:GetGuideParams()
  return self.data and self.data.guideParam
end

function GuideStep:GetGuidData()
  return self.data
end

function GuideStep:Show()
  self.show = true
  if self.data.guideType == GuideType.Button then
    local guideInfo, changed = self:GetUIGuideInfo()
    if not self.ui then
      GuideHelper.GuideLoadLock(true, "Button")
      self:CreateUI(guideInfo)
      self:ExcuteBtnLogic()
      self:ShowGuideStep()
    elseif changed then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuidePosChanged, self)
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.Line then
    if not self.guideParam then
      self.guideParam = Cfg.cfg_inner_guide[self:GetGuideOneParam()]
      local param2
      local allParams = self:GetGuideParams()
      if allParams and 1 < #allParams then
        param2 = allParams[2]
      end
      self:ShowGuideStep()
      if param2 then
        self.btnGuideCfg = param2 and Cfg.cfg_guide_warn[param2]
        if self.btnGuideCfg then
          self:GetBtn()
          if self.btn then
            local guideInfo, changed = self:GetUIGuideInfo(param2)
            self:CreateUI(guideInfo)
          end
        end
      end
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.PreviewLinkLine then
    if not self.guideParam then
      self.guideParam = Cfg.cfg_inner_guide[self:GetGuideOneParam()]
      self:ShowGuideStep()
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.StoryBanner then
    if not self.guideParam then
      local isShow = GameGlobal.UIStateManager():IsShow("UIStoryBanner")
      if not isShow then
        GuideHelper.GuideLoadLock(true, "UIStoryBanner")
      end
      self.guideParam = self:GetGuideParams()
      local bannerID = self.guideParam[1]
      local bannerType = self.guideParam[2]
      GameGlobal.UIStateManager():ShowDialog("UIStoryBanner", bannerID, bannerType, nil, self.data.lockScreen)
      self:ShowGuideStep()
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.Warn then
    if not self.guideParam then
      self.guideParam = self:GetGuideOneParam()
      self:ShowGuideStep()
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.Pop then
    if not self.guideParam then
      GuideHelper.GuideLoadLock(true, "Pop")
      self.guideParam = self:GetGuideOneParam()
      local l_param = {
        guideParam = self.guideParam,
        data = self.data
      }
      GameGlobal.UIStateManager():ShowDialog("UIGuidePopController", l_param)
      self:ShowGuideStep()
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.Piece then
    if not self.guideParam then
      GuideHelper.GuideLoadLock(true, "Piece")
      self.guideParam = Cfg.cfg_inner_guide[self:GetGuideOneParam()]
      self:ShowGuideStep()
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.OpenUI then
    if not self.guideParam then
      self.guideParam = self:GetGuideParams()
      self.guideParam.uiName = GuideHelper.Goto(self.guideParam)
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.InnerAttrIcon then
    if not self.guideParam then
      self.guideParam = 1
      GameGlobal.UIStateManager():ShowDialog("UIGuideAttrController")
      self:ShowGuideStep()
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.BattleComplete then
    self:Done()
  elseif self.data.guideType == GuideType.Circle then
    if not self.guideParam then
      GuideHelper.GuideLoadLock(true, "Circle")
      self.guideParam = Cfg.cfg_guide_circle[self:GetGuideOneParam()]
      if self.guide:IsCoreGameGuide() then
        self:ShowGuideStep()
      else
        GameGlobal.UIStateManager():ShowDialog("UIGuideCircleController", self.guideParam)
      end
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.UnLock then
    if not self.guideParam then
      self.guideParam = self:GetGuideParams()
      local functionId = self.guideParam[1]
      local type = self.guideParam[2]
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideUnLock, functionId, type)
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.Story then
    if not self.guideParam then
      self.guideParam = self:GetGuideOneParam()
      GameGlobal.UIStateManager():ShowDialog("UIStoryController", self.guideParam, function()
        if self.checkStepDone then
          self.checkStepDone[GuideType.Story] = true
        end
      end)
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.Buff then
    if not self.guideParam then
      self.guideParam = self:GetGuideOneParam()
      self:ShowGuideStep()
    end
    self:Done()
  elseif self.data.guideType == GuideType.Entity then
    if not self.guideParam then
      self.guideParam = self:GetGuideParams()
      self:ShowGuideStep()
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.AirCameraFocusPet then
    if not self.guideParam then
      self.guideParam = self:GetGuideOneParam()
      local main = GameGlobal.GetModule(AircraftModule):GetClientMain()
      if main then
        local pet = main:GetPetByTmpID(self.guideParam)
        if pet ~= nil then
          main:FocusPet(pet, nil, function()
            self.checkStepDone[self.data.guideType] = true
          end)
        end
      end
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.GameCommand then
    self.guideParam = self:GetGuideParams()
    self:ExcuteGameCommand(self.guideParam)
    self:Done()
  elseif self.data.guideType == GuideType.OperationFinish then
    if not self.guideParam then
      self.guideParam = self:GetGuideParams()
      self:ShowGuideStep()
    end
    if self:CheckDone() then
      self:Done()
    end
  elseif self.data.guideType == GuideType.PuzzleCountdown then
    if not self.guideParam then
      self.guideParam = self:GetGuideParams()
      self:ShowGuideStep()
    end
    self:Done()
  end
end

function GuideStep:CheckDone()
  if self.data.guideType == GuideType.Button then
    if self.btnGuideCfg.completeRule == GuideCompleteType.HideCancelLineBtn or self.btnGuideCfg.completeRule == GuideCompleteType.ReleaseActiveSkill or self.btnGuideCfg.completeRule == GuideCompleteType.PressOrAction or self.btnGuideCfg.completeRule == GuideCompleteType.OperationComplete or self.btnGuideCfg.completeRule == GuideCompleteType.TaskState then
      return self.checkStepDone[self.data.guideType]
    end
  else
    return self.checkStepDone[self.data.guideType]
  end
end

function GuideStep:Hide()
  if self.show then
    GameGlobal.UAReportForceGuideEvent("GuideStepEnd", {
      self.data.guide,
      self.data.step
    })
  end
  self.show = false
  self.guideParam = nil
  if self.ui then
    GameGlobal.GuideMessageBoxMng():ClosePopup(self.ui)
    self.ui = nil
  end
end

function GuideStep:UIClose(name)
  if self.btnGuideCfg and self.btnGuideCfg.guideController and self.btnGuideCfg.guideController == name then
    if self.show and self.data.guideType == GuideType.Button and self.btnGuideCfg.completeRule == GuideCompleteType.CompleteImmediately and self.done == false then
      self.checkStepDone[GuideType.Button] = true
      self:Done()
    end
    self:Hide()
    if self.btn then
      self.btn = nil
    end
  end
end

function GuideStep:UIOpen(name)
  if self.show and self.data.guideType == GuideType.OpenUI and self.guideParam then
    local controllerType = self.guideParam[1]
    if controllerType == GuideGotoType.UIDiscovery then
      local missionId = self.guideParam[2]
      if missionId then
        TaskManager:GetInstance():StartTask(function(TT)
          local lockName = "GuideGotoUIDiscovery"
          GameGlobal.UIStateManager():Lock(lockName)
          YIELD(TT, 1000)
          GameGlobal.UIStateManager():UnLock(lockName)
          self.checkStepDone[GuideType.OpenUI] = true
        end)
      else
        self.checkStepDone[GuideType.OpenUI] = true
      end
    elseif self.guideParam.uiName == name then
      self.checkStepDone[GuideType.OpenUI] = true
    end
  end
  if self.show and self.data.guideType == GuideType.Button and self.btnGuideCfg.completeRule == GuideCompleteType.CompleteImmediately then
    self.checkStepDone[GuideType.Button] = true
    self:Done()
  end
end

function GuideStep:OnHomelandInteractPointUIRefresh()
  if self.btnGuideCfg and tonumber(self.btnGuideCfg.guideArea) == GuideBtnType.UIInteractPointController then
    self.btn = nil
  end
end

function GuideStep:IsClickDone()
  return self.btnGuideCfg.completeRule == nil or self.btnGuideCfg.completeRule == GuideCompleteType.Click or self.btnGuideCfg.completeRule == GuideCompleteType.AnyClickOnlyTrigger
end

function GuideStep:DoSpecialDoneLogic()
  if self.btnGuideCfg and tonumber(self.btnGuideCfg.guideArea) == GuideBtnType.UIAircraft3DUI then
    self:GetAircraftMain():GotoSpace(self.btnGuideCfg.areaArgs[1], false)
  elseif self.data.guideType == GuideType.Circle then
    if self.guideParam and self.guideParam.type == GuideCircleType.Finger then
      self:GetAircraftMain():GuideGotoSpace(self.guideParam.param[1])
    elseif self.guideParam and self.guideParam.type == GuideCircleType.AirPet then
      local main = self:GetAircraftMain()
      local pet = main:GetPetByTmpID(self.guideParam.param[1])
      main:OnClickPet(pet)
    elseif self.guideParam.type == GuideCircleType.AirSmelt then
      GameGlobal.UIStateManager():ShowDialog("UIAircraftItemSmeltController")
    elseif self.guideParam.type == GuideCircleType.AirSandBox then
      GameGlobal.UIStateManager():ShowDialog("UIDispatchMapController")
    elseif self.guideParam.type == GuideCircleType.AirTactic then
      GameGlobal.UIStateManager():ShowDialog("UIAircraftTactic")
    end
  end
end

function GuideStep:Done()
  if self.done then
    return
  end
  self:DoSpecialDoneLogic()
  if self.guide:IsCoreGameGuide() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideYield, self)
  end
  if self:Yield() == 1 and not self.last then
    GuideHelper.GuideLoadLock(true, "GuideStep Done.")
  end
  if self:HasTargetGuide() then
    self.done = true
    self.guideParam = nil
    self:ResetCheckStep()
    self:Hide()
  else
    self.done = true
    Log.notice("[guidestep] done step:guideId", self.data.guide, ",", self.data.step)
    local workModule = GameGlobal.GetModule(RoleModule)
    workModule:PushClientLog("[guide]", "done step:guideId:" .. self.data.guide .. ",step:" .. self.data.step)
    self.guideParam = nil
    self:ResetCheckStep()
    self:Hide()
    if self.last or self.data.coreStep then
      Log.notice("[guidestep] done guide:guideId", self.data.guide)
      workModule:PushClientLog("[guide]", "done guide:guideId:" .. self.data.guide)
      if self.data.coreStep then
        local guideModule = GameGlobal.GetModule(GuideModule)
        guideModule:SetLastCompleteGuide(self.data.guide)
      end
      self.guide:Complete(not self.last)
    end
  end
  self:YIELDGuideDoneLock()
  if self.data.continueGuide then
    TaskManager:GetInstance():StartTask(function(TT)
      YIELD(TT)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideDone, self.data.continueGuide)
    end)
  end
end

function GuideStep:ShowGuideStep()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowGuideStep, self)
  local isShow = GameGlobal.UIStateManager():IsShow("UIBattleCheat")
  if isShow then
    GameGlobal.UIStateManager():CloseDialog("UIBattleCheat")
  end
  local isShow = GameGlobal.UIStateManager():IsShow("UIBattleInfo")
  if isShow then
    GameGlobal.UIStateManager():CloseDialog("UIBattleInfo")
  end
  local isShow = GameGlobal.UIStateManager():IsShow("UIBattleQuit")
  if isShow then
    GameGlobal.UIStateManager():CloseDialog("UIBattleQuit")
  end
end

function GuideStep:YIELDGuideDoneLock()
  TaskManager:GetInstance():StartTask(function(TT)
    GameGlobal.UIStateManager():Lock("GuideDoneLock")
    local yieldTime = self.data.yieldTime or 0.2
    YIELD(TT, yieldTime * 1000)
    GameGlobal.UIStateManager():UnLock("GuideDoneLock")
  end)
end

function GuideStep:ExcuteBtnLogic()
  if self.btnGuideCfg and tonumber(self.btnGuideCfg.guideArea) == GuideBtnType.UIWidgetBattlePet then
    local petConfigID = self.btnGuideCfg.areaArgs[1]
    local guideStepParam = {
      petTempID = petConfigID,
      guideStepID = self.data.id
    }
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideActiveSkill, guideStepParam)
  elseif self.data and self.data.guide == GuideConst.guide_team_clear_guideid[1] and self.data.step == GuideConst.guide_team_clear_guideid[2] then
    local missionModule = GameGlobal.GetModule(MissionModule)
    local ctx = missionModule:TeamCtx()
    local _team = ctx.teams:Get(1):Clone()
    for _slot, value in ipairs(_team.pets) do
      if _slot ~= 1 then
        _team.pets[_slot] = 0
      end
    end
    TaskManager:GetInstance():StartTask(function()
      missionModule:UpdateMainFormationInfo(self, _team.id, _team.name, _team.pets)
    end)
  end
end

function GuideStep:ExcuteGameCommand(params)
  local commandType = params[1]
  if commandType == GuideGameCommandType.SkillReady then
    local petConfigID = params[2]
    if petConfigID then
      local guideStepParam = {
        petTempID = petConfigID,
        guideStepID = self.data.id
      }
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideActiveSkill, guideStepParam)
    else
      Log.fatal("[Guide] GuideStep:ExcuteGameCommand GuideGameCommandType.SkillReady petConfigID is nil!")
    end
  end
end

function GuideStep:Clear(isDispose)
  self.done = false
  self.show = false
  self.guideParam = nil
  self:ResetCheckStep()
  self:RemoveListener(isDispose)
  if self.delay then
    self.delay = nil
  end
end

function GuideStep:NeedYield()
  if self.data.guideType == GuideType.StoryBanner or self.data.guideType == GuideType.Pop or self.data.guideType == GuideType.InnerAttrIcon or self.data.guideType == GuideType.Circle then
    return true
  elseif self.data.guideType == GuideType.Piece then
    if self.guideParam.InvokeType == GuideInvokeType.GuidePieceInfinityDontYield then
      return false
    else
      return true
    end
  elseif self.data.guideType == GuideType.Button then
    return self.data.yield
  end
  return false
end

function GuideStep:Yield()
  return self.data.yield
end

function GuideStep:GetBtnGuideCfg()
  return self.btnGuideCfg
end
