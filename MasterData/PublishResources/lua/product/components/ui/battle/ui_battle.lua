_class("UIBattle", UIController)
UIBattle = UIBattle

function UIBattle:OnShow(uiParams)
  UnityEngine.Input.multiTouchEnabled = false
  self._dbgAutoFightInfo = {}
  if self._uiLeaveMatchHandler then
    self._uiLeaveMatchHandler:Dispose()
    self._uiLeaveMatchHandler = nil
  end
  self._uiLeaveMatchHandler = UILeaveMatchHandler:New(self)
  if self._uiBattleFinishHandler then
    self._uiBattleFinishHandler:Dispose()
    self._uiBattleFinishHandler = nil
  end
  self._uiBattleFinishHandler = UIBattleFinishHandler:New(self)
  local collector = GameGlobal:GetInstance():GetCollector("CoreGameLoading")
  collector:Sample("UIBattle:OnShow() begin")
  self._safeAreaCanvasGroup = self:GetUIComponent("CanvasGroup", "SafeArea")
  self._graphicRaycaster = self:GetUIComponent("GraphicRaycaster", "UICanvas")
  self._graphicRaycaster.enabled = true
  self._showDebugInfo = true
  self._uiAtlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
  self._petAreaGen = self:GetUIComponent("UISelectObjectPath", "PetInfo")
  self._petAreaWidget = self._petAreaGen:SpawnObject("UIWidgetPetArea")
  self._petAreaWidget:SetData(self)
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  local localPlayerInfo = matchEnterData:GetLocalPlayerInfo()
  self.enemyPetInfoGo = self:GetGameObject("EnemyPetInfo")
  if not self:IsBlackFist() then
    self.enemyPetInfoGo:SetActive(false)
  else
    self.enemyPetInfoGo:SetActive(true)
    local enemyPetInfoSop = self:GetUIComponent("UISelectObjectPath", "EnemyPetInfo")
    self.enemyPetInfo = enemyPetInfoSop:SpawnObject("UIWidgetBattleEnemyPetInfo")
    self.enemyPetInfo:SetData(matchEnterData)
  end
  self._skillAreaGen = self:GetUIComponent("UISelectObjectPath", "SkillArea")
  self._skillAreaWidget = self._skillAreaGen:SpawnObject("UIWidgetSkillArea")
  self._skillAreaWidget:SetData(self)
  self._mirageUIGen = self:GetUIComponent("UISelectObjectPath", "MirageUI")
  self._mirageUIWidget = self._mirageUIGen:SpawnObject("UIWidgetMirageUI")
  self._puzzleUIGen = self:GetUIComponent("UISelectObjectPath", "PuzzleCountdown")
  self._puzzleWidget = self._puzzleUIGen:SpawnObject("UIWidgetPuzzle")
  self.cancelActiveSkillBtn = self:GetGameObject("CancelActiveSkillBtn")
  self._teamBuffList = {}
  if matchEnterData:GetMatchType() ~= MatchType.MT_Chess then
    local teamState = self:GetUIComponent("UISelectObjectPath", "teamState")
    self._teamState = teamState:SpawnObject("UIBattleTeamStateEnter")
    self._teamState:Init(localPlayerInfo.pet_list, self._teamBuffList)
  end
  self._lowHpWarning = self:GetUIComponent("UISelectObjectPath", "LowHpWarning"):SpawnObject("UIBattleLowHPWarning")
  self._outOfRoundWarning = self:GetUIComponent("UISelectObjectPath", "OutOfRoundContainer"):SpawnObject("UIBattleOutOfRoundDamageWarning")
  self._combo = self:GetUIComponent("UISelectObjectPath", "ComboContainer"):SpawnObject("UIBattleCombo")
  self._fullScreenEffect = self:GetGameObject("FullScreenEffect")
  self._auroraTimeEff = self:GetUIComponent("UISelectObjectPath", "auroraTimeEff"):SpawnObject("UIBattleAuroraTime")
  self._effectLoader = self:GetUIComponent("EffectLoader", "UIEffRoot")
  self:SpawnCancelArea()
  self._isFromMaze = matchEnterData:GetMatchType() == MatchType.MT_Maze
  self._isFromMiniMaze = matchEnterData:GetMatchType() == MatchType.MT_MiniMaze
  self._isPopStarPro = matchEnterData:GetMatchType() == MatchType.MT_PopStarPro
  self._isFromSeasonMaze = matchEnterData:GetMatchType() == MatchType.MT_SeasonMaze
  local isShowMazeBackpackBtn = self._isFromMaze or self._isFromMiniMaze or self._isPopStarPro or self._isFromSeasonMaze
  self.mazeBackpackBtn = self:GetGameObject("mazeBackpackBtn")
  self.mazeBackpackBtn:SetActive(isShowMazeBackpackBtn)
  local sop = self:GetUIComponent("UISelectObjectPath", "turnInfo")
  if self._isFromMaze or self._isFromSeasonMaze then
    sop.dynamicInfoOfEngine:SetObjectName("UIBattleMazeLightInfo.prefab")
    if matchEnterData:GetSubMatchType() == MatchType.MT_WorldBoss and self._isFromSeasonMaze then
      self._turnInfo = sop:SpawnObject("UIBattleTurnInfo")
    else
      self._turnInfo = sop:SpawnObject("UIBattleMazeLightInfo")
    end
  else
    self._turnInfo = sop:SpawnObject("UIBattleTurnInfo")
  end
  self:SpawnFeature()
  self:RegisterEvent()
  local affixSop = self:GetUIComponent("UISelectObjectPath", "mazeAffix")
  if affixSop then
    self._affixWidget = affixSop:SpawnObject("UIWidgetBattleAffix")
    self._affixWidget:SetData(matchEnterData)
  end
  local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
  self.levelId = levelConfigData:GetLevelID()
  local levelRoundCount = levelConfigData:GetLevelRoundCount()
  self._turnInfo:InitRoundCount(levelRoundCount)
  self._transitionEffectImg = self:GetUIComponent("Image", "TransitionEffect")
  self._transitionEffectImg:DOFade(0, 0.01)
  local eptRect = self:GetUIComponent("RectTransform", "UIBattleProgressInfoEpt")
  if self:IsBlackFist() then
    eptRect.anchoredPosition = Vector2(eptRect.anchoredPosition.x, 23.2)
  else
    eptRect.anchoredPosition = Vector2(eptRect.anchoredPosition.x, 0)
  end
  local ept = self:GetUIComponent("UISelectObjectPath", "UIBattleProgressInfoEpt")
  self._progressInfo = ept:SpawnObject("UIBattleProgressInfo")
  local trapSkillInfoPath = self:GetUIComponent("UISelectObjectPath", "trapSkillInfo")
  self._trapSkillUI = trapSkillInfoPath:SpawnObject("UIWidgetTrapSkill")
  self:_OnUITrapSkillVisible(false)
  self._guideMask = self:GetGameObject("GuideMask")
  self._guideWeakMaskGO = self:GetGameObject("guideWeakMask")
  self._guideWeakMaskGO:SetActive(false)
  self._guideWarnTurn = self:GetUIComponent("RectTransform", "GuideWarnTurn")
  self._guideWarnTurnGO = self:GetGameObject("GuideWarnTurn")
  self._guideWarnTurnGO:SetActive(false)
  self._guideWarnTurnY = self._guideWarnTurn.anchoredPosition.y
  self._guideWarnDescTxt = self:GetUIComponent("UILocalizationText", "guidewarndesc")
  self._guideWarnIcon = self:GetUIComponent("Image", "guidewarnicon")
  self._guideWarnIconGO = self:GetGameObject("guidewarnicon")
  self._guideWarnCanvasGroup = self:GetUIComponent("CanvasGroup", "GuideWarnTurn")
  self._guideWarnCanvasGroup.alpha = 0.7
  self._guideConditionGO = self:GetGameObject("GuideCondition")
  self._guideConditionGO:SetActive(false)
  self._guideConditionDescTxt = self:GetUIComponent("UILocalizationText", "guideconditiondesc")
  self._guideConditionFinishTxt = self:GetUIComponent("UILocalizationText", "guideconditionfinish")
  self._guideConditionAnim = self:GetUIComponent("Animation", "GuideCondition")
  self._playerTurn = self:GetUIComponent("RectTransform", "PlayerTurn")
  self._auroraTime = self:GetUIComponent("RectTransform", "AuroraTime")
  self._enemyTurn = self:GetUIComponent("RectTransform", "EnemyTurn")
  self.pTurnLayout = self:GetUIComponent("RectTransform", "pTurnLayout")
  self.eTurnLayout = self:GetUIComponent("RectTransform", "eTurnLayout")
  self.pTurnTex = self:GetUIComponent("UILocalizationText", "pTurnTex")
  self.eTurnTex = self:GetUIComponent("UILocalizationText", "eTurnTex")
  self.pTurnTex:SetText(StringTable.Get("str_battle_player_turn_1"))
  self.eTurnTex:SetText(StringTable.Get("str_battle_enemy_turn_1"))
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.pTurnLayout)
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.eTurnLayout)
  self.pTurnLayoutLeftX = -1 * (self.pTurnLayout.sizeDelta.x - 17.8 + 103.8)
  self.eTurnLayoutLeftX = -1 * (self.eTurnLayout.sizeDelta.x - 17.8 + 103.8)
  self._playerTurn.anchoredPosition = Vector2(self.pTurnLayoutLeftX, -60)
  self._enemyTurn.anchoredPosition = Vector2(self.eTurnLayoutLeftX, -60)
  self._autoBeadTime = self:GetUIComponent("RectTransform", "AutoBeadTime")
  self._autoBeadTime.gameObject:SetActive(false)
  self._benumbTips = self:GetUIComponent("RectTransform", "UIBenumbTips")
  self._besiegedTips = self:GetUIComponent("RectTransform", "UIBesiegedTips")
  self.uiPetInfoCanvasGroup = self:GetUIComponent("CanvasGroup", "PetInfo")
  self._mainStateTxt = self:GetUIComponent("UILocalizationText", "MainState")
  self._LevelName = self:GetUIComponent("UILocalizationText", "LevelName")
  self._fpsTxt = self:GetUIComponent("UILocalizationText", "fpstext")
  self._mvpTxt = self:GetUIComponent("UILocalizationText", "mvptext")
  self._cheatBtn = self:GetGameObject("btnTemp")
  self:SwitchDebugInfo(true)
  self.btnSettingGO = self:GetGameObject("btnSetting")
  local targetMission = Cfg.cfg_guide_const.guide_battle_quit_hide.IntValue
  local mission = self:GetModule(MissionModule)
  if NOGUIDE then
    self.btnSettingGO:SetActive(true)
  else
    self.btnSettingGO:SetActive(targetMission <= mission:GetCurMissionID())
  end
  local goChainPreview = self:GetUIComponent("UISelectObjectPath", "goChainPreview")
  self.goChainPreview = goChainPreview:SpawnObject("UIChainSkillPreview")
  collector:Sample("UIBattle:OnShow() end")
  self:_ShowHideUIBattle(false)
  self._autoBtnPool = self:GetUIComponent("UISelectObjectPath", "auto")
  self._manualBtns = self:GetGameObject("manual")
  local talePetMissionInfo = matchEnterData:GetTalePetMissionInfo()
  local isTrial = true
  if talePetMissionInfo then
    local cfg = Cfg.cfg_tale_stage[talePetMissionInfo.nId]
    if cfg and cfg.Type ~= 1 then
      isTrial = false
    end
  end
  self._taleBuffInfoBtn = self:GetGameObject("taleBuffInfoBtn")
  self._taleBuffInfoBtn:SetActive(matchEnterData:GetMatchType() == MatchType.MT_TalePet and not isTrial)
  self:_CheckAffixEntryBtn(matchEnterData)
  self._seasonBuffEntryBtn = self:GetGameObject("SeasonBuffEntryBtn")
  self._seasonBuffEntryBtn:SetActive(matchEnterData:GetMatchType() == MatchType.MT_Season)
  self:_CheckSeasonBuffEntryBtn(matchEnterData)
  self._campaignTalentEntryBtn = self:GetGameObject("CampaignTalentEntryBtn")
  if self._campaignTalentEntryBtn then
    self:_CheckCampaignTalentEntryBtn(matchEnterData)
  end
  self._hasHandleBattleEnd = false
  self._chessPanelPool = self:GetUIComponent("UISelectObjectPath", "ChessPanelPool")
  if matchEnterData:GetMatchType() == MatchType.MT_Chess and self._chessPanelPool then
    local bossHP = self:GetUIComponent("UISelectObjectPath", "chessHP")
    bossHP:SpawnObject("UIBattleChessHPInfo")
    self._goChessPanel = self._chessPanelPool:SpawnObject("UIBattleWidgetChess")
    self:GetGameObject("RightAnchor2"):SetActive(false)
    self:GetGameObject("RightUpAnchor"):SetActive(false)
  else
    local bossHP = self:GetUIComponent("UISelectObjectPath", "bossHP")
    bossHP:SpawnObject("UIBattleBossHP")
    self:GetGameObject("RightAnchor2"):SetActive(true)
    self:GetGameObject("RightUpAnchor"):SetActive(true)
  end
  local autoGen = self:GetUIComponent("UISelectObjectPath", "SerialAutoFight")
  self._widgetAutoFight = autoGen:SpawnObject("UIWidgetAutoFight")
  self._widgetAutoFight:SetData(matchEnterData, self._chessPanelPool)
  self:_RefreshUIBattleForMatchType()
  self._unscaledCountDownGen = self:GetUIComponent("UISelectObjectPath", "UnscaledCountDown")
  if self._unscaledCountDownGen then
    self._unscaledCountDownWidget = self._unscaledCountDownGen:SpawnObject("UIWidgetUnscaledCountDownUI")
  end
  self._cheatHideUIRecord = {}
end

function UIBattle:_RefreshUIBattleForMatchType()
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  if matchEnterData:GetMatchType() ~= MatchType.MT_PopStar and matchEnterData:GetSubMatchType() ~= MatchType.MT_PopStar then
    return
  end
  self._progressInfo:GetGameObject():SetActive(false)
  self:GetGameObject("RightUpAnchor"):SetActive(false)
  self._widgetAutoFight:GetGameObject():SetActive(false)
  local popStarNumPath = self:GetUIComponent("UISelectObjectPath", "popStarNum")
  self._popStarNum = popStarNumPath:SpawnObject("UIWidgetPopStarNum")
  self._popStarNum:GetGameObject():SetActive(false)
  local popStarProgressPath = self:GetUIComponent("UISelectObjectPath", "popStarProgress")
  self._popStarProgressInfo = popStarProgressPath:SpawnObject("UIWidgetPopStarProgressInfo")
  self._popStarProgressInfo:SetActive(true)
end

function UIBattle:_UpdateMultiMazeAffix(deltaTimeMS)
  if self._affixWidget then
    self._affixWidget:_OnUpdate(deltaTimeMS)
  end
end

function UIBattle:_CheckAffixEntryBtn(matchEnterData)
  local affixBtn = self:GetGameObject("AffixEntryBtn")
  local affixBtnImg = self:GetUIComponent("Image", "AffixEntryBtn")
  self._curAffixCampaignType = nil
  local show = false
  local campaignModule = self:GetModule(CampaignModule)
  local missionInfo = matchEnterData:GetMissionCreateInfo()
  if matchEnterData:GetMatchType() == MatchType.MT_Campaign then
    local campId, comId, comType = campaignModule:ParseCampaignMissionParams(missionInfo.CampaignMissionParams)
    local campConfig = Cfg.cfg_campaign[campId]
    if campConfig then
      self._curAffixCampaignType = campConfig.CampaignType
      if self._curAffixCampaignType == ECampaignType.CAMPAIGN_TYPE_SUMMER_II then
        if comType == CampaignComType.E_CAMPAIGN_COM_SUM_II_MISSION then
          local cfgs = Cfg.cfg_component_summer_ii_mission({
            CampaignMissionId = missionInfo.nCampaignMissionId,
            ComponentID = missionInfo.CampaignMissionParams[1]
          })
          if cfgs and 0 < #cfgs and cfgs[1].LevelType ~= UISummerActivity2LevelType.Normal then
            show = true
          end
        end
      elseif self._curAffixCampaignType == ECampaignType.CAMPAIGN_TYPE_N12 then
        if comType == CampaignComType.E_CAMPAIGN_COM_DAILY_MISSION or comType == CampaignComType.E_CAMPAIGN_COM_CHALL_MISSION then
          show = true
        end
      elseif self._curAffixCampaignType == ECampaignType.CAMPAIGN_TYPE_N21_CHALLENGE then
        if comType == CampaignComType.E_CAMPAIGN_COM_CHALL_MISSION then
          show = true
        end
      elseif self._curAffixCampaignType == ECampaignType.CAMPAIGN_TYPE_INLAND_N4_CHALLENGE and comType == CampaignComType.E_CAMPAIGN_COM_CHALL_MISSION then
        show = true
      end
    end
  end
  affixBtn:SetActive(show)
  if show then
    local spriteAtlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
    local spriteName = "summer_junei_btn1"
    if self._curAffixCampaignType == ECampaignType.CAMPAIGN_TYPE_N12 then
      spriteAtlas = self:GetAsset("UIN12.spriteatlas", LoadType.SpriteAtlas)
      spriteName = "n12_juenei_btn_citiao"
    elseif self._curAffixCampaignType == ECampaignType.CAMPAIGN_TYPE_N21_CHALLENGE then
      spriteName = "n21_wjyz_jnct_di15"
    elseif self._curAffixCampaignType == ECampaignType.CAMPAIGN_TYPE_INLAND_N4_CHALLENGE then
      spriteAtlas = self:GetAsset("UIN4CC.spriteatlas", LoadType.SpriteAtlas)
      spriteName = "activity_wjyz_zjm_icon14"
    end
    affixBtnImg.sprite = spriteAtlas:GetSprite(spriteName)
  end
end

function UIBattle:SwitchDebugInfo(show)
  local isDevelopmentBuild = false
  if HelperProxy:GetInstance():IsDebug() or EDITOR then
    isDevelopmentBuild = true
  end
  local bshowfps = HelperProxy:GetInstance():GetConfig("ShowFps", "false")
  local bshowcheatbtn = HelperProxy:GetInstance():GetConfig("ShowCheatBtn", "false")
  if isDevelopmentBuild == true and show then
    self._mainStateTxt.gameObject:SetActive(true)
    self._LevelName.gameObject:SetActive(true)
    self._LevelName:SetText("LevelID:" .. tostring(self.levelId))
    self._cheatBtn:SetActive(true)
    self._fpsTxt.gameObject:SetActive(true)
    self._mvpTxt.gameObject:SetActive(true)
  else
    if bshowcheatbtn == "true" and show then
      self._cheatBtn:SetActive(true)
    else
      self._cheatBtn:SetActive(false)
    end
    if bshowfps == "true" and show then
      self._mainStateTxt.gameObject:SetActive(true)
      self._LevelName.gameObject:SetActive(true)
      self._fpsTxt.gameObject:SetActive(true)
      self._mvpTxt.gameObject:SetActive(true)
    else
      self._mainStateTxt.gameObject:SetActive(false)
      self._LevelName.gameObject:SetActive(false)
      self._fpsTxt.gameObject:SetActive(false)
      self._mvpTxt.gameObject:SetActive(false)
    end
  end
end

function UIBattle:Dispose()
  Log.fatal("UIBattle:Dispose traceBack", debug.traceback())
  self._hasHandleBattleEnd = false
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  if self._uiLeaveMatchHandler then
    self._uiLeaveMatchHandler:Dispose()
  end
  if self._uiBattleFinishHandler then
    self._uiBattleFinishHandler:Dispose()
  end
  UIBattle.super:Dispose()
end

function UIBattle:ShotBattleResult()
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  if not self._shot then
    return
  end
  local shotRect = self:GetUIComponent("RectTransform", "screenShot")
  shotRect.gameObject:SetActive(true)
  self._shot.width = shotRect.rect.width
  self._shot.height = shotRect.rect.height
  self._shot.blurTimes = 0
  self._shot:CleanRenderTexture()
  self._battleResultRt = self._shot:RefreshBlurTexture()
end

function UIBattle:AffixEntryBtnOnClick()
  if not self._curAffixCampaignType then
    return
  end
  if self._curAffixCampaignType == ECampaignType.CAMPAIGN_TYPE_SUMMER_II then
    self:ShowDialog("UISummerActivityTwoEntryController")
  elseif self._curAffixCampaignType == ECampaignType.CAMPAIGN_TYPE_N12 then
    self:ShowDialog("UIN12BattleAffix")
  elseif self._curAffixCampaignType == ECampaignType.CAMPAIGN_TYPE_N21_CHALLENGE then
    self:ShowDialog("UIActivityN21CCAffixDetail")
  elseif self._curAffixCampaignType == ECampaignType.CAMPAIGN_TYPE_INLAND_N4_CHALLENGE then
    self:ShowDialog("UIActivityN4CCAffixDetail")
  end
end

function UIBattle:OnUpdate(deltaTimeMS)
  self:_UpdateMultiMazeAffix(deltaTimeMS)
  if self._mirageUIWidget then
    self._mirageUIWidget:OnUpdate(deltaTimeMS)
  end
  if self._puzzleWidget then
    self._puzzleWidget:OnUpdate(deltaTimeMS)
  end
  if self._unscaledCountDownWidget then
    self._unscaledCountDownWidget:OnUpdate(deltaTimeMS)
  end
  if (IsPc() or IsUnityEditor()) and GameGlobal.EngineInput().GetKeyDown(UnityEngine.KeyCode.BackQuote) then
    self._showDebugInfo = not self._showDebugInfo
    self:SwitchDebugInfo(self._showDebugInfo)
  end
  if self._show then
  end
end

function UIBattle:_AddPetAtkDefHp(petId, addAtk, addDef, addHp)
  local petList = self._petAreaWidget:_AddPetAtkDefHp(petId, addAtk, addDef, addHp)
  if petList and self._teamState then
    self._teamState:Init(petList, self._teamBuffList)
  end
end

function UIBattle:OnHide()
  if self._effectEvent then
    self._effectLoader:DestroyCurrentEffect()
    GameGlobal.Timer():CancelEvent(self._effectEvent)
    self._effectEvent = nil
  end
  if self._outsideEffectReq then
    self._outsideEffectReq:Dispose()
    self._outsideEffectReq = nil
  end
  if self._effectOutsideEvent then
    GameGlobal.Timer():CancelEvent(self._effectOutsideEvent)
    self._effectOutsideEvent = nil
  end
  if self._canvasGroupTweener then
    self._canvasGroupTweener:Kill()
    self._canvasGroupTweener = nil
  end
  if self._autoBeadTask then
    GameGlobal.TaskManager():KillTask(self._autoBeadTask)
    self._autoBeadTask = nil
  end
  self:UnRegisterEvent()
  if self._uiLeaveMatchHandler then
    self._uiLeaveMatchHandler:Dispose()
    self._uiLeaveMatchHandler = nil
  end
  if self._uiBattleFinishHandler then
    self._uiBattleFinishHandler:Dispose()
    self._uiBattleFinishHandler = nil
  end
end

function UIBattle:_ShowHideUIBattle(isShow)
  local go = self:GetGameObject()
  if go then
    go:SetActive(isShow)
  end
end

function UIBattle:RegisterEvent()
  self:AttachEvent(GameEventType.OnSetGraphicRaycaster, self.OnSetGraphicRaycaster)
  self:AttachEvent(GameEventType.UIShowPetInfo, self.HandleUIShowPetInfo)
  self:AttachEvent(GameEventType.ShowHideSuperChain, self.ShowHideSuperChain)
  self:AttachEvent(GameEventType.ShowHideBossComing, self.ShowHideBossComing)
  self:AttachEvent(GameEventType.ShowHideWaveWarning, self.ShowHideWaveWarning)
  self:AttachEvent(GameEventType.ShowBonusInfo, self.ShowBonusInfo)
  self:AttachEvent(GameEventType.WaveSwitch, self._OnWaveSwitch)
  self:AttachEvent(GameEventType.ShowZeroRoundWarning, self.ShowZeroRoundWarning)
  self:AttachEvent(GameEventType.ShowHideOutOfRoundPunishWarn, self.ShowOutOfRoundPunishWarn)
  self:AttachEvent(GameEventType.ShowWaveSwitch, self.ShowWaveSwitch)
  self:AttachEvent(GameEventType.ChangeTeamBuff, self.OnChangeBuff)
  self:AttachEvent(GameEventType.ShowTransitionEffect, self.ShowTransitionEffect)
  self:AttachEvent(GameEventType.ShowGuideFailed, self.ShowGuideFailed)
  self:AttachEvent(GameEventType.ShowGuideMask, self._ShowGuideMask)
  self:AttachEvent(GameEventType.ShowHideUIBattle, self._ShowHideUIBattle)
  self:AttachEvent(GameEventType.ShowStoryBanner, self._ShowStoryBanner)
  self:AttachEvent(GameEventType.PlayBattleUIEffect, self.ShowUIEffect)
  self:AttachEvent(GameEventType.PlayBattleUIEffectOutside, self.PlayBattleUIEffectOutside)
  self:AttachEvent(GameEventType.ShowTurnTips, self._ShowTurnTipsOut)
  self:AttachEvent(GameEventType.ShowGuideWarn, self._ShowGuideWarnOut)
  self:AttachEvent(GameEventType.ShowGuideCondition, self._ShowGuideCondition)
  self:AttachEvent(GameEventType.ShowPetInfo, self._ShowPetInfo)
  self:AttachEvent(GameEventType.RefreshMainState, self._RefreshMainState)
  self:AttachEvent(GameEventType.UiBattleVisible, self.OnUiBattleVisible)
  self:AttachEvent(GameEventType.ShowHideBenumbTips, self.ShowHideBenumbTips)
  self:AttachEvent(GameEventType.ShowHideBesiegedTips, self.ShowHideBesiegedTips)
  self:AttachEvent(GameEventType.ChangePetAtkDefHp, self._AddPetAtkDefHp)
  self:AttachEvent(GameEventType.UITrapSkillVisible, self._OnUITrapSkillVisible)
  self:AttachEvent(GameEventType.RefreshMVPText, self.OnRefreshMVPText)
  self:AttachEvent(GameEventType.SetCurPickExtraParam, self._OnSetCurPickExtraParam)
  self:AttachEvent(GameEventType.UIShowHideCancelActiveSkillBtn, self.ShowHideCancelActiveSkillBtn)
  self:AttachEvent(GameEventType.UISetTeamStateTeamLeader, self.SetTeamStateTeamLeader)
  self:AttachEvent(GameEventType.ShowChoosePartnerUI, self.ShowChoosePartnerUI)
  self:AttachEvent(GameEventType.UIShowBossSpeak, self.UIShowBossSpeak)
  self:AttachEvent(GameEventType.PopStarShowPopNum, self._OnUIPopStarNumVisible)
  self:AttachEvent(GameEventType.UICheatHideArea, self.UICheatHideArea)
  self:AttachEvent(GameEventType.FeatureAutoBeadSkill, self._OnFeatureAutoBeadSkill)
end

function UIBattle:UnRegisterEvent()
end

function UIBattle:_CloseAllDialogs(hide)
  local uiStateManager = GameGlobal.UIStateManager()
  if uiStateManager:IsShow("UIBattleInfo") then
    uiStateManager:CloseDialog("UIBattleInfo")
  end
  if uiStateManager:IsShow("UIBattleQuit") and hide then
    uiStateManager:CloseDialog("UIBattleQuit")
  end
  if uiStateManager:IsShow("UIBattleTeamState") then
    uiStateManager:CloseDialog("UIBattleTeamState")
  end
end

function UIBattle:_OnWaveSwitch()
  self:_CloseAllDialogs(true)
end

function UIBattle:ShowBonusInfo(isShow)
  if isShow == true then
    self:ShowDialog("UIBattleBonus")
  else
    GameGlobal.UIStateManager():CloseDialog("UIBattleBonus")
  end
end

function UIBattle:btnSettingOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattle",
    input = "btnSettingOnClick",
    args = {}
  })
  GameGlobal.UAReportForceGuideEvent("FightClick", {
    "btnSettingOnClick",
    0
  }, false, true)
  if self:IsAutoFighting() then
    self:ShowAutoFightForbiddenMsg()
    return
  end
  self:ShowDialog("UIBattleInfo")
end

function UIBattle:btnTempOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattle",
    input = "btnTempOnClick",
    args = {}
  })
  self:ShowDialog("UIBattleCheat", nil, self._cheatHideUIRecord)
end

function UIBattle:GetPetWidgetByPstID(petPstID)
  return self._petAreaWidget:GetPetWidgetByPstID(petPstID)
end

function UIBattle:GetPreviewPetId()
  return self._skillAreaWidget:GetPreviewPetId()
end

function UIBattle:GetCurPetActiveSkillId()
  return self._skillAreaWidget:GetCurPetActiveSkillId()
end

function UIBattle:CancelActiveSkillBtnOnClick(go)
  self._skillAreaWidget:OnCancelActiveSkillBtnOnClick(go)
end

function UIBattle:OnSetGraphicRaycaster(enable)
  self._graphicRaycaster.enabled = enable
end

function UIBattle:HideUIBattleQuit(enterData, victory)
  if MatchType.MT_Conquest == enterData._match_type then
    local gameMatchModule = self:GetModule(GameMatchModule)
    local matchResult = gameMatchModule:GetMachResult()
    if matchResult.m_vecAwardNormal.count <= 0 and victory then
      return false
    end
  elseif MatchType.MT_WorldBoss == enterData._match_type then
    local gameMatchModule = self:GetModule(GameMatchModule)
    local matchResult = gameMatchModule:GetMachResult()
    if 0 >= matchResult.m_damage and victory then
      return false
    end
  elseif MatchType.MT_MiniMaze == enterData._match_type then
    local gameMatchModule = self:GetModule(GameMatchModule)
    local matchResult = gameMatchModule:GetMachResult()
    if 0 >= matchResult.wave and victory then
      return false
    end
  elseif MatchType.MT_PopStar == enterData._match_type then
    local gameMatchModule = self:GetModule(GameMatchModule)
    local matchResult = gameMatchModule:GetMachResult()
    if 0 >= matchResult._starNum and victory then
      return false
    end
  end
  return true
end

function UIBattle:OnShowPetInfoInish()
  self._petAreaWidget:OnShowPetInfoInish()
  if self.enemyPetInfo then
    self.enemyPetInfo:OnShowPetInfoInish()
  end
end

function UIBattle:ShowHideSuperChain(isShow, pos)
  if isShow then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUISuperChain)
    GameGlobal.UIStateManager():ShowDialog("UISuperChainSkill", pos)
  else
    GameGlobal.UIStateManager():CloseDialog("UISuperChainSkill")
  end
end

function UIBattle:ShowHideBossComing(isShow, bossId)
  if isShow then
    if not bossId then
      Log.fatal("### [boss coming] bossId is null.")
      return
    end
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIBossAlarm)
    GameGlobal.UIStateManager():ShowDialog("UIBattleBossWarning", bossId)
  else
    GameGlobal.UIStateManager():CloseDialog("UIBattleBossWarning")
  end
end

function UIBattle:ShowHideWaveWarning(isShow, levelId)
  if isShow then
    if not levelId then
      Log.fatal("### [boss coming] levelId is null.")
      return
    end
    AudioHelper.PlayUISoundAutoReleaseBylevelId(levelId)
    GameGlobal.UIStateManager():ShowDialog("UIHarvestTime")
  else
    GameGlobal.UIStateManager():CloseDialog("UIHarvestTime")
  end
end

function UIBattle:ShowZeroRoundWarning(isShow)
  if isShow then
    GameGlobal.UIStateManager():ShowDialog("UIBattleZeroRoundWarning")
  else
    GameGlobal.UIStateManager():CloseDialog("UIBattleZeroRoundWarning")
  end
end

function UIBattle:ShowOutOfRoundPunishWarn(isShow)
  if isShow then
    GameGlobal.UIStateManager():ShowDialog("UIBattleOutOfRoundPunishWarn")
  else
    GameGlobal.UIStateManager():CloseDialog("UIBattleOutOfRoundPunishWarn")
  end
end

function UIBattle:ShowWaveSwitch(isShow, waveNum)
  if isShow then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIWaveSwitch)
    GameGlobal.UIStateManager():ShowDialog("UIBattleWaveSwitch", waveNum)
  else
    GameGlobal.UIStateManager():CloseDialog("UIBattleWaveSwitch")
  end
end

function UIBattle:OnChangeBuff(buffList)
  self._teamBuffList = buffList
  self._teamState:OnChangeBuff(buffList)
end

function UIBattle:ShowTransitionEffect()
  self.rt = self:Shot()
  local transitionTime = 1
  self._transitionEffectImg:DOFade(1, transitionTime)
end

function UIBattle:ShowGuideFailed()
  local match = GameGlobal.GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  local matchType = enterData._match_type
  local missionId
  if MatchType.MT_Mission == matchType then
    local data = enterData:GetMissionCreateInfo()
    missionId = data.mission_id
  end
  self:ShowDialog("UIGuideFailedController", missionId, matchType)
end

function UIBattle:_GetMatchResult()
  local gameMatchModule = self:GetModule(GameMatchModule)
  local matchResult = UI_MatchResult:New()
  matchResult = gameMatchModule:GetMachResult()
  return matchResult
end

function UIBattle:_ShowGuideMask(isShow)
  self._guideMask:SetActive(isShow)
end

function UIBattle:_ShowPetInfo(addalpha)
  local srcalpha = self.uiPetInfoCanvasGroup.alpha
  local dstalpha = srcalpha + addalpha
  if srcalpha < 1 and 1 <= dstalpha then
    self.uiPetInfoCanvasGroup.alpha = dstalpha
  elseif 0 < srcalpha and dstalpha <= 0 then
    self.uiPetInfoCanvasGroup.alpha = dstalpha
  else
    self.uiPetInfoCanvasGroup.alpha = dstalpha
  end
  if dstalpha < 1 then
    self.uiPetInfoCanvasGroup.blocksRaycasts = false
  else
    self.uiPetInfoCanvasGroup.blocksRaycasts = true
    self:OnShowPetInfoInish()
  end
end

function UIBattle:_ShowStoryBanner(bannerID, bannerType)
  GameGlobal.UIStateManager():ShowDialog("UIStoryBanner", bannerID, bannerType)
end

function UIBattle:_ShowTurnTipsOut(isPlayerTurn, isAuroraTime)
  local duration = UIConst.TurnTipsOutTick / 1000.0
  local stay = UIConst.TurnTipsStayTick / 1000.0
  local offsetEndX = 0
  if isPlayerTurn then
    if isAuroraTime then
    else
      self._playerTurn:DOAnchorPosX(offsetEndX, duration):OnComplete(function()
        self._playerTurn:DOAnchorPosX(offsetEndX, stay):OnComplete(function()
          self:_ShowTurnTipsIn(isPlayerTurn, isAuroraTime)
        end)
      end)
    end
  else
    self._enemyTurn:DOAnchorPosX(offsetEndX, duration):OnComplete(function()
      self._enemyTurn:DOAnchorPosX(offsetEndX, stay):OnComplete(function()
        self:_ShowTurnTipsIn(isPlayerTurn)
      end)
    end)
  end
end

function UIBattle:_ShowTurnTipsIn(isPlayerTurn, isAuroraTime)
  local duration = UIConst.TurnTipsInTick / 1000.0
  local offsetEndX
  if isPlayerTurn then
    if isAuroraTime then
    else
      offsetEndX = self.pTurnLayoutLeftX
      self._playerTurn:DOAnchorPosX(offsetEndX, duration)
    end
  else
    offsetEndX = self.eTurnLayoutLeftX
    self._enemyTurn:DOAnchorPosX(offsetEndX, duration)
  end
end

function UIBattle:_ShowGuideWarnOut(guideWarnId)
  local cfg = Cfg.cfg_guide_warn[guideWarnId]
  if not self.guideAtlas then
    self.guideAtlas = self:GetAsset("UIGuide.spriteatlas", LoadType.SpriteAtlas)
  end
  if cfg then
    self._guideWarnIconGO:SetActive(true)
    self._guideWarnIcon.sprite = self.guideAtlas:GetSprite(cfg.icon)
    self._guideWarnDescTxt:SetText(StringTable.Get(cfg.describe))
    if cfg.audio then
      AudioHelperController.RequestAndPlayUIVoiceAutoRelease(cfg.audio)
    end
  else
    self._guideWarnTurnGO:SetActive(false)
    return
  end
  self._guideWarnTurnGO:SetActive(true)
  local moveTime = 0.5
  local waitTime = 5
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Warn)
  self._guideWarnTurn.anchoredPosition = Vector2(-700, self._guideWarnTurnY)
  self._guideWarnCanvasGroup:DOFade(1.0, moveTime)
  self._guideWarnTurn:DOAnchorPosX(0, moveTime):OnComplete(function()
    self._guideWarnTurn:DOAnchorPosX(0, waitTime):OnComplete(function()
      self._guideWarnTurn.anchoredPosition = Vector2(-700, self._guideWarnTurnY)
      self._guideWarnCanvasGroup.alpha = 0.7
      self._guideWarnTurnGO:SetActive(false)
    end)
  end)
end

function UIBattle:_RefreshMainState(stateID, stateName)
  self._mainStateID = stateID
  self._mainStateTxt:SetText(stateName)
end

function UIBattle:OnRefreshMVPText(value)
  self._mvpTxt:SetText(value)
end

function UIBattle:ShowHideCancelActiveSkillBtn(bShow)
  self.cancelActiveSkillBtn:SetActive(bShow)
end

function UIBattle:ShowHideBenumbTips(isShow)
  if isShow then
    self._benumbTipsQueue = DG.Tweening.DOTween.Sequence()
    self._benumbTipsQueue:Append(self._benumbTips:DOAnchorPosY(46, 0.5))
    self._benumbTipsQueue:Append(self._benumbTips:DOShakeAnchorPos(0.5, 10, 10, 10, false, true))
  else
    if self._benumbTipsQueue then
      self._benumbTipsQueue:Complete()
    end
    self._benumbTips:DOAnchorPosY(-26, 0.5)
  end
end

function UIBattle:ShowHideBesiegedTips(isShow)
  if isShow then
    local cfgLimitCount = Cfg.cfg_global.ui_besieged_tips_count.IntValue
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    local dbKey = "UI_BESIEGED_TIPS_COUNT" .. pstId
    local dbCount = LocalDB.GetInt(dbKey)
    if cfgLimitCount > dbCount then
      self._besiegedTips:DOAnchorPosY(46, 0)
      LocalDB.SetInt(dbKey, dbCount + 1)
    end
  else
    self._besiegedTips:DOAnchorPosY(-26, 0)
  end
end

function UIBattle:_ShowGuideCondition(matchResult)
  if not matchResult then
    return
  end
  local match = GameGlobal.GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  if MatchType.MT_Mission ~= enterData._match_type then
    return
  end
  local mission = GameGlobal.GameLogic():GetModule(MissionModule)
  local missionId = enterData:GetMissionCreateInfo().mission_id
  local targetMission = Cfg.cfg_guide_const.guide_condition_mission.IntValue
  if missionId < targetMission then
    return
  end
  if not self.guideMatchResult then
    self.guideMatchResult = {}
  end
  local desc = ""
  local cur3StarProgress = ""
  for i, id in ipairs(matchResult) do
    if not table.icontains(self.guideMatchResult, id) then
      desc = mission:Get3StarConditionDesc(id, "FFFFFF")
      cur3StarProgress = BattleStatHelper.Get3StarProgress(id)
      table.insert(self.guideMatchResult, id)
      local cfg = Cfg.cfg_threestarcondition[id]
      if not cfg or cfg.GuideShow == false then
        self._guideConditionGO:SetActive(false)
      else
        self:StartTask(function(TT)
          self._guideConditionGO:SetActive(true)
          self._guideConditionAnim:Play()
          self._guideConditionDescTxt:SetText(desc)
          local temp = cur3StarProgress
          temp = string.sub(temp, 2, -2)
          local params = string.split(temp, "/")
          local str = ""
          if params and params[1] and params[2] and tonumber(params[1]) < tonumber(params[2]) then
            str = string.format(StringTable.Get("str_guide_condition_nofinish"), cur3StarProgress)
          else
            str = string.format(StringTable.Get("str_guide_condition_finish"), cur3StarProgress)
          end
          self._guideConditionFinishTxt:SetText(str)
          YIELD(TT, 5000)
          if not GameGlobal:GetInstance():IsCoreGameRunning() then
            return
          end
          self._guideConditionGO:SetActive(false)
        end, self)
      end
    end
  end
end

function UIBattle:GetPetBattleBtnByPetTempId(petTempId)
  return self._petAreaWidget:GetPetBattleBtnByPetTempId(petTempId)
end

function UIBattle:GetPetBattleBtnHp(_index)
  return self._petAreaWidget:GetPetBattleBtnHp(_index)
end

function UIBattle:GetPetSkillBtn()
  return self._skillAreaWidget:GetPetSkillBtn()
end

function UIBattle:GetTeamStateBtn()
  return self._teamState and self._teamState:GetGameObject("TeamState")
end

function UIBattle:GetChangeLeaderBtn()
  return self._teamState and self._teamState:GetGameObject("ChangeTeamLeader")
end

function UIBattle:GetTurnInfoBg()
  return self._turnInfo:GetGameObject("BG")
end

function UIBattle:GetUIBattleCollect()
  return self._progressInfo and self._progressInfo:GetGameObject("BG")
end

function UIBattle:GetUIBattleLimitRound()
  return self._progressInfo and self._progressInfo:GetGameObject("limitbg")
end

function UIBattle:GetUITrapSkillIcon(index)
  return self._trapSkillUI and self._trapSkillUI:GetTrapSkillIcon(index)
end

function UIBattle:GetUITrapSkillBtn()
  return self._trapSkillUI and self._trapSkillUI:GetGameObject("btnGo")
end

function UIBattle:GetChainPreviewGOBtn()
  return self.goChainPreview and self.goChainPreview:GetGameObject("btnOK")
end

function UIBattle:GetSpeedBtn()
  if self._widgetAutoFight then
    return self._widgetAutoFight:GetSpeedBtn()
  end
end

function UIBattle:GetPetMultiSkillIndexBtn(index)
  return self._skillAreaWidget:GetPetMultiSkillIndexBtn(index)
end

function UIBattle:OnUiBattleVisible(visible, time)
  self._canvasGroupTweener = self._safeAreaCanvasGroup:DOFade(visible, time * 0.001)
  self._safeAreaCanvasGroup.blocksRaycasts = visible == 1 and true or false
end

function UIBattle:_OnUITrapSkillVisible(visible, trapEntityID)
  if visible then
    self._trapSkillUI:Init(trapEntityID)
  else
    self._trapSkillUI:GetGameObject():SetActive(false)
  end
end

function UIBattle:Shot()
  local shot = self:GetUIComponent("H3DUIBlurHelper", "shot")
  local shotRect = self:GetUIComponent("RectTransform", "shot")
  shotRect.gameObject:SetActive(true)
  local rt = shot:RefreshBlurTexture()
  return rt
end

function UIBattle:OnPetResurgence(petID)
end

function UIBattle:ResetLayout(TT)
  self._combo:HideCombo()
  self._petAreaWidget:ResetLayout(TT)
end

function UIBattle:mazeBackpackBtnOnClick()
  local strText = "str_maze_no_relics"
  local matchModule = GameGlobal.GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  local relicList = {}
  if self._isFromMiniMaze then
    relicList = BattleStatHelper.GetAllMiniMazeRelic()
  elseif self._isPopStarPro then
    local createInfo = enterData:GetMissionCreateInfo()
    relicList = createInfo.relics
    strText = "str_eliminate_no_relic"
  elseif self._isFromSeasonMaze then
    relicList = {}
    local createInfo = enterData:GetSeasonMazeMissionInfo()
    for relicID, counter in pairs(createInfo.relic_list) do
      table.insert(relicList, relicID)
    end
    strText = "str_season_maze_no_relic"
  else
    local mazeCreateInfo = enterData:GetMazeCreateInfo()
    relicList = mazeCreateInfo.relics
  end
  local relicCount = #relicList
  if relicCount <= 0 then
    ToastManager.ShowToast(StringTable.Get(strText))
    return
  end
  if not self._isFromSeasonMaze then
    self:ShowDialog("UIRugueLikeBackpackController", true)
  else
    self:ShowDialog("UISeasonMazeBackPackController", 2, true)
  end
end

function UIBattle:ShowUIEffect(name, duaration)
  self._effectLoader:LoadEffect(name)
  if self._effectEvent then
    self._effectLoader:DestroyCurrentEffect()
    self._effectEvent = nil
  end
  self._effectEvent = GameGlobal.Timer():AddEvent(duaration, function()
    self._effectLoader:DestroyCurrentEffect()
    self._effectEvent = nil
  end)
end

function UIBattle:PlayBattleUIEffectOutside(name, duration)
  if self._outsideEffectReq then
    self._outsideEffectReq:Dispose()
    self._outsideEffectReq = nil
  end
  self._outsideEffectReq = ResourceManager:GetInstance():SyncLoadAsset(name .. ".prefab", LoadType.GameObject)
  if self._outsideEffectReq and self._outsideEffectReq.Obj then
    local gameObject = self:GetGameObject()
    local parent = gameObject.transform.parent
    self._outsideEffect = self._outsideEffectReq.Obj
    self._outsideEffect:SetActive(true)
    self._outsideEffect.transform:SetParent(parent)
    self._outsideEffect.transform.localPosition = Vector3.zero
    self._outsideEffect.transform.localRotation = Quaternion.Euler(0, 0, 0)
    local bgCanvasTransform = self._outsideEffect.transform:Find("BGCanvas")
    local uiCanvasTransform = self._outsideEffect.transform:Find("UICanvas")
    if bgCanvasTransform or uiCanvasTransform then
      local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
      if bgCanvasTransform then
        local bgCanvas = bgCanvasTransform.gameObject:GetComponent("Canvas")
        bgCanvas.worldCamera = camera
      end
      if uiCanvasTransform then
        local uiCanvas = uiCanvasTransform.gameObject:GetComponent("Canvas")
        uiCanvas.worldCamera = camera
      end
    end
    self._effectOutsideEvent = GameGlobal.Timer():AddEvent(duration, function()
      if self._outsideEffectReq then
        self._outsideEffectReq:Dispose()
        self._outsideEffectReq = nil
      end
    end)
  end
end

function UIBattle:taleBuffInfoBtnOnClick()
  self:ShowDialog("UIBattleTaleBuffDesc")
end

function UIBattle:ShowAutoTestLogs()
  if EDITOR then
    self:ShowDialog("UIBattleAutoTest")
  end
end

function UIBattle:_OnSetCurPickExtraParam(skillID, extraParam)
  if not self._curPickExtraParam then
    self._curPickExtraParam = {}
  end
  self._curPickExtraParam[skillID] = extraParam
end

function UIBattle:GetCurPickExtraParam(skillID)
  if self._curPickExtraParam then
    return self._curPickExtraParam[skillID]
  end
end

function UIBattle:HandleBattleEnd(enterData, victory)
  self:_CloseAllDialogs(self:HideUIBattleQuit(enterData, victory))
  self._lowHpWarning:ShowHideLowHpWarning(false)
end

function UIBattle:SpawnCancelArea()
  local cancelAreaRoot = self:GetUIComponent("UISelectObjectPath", "CancelAreaRoot")
  self._cancelAreaWidget = cancelAreaRoot:SpawnObject("UIWidgetCancelArea")
end

function UIBattle:SpawnFeature()
  self._featureListSopGo = self:GetGameObject("featureList")
  local featureListSop = self:GetUIComponent("UISelectObjectPath", "featureList")
  self._featureList = featureListSop:SpawnObject("UIWidgetFeatureList")
  self._featureList:SetUIBattle(self)
  local featureDayNightSop = self:GetUIComponent("UISelectObjectPath", "featureDayNight")
  self._featureDayNight = featureDayNightSop:SpawnObject("UIWidgetFeatureDayNight")
  local featureTrapCountSop = self:GetUIComponent("UISelectObjectPath", "featureTrapCount")
  self._featureTrapCount = featureTrapCountSop:SpawnObject("UIWidgetFeatureTrapCount")
  self._featureCardInfoGenGo = self:GetGameObject("CardInfoGen")
  self._featureCardInfoGenGo:SetActive(false)
  self._featureBanPetSkillPartent = self:GetGameObject("FeatureBanPetSkillPartent")
end

function UIBattle:GetFeatureCardUI(uiType)
  if not self._featureCardUI then
    local cardInfoGen = self:GetUIComponent("UISelectObjectPath", "CardInfoGen")
    local widgetName = "UIWidgetFeatureCardInfo"
    if uiType and uiType == FeatureCardUiType.Skin1 then
      cardInfoGen:Engine():SetObjectName("UIWidgetFeatureCardInfo_l.prefab")
      widgetName = "UIWidgetFeatureCardInfo_L"
    end
    self._featureCardUI = cardInfoGen:SpawnObject(widgetName)
    self._featureCardUI:SetUIBattle(self)
  end
  return self._featureCardUI
end

function UIBattle:ShowFeatureCardInfo(bShow)
  self._featureCardInfoGenGo:SetActive(bShow)
end

function UIBattle:FeatureOnChooseTargetConfirm()
  if self._featureList then
    self._featureList:OnChooseTargetConfirm()
  end
end

function UIBattle:HandleUIShowPetInfo(petPstID, isShow)
end

function UIBattle:IsAutoFighting()
  return GameGlobal.GetUIModule(MatchModule):IsAutoFighting()
end

function UIBattle:ShowAutoFightForbiddenMsg()
  return GameGlobal.GetUIModule(MatchModule):ShowAutoFightForbiddenMsg()
end

function UIBattle:GetBattleResultCompleteRT()
  return self.rt
end

function UIBattle:GetUITeamLeaderPstID()
  return self._petAreaWidget:GetUITeamLeaderPstID()
end

function UIBattle:GetUITeamLeaderName()
  return self._petAreaWidget:GetUITeamLeaderName()
end

function UIBattle:GetUITeamTailName()
  return self._petAreaWidget:GetUITeamTailName()
end

function UIBattle:GetUIFeatureCardBuffEffBeginScreenPos()
  return self._featureCardUI:GetCardBuffEffBeginScreenPos()
end

function UIBattle:GetUIFeatureCardBuffEffBeginPos()
  return self._featureCardUI:GetCardBuffEffBeginPos()
end

function UIBattle:SetTeamStateTeamLeader(data)
  self._teamState:SetTeamLeader(data)
end

function UIBattle:ShowChoosePartnerUI(bShow, choosePartners, choosenRelicID)
  if bShow then
    self:ShowDialog("UIMiniMazeChoosePartnerController", choosePartners, choosenRelicID)
  else
    GameGlobal.UIStateManager():CloseDialog("UIMiniMazeChoosePartnerController")
  end
end

function UIBattle:UIShowBossSpeak(animNames, bossImage, bossName, bossSpeak, duration, outAnim)
  GameGlobal.UIStateManager():ShowDialog("UIBattleBossSpeakDialog", animNames, bossImage, bossName, bossSpeak, duration, outAnim)
end

function UIBattle:_OnUIPopStarNumVisible(visible, gridNum, superGridNum)
  if visible then
    self._popStarNum:Init(gridNum, superGridNum)
  else
    self._popStarNum:HideNum()
  end
end

function UIBattle:UICheatHideArea(hidePart, bHide)
  self._cheatHideUIRecord[hidePart] = bHide
  if hidePart == UIBattleCheatHideUIArea.LeftUp then
    if self.btnSettingGO then
      self.btnSettingGO:SetActive(not bHide)
    end
    local eptGo = self:GetGameObject("UIBattleProgressInfoEpt")
    if eptGo then
      eptGo:SetActive(not bHide)
    end
    local HelpIntrBtn = self:GetGameObject("HelpIntrBtn")
    if HelpIntrBtn then
      if bHide then
        HelpIntrBtn:SetActive(false)
      elseif self.helpIntrs and next(self.helpIntrs) then
        HelpIntrBtn:SetActive(true)
      else
        HelpIntrBtn:SetActive(false)
      end
    end
  elseif hidePart == UIBattleCheatHideUIArea.LeftDown then
    local turnGo = self:GetGameObject("turnInfo")
    if turnGo then
      turnGo:SetActive(not bHide)
    end
    local affixGo = self:GetGameObject("mazeAffix")
    if affixGo then
      affixGo:SetActive(not bHide)
    end
    local featureGo = self:GetGameObject("featureList")
    if featureGo then
      featureGo:SetActive(not bHide)
    end
  elseif hidePart == UIBattleCheatHideUIArea.AutoArea then
    local autoGo = self:GetGameObject("SerialAutoFight")
    if autoGo then
      autoGo:SetActive(not bHide)
    end
  elseif hidePart == UIBattleCheatHideUIArea.StateArea then
    local rightUpGo = self:GetGameObject("RightUpAnchor")
    if rightUpGo then
      rightUpGo:SetActive(not bHide)
    end
  elseif hidePart == UIBattleCheatHideUIArea.DebugInfo then
    self._showDebugInfo = not self._showDebugInfo
    self:SwitchDebugInfo(self._showDebugInfo)
    self._cheatBtn:SetActive(true)
  elseif hidePart == UIBattleCheatHideUIArea.CheatBtn then
    local tempImage = self:GetUIComponent("Image", "btnTemp")
    if tempImage then
      if bHide then
        tempImage.color = Color(tempImage.color.r, tempImage.color.g, tempImage.color.b, 0)
      else
        tempImage.color = Color(tempImage.color.r, tempImage.color.g, tempImage.color.b, 1)
      end
    end
  elseif hidePart == UIBattleCheatHideUIArea.Combo then
    local comboGo = self:GetGameObject("ComboContainer")
    if comboGo then
      comboGo:SetActive(not bHide)
    end
  end
end

function UIBattle:_CheckSeasonBuffEntryBtn(matchEnterData)
  local seasonBuffEntryBtn = self:GetGameObject("SeasonBuffEntryBtn")
  local seasonBuffEntryBtnImg = self:GetUIComponent("RawImageLoader", "SeasonBuffEntryBtn")
  local show = false
  local campaignModule = self:GetModule(CampaignModule)
  local missionInfo = matchEnterData:GetMissionCreateInfo()
  if matchEnterData:GetMatchType() == MatchType.MT_Season then
    show = true
    local imgRes = UISeasonHelper.CurSeasonBuffIconInBattle()
    if imgRes then
      seasonBuffEntryBtnImg:LoadImage(imgRes)
    end
  end
  seasonBuffEntryBtn:SetActive(show)
end

function UIBattle:SeasonBuffEntryBtnOnClick()
  UISeasonHelper.OpenBuffTipInnerGame()
end

function UIBattle:_CheckCampaignTalentEntryBtn(matchEnterData)
  local matchType = matchEnterData:GetMatchType()
  local subMatchType = matchEnterData:GetSubMatchType()
  local linkLineType = matchEnterData:GetLinkLineType()
  local showTalentEntry = false
  if matchType == MatchType.MT_Campaign and linkLineType == ELinkLineType.ELLT_LINE_NoElementCostStep then
    local missionInfo = matchEnterData:GetCampaignMissionInfo()
    local componentID = missionInfo.CampaignMissionParams[1]
    if componentID and componentID == 506800503 then
      showTalentEntry = true
    end
  end
  self._campaignTalentEntryBtn:SetActive(showTalentEntry)
end

function UIBattle:CampaignTalentEntryBtnOnClick()
  self:ShowDialog("UICampaignTalentInnerInfo")
end

function UIBattle:IsBlackFist()
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  if matchEnterData:GetMatchType() == MatchType.MT_BlackFist then
    return true
  elseif matchEnterData:GetMatchType() == MatchType.MT_Campaign and matchEnterData:GetSubMatchType() == MatchType.MT_BlackFist then
    return true
  else
    return false
  end
end

function UIBattle:_OnFeatureAutoBeadSkill(show)
  if show then
    self._autoBeadActive = true
    self._autoBeadTask = self:StartTask(function(TT)
      self._autoBeadTime.gameObject:SetActive(true)
      YIELD(TT, 1500)
      if self._autoBeadActive == false then
        self._autoBeadTime.gameObject:SetActive(false)
      else
        self._autoBeadActive = false
      end
    end, self)
  elseif self._autoBeadActive == false then
    self._autoBeadTime.gameObject:SetActive(false)
  else
    self._autoBeadActive = false
  end
end
