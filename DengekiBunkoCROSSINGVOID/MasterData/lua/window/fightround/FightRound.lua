local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local S = require("Common/Singleton")
local AU = require("Common/ActorUtil")
local FH = require("Logic/HelpLogic")
local TLog = require("Common/TlogUtil")
local SE = require("Common/SkillEffect")
local CU = require("Common/ChatUtil")
local PU = require("Common/PlatformUtil")
local DEFINE = require("Logic/Define")
local FightHelper = require("Common/FightHelper")
local Macro = require("Common/Macro")
local DU = require("Common/DungeonUtil")
local TimeScale = 1.5
local BGCameraY = 5000
local m_fightLuaRef
local m_weaponLock = false
local m_paramsForAFR = {
  dungeonType = PB.enum.DungoenType.None,
  dungeonId = 0,
  isAutoFight = false,
  isSpeedUp = false,
  skillGroupList = {},
  autoFightDelayTime = 0,
  isRecordGame = false,
  sequenceActor = 0,
  teamInfo = nil,
  skipNeedShow = false,
  stateWidget = nil,
  weaponBtnInfos = {},
  weaponUnlocked = false
}
local m_configDataManager = S:Get("ConfigDataManager")
local m_tutorialManager = S:Get("TutorialManager")
local MAX_ACTOR_HUD = 5
local MAX_ASSIST_COUNT = 5
local sceneInstance, fightInstance
local refreshDelay = 0
local Vector3 = CS.UnityEngine.Vector3
local mLeftBtnRoot, mBottomBtnRoot, mStateWidget
local mCardHideTime = 0
local mCardActiveState = 0
local mRoundTime = 0
local mRoundTimeDelay = 0
local mRoundSkip = false
local mShowDelayTime = 0
local mRotateDir = 0
local mRotateState = 0
local mRotateTotalTime = 0.15
local mRotateCurTime = 0
local mCardAnimState = 0
local mTeamID = 0
local mTeamInfo
local mActiveUseCard = 0
local mSequenceActor = 0
local mCurTotalStar = 0
local mIsTeam1Left = true
local mIsRecordGame = false
local mBuffDetailAutoCloseLeftTime = 0
local BUFF_DETAIL_AUTO_CLOSE_TIME = 5.0
local mBuffDetailID = 0
local mAllSkillInfoID = 0
local totalPt = 0
local totalHurtVal = 0
local curHurtVal = 0
local curHurtUIVal = 0
local curHurtTeam = -1
local curHurtTime = -1
local curHurtTotalTime = 0
local dungeonType, dungeonId, tutorialVal
local mNetPauseState = 0
local mPauseSignFlags = 0
local mPressSkillTime = 0
local mSkillTipActor
local mSkillTipBuffIndex = 0
local mSkillTipSpeacialIndex = 0
local mSkillTipInfo
local mSkillTipLinkID = 0
local mPlayerActorStateList = {}
local mEnemyActorStateList = {}
local mSkillGroupList = {}
local mLeftAssistList = {}
local mRightAssistList = {}
local mRecordAutoFight = false
local mHaveSkill = true
local chatImageList = {}
local chatInterval = 0
local lastChatTime = 0
local skipGuideLock = false
local GroupChatInterval
local m_groupChatInterval = 10
local m_preTimeScale = 1
local cameraFight
local cameraRotate = CS.UnityEngine.Quaternion.identity
local showMonsterId, showMonsterIndex
local m_specialTriggerListTeam1 = {}
local m_specialTriggerListTeam2 = {}
local m_dungeonMonster, m_isDungeonChain, m_selfTeamInfo, m_defineParams, m_useCountNotFull, m_roundChanged, m_lastEnergySP, m_lastEnergyMP, m_tempEnergyInfo
local m_hudNodeMap = {}
local m_positionNodeMap = {}
local m_fightTalkMap = {}
local m_debugMode
local m_debugActorState = {}
local mflyRoutine = {}
local mEffectFly = false
local mUniqueWeaponGuideStart
local GuideSkillInfo = {
  [2011] = {
    {1},
    {2},
    {3}
  },
  [2012] = {
    {3}
  },
  [2013] = {
    {1},
    {5},
    {4},
    {2}
  },
  [2] = {
    {0},
    {0},
    {2},
    {2}
  },
  [5] = {
    {0},
    {0},
    {4}
  },
  [7] = {
    {0},
    {1},
    {5}
  },
  [9] = {
    {0},
    {1},
    {4}
  },
  [13] = {
    {99}
  },
  [15] = {
    {0},
    {0},
    {2}
  },
  [3101] = {
    {3},
    {4},
    {3}
  }
}
local SkillPosTable = {
  {-340, -455},
  {-180, -405},
  {0, -377},
  {180, -405},
  {340, -455}
}
local SupportPosTable = {
  {700, -450},
  {800, -450},
  {900, -450}
}

function SetupWindow()
  local FightLuaLogic = CS.FightLuaLogic.Instance
  m_fightLuaRef = _ENV["$"](FightLuaLogic.transform)
  FightLuaLogic.mFightRoundSandBox = REF["$LuaInjector"].Sandbox
  WU.ToggleRendering(REF.Player1, false)
  WU.ToggleRendering(REF.Player2, false)
  for i = 0, DEFINE.HALF_ACTOR_NUM - 1 do
    local player_main = CS.UIActorCardButtonInfo()
    player_main.btn = CS.UnityEngine.GameObject.Instantiate(REF.Player1.gameObject, REF.Player1.transform.parent)
    player_main.btn:SetActive(false)
    table.insert(mPlayerActorStateList, player_main)
    local enemy_main = CS.UIActorCardButtonInfo()
    enemy_main.btn = CS.UnityEngine.GameObject.Instantiate(REF.Player2.gameObject, REF.Player2.transform.parent)
    enemy_main.btn:SetActive(false)
    table.insert(mEnemyActorStateList, enemy_main)
  end
  CS.UnityEngine.GameObject.DestroyImmediate(REF.Player1.gameObject)
  CS.UnityEngine.GameObject.DestroyImmediate(REF.Player2.gameObject)
  for i = 1, MAX_ASSIST_COUNT do
    local newBtn = CS.UnityEngine.GameObject.Instantiate(REF.LeftAssist.gameObject, REF.LeftAssist.transform.parent)
    newBtn.name = "LeftAssist_" .. i
    WU.ToggleRendering(newBtn, false)
    table.insert(mLeftAssistList, newBtn)
    local newBtn = CS.UnityEngine.GameObject.Instantiate(REF.RightAssist.gameObject, REF.RightAssist.transform.parent)
    newBtn.name = "RightAssist_" .. i
    WU.ToggleRendering(newBtn, false)
    table.insert(mRightAssistList, newBtn)
  end
  CS.UnityEngine.GameObject.DestroyImmediate(REF.LeftAssist.gameObject)
  CS.UnityEngine.GameObject.DestroyImmediate(REF.RightAssist.gameObject)
  mLeftBtnRoot = REF.LeftBtnRoot.UIWidget
  mBottomBtnRoot = REF.AutoFightRoot.UIWidget
  mStateWidget = REF.InfoRoot.UIPanel
  m_paramsForAFR.stateWidget = REF.InfoRoot.UIPanel
  WU.SetActive(REF.ChangeUI, false)
  WU.BindButtonEvent(REF.BtnChatInTalk, OnBtnChat)
  WU.BindButtonEvent(REF.BtnSkipRound, OnBtnSkipRound)
  WU.BindButtonEvent(REF.BtnChat, OnBtnChat)
  WU.BindButtonEvent(REF.BtnFace, OnBtnFace)
  WU.BindButtonEvent(REF.BtnTalk, OnBtnTalk)
  WU.BindButtonEvent(REF.BtnSwitch, OnBtnSwitch)
  REF.BtnSwitch.gameObject:SetActive(false)
  CS.UIWindowHelp.ChangeUIWidgetEnable(REF.BtnSkipRound.gameObject, false)
  m_paramsForAFR.skipNeedShow = false
  WU.SetActive(REF.AutoSetting, false)
  WU.SetActive(REF.AutoSettingPlaceHolder, true)
  WU.SetActive(REF.SpeedAddPlaceHolder, false)
  WU.BindButtonEvent(REF.BtnSkill.gameObject, OnActorSkillClick)
  WU.TraverseChildren(REF.WeaponGrid, function(go)
    local ref = _ENV["$"](go)
    WU.BindButtonEvent(ref.WeaponRect.gameObject, function()
      if m_weaponLock then
        return
      end
      OnActorSkillClick(go)
    end)
  end)
  WU.BindButtonEvent(REF.FightWeaponSkills, function(go)
    if m_weaponLock then
      return
    end
    local weaponInfos = FH.getTeamWeapons({mTeamInfo})
    if 0 < #weaponInfos then
      local ui = OnButtonPause(go, "FightWeaponSkills")
      _ENV["$"](ui)["$$RefreshWeaponInfo"](weaponInfos, mTeamInfo, m_tempEnergyInfo)
    end
  end)
  WU.BindPressEvent(REF.BtnSkill.gameObject, OnActorSkillTip)
  WU.ToggleRendering(REF.BtnSkill, false)
  WU.ToggleRendering(REF.BattleScoreBG, false)
  
  local function OnEnergyAnimFinished(ref, val)
    ref.EnergyValLabel.UILabel.text = val
  end
  
  CS.EventDelegate.Add(REF.Bottom.UIPlayTween.onFinished, function()
    REF.UIChangeEffect.EffectGenerator:Reset()
    REF.UIChangeEffect.EffectGenerator:Play(function()
      mUniqueWeaponGuideStart = true
      SendTutorialEvent("Tutorial/StepReady")
      WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, false)
    end)
  end)
  CS.EventDelegate.Add(REF.EnergyBarSp.UIPlayTween.onFinished, function()
    OnEnergyAnimFinished(_ENV["$"](REF.EnergyBarSp), m_lastEnergySP)
  end)
  CS.EventDelegate.Add(REF.EnergyBarMp.UIPlayTween.onFinished, function()
    OnEnergyAnimFinished(_ENV["$"](REF.EnergyBarMp), m_lastEnergyMP)
  end)
  HideEnergyUI()
  HideHurtVal()
  HideUIBuffDetailBg(nil)
  HideSkillTip()
  WU.BindButtonEvent(REF.BuffDetailBgBtn, HideUIBuffDetailBg)
  REF.BuffDetailGridScrollView.UIScrollView.onPressedShouldNotMove = OnBuffDetailScrollViewPressedShouldNotMove
  REF.BuffDetailGridScrollView.UIScrollView.onDragFinished = OnBuffDetailScrollViewDragFinished
  REF.BuffDetailGridScrollView.UIScrollView.onDragStarted = OnBuffDetailScrollViewDragStarted
  REF.BuffDetailGridScrollView.UIScrollView.onStoppedMoving = OnBuffDetailScrollViewStoppedMoving
  
  local function FightPauseWindow(go)
    local windowName = fif(dungeonType ~= 0, "FightPauseWithMoreContent", "FightPause")
    OnButtonPause(go, windowName)
  end
  
  WU.BindButtonEvent(REF.BtnPause, function(go)
    FightPauseWindow(go)
    if EnablePause() and DB:GetData("playerId") then
      WU.SetGameDataCache("PauseShowBefore" .. DB:GetData("playerId"), true)
    end
  end)
  WU.BindKeyEvent(REF.BtnPause, FightPauseWindow)
  WU.BindButtonEvent(REF.TimeBG, FightPauseWindow)
  m_paramsForAFR.weaponUnlocked = this:GetData("Arm/ArmUnlock") or false
  WU.ToggleRendering(REF.WeaponSkills, m_paramsForAFR.weaponUnlocked)
  dungeonId = this:GetData("WindowDungeon/DungeonId")
  m_dungeonMonster = PB.get("DungeonMonster", dungeonId)
  m_isDungeonChain = m_dungeonMonster and m_dungeonMonster.nextDungeonId ~= 0
  if m_isDungeonChain then
    local fightInitInfo = this:GetData("FightInitInfo")
    if fightInitInfo and fightInitInfo.gameRound then
      REF.roundVal.UILabel.text = tostring(fightInitInfo.gameRound - 1)
    else
      REF.roundVal.UILabel.text = 1
    end
  end
  m_defineParams = DEFINE.GetDefineParams(dungeonId)
  dungeonType = this:GetData("FightDungeonType")
  m_paramsForAFR.dungeonType = dungeonType
  m_paramsForAFR.dungeonId = dungeonId
  if dungeonType == PB.enum.DungeonType.RacePVP or dungeonType == PB.enum.DungeonType.AssistGuild or dungeonType == PB.enum.DungeonType.ChallengeGuild then
    REF.LabelBattleScore.UIHtmlLabel.text = WU.GetString("PVPREALRACE_BATTLESCOREINGAME", 0)
    WU.ToggleRendering(REF.BattleScoreBG, true)
  end
  if dungeonType == PB.enum.DungeonType.BurstLinkPvp or dungeonType == PB.enum.DungeonType.FriendPvp or dungeonType == PB.enum.DungeonType.RD then
    REF.BtnTalk.gameObject:SetActive(false)
    REF.BtnChat.gameObject:SetActive(false)
    REF.BtnFace.transform.localPosition = Vector3.zero
  elseif dungeonType == PB.enum.DungeonType.TeamPve then
    REF.BtnTalk.transform.localPosition = Vector3.zero
    REF.BtnChat.gameObject:SetActive(false)
    REF.BtnFace.gameObject:SetActive(false)
  else
    REF.BtnTalk.gameObject:SetActive(false)
    REF.BtnChat.transform.localPosition = Vector3.zero
    REF.BtnFace.gameObject:SetActive(false)
  end
  WU.PreloadWindow("FightAutoSetting")
  REF.AutoFightRoot["$SetupAutoFight"](m_paramsForAFR)
end

function InitWindow()
  InitGMTool(false)
  fightInstance = CS.FightRoundBase.Instance
  sceneInstance = CS.SceneFight.Instance
  refreshDelay = 0
  this:Bind("FightUI/HudText", OnHudText)
  this:Bind("FightUI/Position", OnPosition)
  this:Bind("FightUI/FightTalk", OnFightTalk)
  this:RegisterGameEvent("FightUI_InitActor", InitActorList)
  this:RegisterGameEvent("FightUI_OverRound", OverRound)
  this:RegisterGameEvent("FightUI_HideSelfCard", HideSelfCard)
  this:RegisterGameEvent("FightUI_HideSelfUI", HideSelfUI)
  this:RegisterGameEvent("FightUI_CreateSkill", CreateSkill)
  this:RegisterGameEvent("FightUI_ClearRoundState", ClearRoundStateEx)
  this:RegisterGameEvent("FightUI_ActorCard", OnCardActive)
  this:RegisterGameEvent("FightUI_AssistEffect", OnAssistEffect)
  this:RegisterGameEvent("FightUI_RefreshEnergyVal", OnRefreshEnergyUI)
  this:RegisterGameEvent("FightUI_SceneAlpha", SetWindowAlpha)
  this:RegisterGameEvent("FightUI_HpChange", OnActorHpChange)
  this:RegisterGameEvent("FightUI_SetBGCamera", OnSetBGCamera)
  this:RegisterGameEvent("FightUI_ShowGameHint", ShowGameHint)
  this:RegisterGameEvent("FightUI_ShowGameRound", ShowGameRound)
  this:RegisterGameEvent("FightBase_ActorDead", OnActorDead)
  this:RegisterGameEvent("OnFightGamePause", OnPauseRecover)
  this:RegisterGameEvent("FightUI_HurtVal", AddHurtVal)
  this:RegisterGameEvent("NetworkChanged", OnNetworkChanged)
  this:RegisterGameEvent("FightUI_EmoteNtf", OnFightEmoteData)
  this:RegisterGameEvent("FightUI_PVPOverType", OnPVPOverType)
  this:RegisterGameEvent("DungeonTeamGroupChatMsg", OnFightSendTalk)
  _ENV["$"](REF.TimeBG).roundEffect.gameObject:SetActive(false)
  REF.FightTip.gameObject:SetActive(false)
  REF.EffectTutorialTip.gameObject:SetActive(false)
  REF.FocusEffect.gameObject:SetActive(false)
  this:Bind("LockInputFlags", UpdateInputLock)
  CS.GameLogic.AddUIEffectToPool("P_CardEffect1", 0, 10)
  CS.GameLogic.AddUIEffectToPool("P_CardEffect3", 0, 10)
  mPauseSignFlags = WU.LockInputFlag.NetworkLoading2 | WU.LockInputFlag.NetworkLoading3
  tutorialVal = this:GetData("CurrentTutorial")
  if tutorialVal == 100 then
    WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, true)
    local pos = REF.WeaponSkills.gameObject.transform.localPosition
    local pos2 = REF.AutoFightRoot.gameObject.transform.localPosition
    REF.WeaponSkills.gameObject.transform.localPosition = {
      x = pos.x,
      y = pos.y - 130,
      z = pos.z
    }
    REF.AutoFightRoot.gameObject.transform.localPosition = {
      x = pos2.x,
      y = pos2.y - 130,
      z = pos2.z
    }
    WU.SetActive(REF.ChangeUI, true)
  end
  if IsTutorialUIFight() then
    this:RegisterGameEvent("Tutorial/StepStart", OnTutorialStart)
  end
  if this:GetData("FightDataRecord") ~= nil then
    mIsRecordGame = true
    m_paramsForAFR.isRecordGame = true
    WU.ToggleRendering(REF.LeftBtnRoot, false)
    WU.ToggleRendering(REF.AutoFightRoot, false)
    WU.ToggleRendering(REF.RecordTip, true)
  end
  REF.NodeEmoji.gameObject:SetActive(false)
  REF.LeftEmojiBg.gameObject:SetActive(false)
  REF.RightEmojiBg.gameObject:SetActive(false)
  if REF.BtnTalk.gameObject.activeSelf then
    local talkData = PB.all("TeamPVETalk")
    REF.TalkContent.UIWrapContent.onInitializeItem = UpdateTalkSlot
    REF.TalkContent.UIWrapContent:UpdateContent(#talkData, true)
  else
    REF.TalkRoot.gameObject:SetActive(false)
  end
  if REF.BtnFace.gameObject.activeSelf then
    local baseInfo = this:GetData("fci/baseinfo/")
    if baseInfo ~= nil then
      REF.GridEmoji.gameObject:SetActive(false)
      this:BindRemote(DB:GameRequest("fci/emoji/"), SetFaceChat)
    else
      SetFaceChat(nil, true)
    end
  end
  if Macro.__IOS then
    local models = PB.all("SpecialDevice"):first().hasBottomLine
    for i = 1, #models do
      if WU.IsDeviceModelOrNot(models[i]) then
        local ref = _ENV["$"](REF.EnergyBarSp)
        ref.EnergyValLabel.UILabel.fontSize = 46
        ref.EnergyValLabel.transform.localPosition = CS.UnityEngine.Vector3(95, 50, 0)
        ref = _ENV["$"](REF.EnergyBarMp)
        ref.EnergyValLabel.UILabel.fontSize = 46
        ref.EnergyValLabel.transform.localPosition = CS.UnityEngine.Vector3(-95, 50, 0)
        break
      end
    end
  end
  TLog.CollectBeginInfo()
end

function UninitWindow()
  this:SetData("FightUI/HudText", nil)
  this:SetData("FightUI/Position", nil)
  this:SetData("FightUI/FightTalk", nil)
  this:SetData("Fight/SelfTeamInfo", nil)
  this:SetData("ChatRoom/ShowChatGroup", false)
  this:SetData("FightAutoSettingPlayer", nil)
  this:SetData("FightCommandSettingPlayer", nil)
  this:SetData("FightAutoSettingTeam", nil)
  fightInstance = nil
  sceneInstance = nil
  REF.BuffDetailGridScrollView.UIScrollView.onPressedShouldNotMove = nil
  REF.BuffDetailGridScrollView.UIScrollView.onDragFinished = nil
  REF.BuffDetailGridScrollView.UIScrollView.onDragStarted = nil
  REF.BuffDetailGridScrollView.UIScrollView.onStoppedMoving = nil
end

function UpdateInputLock(flags)
  flags = flags or 0
  if flags & mPauseSignFlags ~= 0 then
    OnNetworkChanged(false)
  else
    OnNetworkChanged(true)
  end
end

function OnNetworkChanged(reachable)
  if sceneInstance == nil then
    return
  end
  if reachable then
    if mNetPauseState == 1 then
      mNetPauseState = 0
      sceneInstance:PauseGame(false)
    end
  elseif not sceneInstance:IsGamePause() then
    m_preTimeScale = 1
    sceneInstance:PauseGame(true)
    mNetPauseState = 1
  end
end

function UpdateWindow(delta)
  m_groupChatInterval = m_groupChatInterval + delta
  UpdateBtnPos(delta)
  UpdateHurtVal(delta)
  if __EditorMode and m_debugMode then
    WU.SetActive(REF.DebugActorState, CS.FightConfig.Instance.debugActorState)
  end
  if EnableUpdateUI() == false then
    return
  end
  CheckAnimState(delta)
  UpdateRoundTime(delta)
  UpdateCardIntroEffect(delta)
  UpdateCardHide(delta)
  UpdateBuffDetail(delta)
  UpdateSkillTip(delta)
  UpdateEffect2Pause(delta)
end

function LateUpdateWindow(delta)
  if EnableUpdateUI() == false then
    return
  end
  refreshDelay = refreshDelay + delta
  if 0.1 <= refreshDelay then
    refreshDelay = 0.0
  else
    return
  end
end

function IsTutorialUIFight()
  if tutorialVal == 2 or tutorialVal == 3 or tutorialVal == 8 or tutorialVal == 9 or tutorialVal == 10 or tutorialVal == 21 or tutorialVal == 22 or tutorialVal == 27 or tutorialVal == 24 or tutorialVal == 25 or tutorialVal == 26 or tutorialVal == 41 or tutorialVal == 100 or tutorialVal == 56 or m_tutorialManager.IsTrainingTutorial(tutorialVal) then
    return true
  end
  return false
end

function HideAllSmallWindow()
  HideUIBuffDetailBg(nil)
  HideSkillTip()
  REF.NodeEmoji.gameObject:SetActive(false)
  REF.TalkRoot.gameObject:SetActive(false)
end

function SetWindowAlpha(val, kind)
  if kind == 0 then
    HideAllSmallWindow()
    CS.UIWindowHelp.ChangeUIWidgetAlpha(mStateWidget, val)
    CS.UIWindowHelp.ChangeUIWidgetAlpha(mLeftBtnRoot, val)
    CS.UIWindowHelp.ChangeUIWidgetAlpha(mBottomBtnRoot, val)
    CS.UIWindowHelp.ChangeUIWidgetAlpha(REF.BtnPause.UISprite, val)
    WU.ToggleRendering(REF.Bottom, val ~= 0)
  elseif kind == 1 then
    warning("GamePlay", "can not use this kind")
  else
    return
  end
end

function ShowGameHint()
  local step
  local hint_text = ""
  local showPauseTip = false
  if DB:GetData("playerId") then
    showPauseTip = not WU.GetGameDataCache("PauseShowBefore" .. DB:GetData("playerId")) and not IsTutorialUIFight()
  end
  if m_dungeonMonster ~= nil and m_dungeonMonster.hintShow == 1 then
    local fightActiveData = m_fightLuaRef.MainLogic["$fightActiveData"]()
    local selfTeamInfo = FH.getTeamInfo(fightActiveData.teamList, CS.FightLuaLogic.Instance.SelfTeam)
    if dungeonType == PB.enum.DungeonType.Gold and #selfTeamInfo.winParam < 4 then
      hint_text = WU.GetString("WinType_GOLD", selfTeamInfo.winParam[2], selfTeamInfo.winParam[3])
    elseif #selfTeamInfo.winParam > 0 then
      local winTypeIndex = table.find(selfTeamInfo.winParam, function(_, v)
        return v ~= 0
      end)
      local winType = selfTeamInfo.winParam[winTypeIndex]
      local p2 = selfTeamInfo.winParam[winTypeIndex + 1]
      local p3 = selfTeamInfo.winParam[winTypeIndex + 2]
      if winType == PB.enum.WinType.KillSingle or winType == PB.enum.WinType.KillSingleInRound or winType == PB.enum.WinType.NoDeadSingle or winType == PB.enum.WinType.NoDeadSingleInRound then
        hint_text = WU.GetString("WinType_" .. winType .. "_" .. p2, p2, p3)
      else
        hint_text = WU.GetString("WinType_" .. winType, p2, p3)
      end
    end
  end
  this:DelayInvokeInScaledSeconds(0.3, function()
    ShowHintUI(step, hint_text, function()
      if showMonsterId then
        REF.FocusEffect.gameObject:SetActive(true)
        REF.FocusEffect.transform.localPosition = REF["Pos" .. showMonsterIndex].transform.localPosition
        this:DelayInvokeInSeconds(1, function()
          WU.AcquireWindowAsync("MonsterIntro", function(ui)
            _ENV["$"](ui)["$$SetData"](showMonsterId, function()
              fightInstance:SetRoundStep(CS.RoundStep.RoundBuff)
            end)
            REF.FocusEffect.gameObject:SetActive(false)
          end)
        end)
      end
      if hint_text ~= "" then
        mEffectFly = true
        mflyRoutine = WU.TranslatePrepare(REF.TipEffectStar, "FightRound", "BtnPause", 0.37)
        REF.TipEffectStar.gameObject:SetActive(true)
        this:DelayInvokeInScaledSeconds(0.37, function()
          mEffectFly = false
          REF.EffectPause.gameObject:SetActive(true)
          REF.TipEffectStar.gameObject:SetActive(false)
          REF.EffectTutorialTip.gameObject:SetActive(showPauseTip)
          this:DelayInvokeInSeconds(3, function()
            REF.EffectTutorialTip.gameObject:SetActive(false)
          end)
        end)
      end
    end)
    REF.NodeAura.gameObject:SetActive(false)
    local auraInfo = this:GetData("FightInfo/Aura")
    if auraInfo and auraInfo.actorId and auraInfo.quality then
      local actorConfig = PB.get("ActorConfig", auraInfo.actorId)
      local actorQualityInfo = PB.get("ActorQualityInfo", auraInfo.actorId, auraInfo.quality)
      local auraText, attrType = AU.RenderAuraOrMedalAttr(actorQualityInfo, true, nil, nil, true, true)
      REF.NodeAura.gameObject:SetActive(true)
      REF.ActorAuraBg.UISprite.spriteName = "sub_friend_bg_" .. auraInfo.quality
      REF.LabelAura.UILabel.text = auraText
      REF.ActorAuraHead.UITexture.mainTexturePath = "Texture/ActorInfightHead/sub_2/infight_head_" .. actorConfig.animRes
      REF.WidgetAuraAlpha.TweenAlpha:SetOnFinished(function()
        REF.NodeAura.gameObject:SetActive(false)
        REF.NodeAuraEffect.gameObject:SetActive(false)
      end)
      local attr2Index = {}
      local showCount = 0
      attr2Index[PB.enum.AttrType.Penetration] = 1
      attr2Index[PB.enum.AttrType.PenetrationRate] = 1
      attr2Index[PB.enum.AttrType.Attack] = 1
      attr2Index[PB.enum.AttrType.AttackRate] = 1
      attr2Index[PB.enum.AttrType.PhysicalDefense] = 2
      attr2Index[PB.enum.AttrType.PhysicalDefenseRate] = 2
      attr2Index[PB.enum.AttrType.MagicalDefense] = 2
      attr2Index[PB.enum.AttrType.MagicalDefenseRate] = 2
      attr2Index[PB.enum.AttrType.Hp] = 3
      attr2Index[PB.enum.AttrType.HpRate] = 3
      for i = 1, #mPlayerActorStateList do
        if 0 < mPlayerActorStateList[i].uniqueID then
          showCount = showCount + 1
        end
      end
      WU.TraverseChildren(REF.NodeAuraEffect, function(go, index)
        local ref = _ENV["$"](go)
        local realIdx = index + 1
        local postFix = attr2Index[attrType] or 1
        ref.root.EffectGenerator.m_EffectName = "UI_FSbuff_0" .. postFix
        ref.root.gameObject:SetActive(4 - realIdx <= showCount)
      end)
    end
  end)
end

function ShowGameRound(round)
  if round == 1 then
    _ENV["$"](REF.TimeBG).roundVal.UILabel.text = tostring(round)
    if tutorialVal == 100 then
      REF.ChangeUI.TweenPosition:SetOnFinished(function()
        REF.Bottom.UIPlayTween:Play(true)
      end)
      REF.ChangeUI.TweenPosition:ResetToBeginning()
      REF.ChangeUI.TweenPosition:PlayForward()
    end
    if not CS.SceneFight.s_Standalone and dungeonType == PB.enum.DungeonType.Normal and m_dungeonMonster then
      local chapterId = this:GetData("WindowDungeon/ChapterId")
      local dungeonRecord = this:GetData("fci/dungeon/chapter/" .. chapterId).recordDungeons[dungeonId]
      if not dungeonRecord or #dungeonRecord.targetsDone == 0 then
        showMonsterIndex = m_dungeonMonster.showMonsterIndex
        if showMonsterIndex and 0 < showMonsterIndex then
          showMonsterId = m_dungeonMonster.monsterId[showMonsterIndex]
          if showMonsterId then
            fightInstance:SetRoundStep(CS.RoundStep.None)
          end
        end
      end
    end
  else
    m_roundChanged = true
    _ENV["$"](REF.TimeBG).roundEffect.gameObject:SetActive(false)
    _ENV["$"](REF.TimeBG).roundEffect.gameObject:SetActive(true)
    _ENV["$"](REF.TimeBG).roundVal.TweenScale:ResetToBeginning()
    _ENV["$"](REF.TimeBG).roundVal.TweenScale:PlayForward()
    _ENV["$"](REF.TimeBG).roundVal.TweenScale:SetOnFinished(function()
      _ENV["$"](REF.TimeBG).roundVal.UILabel.text = tostring(round)
    end)
    if Macro.__IOS then
      local preferences = m_configDataManager.GetPreferences()
      if preferences.isPoorDevice then
        local clearCount = CS.EffectPoolManager.Instance:GetTemperoryEffectCount()
        if round == 2 or 10 <= clearCount then
          CS.EffectPoolManager.Instance:TryToClearTemperoryEffect()
        end
      end
    end
  end
  if m_dungeonMonster ~= nil and m_dungeonMonster.hintShow == 1 then
    local fightActiveData = m_fightLuaRef.MainLogic["$fightActiveData"]()
    local selfTeamInfo = FH.getTeamInfo(fightActiveData.teamList, CS.FightLuaLogic.Instance.SelfTeam)
    if #selfTeamInfo.winParam >= 3 then
      local winTypeIndex = table.find(selfTeamInfo.winParam, function(_, v)
        return v ~= 0
      end)
      local winType = selfTeamInfo.winParam[winTypeIndex]
      local p2 = selfTeamInfo.winParam[winTypeIndex + 1]
      local p3 = selfTeamInfo.winParam[winTypeIndex + 2]
      if winType == PB.enum.WinType.KillALLInRound or winType == PB.enum.WinType.KillSingleInRound or winType == PB.enum.WinType.NoDeadAllInRound or winType == PB.enum.WinType.NoDeadSingleInRound or winType == PB.enum.WinType.NoDeadAnyInRound or winType == PB.enum.WinType.DeadAllInRound then
        local left = p3 - round + 1
        if 1 <= left and left <= 3 then
          ShowHintUI(nil, WU.GetString("Gold_RoundTip", left))
        end
      end
    end
  end
end

function ShowHintUI(step, hint_text, callback)
  if step ~= nil or hint_text ~= "" then
    REF.FightTip.gameObject:SetActive(true)
    if step ~= nil then
      REF.TipRoundName1.UISprite.gameObject:SetActive(true)
      REF.TipRoundName2.UISprite.gameObject:SetActive(true)
      REF.TipRoundName3.UISprite.gameObject:SetActive(true)
      REF.TipRoundNum.UISprite.gameObject:SetActive(true)
      REF.TipRoundNum.UISprite.spriteName = "round_" .. step
      REF.TipRoundName1.TweenPosition:ResetToBeginning()
      REF.TipRoundName1.TweenPosition:PlayForward()
      REF.TipRoundName2.TweenPosition:ResetToBeginning()
      REF.TipRoundName2.TweenPosition:PlayForward()
      REF.TipRoundName3.TweenPosition:ResetToBeginning()
      REF.TipRoundName3.TweenPosition:PlayForward()
      REF.TipRoundNum.TweenPosition:ResetToBeginning()
      REF.TipRoundNum.TweenPosition:PlayForward()
      REF.TipLabel.UILabel.text = ""
    else
      REF.TipRoundName1.UISprite.gameObject:SetActive(false)
      REF.TipRoundName2.UISprite.gameObject:SetActive(false)
      REF.TipRoundName3.UISprite.gameObject:SetActive(false)
      REF.TipRoundNum.UISprite.gameObject:SetActive(false)
      REF.TipLabel.UILabel.text = hint_text
      REF.TipLabel.TweenScale:ResetToBeginning()
      REF.TipLabel.TweenScale:PlayForward()
    end
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_DeployComplete")
    if tutorialVal == 9 then
      SendTutorialEvent("Tutorial/StepReady")
    end
    REF.TipRoot.TweenAlpha:ResetToBeginning()
    REF.TipRoot.TweenAlpha:PlayForward()
    REF.TipRoot.TweenAlpha:SetOnFinished(function()
      REF.FightTip.gameObject:SetActive(false)
      if callback then
        callback()
      end
    end)
  elseif callback then
    callback()
  end
end

function InitActorList(list, team1Left, teamInfo1, teamInfo2)
  local fightActiveData = m_fightLuaRef.MainLogic["$fightActiveData"]()
  mIsTeam1Left = team1Left
  local leftTeam = FH.getTeamInfo(fightActiveData.teamList, 1)
  local rightTeam = FH.getTeamInfo(fightActiveData.teamList, 2)
  if not team1Left then
    leftTeam, rightTeam = rightTeam, leftTeam
  end
  local selfTeam = CS.FightLuaLogic.Instance.SelfTeam
  local isSelfTeamLeft = false
  if mIsTeam1Left and selfTeam == 1 or not mIsTeam1Left and selfTeam == 2 then
    isSelfTeamLeft = true
  end
  m_selfTeamInfo = fif(isSelfTeamLeft, leftTeam, rightTeam)
  this:SetData("Fight/SelfTeamInfo", m_selfTeamInfo)
  local mSkillButton = REF.BtnSkill.gameObject
  local max_count = #SkillPosTable
  max_count = 6 + max_count
  max_count = max_count + 9
  for i = 1, max_count do
    local newBtn = CS.UnityEngine.GameObject.Instantiate(mSkillButton, REF.SkillRoot.transform)
    newBtn.name = "BtnSkill_" .. i
    CS.UIWindowHelp.CloneButtonParam(newBtn, mSkillButton)
    local newInfo = CS.UIActorCardButtonInfo()
    newInfo.btn = newBtn
    newInfo:InitEffect(REF.SkillRoot.UIPanel.depth)
    table.insert(mSkillGroupList, newInfo)
  end
  m_paramsForAFR.skillGroupList = mSkillGroupList
  for i = 0, list.Count - 1 do
    local process = list[i]
    local team = process:GetTeam()
    team = GetTeamForUI(team)
    local resultList
    local left = true
    local teamInfo
    if team == 1 then
      left = true
      resultList = mPlayerActorStateList
      teamInfo = leftTeam
    elseif team == 2 then
      left = false
      resultList = mEnemyActorStateList
      teamInfo = rightTeam
    end
    if resultList then
      InitActorState(resultList, process, left, teamInfo)
    end
    if not left then
      TLog.CollectEnemyBaseInfo(i, process)
    end
  end
  local player_table = {}
  for j = 1, #mPlayerActorStateList do
    local btnRef = _ENV["$"](mPlayerActorStateList[j].btn)
    local actor_table = btnRef["$$GetAllActorInfo"]()
    local result = GetGroupTable(leftTeam, actor_table)
    local skill_info = CreateFiveSkill(result[1], {}, true, false)
    btnRef["$$InitAllSkillInfo"](skill_info)
    if #actor_table ~= 0 and EnableAutoSetting() then
      table.insert(player_table, {
        skill_info,
        btnRef["$$GetHeadTexPath"](),
        btnRef["@processSequence"] or 0,
        result,
        btnRef["$$GetUID"]()
      })
    end
  end
  this:SetData("FightAutoSettingPlayer", player_table)
  this:SetData("FightAutoSettingTeam", leftTeam)
  player_table = {}
  for j = 1, #mPlayerActorStateList do
    local btnRef = _ENV["$"](mPlayerActorStateList[j].btn)
    local actor_table = btnRef["$$GetAllActorInfo"]()
    local result = GetGroupTable(leftTeam, actor_table)
    local skill_info = CreateFiveSkill(result[1], {}, true, true)
    if #actor_table ~= 0 and EnableAutoSetting() then
      table.insert(player_table, {
        skill_info,
        btnRef["$$GetHeadTexPath"](),
        btnRef["@processSequence"] or 0,
        result,
        btnRef["$$GetUID"]()
      })
    end
  end
  this:SetData("FightCommandSettingPlayer", player_table)
  if dungeonType == PB.enum.DungeonType.BurstLinkPvp or dungeonType == PB.enum.DungeonType.FriendPvp then
    for j = 1, #mEnemyActorStateList do
      local btnObject = mEnemyActorStateList[j].btn
      local actor_table = _ENV["$"](btnObject)["$$GetAllActorInfo"]()
      local result = GetGroupTable(rightTeam, actor_table)
      local skill_info = CreateFiveSkill(result[1], {}, true, false)
      _ENV["$"](btnObject)["$$InitAllSkillInfo"](skill_info)
    end
  end
  local fightInitInfo = this:GetData("FightInitInfo")
  local deadSeat2ActorId = {}
  if fightInitInfo and m_isDungeonChain then
    local fightActorInfo = this:GetData("FightActorInfo")
    if fightActorInfo then
      local playerId = this:GetData("playerId")
      local actors = {}
      if playerId then
        local _, result = table.find(fightActorInfo, function(_, v)
          return v.playerId == playerId
        end)
        if result then
          actors = result.actors
        end
      end
      for i = 1, #fightInitInfo[selfTeam].hp do
        if 0 > fightInitInfo[selfTeam].hp[i] and actors[i] then
          deadSeat2ActorId[i] = actors[i].id
        end
      end
    elseif CS.SceneFight.s_Standalone then
      for i = 1, #fightInitInfo[selfTeam].hp do
        if 0 > fightInitInfo[selfTeam].hp[i] and fightInitInfo[selfTeam].monsterList[i] then
          deadSeat2ActorId[i] = fightInitInfo[selfTeam].monsterList[i]
        end
      end
    end
  end
  REF.AutoFightRoot["$InitAutoFight"](m_selfTeamInfo, m_dungeonMonster)
  if m_paramsForAFR.weaponUnlocked then
    local weaponInfos = FH.getTeamWeapons({m_selfTeamInfo})
    m_paramsForAFR.weaponBtnInfos = REF.WeaponSkills["$SetWeaponInfo"](weaponInfos)
  end
  HideSelfUI(false)
  local team1Sign = -1
  local team2Sign = team1Sign * -1
  
  local function RefreshActorStatePos(mOffWidth, mBaseLeft, actorStateList, height, sign, deadSeat2ActorId)
    local delCount = 0
    local index = 0
    for i = 1, #actorStateList do
      local info = actorStateList[i]
      local dungeonChainDeadActor = m_isDungeonChain and deadSeat2ActorId and deadSeat2ActorId[i]
      if 0 >= info.uniqueID and not dungeonChainDeadActor then
        WU.ToggleRendering(info.btn, false)
        delCount = delCount + 1
      else
        info.btn.transform.localPosition = Vector3(mBaseLeft + sign * index * mOffWidth, height, 0)
        index = index + 1
      end
    end
    return delCount
  end
  
  RefreshActorStatePos(230, 0, mPlayerActorStateList, 0, team1Sign, deadSeat2ActorId)
  RefreshActorStatePos(230, 0, mEnemyActorStateList, 0, team2Sign, nil)
  for i = 1, 6 do
    if deadSeat2ActorId[i] then
      local uid = DEFINE.GenRoundActorInfoUniqueId(selfTeam, i)
      local halfActorNum = DEFINE.HALF_ACTOR_NUM
      local index = fif(i > halfActorNum, i - halfActorNum, i)
      local uiActorCardButtonInfo = mPlayerActorStateList[index]
      local actorConfig = PB.get("ActorConfig", deadSeat2ActorId[i])
      UITopActorHead(uiActorCardButtonInfo, uid, actorConfig, isSelfTeamLeft, "")
      if actorConfig and actorConfig.kind == PB.enum.ActorType.Main then
        uiActorCardButtonInfo:SetBtnEnable(false)
        _ENV["$"](uiActorCardButtonInfo.btn)["$$SetActorDead"]()
        OnActorHpChange(uid, 0, 0)
      end
    end
  end
  SetRotateState(0)
  if IsTutorialUIFight() then
    REF.BtnChat.gameObject:SetActive(false)
    if tutorialVal == 2 or tutorialVal == 3 then
      WU.ToggleRendering(REF.AutoFightRoot, false)
    end
    if tutorialVal ~= 26 then
      m_paramsForAFR.isAutoFight = false
    end
  end
  REF.AutoFightRoot["$AutoFightRefresh"](tutorialVal)
  if not EnableAttackTimeScale() then
    m_paramsForAFR.isSpeedUp = false
    WU.SetActive(REF.SpeedAdd, false)
    WU.SetActive(REF.SpeedAddPlaceHolder, true)
  else
    if dungeonType == PB.enum.DungeonType.TeamPve or dungeonType == PB.enum.DungeonType.BurstLinkPvp then
      m_paramsForAFR.isSpeedUp = true
    end
    REF.AutoFightRoot["$SpeedUpRefresh"]()
  end
  InitFightCamera()
end

function HideSelfUI(gameEnd)
  if gameEnd then
    mCardActiveState = 0
    mCardHideTime = 0
    WU.ToggleRendering(REF.BtnSwitch, false)
    local chatWindow = WU.FindWindow("ChatRoom")
    if chatWindow ~= nil then
      WU.ToggleRendering(chatWindow, false)
    end
  end
  HideSelfCard()
  HideAllSmallWindow()
end

function HideSelfCard()
  ClearRoundState()
  for i = 1, #mSkillGroupList do
    mSkillGroupList[i]:ClearBtnInfo()
  end
  HideEnergyUI()
  mShowDelayTime = 0
  mCardAnimState = 0
  mActiveUseCard = 0
  mTeamID = 0
  mTeamInfo = nil
  if m_paramsForAFR.weaponUnlocked then
    WU.ToggleRendering(REF.WeaponSkills, false)
  end
end

function OverRound(actorID, card, scard, linkID)
  mCardAnimState = 0
  CS.UIWindowHelp.ChangeUIWidgetEnable(REF.BtnSkipRound.gameObject, false)
  m_paramsForAFR.skipNeedShow = false
  for i = 1, #mSkillGroupList do
    local info = mSkillGroupList[i]
    if info:ShowCard() then
      info.used = false
      if info:HaveCard() then
        if 0 < linkID then
          if info.linkIndex == linkID then
            info.used = true
          end
        elseif info.cardIndex == card and info.scardIndex == scard and info:GetActorRuntimeID() == actorID then
          info.used = true
        end
      end
      info:SetBtnEnable(info.used)
      info:ClearGuideLock()
      m_weaponLock = false
    end
  end
end

function ClearRoundStateEx()
  FixFightCamera(true)
  ClearRoundState()
end

function ClearRoundState()
  SetTimeWindow(false, "text_in_game_fight")
  mRoundTime = 0
end

function SendUseCard(card, scard, linkID, selectList, debug, recordIndex)
  if tutorialVal ~= 9 and tutorialVal ~= 10 then
    if selectList then
      local team, seat = DEFINE.RoundActorInfoUniqueId(selectList[0].ActorRuntimeID)
      if seat <= DEFINE.ACTOR_NUM then
        SendTutorialEvent("Tutorial/StepDone")
      end
    else
      SendTutorialEvent("Tutorial/StepDone")
    end
  end
  local selfTeam = CS.FightLuaLogic.Instance.SelfTeam
  if fightInstance:UseCardsFromlua(mTeamID, card, scard, linkID, selectList, debug) ~= 0 then
    print("GamePlay", "No Match Card")
  elseif mTeamID == selfTeam then
    REF.AutoFightRoot["$RecordSkillIndex"](recordIndex)
  end
end

function ResetRoundTime(time)
  if mRoundSkip then
    return
  end
  if time == 0 or IsTutorialUIFight() then
    return
  end
  mRoundTime = time
  mRoundTimeDelay = 0
  SetTimeWindow(true, time)
end

function SetTimeWindow(isNumber, str)
  local pic = str
  local time = ""
  if isNumber then
    pic = ""
    if 10 <= str then
      time = tostring(str)
    else
      time = "0" .. str
    end
    if str <= 10 then
      REF.roundTime.TweenScale:ResetToBeginning()
      REF.roundTime.TweenScale:PlayForward()
    end
  end
  _ENV["$"](REF.TimeBG).roundTime.UILabel.text = time
  _ENV["$"](REF.TimeBG).roundSprite.UISprite.spriteName = pic
end

function OnRefreshEnergyUI(teamInfo, effect, sequenceActor)
  if effect then
    RecordVideoInfo(teamInfo)
  end
  local energyVal = FH.getCurEnergy(teamInfo, dungeonType, sequenceActor)
  if energyVal[1] ~= m_lastEnergyMP then
    m_lastEnergyMP = m_lastEnergyMP or 0
    OnEnergyAnimBegin(energyVal[1], m_lastEnergyMP, m_defineParams.maxMp, _ENV["$"](REF.EnergyBarMp))
    m_lastEnergyMP = energyVal[1]
  end
  if energyVal[2] ~= m_lastEnergySP then
    m_lastEnergySP = m_lastEnergySP or 0
    OnEnergyAnimBegin(energyVal[2], m_lastEnergySP, m_defineParams.maxSp, _ENV["$"](REF.EnergyBarSp))
    m_lastEnergySP = energyVal[2]
  end
  if m_paramsForAFR.weaponUnlocked then
    local weaponInfos = FH.getTeamWeapons({teamInfo})
    m_tempEnergyInfo = REF.WeaponSkills["$PlayEffectEnergy"](weaponInfos)
  end
end

function RecordVideoInfo(teamInfo)
  if PU.IsRecordVideoSwitchOn() and teamInfo.useCardList[1] then
    local assistId = 0
    local newRecord = {}
    newRecord.startTime = CS.GameJoy.getSystemCurrentTimeMillis
    if teamInfo.useLinkID and 0 < teamInfo.useLinkID then
      newRecord.linkId = teamInfo.useLinkID
      newRecord.mainActorId = teamInfo.useCardList[1].actorID
    elseif teamInfo.useCardList[1].assist == false and 1 <= teamInfo.useSCard then
      newRecord.mainActorId = teamInfo.useCardList[1].actorID
      newRecord.useIndex = teamInfo.useSCard
    end
    if newRecord.mainActorId then
      for i, v in ipairs(teamInfo.activeList) do
        if 103 < v then
          for i2, player in ipairs(teamInfo.playerList) do
            for i3, actor in ipairs(player.actorList) do
              if actor.uniqueID == v then
                assistId = actor.actorInfo.id
                newRecord.subActorId = assistId
                break
              end
            end
          end
        end
      end
      newRecord.round = teamInfo.statistic.gameRound
      this:SetData("RecordVideoData", newRecord)
    end
  end
end

function OnEnergyAnimBegin(val, lastVal, max, ref)
  local diff = val - lastVal
  local fromFill = lastVal / max
  local toFill = val / max
  if 0 < diff then
    ref.EnergyValLabel.UILabel.text = string.format("+%d", math.floor(diff))
    ref.EnergyValColor.TweenFillAmount.from = fromFill
    ref.EnergyValColor.TweenFillAmount.to = toFill
    ref.EnergyValWhite.TweenFillAmount.from = fromFill
    ref.EnergyValWhite.TweenFillAmount.to = toFill
    ref["$UIPlayTween"]:Play(true)
    ref.EffectEnergy.EffectGenerator:Play()
  elseif diff <= 0 then
    ref.EnergyValLabel.UILabel.text = val
    ref.EnergyValColor.UISprite.fillAmount = toFill
    ref.EnergyValWhite.UISprite.fillAmount = toFill
  end
end

function HideEnergyUI()
  WU.ToggleRendering(REF.EnergyBarSp, false)
  WU.ToggleRendering(REF.EnergyBarMp, false)
  WU.ToggleRendering(REF.SkillCircleBg, false)
end

function ShowSkill()
  CS.TweenAlpha.Begin(REF.EnergyBarSp.gameObject, 0.2, 1.0)
  CS.TweenAlpha.Begin(REF.EnergyBarMp.gameObject, 0.2, 1.0)
  CS.TweenAlpha.Begin(REF.SkillCircleBg.gameObject, 0.2, 1.0)
  WU.ToggleRendering(REF.EnergyBarSp, true)
  WU.ToggleRendering(REF.EnergyBarMp, true)
  WU.ToggleRendering(REF.SkillCircleBg, true)
  if m_paramsForAFR.weaponUnlocked and mTeamInfo.team == m_selfTeamInfo.team then
    CS.TweenAlpha.Begin(REF.WeaponSkills.gameObject, 0.2, 1.0)
    WU.ToggleRendering(REF.WeaponSkills, true)
    if m_useCountNotFull and m_roundChanged then
      REF.EffectUseCountRefresh.EffectGenerator:Play()
      m_useCountNotFull = false
      m_roundChanged = false
    end
  end
  m_paramsForAFR.skipNeedShow = true
  if not m_paramsForAFR.isAutoFight then
    CS.UIWindowHelp.ChangeUIWidgetEnable(REF.BtnSkipRound.gameObject, true)
  end
end

function CreateSkill(teamInfo, sequenceActor)
  FixFightCamera(false)
  local delayTime = teamInfo.cardShowDelay
  if delayTime < 0 then
    return
  end
  HideSkillTip()
  if m_paramsForAFR.weaponUnlocked then
    local weaponInfos = FH.getTeamWeapons({teamInfo})
    REF.WeaponSkills["$RefreshWeaponInfo"](weaponInfos, teamInfo)
  end
  OnRefreshEnergyUI(teamInfo, false, sequenceActor)
  mTeamID = teamInfo.team
  mTeamInfo = teamInfo
  mSequenceActor = sequenceActor
  m_paramsForAFR.teamInfo = teamInfo
  m_paramsForAFR.sequenceActor = sequenceActor
  mCardAnimState = 2
  mRoundSkip = false
  local cardTime = math.floor(delayTime / 1000)
  mShowDelayTime = math.max(cardTime, 0.01)
  mCardActiveState = 0
  mCardHideTime = 0
  skipGuideLock = false
  local result = GetGroupTable(teamInfo, teamInfo.activeList, true)
  local group_table = result[1]
  mCurTotalStar = result[2]
  if #group_table == 0 then
    warning("GamePlay", "empty skill " .. #teamInfo.activeList)
    for j = 1, #teamInfo.activeList do
      warning("GamePlay", teamInfo.activeList[j])
    end
  end
  local card_hand = teamInfo.cardsInHand
  local actor_skill = CreateFiveSkill(group_table, card_hand, false, true)
  if this:GetData("fci/baseinfo/") == nil then
    for i = 1, #group_table do
      local actor = group_table[i][1]
      local uid = actor.uniqueID
      local id = actor.actorInfo.id
      local link = group_table[i][2]
      if link == 0 then
        local startIndex = 2
        local sStartIndex = 1
        local dis_add = 0
        if not actor.isAssist then
          startIndex = 3
          sStartIndex = 2
          dis_add = 1
        end
        for j = startIndex, 9 do
          local skill_info = PB.get("ActorCombo", id, j, 0)
          if skill_info ~= nil and skill_info.placeIndex == 0 then
            CheckSkillInfo(actor_skill, actor, GetCardList(card_hand, uid, id, false, 0, j, nil), id, j, 0, j + dis_add, "empty")
          end
        end
        for k = sStartIndex, 9 do
          local skill_info = PB.get("ActorCombo", id, 0, k)
          if skill_info ~= nil and skill_info.placeIndex == 0 then
            CheckSkillInfo(skill_table, actor, GetCardList(card_hand, uid, id, true, 0, k, nil), id, 0, k, 3, "empty")
          end
        end
      end
    end
  end
  SetSkillGroupInfo(actor_skill, teamInfo)
end

function GetGroupTable(teamInfo, activeList)
  local group_table = {}
  local link_table = {}
  local total_star = 0
  if teamInfo then
    local player_id = ""
    for i = 1, #teamInfo.playerList do
      local actorList = teamInfo.playerList[i].actorList
      local link_list = teamInfo.linkInfoList
      for k = 1, #actorList do
        for j = 1, #activeList do
          if activeList[j] == actorList[k].uniqueID then
            player_id = teamInfo.playerList[i].playerId
            if not actorList[k].isAssist then
              mActiveUseCard = actorList[k].lastUseCard
            end
            table.insert(group_table, {
              actorList[k],
              0
            })
            for d = 1, #link_list do
              if 0 < link_list[d].linkID and link_list[d].ownerSeat == actorList[k].baseSeat then
                table.insert(link_table, {
                  actorList[k],
                  link_list[d].linkID
                })
                total_star = link_list[d].totalStar
                break
              end
            end
          end
        end
      end
    end
    for i = 1, #link_table do
      table.insert(group_table, link_table[i])
    end
  end
  return {group_table, total_star}
end

function CreateFiveSkill(group_table, card_hand, onlyShow, changeSkill)
  local skill_table = {}
  for i = 1, #group_table do
    local actor = group_table[i][1]
    local uid = actor.uniqueID
    local id = actor.actorInfo.id
    local link = group_table[i][2]
    if link == 0 then
      if actor.isAssist then
        CheckSkillInfo(skill_table, actor, GetCardList(card_hand, uid, id, false, 0, 1, onlyShow), id, 1, 0, 1)
      else
        CheckSkillInfo(skill_table, actor, GetCardList(card_hand, uid, id, false, 0, 1, onlyShow), id, 1, 0, 1)
        CheckSkillInfo(skill_table, actor, GetCardList(card_hand, uid, id, false, 0, 2, onlyShow), id, 2, 0, 2)
        CheckSkillInfo(skill_table, actor, GetCardList(card_hand, uid, id, true, 0, 1, onlyShow), id, 0, 1, 3)
      end
    else
      CheckLinkInfo(skill_table, actor, GetCardList(card_hand, uid, id, false, link, 0, onlyShow), link)
    end
  end
  if #group_table == 1 or #group_table == 2 then
    if #group_table == 1 then
      table.insert(skill_table, {
        {},
        0,
        0,
        0,
        nil,
        "",
        "",
        1,
        false,
        false
      })
    end
    table.insert(skill_table, {
      {},
      0,
      0,
      0,
      nil,
      "",
      "",
      1,
      false,
      false
    })
  end
  if changeSkill then
    for i = 1, #group_table do
      local actor = group_table[i][1]
      local uid = actor.uniqueID
      local id = actor.actorInfo.id
      local link = group_table[i][2]
      if link == 0 then
        local startIndex = 2
        local sStartIndex = 1
        local dis_add = 0
        if not actor.isAssist then
          startIndex = 3
          sStartIndex = 2
          dis_add = 1
        end
        local n_Count = 0
        for j = startIndex, 9 do
          local skill_info = PB.get("ActorCombo", id, j, 0)
          if skill_info ~= nil and 0 < skill_info.placeIndex then
            CheckSkillInfo(skill_table, actor, GetCardList(card_hand, uid, id, false, 0, j, onlyShow), id, j, 0, j + dis_add)
            n_Count = n_Count + 1
          end
        end
        for k = sStartIndex, 9 do
          local skill_info = PB.get("ActorCombo", id, 0, k)
          if skill_info ~= nil and 0 < skill_info.placeIndex then
            CheckSkillInfo(skill_table, actor, GetCardList(card_hand, uid, id, true, 0, k, onlyShow), id, 0, k, k + 1 + 1 + n_Count)
          end
        end
      end
    end
  end
  return skill_table
end

function SetSkillGroupInfo(info_table, teamInfo)
  mHaveSkill = true
  local skillList = mSkillGroupList
  for i = 1, #skillList do
    skillList[i]:ClearBtnInfo()
  end
  local base_skill_count = 0
  for i = 1, #info_table do
    skillList[i].showCard = true
    for c = 1, #info_table[i][1] do
      skillList[i]:AddCard(info_table[i][1][c])
    end
    local isLock = skillList[i]:IsLocked()
    if isLock then
      mHaveSkill = false
    end
    skillList[i].support = info_table[i][10]
    if not skillList[i].support then
      base_skill_count = base_skill_count + 1
    elseif not mHaveSkill then
      skillList[i].manualLock = true
      isLock = true
    end
    skillList[i].cardIndex = info_table[i][2]
    skillList[i].scardIndex = info_table[i][3]
    skillList[i].linkIndex = info_table[i][4]
    local ref_btn = _ENV["$"](skillList[i].btn)
    local tex_path = info_table[i][5]
    local have_card = skillList[i]:HaveCard()
    ref_btn.SkillIconTexture.UITexture.mainTexturePath = tex_path
    ref_btn.SkillIconTexture.gameObject:SetActive(tex_path ~= nil)
    ref_btn.SkillDescribe.UISprite.spriteName = info_table[i][6]
    ref_btn.SkillDescribe.gameObject:SetActive(have_card)
    if 0 < info_table[i][3] then
      ref_btn.SkillBg.UISprite.spriteName = "fight_skill_bg_2"
    else
      ref_btn.SkillBg.UISprite.spriteName = "fight_skill_bg_1"
    end
    if not have_card then
      ref_btn.SkillBg.UISprite.spriteName = "fight_skill_bg_3"
    end
    ref_btn.SkillBg.UISprite:MakePixelPerfect()
    if skillList[i].support then
      local use_count = info_table[i][11]
      if use_count ~= nil and 0 < use_count and use_count < 100 then
        ref_btn.SkillUseLabel.UILabel.text = use_count
      else
        ref_btn.SkillUseLabel.UILabel.text = ""
      end
    else
      ref_btn.SkillUseLabel.UILabel.text = ""
    end
    local num = info_table[i][7]
    ref_btn.SkillEnergyLabel.UILabel.text = num
    if info_table[i][8] == 1 then
      ref_btn.SkillEnergyLabel.UILabel.color = CS.NGUIMath.HexToColor(16777215)
    elseif info_table[i][8] == 2 then
      ref_btn.SkillEnergyLabel.UILabel.color = CS.NGUIMath.HexToColor(4294902015)
    end
    local use_enable = info_table[i][9]
    skillList[i]:SetBtnEnable(use_enable)
    if use_enable then
      ref_btn.SkillIconTexture.UITexture.color = CS.NGUIMath.HexToColor(4294967295)
      ref_btn.SkillDescribe.UISprite.color = CS.NGUIMath.HexToColor(4294967295)
    else
      ref_btn.SkillIconTexture.UITexture.color = CS.NGUIMath.HexToColor(2021161160)
      ref_btn.SkillDescribe.UISprite.color = CS.NGUIMath.HexToColor(2021161160)
    end
    ref_btn.SkillLock.gameObject:SetActive(isLock)
    ref_btn.SkillSetting.gameObject:SetActive(false)
    skillList[i]:SetBtnActive(true)
  end
  RefreshActorBtnPos(skillList, base_skill_count, 1)
  SwitchBtnPos(skillList, teamInfo)
  REF.AutoFightRoot["$RefreshAutoFightSetting"]()
  PlaySkillBtnIntroEffect()
end

function SwitchBtnPos(infoList, teamInfo)
  local same_place = {}
  for i = 1, #infoList do
    local info = infoList[i]
    if info:ShowCard() and not info.support and (info.cardIndex > 0 or 0 < info.scardIndex) then
      local temp_index = info:GetActorID()
      if info.linkIndex ~= 0 then
        temp_index = info.linkIndex
      end
      local skill_info = PB.get("ActorCombo", temp_index, info.cardIndex, info.scardIndex)
      if skill_info ~= nil and 0 < skill_info.placeIndex then
        local temp_key = temp_index .. "," .. skill_info.placeIndex
        if same_place[temp_key] == nil then
          same_place[temp_key] = {info}
        else
          table.insert(same_place[temp_key], info)
        end
      end
    end
  end
  for k, v in pairs(same_place) do
    if 1 < #v then
      local selectIndex = GetSkillInGroup(v, teamInfo)
      for j = 1, #v do
        if j == selectIndex then
          local pos_index = 4
          local temp_index = v[j]:GetActorID()
          if v[j].linkIndex ~= 0 then
            temp_index = v[j].linkIndex
          end
          local skill_info = PB.get("ActorCombo", temp_index, v[j].cardIndex, v[j].scardIndex)
          local actorConfig = PB.get("ActorConfig", temp_index)
          if actorConfig.kind == 1 then
            pos_index = skill_info.placeIndex
          end
          local curPos = SkillPosTable[pos_index]
          v[j].baseX = curPos[1]
          v[j].baseY = curPos[2]
        else
          v[j].baseX = 0
          v[j].baseY = -1200
        end
        v[j]:SetBtnPosition()
      end
    end
  end
end

function RefreshActorBtnPos(infoList, totalNum, sign)
  local pos_table = SkillPosTable
  totalNum = totalNum - #pos_table
  local SKILL_WIDTH = 170
  local mBaseLeft = -(totalNum - 1) * SKILL_WIDTH / 2 * sign
  local index = 0
  local support_index = 0
  for i = 1, #infoList do
    local info = infoList[i]
    info.btn.transform.localScale = Vector3(1, 1, 1)
    if info:ShowCard() then
      if info.support then
        support_index = support_index + 1
        local curPos = SupportPosTable[support_index]
        if curPos ~= nil then
          info.baseX = curPos[1]
          info.baseY = curPos[2]
        end
        info.btn.transform.localScale = Vector3(0.65, 0.65, 1)
      else
        local curPos = pos_table[i]
        if curPos ~= nil then
          info.baseX = curPos[1]
          info.baseY = curPos[2]
        else
          info.baseX = mBaseLeft + index * sign * SKILL_WIDTH
          info.baseY = -1000
          index = index + 1
        end
      end
      info:SetBtnPosition()
    else
      info:HideBtn()
    end
  end
end

function PlaySkillBtnIntroEffect()
  local index = 0
  for i = 1, #mSkillGroupList do
    local info = mSkillGroupList[i]
    if info:ShowCard() then
      local tempTime = 0.06
      local delay = tempTime
      info:HideBtn()
      info.introTime = delay
      info.btn.transform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 90, 0)
      index = index + 1
    end
  end
end

function GetCardList(cardHandList, uid, id, sCard, link, index, onlyShow)
  if onlyShow then
    return {
      {uid, id}
    }
  end
  local list = {}
  for c = 1, #cardHandList do
    if cardHandList[c].actorRuntimeID == uid and cardHandList[c].sCard == sCard and cardHandList[c].linkID == link then
      local match = false
      if index ~= nil then
        if cardHandList[c].skillIndex == index then
          match = true
        end
      else
        match = true
      end
      if match and cardHandList[c].useCount > 0 and not cardHandList[c].dead then
        table.insert(list, cardHandList[c])
        break
      end
    end
  end
  return list
end

function IsActorHaveSkill(actor, skill_info)
  if skill_info == nil then
    return false
  else
    for i = 1, #skill_info.skillList do
      local needSkillID = skill_info.skillList[i]
      local find = false
      for j = 1, #actor.actorInfo.skills do
        if actor.actorInfo.skills[j].id == needSkillID then
          find = true
          break
        end
      end
      if not find then
        return false
      end
    end
    return true
  end
end

function CheckSkillInfo(info_table, actor, card_list, id, card, scard, displayIndex, empty)
  local skill_info = PB.get("ActorCombo", id, card, scard)
  if 0 < #card_list and IsActorHaveSkill(actor, skill_info) then
    local texturePath = "Texture/ActorSkill/actor_skill_" .. id .. string.format("%02d", displayIndex)
    table.insert(info_table, GetSkillInfo(card_list, texturePath, actor, card, scard, 0, skill_info))
  elseif empty == nil then
    table.insert(info_table, {
      {},
      card,
      scard,
      actor.actorInfo.id,
      nil,
      "",
      "",
      1,
      false,
      actor.baseSeat > 6
    })
  end
end

function CheckLinkInfo(info_table, actor, card_list, link)
  if 0 < #card_list then
    local texturePath = "Texture/ActorRelationSkill/actor_relation_" .. link
    local link_info = PB.get("ActorLink", link)
    if this:GetData("fci/baseinfo/") == nil then
      table.insert(info_table, GetSkillInfo(card_list, texturePath, actor, 0, 0, link, link_info))
    elseif U.IsTimeOpen(link_info.openTime) then
      table.insert(info_table, GetSkillInfo(card_list, texturePath, actor, 0, 0, link, link_info))
    else
      table.insert(info_table, {
        {},
        0,
        0,
        0,
        nil,
        "",
        "",
        1,
        false,
        false
      })
    end
  else
    table.insert(info_table, {
      {},
      0,
      0,
      0,
      nil,
      "",
      "",
      1,
      false,
      false
    })
  end
end

function GetSkillInfo(card_list, texturePath, actor, card, scard, link, skillInfo)
  local cost_val = 0
  local check_energy = 0
  local display_kind = 1
  if 0 < skillInfo.costSp then
    cost_val = skillInfo.costSp
    local sp_change = FH.getCostChangeByBuff(actor, card, scard, link, "sp")
    cost_val = math.max(0, cost_val + sp_change)
    check_energy = m_lastEnergySP or 0
    display_kind = 2
  else
    cost_val = skillInfo.costMp
    local mp_change = FH.getCostChangeByBuff(actor, card, scard, link, "mp")
    cost_val = math.max(0, cost_val + mp_change)
    check_energy = m_lastEnergyMP or 0
    display_kind = 1
  end
  local card_enable = cost_val <= tonumber(check_energy)
  local use_count = 0
  if card_list ~= nil and 0 < #card_list then
    use_count = card_list[1].useCount
  end
  return {
    card_list,
    card,
    scard,
    link,
    texturePath,
    skillInfo.kindIcon,
    cost_val,
    display_kind,
    card_enable,
    actor.baseSeat > 6,
    use_count
  }
end

function OnActorDead(id, step)
  if step <= 0 and not CheckActorStateDead(mPlayerActorStateList, id, step) and not CheckActorStateDead(mEnemyActorStateList, id, step) then
    warning("GamePlay", id)
  end
end

function CheckActorStateDead(actorStateList, id, step)
  local en = false
  if step < 0 then
    en = true
  end
  for j = 1, #actorStateList do
    if actorStateList[j].uniqueID == id then
      actorStateList[j]:SetBtnEnable(en)
      local btnObject = actorStateList[j].btn
      if not en then
        _ENV["$"](btnObject)["$$SetActorDead"]()
      end
      return true
    end
  end
  return false
end

function OnActorHpChange(uniqueID, percentage, curHp)
  if not CheckActorHp(mPlayerActorStateList, uniqueID, percentage, curHp) and not CheckActorHp(mEnemyActorStateList, uniqueID, percentage, curHp) then
    warning("GamePlay", uniqueID)
  end
end

function CheckActorHp(actorStateList, uniqueID, percentage, curHp)
  for i = 1, #actorStateList do
    local info = actorStateList[i]
    if info.uniqueID == uniqueID then
      _ENV["$"](info.btn).val.UISprite.fillAmount = percentage
      _ENV["$"](info.btn).text.UILabel.text = curHp
      this:SetData("FightUIActorHP_" .. uniqueID, percentage)
      return true
    end
  end
  return false
end

function OnSetBGCamera(show)
  local y = 466
  if show then
    y = y + BGCameraY
  end
  local box_y = CS.UnityEngine.Vector2(0, BGCameraY)
  if show then
    box_y = CS.UnityEngine.Vector2(0, 0)
  end
  REF.TimeBG.BoxCollider2D.offset = box_y
  REF.InfoRoot.transform.localPosition = Vector3(0, y, 0)
  this:BroadcastGameEvent("OnRoleUIPosChange", show)
  if show then
    SetAttackTimeScale(false)
  else
    SetAttackTimeScale(true)
  end
end

function EnableAutoSetting()
  if tutorialVal == 25 or tutorialVal == 26 then
    return true
  end
  if CS.GameLogic.IsLocalMode() and EnablePause() and not IsTutorialUIFight() and not mIsRecordGame then
    return true
  end
  return false
end

function EnablePause()
  if tutorialVal == 2 or tutorialVal == 3 or m_tutorialManager.IsTutorialUIShowing() then
    return false
  end
  return true
end

function OnButtonPause(obj, windowName)
  local ui
  if EnablePause() and sceneInstance:EnablePauseGame() then
    m_preTimeScale = CS.GameTime.timeScale
    sceneInstance:PauseGame(true)
    HideAllSmallWindow()
    ui = WU.AcquireWindow(windowName)
  end
  return ui
end

function OnBtnSwitch(obj)
  if mLeftBtnRoot.alpha ~= 1 then
    return
  end
  if mRotateDir ~= 0 then
    mRotateDir = -mRotateDir
  elseif mRotateState == 0 then
    mRotateDir = 1
  elseif mRotateState == 1 then
    mRotateDir = -1
  end
end

function SetRotateState(state)
  mRotateState = state
  mRotateDir = 0
  if state == 0 then
    REF.SwitchIcon.transform.localRotation = CS.UnityEngine.Quaternion.identity
    mRotateCurTime = 0
  elseif state == 1 then
    REF.SwitchIcon.transform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, 90)
    mRotateCurTime = mRotateTotalTime
  end
end

function OnBtnChat(obj)
  if sceneInstance:EnablePauseGame() and mStateWidget.alpha == 1 then
    local baseInfo = this:GetData("fci/baseinfo/")
    if baseInfo ~= nil and not WU.WindowIsLocked(PB.enum.UnlockWindow.ChatRoom, PB.enum.UnlockWindow.ChatRoom) then
      HideAllSmallWindow()
      this:SetData("ApplyChatRoomHyperLink", false)
      if dungeonType == PB.enum.DungeonType.TeamPve then
        this:SetData("ChatRoom/ShowChatGroup", true)
      end
      WU.AcquireWindowAsync("ChatRoom", function(ui)
        if dungeonType == PB.enum.DungeonType.TeamPve then
          _ENV["$"](ui)["$$SetChannelVisible"](4)
        end
      end)
    end
  end
end

function OnBtnFace(obj)
  if sceneInstance:EnablePauseGame() and mStateWidget.alpha == 1 then
    HideUIBuffDetailBg(nil)
    HideSkillTip()
    local active = REF.NodeEmoji.gameObject.activeSelf
    REF.NodeEmoji.gameObject:SetActive(not active)
  end
end

function OnBtnTalk(obj)
  if sceneInstance:EnablePauseGame() and mStateWidget.alpha == 1 then
    HideUIBuffDetailBg(nil)
    HideSkillTip()
    local active = REF.TalkRoot.gameObject.activeSelf
    REF.TalkRoot.gameObject:SetActive(not active)
  end
end

function OnBtnSkipRound(obj)
  if obj ~= nil and (not IsButtonClickEnable() or skipGuideLock) then
    return
  end
  if obj == nil and mHaveSkill and not m_paramsForAFR.isAutoFight and dungeonType == PB.enum.DungeonType.TeamPve then
    m_paramsForAFR.isAutoFight = true
    REF.AutoFightRoot["$AutoFightRefresh"](tutorialVal)
    return
  end
  TLog.CollectButtonClick("passCount")
  HideUIBuffDetailBg(nil)
  HideSkillTip()
  SendUseCard(0, 0, 0, nil, 0, DEFINE.PreDefinedCommand.SkipCommand)
end

function OnPauseRecover()
  if 1 < m_preTimeScale then
    CS.GameTime.timeScale = m_preTimeScale
  end
end

function CheckAnimState(delta)
  if mCardAnimState == 2 and mShowDelayTime == 0 and IsAllAnimEnd() then
    for i = 1, #mSkillGroupList do
      local info = mSkillGroupList[i]
      if info:ShowCard() then
        info.btn.transform.localRotation = CS.UnityEngine.Quaternion.identity
      end
    end
    mCardAnimState = 1
    m_paramsForAFR.autoFightDelayTime = 0
    if m_paramsForAFR.isAutoFight then
      m_paramsForAFR.autoFightDelayTime = 0.2
    end
  end
  if mCardAnimState == 1 then
    m_paramsForAFR.autoFightDelayTime = m_paramsForAFR.autoFightDelayTime - delta
    if 0 >= m_paramsForAFR.autoFightDelayTime then
      m_paramsForAFR.autoFightDelayTime = 0
      mCardAnimState = 0
      fightInstance:SetCardStateFromLua(mTeamID, 3)
      if tutorialVal ~= 9 and (tutorialVal ~= 100 or mUniqueWeaponGuideStart) then
        SendTutorialEvent("Tutorial/StepReady")
      end
      if not mHaveSkill and not IsTutorialUIFight() and not mIsRecordGame and not m_paramsForAFR.isAutoFight then
        local request = this:GetData("FightRequestCardMode")
        if request == nil or request == 0 then
          ResetRoundTime(2)
          mRoundSkip = true
          WU.ShowHintText(WU.GetString("Game_NoSkill"))
        end
      end
    end
  end
end

function UpdateRoundTime(delta)
  if mRoundTime == 0 then
    return
  end
  mRoundTimeDelay = mRoundTimeDelay + delta
  if 1.0 <= mRoundTimeDelay then
    mRoundTimeDelay = mRoundTimeDelay - 1.0
    mRoundTime = mRoundTime - 1
    if mRoundTime <= 0 then
      mRoundTime = 0
      OnBtnSkipRound(nil)
    else
      SetTimeWindow(true, mRoundTime)
    end
  end
end

function UpdateBtnPos(delta)
  if mRotateDir == 0 then
    return
  end
  mRotateCurTime = mRotateCurTime + delta * mRotateDir
  if mRotateCurTime >= mRotateTotalTime then
    SetRotateState(1)
  elseif mRotateCurTime <= 0 then
    SetRotateState(0)
  else
    local percent = mRotateCurTime / mRotateTotalTime
    local z = CS.UnityEngine.Mathf.Lerp(0, 90, percent)
    REF.SwitchIcon.transform.localRotation = CS.UnityEngine.Quaternion.Euler(0, 0, z)
  end
end

function EnableUpdateUI()
  local instance = fightInstance
  if instance ~= nil and instance:EnableUpdateUI() then
    return true
  end
  return false
end

function UpdateCardIntroEffect(delta)
  if mCardAnimState == 0 then
    return
  end
  if mShowDelayTime ~= 0 then
    mShowDelayTime = mShowDelayTime - delta
    if mShowDelayTime <= 0 then
      mShowDelayTime = 0
      ShowSkill()
    end
    return
  end
  for i = 1, #mSkillGroupList do
    local info = mSkillGroupList[i]
    if info:ShowCard() and 0 < info.introTime then
      info.introTime = info.introTime - delta
      if 0 >= info.introTime then
        info.introTime = 0
        info:SetBtnPosition()
        local rt = CS.TweenRotation.Begin(info.btn, 0.15, CS.UnityEngine.Quaternion.identity)
        rt.ignoreTimeScale = false
      end
    end
  end
end

function InitActorState(actorList, process, left, teamInfo)
  local uniqueId = process:GetUniqueID()
  local roundActorInfo = FH.getActorByUid(teamInfo, uniqueId)
  if roundActorInfo and not DEFINE.IsWeapon(roundActorInfo) then
    local baseSeat = roundActorInfo.baseSeat
    if roundActorInfo.isAssist then
      baseSeat = baseSeat - DEFINE.HALF_ACTOR_NUM
    end
    for j = 1, #actorList do
      if j == baseSeat then
        local actorConfig = PB.get("ActorConfig", process:GetActorID())
        UITopActorHead(actorList[j], uniqueId, actorConfig, left, process:GetPlayerID())
        if not roundActorInfo.isAssist then
          _ENV["$"](actorList[j].btn)["@processSequence"] = roundActorInfo.sequence
        end
        break
      end
    end
  end
end

function UITopActorHead(uiActorCardButtonInfo, uid, actorConfig, isSelfTeamLeft, playerId)
  if actorConfig == nil or uiActorCardButtonInfo == nil then
    return
  end
  local animRes = actorConfig.animRes
  local isAssist = fif(actorConfig.kind == PB.enum.ActorType.Sub, true, false)
  local btnObject = uiActorCardButtonInfo.btn
  if isAssist then
    if uiActorCardButtonInfo.uniqueID ~= 0 then
      _ENV["$"](btnObject)["$$AddSupportActor"](uid, actorConfig.id, animRes, isSelfTeamLeft, m_selfTeamInfo)
    end
  else
    uiActorCardButtonInfo.uniqueID = uid
    btnObject.name = uid
    btnObject:SetActive(true)
    _ENV["$"](btnObject)["$$InitFightHeadInfo"](uid, actorConfig.id, animRes, playerId, isSelfTeamLeft, mStateWidget)
  end
end

function IsButtonClickEnable()
  if mCardActiveState ~= 0 and mCardActiveState ~= 4 then
    return false
  end
  if m_paramsForAFR.isAutoFight then
    return false
  end
  if mCardAnimState ~= 0 then
    return false
  end
  return true
end

function IsAllAnimEnd()
  if not IsCardAnimEnd(mSkillGroupList) then
    return false
  end
  return true
end

function IsCardAnimEnd(infoList)
  for i = 1, #infoList do
    local info = infoList[i]
    local tp = info.btn:GetComponent(typeof(CS.TweenPosition))
    if tp ~= nil and tp.enabled then
      return false
    end
    local tr = info.btn:GetComponent(typeof(CS.TweenRotation))
    if tr ~= nil and tr.enabled then
      return false
    end
    if info.introTime ~= 0 then
      return false
    end
  end
  return true
end

function ShowAllSkill(id, show, title_1, title_2, info_table)
  if mStateWidget.alpha ~= 1 then
    return
  end
  HideUIBuffDetailBg(nil)
  REF.NodeEmoji.gameObject:SetActive(false)
  REF.TalkRoot.gameObject:SetActive(false)
  if show then
    WU.ToggleRendering(REF.ActorSkillDetail, false)
    WU.ToggleRendering(REF.AllSkillInfo, true)
    mAllSkillInfoID = id
    CS.SoundManager.Instance:PlaySound("Sound/effect/other/zmmse_01")
    if title_2 == "" then
      REF.AllSkillOwner.UILabel.text = title_1
      REF.AllSkillOwner_1.UILabel.text = ""
      REF.AllSkillOwner_2.UILabel.text = ""
    else
      REF.AllSkillOwner.UILabel.text = "&"
      REF.AllSkillOwner_1.UILabel.text = title_1
      REF.AllSkillOwner_2.UILabel.text = title_2
    end
    for i = 1, #info_table do
      local ref_btn = _ENV["$"](REF["OneSkillInfo_" .. i])
      local tex_path = info_table[i][5]
      local have_card = tex_path ~= nil
      ref_btn.SkillIconTexture.UITexture.mainTexturePath = tex_path
      ref_btn.SkillIconTexture.gameObject:SetActive(tex_path ~= nil)
      ref_btn.SkillDescribe.UISprite.spriteName = info_table[i][6]
      ref_btn.SkillDescribe.gameObject:SetActive(have_card)
      if i == 3 then
        ref_btn.SkillBg.UISprite.spriteName = "fight_skill_bg_2"
      else
        ref_btn.SkillBg.UISprite.spriteName = "fight_skill_bg_1"
      end
      if not have_card then
        ref_btn.SkillBg.UISprite.spriteName = "fight_skill_bg_3"
      end
      ref_btn.SkillBg.UISprite:MakePixelPerfect()
      local num = info_table[i][7]
      ref_btn.SkillEnergyLabel.UILabel.text = num
      if info_table[i][8] == 1 then
        ref_btn.SkillEnergyLabel.UILabel.color = CS.NGUIMath.HexToColor(16777215)
      elseif info_table[i][8] == 2 then
        ref_btn.SkillEnergyLabel.UILabel.color = CS.NGUIMath.HexToColor(4294902015)
      end
    end
  else
    HideSkillTip()
  end
end

function HideSkillTip()
  mSkillTipActor = nil
  mSkillTipInfo = nil
  mSkillTipLinkID = 0
  mPressSkillTime = 0
  WU.ToggleRendering(REF.ActorSkillDetail, false)
  WU.ToggleRendering(REF.AllSkillInfo, false)
  mAllSkillInfoID = 0
end

function ShowSkillTip()
  if mSkillTipActor == nil then
    return
  end
  REF.NodeEmoji.gameObject:SetActive(false)
  REF.TalkRoot.gameObject:SetActive(false)
  HideUIBuffDetailBg(nil)
  WU.ToggleRendering(REF.AllSkillInfo, false)
  WU.ToggleRendering(REF.ActorSkillDetail, true)
  this:BroadcastGameEvent("HideTutorial", true)
  local result_info = GetSkillTipDesc(mSkillTipActor, mSkillTipInfo, mSkillTipLinkID, mCurTotalStar, mSkillTipBuffIndex, mSkillTipSpeacialIndex)
  REF.LabelSkillName.UILabel.text = result_info[1]
  REF.LabelCurrentDesc.UIHtmlLabel.text = result_info[2]
  REF.LabelKind.UILabel.text = result_info[3]
end

function GetSkillTipDesc(skillActor, skillInfo, linkID, totalStar, buffIndex, speacialIndex)
  local tip_skillName = ""
  local tip_skillDesc = ""
  local tip_skillKind = ""
  local tip_skillLevel = ""
  if linkID ~= 0 then
    local link_info = PB.get("ActorLink", linkID)
    tip_skillName = WU.GetString("Window_ActorLinkName_" .. link_info.linkID)
    tip_skillDesc = AU.GetActorLinkDesc(link_info.linkID, totalStar + 1, "#72e6ff", buffIndex + 1, speacialIndex + 1)
    tip_skillKind = WU.GetString(link_info.kindIcon)
    tip_skillLevel = WU.GetString("Window_ActorRelationSkill")
  elseif skillInfo ~= nil then
    local m_skills = SE.GetActorSkills(skillActor.id)
    if 0 < #m_skills then
      local m_skillDesc = SE.GetSkillDetail(skillActor, m_skills[skillInfo.placeIndex], "#72e6ff", buffIndex + 1, speacialIndex + 1)
      local count = #m_skillDesc.describes
      local index = 1
      if count ~= 1 then
        for i = 1, #m_skillDesc.skillIds do
          if table.has(skillInfo.skillList, m_skillDesc.skillIds[i]) then
            index = i
            break
          end
        end
      end
      tip_skillName = m_skillDesc.skillNames[index]
      tip_skillKind = WU.GetString(m_skillDesc.kindIcons[index])
      for i = 1, #m_skillDesc.describes do
        tip_skillDesc = tip_skillDesc .. m_skillDesc.describes[i] .. "\n"
      end
      if count == 1 then
        REF.LabelCurrentDesc.UIHtmlLabel.fontSize = 32
      else
        REF.LabelCurrentDesc.UIHtmlLabel.fontSize = 24
      end
      tip_skillLevel = WU.GetString("Window_Level", m_skillDesc.skillLevel)
    end
  end
  return {
    tip_skillName,
    tip_skillDesc,
    tip_skillKind,
    tip_skillLevel
  }
end

function GetSkillTipInfo(teamInfo, uniqueID)
  if teamInfo == nil then
    return {
      nil,
      0,
      0
    }
  else
    for i = 1, #teamInfo.playerList do
      local actorList = teamInfo.playerList[i].actorList
      for k = 1, #actorList do
        if uniqueID == actorList[k].uniqueID then
          return {
            actorList[k].actorInfo,
            actorList[k].buffIndex,
            actorList[k].specialIndex
          }
        end
      end
    end
  end
  return {
    nil,
    0,
    0
  }
end

function OnActorSkillTip(obj, pressed)
  for i = 1, #mSkillGroupList do
    local info = mSkillGroupList[i]
    if info.btn == obj and info:HaveCard() then
      if pressed then
        mPressSkillTime = 0.3
        do
          local result = GetSkillTipInfo(mTeamInfo, info:GetActorRuntimeID())
          mSkillTipActor = result[1]
          mSkillTipBuffIndex = result[2]
          mSkillTipSpeacialIndex = result[3]
          if info.linkIndex ~= 0 then
            mSkillTipInfo = nil
            mSkillTipLinkID = info.linkIndex
            break
          end
          mSkillTipLinkID = 0
          mSkillTipInfo = PB.get("ActorCombo", info:GetActorID(), info.cardIndex, info.scardIndex)
        end
        break
      end
      this:BroadcastGameEvent("HideTutorial", false)
      HideSkillTip()
      break
    end
  end
end

function OnActorSkillClick(obj)
  if m_paramsForAFR.isAutoFight and mCardAnimState == 0 then
    REF.AutoFightRoot["$AutoClickSkill"](obj)
    return
  end
  if not IsButtonClickEnable() then
    return
  end
  HideUIBuffDetailBg(nil)
  local ref = _ENV["$"](obj)
  local indexOfBtnList, e = table.find(mSkillGroupList, function(_, v)
    return v.btn == obj
  end)
  indexOfBtnList = fif(ref["@info"] == nil, indexOfBtnList or 0, ref["@weaponCommand"])
  local info = fif(ref["@info"] == nil, e, ref["@info"])
  if info and info:IsEnableClick() then
    if mCardActiveState == 4 then
      fightInstance:CancelSendListFromLua(mTeamID)
      fightInstance:SetCardStateFromLua(mTeamID, 2)
      CreateSkill(mTeamInfo, mSequenceActor)
    else
      TLog.CollectButtonClick("buttonClickCount" .. tostring(indexOfBtnList))
      CastSkillOrWeapon(ref, info, indexOfBtnList)
    end
  end
end

function CastSkillOrWeapon(ref, info, indexOfBtnList)
  if ref["@costUseCount"] then
    local weaponInfos = FH.getTeamWeapons({mTeamInfo})
    REF.WeaponSkills["$PlayEffectUseWeapon"](weaponInfos, ref)
    if ref["@costUseCount"] > 0 then
      REF.WeaponSkills["$RefreshUseCount"](mTeamInfo, ref["@costUseCount"])
      REF.EffectUseCountCost.EffectGenerator:Play()
      m_useCountNotFull = true
      m_roundChanged = false
    end
  end
  SendUseCard(info.cardIndex, info.scardIndex, info.linkIndex, info.cardList, 0, indexOfBtnList)
end

function UpdateSkillTip(delta)
  if 0 < mPressSkillTime then
    mPressSkillTime = mPressSkillTime - delta
    if mPressSkillTime <= 0 then
      mPressSkillTime = 0
      ShowSkillTip()
    end
  end
end

function UpdateEffect2Pause(delta)
  if not mEffectFly then
    return
  end
  WU.TranslateInTime(REF.TipEffectStar, mflyRoutine)
end

function UpdateCardHide(delta)
  if 0 < mCardHideTime then
    mCardHideTime = mCardHideTime - delta
    if mCardHideTime <= 0 then
      OnCardActive(3)
    end
  end
end

function OnCardActive(state)
  local new_active = state == 1 or state == 4
  if new_active and mCardActiveState ~= 0 then
    mCardActiveState = state
    return
  end
  mCardActiveState = state
  mCardHideTime = 0
  if state == 1 then
    ShowActiveCard()
  elseif state == 2 then
    local time = 1.2
    mCardHideTime = time
    if not IsAlwayShowCard() then
      CS.TweenAlpha.Begin(REF.EnergyBarSp.gameObject, time, 0.002)
      CS.TweenAlpha.Begin(REF.EnergyBarMp.gameObject, time, 0.002)
      CS.TweenAlpha.Begin(REF.SkillCircleBg.gameObject, time, 0.002)
      if m_paramsForAFR.weaponUnlocked then
        CS.TweenAlpha.Begin(REF.WeaponSkills.gameObject, time, 0.002)
      end
    end
  elseif state == 3 then
    HideActiveCard()
  elseif state == 4 then
    ShowActiveCard()
  end
end

function ShowActiveCard()
  mRecordAutoFight = m_paramsForAFR.isAutoFight
  for i = 1, #mSkillGroupList do
    local info = mSkillGroupList[i]
    if info:ShowCard() then
      if info.used then
        local scale_com = info.btn:GetComponent(typeof(CS.TweenScale))
        scale_com.from = Vector3(1, 1, 1)
        scale_com.to = Vector3(1.7, 1.7, 1.7)
        if info.support then
          scale_com.from = scale_com.from * 0.65
          scale_com.to = scale_com.to * 0.65
        end
        info:ActiveCard(1)
      elseif not IsAlwayShowCard() then
        CS.TweenAlpha.Begin(info.btn, 0.6, 0.002)
      end
    end
  end
end

function HideActiveCard()
  for i = 1, #mSkillGroupList do
    local info = mSkillGroupList[i]
    if info:ShowCard() and info.used then
      info:SetEffectActive(CS.CardUIEffect.ACTIVE, false)
      if IsAlwayShowCard() then
        info:SetBtnEnable(false)
      else
        info:DisActiveCard(1)
      end
    end
  end
  if m_paramsForAFR.weaponUnlocked then
    WU.ToggleRendering(REF.WeaponSkills, false)
  end
end

function IsAlwayShowCard()
  if mRecordAutoFight then
    return true
  end
  return false
end

function UpdateHurtVal(delta)
  if curHurtTime < 0 then
    return
  end
  curHurtTime = curHurtTime + delta
  local per = curHurtTime / curHurtTotalTime
  LerpHurtVal(math.min(1, per))
end

function HideHurtVal()
  if curHurtTeam < 0 then
    REF.DamageEffect.transform.localPosition = Vector3(0, 0, -10000)
  end
end

function ResetNormalHurtVal()
  WU.ToggleRendering(REF.DamageText_0, true)
  WU.ToggleRendering(REF.DamageText_1, false)
  WU.ToggleRendering(REF.DamageText_2, false)
  WU.ToggleRendering(REF.DamageFontEffect_1, true)
  WU.ToggleRendering(REF.DamageFontEffect_2, false)
end

function LerpHurtVal(per)
  local val = per * (totalHurtVal - curHurtVal) + curHurtVal
  val = math.ceil(val)
  REF.DamageText_0.UILabel.text = val
  REF.DamageText_1.UILabel.text = val
  REF.DamageText_2.UILabel.text = val
  curHurtUIVal = val
end

function EndRecordVideoInfo()
  if PU.IsRecordVideoSwitchOn() then
    local record = this:GetData("RecordVideoData")
    if record then
      record.endTime = CS.GameJoy.getSystemCurrentTimeMillis
      this:SetData("RecordVideoData", nil)
      local list = this:GetData("RecordVideoList")
      if list == nil then
        list = {}
      end
      list[#list + 1] = record
      this:SetData("RecordVideoList", list)
    end
  end
end

function AddPtVal(team, val)
  if (dungeonType == PB.enum.DungeonType.RacePVP or dungeonType == PB.enum.DungeonType.AssistGuild or dungeonType == PB.enum.DungeonType.ChallengeGuild) and team == 2 and 0 < val then
    totalPt = totalPt + val
    REF.LabelBattleScore.UIHtmlLabel.text = WU.GetString("PVPREALRACE_BATTLESCOREINGAME", math.floor(totalPt / 10))
  end
end

function OnBuffHpChange(team, val)
  AddPtVal(team, val)
end

function AddHurtVal(team, val, critical)
  if team == -1 then
    EndRecordVideoInfo()
  end
  AddPtVal(team, val)
  curHurtTeam = team
  if team < 0 then
    curHurtTime = -1
    LerpHurtVal(1)
    REF.DamageEffect.TweenAlpha:ResetToBeginning()
    REF.DamageEffect.TweenAlpha:PlayForward()
    REF.DamageEffect.TweenAlpha:SetOnFinished(HideHurtVal)
  else
    REF.DamageEffect.transform.localPosition = Vector3(-60, 260, 0)
    WU.ToggleRendering(REF.DamageText_0, false)
    WU.ToggleRendering(REF.DamageText_1, false)
    WU.ToggleRendering(REF.DamageText_2, false)
    WU.ToggleRendering(REF.DamageFont, false)
    WU.ToggleRendering(REF.DamageFontEffect_1, false)
    WU.ToggleRendering(REF.DamageFontEffect_2, false)
    WU.ToggleRendering(REF.DamageLine, false)
    TLog.CollectDamage(team, val, critical)
  end
  if val == 0 then
    totalHurtVal = 0
    curHurtVal = 0
    curHurtUIVal = 0
  else
    WU.ToggleRendering(REF.DamageFont, true)
    WU.ToggleRendering(REF.DamageFontEffect_2, true)
    WU.ToggleRendering(REF.DamageLine, true)
    if critical then
      WU.ToggleRendering(REF.DamageText_0, false)
      WU.ToggleRendering(REF.DamageText_1, false)
      WU.ToggleRendering(REF.DamageText_2, true)
      REF.DamageEffect_Pos1.TweenPosition:ResetToBeginning()
      REF.DamageEffect_Pos1.TweenPosition:PlayForward()
      REF.DamageEffect_Pos2.TweenPosition:ResetToBeginning()
      REF.DamageEffect_Pos2.TweenPosition:PlayForward()
      REF.DamageEffect_Pos3.TweenPosition:ResetToBeginning()
      REF.DamageEffect_Pos3.TweenPosition:PlayForward()
      REF.DamageText_2.TweenScale:ResetToBeginning()
      REF.DamageText_2.TweenScale:PlayForward()
      REF.DamageEffect_Pos2.TweenPosition:SetOnFinished(ResetNormalHurtVal)
    else
      WU.ToggleRendering(REF.DamageText_0, false)
      WU.ToggleRendering(REF.DamageText_1, true)
      WU.ToggleRendering(REF.DamageText_2, false)
      REF.DamageText_1.TweenScale:ResetToBeginning()
      REF.DamageText_1.TweenScale:PlayForward()
      REF.DamageText_1.TweenScale:SetOnFinished(ResetNormalHurtVal)
    end
    curHurtTime = 0
    curHurtTotalTime = 0.3
    totalHurtVal = totalHurtVal + val
    curHurtVal = curHurtUIVal
    LerpHurtVal(0)
    local count = 0
    local num = totalHurtVal
    while num ~= 0 do
      count = count + 1
      num = num // 10
    end
    REF.DamageLine.UISprite.width = math.max(count, 1) * 90
  end
end

function GetTeamForUI(team)
  if not mIsTeam1Left then
    if team == 1 then
      team = 2
    elseif team == 2 then
      team = 1
    end
  end
  return team
end

function OnAssistEffect(list, team)
  team = GetTeamForUI(team)
  if team == 0 then
    for i = 1, #mLeftAssistList do
      _ENV["$"](mLeftAssistList[i])["$"].TweenPosition.enabled = false
      WU.ToggleRendering(mLeftAssistList[i], false)
    end
    for i = 1, #mRightAssistList do
      _ENV["$"](mRightAssistList[i])["$"].TweenPosition.enabled = false
      WU.ToggleRendering(mRightAssistList[i], false)
    end
    return
  end
  local assist_table
  local sign = 0
  if team == 1 then
    assist_table = mLeftAssistList
    sign = 1
  elseif team == 2 then
    assist_table = mRightAssistList
    sign = -1
  end
  local showCount = list.Count
  if assist_table ~= nil then
    if list.Count == 1 then
      fightInstance:SetAssistUITimeLua(0.9)
    elseif 1 < list.Count then
      fightInstance:SetAssistUITimeLua(0.3)
    end
    for i = 1, #assist_table do
      local tw = _ENV["$"](assist_table[i])["$"].TweenPosition
      local ts = _ENV["$"](assist_table[i])["$"].TweenScale
      local tw1 = _ENV["$"](assist_table[i]).AssistTexture.TweenPosition
      local tw2 = _ENV["$"](assist_table[i]).AssistText.TweenPosition
      local ta = _ENV["$"](assist_table[i]).AssistTextureHighLight.TweenAlpha
      if 0 < showCount then
        local height = 250 + (list.Count - showCount) * -110
        assist_table[i].transform.localPosition = Vector3(sign * 200, height, 0)
        local actorConfig = PB.get("ActorConfig", list[list.Count - showCount])
        if actorConfig.supSound ~= "" and list.Count == 1 then
          CS.SoundManager.Instance:PlaySound("Voice/" .. actorConfig.supSound)
        end
        local texturePath = "Texture/ActorInfightHead/sub_2/infight_head_" .. actorConfig.animRes
        _ENV["$"](assist_table[i]).AssistTexture.UITexture.mainTexturePath = texturePath
        _ENV["$"](assist_table[i]).AssistTextureHighLight.UITexture.mainTexturePath = texturePath
        if list.Count == 1 then
          if team == 1 then
            _ENV["$"](assist_table[i]).AssistText.UISprite.spriteName = "our_team_support"
          end
          if team == 2 then
            _ENV["$"](assist_table[i]).AssistText.UISprite.spriteName = "enemy_team_support"
          end
        else
          if team == 1 then
            _ENV["$"](assist_table[i]).AssistText.UISprite.spriteName = "our_team_crossing"
          end
          if team == 2 then
            _ENV["$"](assist_table[i]).AssistText.UISprite.spriteName = "enemy_team_crossing"
          end
        end
        local delay = (list.Count - showCount) * 0.05
        tw.delay = delay
        tw.from = Vector3(tw.from.x, height, tw.from.z)
        tw.to = Vector3(tw.to.x, height, tw.to.z)
        tw:ResetToBeginning()
        tw:PlayForward()
        ts.delay = delay
        ts:ResetToBeginning()
        ts:PlayForward()
        tw1.delay = delay
        tw1:ResetToBeginning()
        tw1:PlayForward()
        tw2.delay = delay
        tw2:ResetToBeginning()
        tw2:PlayForward()
        ta.delay = delay
        ta:ResetToBeginning()
        ta:PlayForward()
      else
        tw.enabled = false
        WU.ToggleRendering(assist_table[i], false)
      end
      showCount = showCount - 1
    end
  end
end

function UpdateTalkSlot(gameObject, wrapIndex, realIndex)
  _ENV["$"](gameObject)["$$UpdateData"](gameObject, wrapIndex, realIndex)
end

function OnBuffDetailScrollViewDragFinished()
  mBuffDetailAutoCloseLeftTime = BUFF_DETAIL_AUTO_CLOSE_TIME
end

function OnBuffDetailScrollViewDragStarted()
  mBuffDetailAutoCloseLeftTime = -1
end

function OnBuffDetailScrollViewStoppedMoving()
  mBuffDetailAutoCloseLeftTime = BUFF_DETAIL_AUTO_CLOSE_TIME
end

function OnBuffDetailScrollViewPressedShouldNotMove()
  mBuffDetailAutoCloseLeftTime = BUFF_DETAIL_AUTO_CLOSE_TIME
end

function UpdateBuffDetail(delta)
end

function ShowBuffDetail(uniqueId, buffList, mergeList, refresh, buffGrid, roundActorInfo)
  local showCancel1 = refresh and mBuffDetailID ~= uniqueId
  local showCancel2 = not refresh and mBuffDetailID == uniqueId
  local buffEmpty = (buffList == nil or #buffList == 0) and (roundActorInfo == nil or roundActorInfo.actorInfo.uniqueWeaponId == nil or roundActorInfo.actorInfo.uniqueWeaponId == 0)
  local alphaCancel = mStateWidget.alpha ~= 1
  if buffEmpty or showCancel1 or showCancel2 or alphaCancel then
    if buffEmpty or showCancel2 then
      HideUIBuffDetailBg(nil)
    end
    return
  end
  HideSkillTip()
  REF.NodeEmoji.gameObject:SetActive(false)
  REF.TalkRoot.gameObject:SetActive(false)
  CS.SoundManager.Instance:PlaySound("Sound/effect/other/zmmse_01")
  WU.ToggleRendering(REF.BuffDetail, true)
  mBuffDetailID = uniqueId
  local position = buffGrid.transform.position
  local origin = REF.BuffActorRoot.transform.position
  REF.BuffActorRoot.transform.position = Vector3(position.x, origin.y, origin.z)
  REF.BuffDetail["$RefreshBuffDetail"](roundActorInfo, buffList, mergeList, uniqueId)
end

function HideUIBuffDetailBg(obj)
  mBuffDetailID = 0
  WU.ToggleRendering(REF.BuffDetail, false)
end

function OnTutorialStart(step)
  info("Tutorial", "fight receive Start")
  SetGuideSkillState()
end

function SendTutorialEvent(param)
  if not IsTutorialUIFight() then
    return
  end
  this:BroadcastGameEvent(param)
end

function SetGuideSkillState()
  if not IsTutorialUIFight() then
    return
  end
  if tutorialVal == 8 or tutorialVal == 9 or tutorialVal == 10 or tutorialVal == 25 or tutorialVal == 26 then
    return
  end
  local guideInfo = GuideSkillInfo[dungeonId]
  if guideInfo == nil then
    return
  end
  local guideResult = 0
  if 0 < #guideInfo then
    local cur_info = guideInfo[1]
    if 0 < #cur_info then
      guideResult = cur_info[1]
      table.remove(cur_info, 1)
      if #cur_info == 0 then
        table.remove(guideInfo, 1)
      end
    end
  end
  print("GamePlay", "guide " .. guideResult)
  if guideResult ~= 0 then
    local index = 1
    for i = 1, #mSkillGroupList do
      local info = mSkillGroupList[i]
      if info:ShowCard() then
        if guideResult == index then
          info:SetGuideLock(false)
          m_weaponLock = false
        else
          info:SetGuideLock(true)
          m_weaponLock = true
        end
        index = index + 1
      end
    end
    if guideResult == 99 then
      skipGuideLock = false
    else
      skipGuideLock = true
    end
  end
end

function OnPVPOverType(val)
  if (dungeonType == PB.enum.DungeonType.BurstLinkPvp or dungeonType == PB.enum.DungeonType.FriendPvp) and (val == 2 or val == 3) then
    WU.ShowHintText(WU.GetString("PVPOverTypeHint"))
  end
end

function SetFaceChat(unlockedEmojiList, showAll)
  if unlockedEmojiList ~= nil or showAll == true then
    REF.GridEmoji.gameObject:SetActive(true)
    chatImageList = PB.all("ChatImage"):where(function(k, v)
      return v.canUseForFight
    end):toarray():sort(function(a, b)
      return a.id < b.id
    end)
    chatInterval = PB.all("Misc"):first().fightInteractionInterval
    local grid = REF.GridEmoji
    for i = 1, #grid do
      if i <= #chatImageList then
        local imgRef = grid[i - 1]
        local isUnlocked
        if showAll then
          isUnlocked = true
        else
          isUnlocked = table.find(unlockedEmojiList, function(k, v)
            return chatImageList[i].id == v.id
          end) ~= nil
        end
        imgRef["$UISprite"].graify = not isUnlocked
        imgRef["$UISprite"].atlasPath = chatImageList[i].atlas
        imgRef["$UISprite"].spriteName = chatImageList[i].sprite
        WU.ClearButtonEvent(imgRef["$"])
        WU.BindButtonEvent(imgRef["$"], function()
          if isUnlocked then
            local now = CS.GameTime.serverUtc
            if now - lastChatTime > chatInterval then
              lastChatTime = now
              local postData = {
                dungeonId = DB:GetData("Dungeon/DungeonUid"),
                emoteId = chatImageList[i].id,
                content = ""
              }
              this:WebSocketSendLua(CS.Restifizer.WebSocketTag.FightService, "CsInteractionReq", postData)
              REF.LeftEmojiBg.gameObject:SetActive(false)
              REF.LeftEmojiBg.gameObject:SetActive(true)
              REF.LeftEmoji.UISprite.atlasPath = chatImageList[i].atlas
              REF.LeftEmoji.UISprite.spriteName = chatImageList[i].sprite
              REF.NodeEmoji.gameObject:SetActive(false)
            else
              WU.ShowHintText(WU.GetString("Window_FightChatTooFast"))
            end
          else
            WU.ShowHintText(WU.GetString("Window_ChatEmojiLocked", WU.GetString("RoleName_" .. chatImageList[i].imageRoleId)))
          end
        end)
      end
    end
  end
end

function OnFightEmoteData(data)
  if dungeonType == PB.enum.DungeonType.BurstLinkPvp or dungeonType == PB.enum.DungeonType.FriendPvp then
    local idx, image = table.find(chatImageList, function(k, v)
      return v.id == data.emoteId
    end)
    if idx ~= nil then
      REF.RightEmojiBg.gameObject:SetActive(false)
      REF.RightEmojiBg.gameObject:SetActive(true)
      REF.RightEmoji.UISprite.atlasPath = image.atlas
      REF.RightEmoji.UISprite.spriteName = image.sprite
    end
  elseif dungeonType == PB.enum.DungeonType.TeamPve then
    local function BroadcastContent(playerId, text)
      for j = 1, #mPlayerActorStateList do
        local btnObject = mPlayerActorStateList[j].btn
        
        _ENV["$"](btnObject)["$$ShowFightTalk"](playerId, text)
      end
    end
    
    local content = data.content
    if data.emoteId ~= nil and data.emoteId > 0 then
      local talkData = PB.get("TeamPVETalk", data.emoteId)
      if talkData ~= nil then
        content = WU.GetString(talkData.talktag)
        BroadcastContent(data.playerId, content)
      end
    else
      BroadcastContent(data.playerId, content)
    end
    local msg = {
      content = content,
      senderId = data.playerId,
      sender = "",
      time = CS.GameTime.serverUtc
    }
    local teamPveInfo = this:GetData("DungeonTeam/BalanceInfo")
    if teamPveInfo ~= nil then
      msg.sender = teamPveInfo[data.playerId].playerInfo.name
    end
    local groupCache = this:GetData("ChatRoom/ChatContentGroup") or _ENV["!"]({})
    groupCache = CU.MergeChatContent(groupCache, {msg})
    this:SetData("ChatRoom/ChatContentGroup", groupCache)
  end
end

function OnFightSendTalk(data, isIndex, isFromChatRoom)
  REF.TalkRoot.gameObject:SetActive(false)
  if GroupChatInterval == nil then
    GroupChatInterval = 0
    local chatChannel = PB.get("ChatChannel", PB.enum.EChatChannel.Group)
    if chatChannel ~= nil then
      GroupChatInterval = chatChannel.interval or 0
    end
  end
  if isFromChatRoom or m_groupChatInterval > GroupChatInterval then
    m_groupChatInterval = 0
    local postData = {
      dungeonId = DB:GetData("Dungeon/DungeonUid"),
      emoteId = fif(isIndex, data, 0),
      content = fif(isIndex, "", data)
    }
    this:WebSocketSendLua(CS.Restifizer.WebSocketTag.FightService, "CsInteractionReq", postData)
    local localData = {
      playerId = this:GetData("FightPlayerID"),
      emoteId = fif(isIndex, data, 0),
      content = fif(isIndex, "", data)
    }
    OnFightEmoteData(localData)
  else
    WU.ShowHintText(WU.GetString("Window_FightChatTooFast"))
  end
end

function GetTutorialIndicator(id, step)
  local target
  if id == 101 and step == 21 then
    target = mEnemyActorStateList[1].btn
  elseif id == 102 and step == 21 then
    target = mPlayerActorStateList[1].btn
  elseif id == 105 and step == 11 then
    target = mEnemyActorStateList[1].btn
  elseif id == 27 and step == 115 then
    target = mPlayerActorStateList[1].btn
  elseif id == 100 and step == 61 then
    target = REF.UniqueWeaponEnergyGuide.gameObject
  elseif id == 100 and step == 105 then
    target = mPlayerActorStateList[1].btn
  end
  if target ~= nil then
    local ref = _ENV["$"](target)
    local indicator = target:AddComponent(typeof(CS.TutorialIndicator))
    if id == 100 and step == 101 then
      indicator.Highlight = ref.root.gameObject
      indicator.Target = ref.WeaponRect.gameObject
    elseif id == 100 and step == 61 then
      indicator.Highlight = ref.root.gameObject
      indicator.Target = ref.root.gameObject
    else
      indicator.Highlight = ref.buffGrid.gameObject
      indicator.Target = ref.buffBtn.gameObject
    end
    return indicator
  end
end

function EnableAttackTimeScale()
  if dungeonType == 0 or dungeonType == PB.enum.DungeonType.TeamPve or dungeonType == PB.enum.DungeonType.BurstLinkPvp or dungeonType == PB.enum.DungeonType.FriendPvp then
    return true
  end
  if IsTutorialUIFight() and tutorialVal ~= 25 and tutorialVal ~= 26 and tutorialVal ~= 41 then
    return false
  end
  if dungeonType == PB.enum.DungeonType.Training or dungeonType == PB.enum.DungeonType.Story then
    return false
  end
  if not CS.GameLogic.IsLocalMode() then
    return false
  end
  return true
end

function SetAttackTimeScale(start)
  if not m_paramsForAFR.isSpeedUp then
    return
  end
  if not EnableAttackTimeScale() then
    return
  end
  if sceneInstance:IsGamePause() then
    return
  end
  local scale_time = 1.0
  if start then
    local teamInfo = fightInstance:GetActionTeamInfo()
    if teamInfo == nil then
      return
    end
    local cardList = teamInfo.UseCardList
    if cardList ~= nil and cardList.Count > 0 then
      local actor = cardList[0].ActorID
      if actor ~= nil then
        local link = teamInfo.UseLinkID
        local card = teamInfo.UseCard
        local sCard = teamInfo.UseSCard
        if link ~= nil and link ~= 0 then
          local link_info = PB.get("ActorLink", link)
          if link_info ~= nil and link_info.costSp == 0 then
            scale_time = TimeScale
          end
        elseif card ~= nil and sCard ~= nil then
          local skill_info = PB.get("ActorCombo", actor, card, sCard)
          if skill_info ~= nil and skill_info.costSp == 0 then
            scale_time = TimeScale
          end
        end
      end
    end
  end
  CS.GameTime.timeScale = scale_time
end

function GetSkillInGroup(skill_list, teamInfo)
  local result = 1
  local first_skill = skill_list[1]
  local skill_info = PB.get("ActorCombo", first_skill:GetActorID(), first_skill.cardIndex, first_skill.scardIndex)
  if skill_info == nil then
    return #skill_list
  end
  if skill_info.paramInt[1] == 1 then
    local compareVal = skill_info.paramInt[2] / 10000
    for i = 1, #mPlayerActorStateList do
      local info = mPlayerActorStateList[i]
      if info.uniqueID ~= 0 then
        local percentage = _ENV["$"](info.btn).val.UISprite.fillAmount
        if percentage ~= 0 and compareVal >= percentage then
          return #skill_list
        end
      end
    end
    for i = 1, #mEnemyActorStateList do
      local info = mEnemyActorStateList[i]
      if info.uniqueID ~= 0 then
        local percentage = _ENV["$"](info.btn).val.UISprite.fillAmount
        if percentage ~= 0 and compareVal >= percentage then
          return #skill_list
        end
      end
    end
  elseif skill_info.paramInt[1] == 2 then
    local compareVal = skill_info.paramInt[2]
    local max_count = 99999
    local fireCount = skill_info.fireCount
    if m_defineParams.infiniteSkill ~= 1 and 0 < fireCount then
      max_count = fireCount
    end
    if compareVal <= max_count - first_skill.cardList[0].UseCount then
      return #skill_list
    end
  elseif skill_info.paramInt[1] == 3 then
    local compareVal = skill_info.paramInt[2]
    local energyVal = FH.getCurEnergy(teamInfo, dungeonType, mSequenceActor)
    if compareVal < energyVal[1] then
      return #skill_list
    end
  elseif skill_info.paramInt[1] == 4 then
    local compareVal = skill_info.paramInt[2]
    local round = teamInfo.statistic.gameRound
    if compareVal <= round then
      return #skill_list
    end
  elseif skill_info.paramInt[1] == 5 then
    local compareVal = skill_info.paramInt[2]
    local max_count = 99999
    local fireCount = skill_info.fireCount
    if m_defineParams.infiniteSkill ~= 1 and 0 < fireCount then
      max_count = fireCount
    end
    local use1 = max_count - first_skill.cardList[0].UseCount
    if skill_list[2] ~= nil and 0 < compareVal then
      local use2 = max_count - skill_list[2].cardList[0].UseCount
      local off = use1 - use2
      if off == 0 then
        return 1
      elseif off == compareVal then
        return #skill_list
      elseif compareVal > off then
        if use1 % compareVal == 0 then
          return #skill_list
        end
      else
        return #skill_list
      end
    end
  elseif skill_info.paramInt[1] == 6 then
    if mActiveUseCard == 1 then
      return 1
    else
      return #skill_list
    end
  end
  return result
end

function InitFightCamera()
  if sceneInstance and sceneInstance.mCamera then
    cameraFight = sceneInstance.mCamera:GetComponent(typeof(CS.CameraFightRound))
    cameraRotate = sceneInstance.mCamera.transform.localRotation
    if cameraFight then
      cameraFight.UseCount = 0
    end
  end
end

function FixFightCamera(play)
  if cameraFight then
    if not cameraFight.enabled then
      cameraFight.transform.localRotation = cameraRotate
      cameraFight.enabled = true
      cameraFight:ClearShake(0)
    end
    if play then
      cameraFight.UseCount = 0
    end
  end
end

local function CreateTextParameters(tb)
  local result = {}
  local val = tb.val
  local showZero = tb.showZero
  local critical = tb.critical
  local type = tb.type
  local skip = val == 0 and not showZero
  if not skip then
    local tmpStr = fif(val < 0, "-", "+") .. math.abs(val)
    result.valStr = fif(critical, ":\n" .. tmpStr, tmpStr)
    result.color = CS.UnityEngine.Color.white
    result.templateName = DEFINE.HUDTemplates[type]
    if type == PB.enum.HudTextType.PhysicsHPDamage or type == PB.enum.HudTextType.MagicHPDamage or type == PB.enum.HudTextType.HPRecover then
      result.fontSize = fif(critical, math.random(37, 39), math.random(19, 21))
      local x = math.random(-40.0, 40.0)
      local y = math.random(-5.0, 25.0)
      result.offset = CS.UnityEngine.Vector3(x, y, 0)
    elseif type == PB.enum.HudTextType.Energy then
      local buff = tb.param
      if buff then
        local buffData = FH.getBuffData(buff.buffKey.id, buff.buffKey.owner)
        result.color = CS.NGUIMath.HexToColor(DEFINE.HEXColor[buffData.type])
      end
      result.fontSize = 38
      result.offset = CS.UnityEngine.Vector3(0, math.random(15.0, 25.0), 0)
    end
  end
  return result
end

local function GetHUDText(actorProcess, templateName)
  local uniqueId = actorProcess:GetUniqueID()
  local HUDTextFonts = m_hudNodeMap[uniqueId] or {}
  m_hudNodeMap[uniqueId] = HUDTextFonts
  local HUDText = HUDTextFonts[templateName]
  if HUDText == nil then
    local gameObject = CS.NGUITools.AddChild(REF.HUDCarrier.gameObject, REF[templateName].gameObject)
    HUDText = gameObject:GetComponent(typeof(CS.HUDText))
    local parent = actorProcess.m_visual:GetVisualObject().m_visualObject
    HUDText:Init(MAX_ACTOR_HUD, parent)
    local actorId = actorProcess:GetActorID()
    local actorConfig = PB.get("ActorConfig", actorId)
    local followTarget = gameObject:GetComponent(typeof(CS.UIFollowTarget))
    followTarget:Init(parent, CS.SceneFight.Instance.mCamera, CS.UIBaseProcess.Instance:GetOriginalCamera(), CS.UnityEngine.Vector3.up * actorConfig.height * 0.7)
    HUDTextFonts[templateName] = HUDText
  end
  return HUDText
end

function OnHudText(tb)
  if tb == nil then
    return
  end
  local result = CreateTextParameters(tb)
  if not table.empty(result) then
    local hudText = GetHUDText(tb.actorProcess, result.templateName)
    hudText:Add(result.valStr, result.color, result.offset, result.fontSize, false, true)
  end
end

local function GetPositionNode(actorProcess)
  local uniqueId = actorProcess:GetUniqueID()
  local node = m_positionNodeMap[uniqueId]
  if node == nil then
    node = CS.NGUITools.AddChild(REF.ActorPos.gameObject, REF.ActorPosTemplate.gameObject)
    m_positionNodeMap[uniqueId] = node
    local actorId = actorProcess:GetActorID()
    local actorConfig = PB.get("ActorConfig", actorId)
    local visualTrans = actorProcess.m_visual:GetVisualObject().m_visualObject
    local followTarget = node:GetComponent(typeof(CS.UIFollowTarget))
    followTarget:Init(visualTrans, CS.SceneFight.Instance.mCamera, CS.UIBaseProcess.Instance:GetOriginalCamera(), CS.UnityEngine.Vector3.up * actorConfig.height * 1.2)
  end
  return node
end

function OnPosition(tb)
  if tb == nil then
    return
  end
  if tb.hideUI then
    REF.ActorPos.TweenAlpha:ResetToBeginning()
    REF.ActorPos.TweenAlpha.enabled = true
    REF.ActorPos.TweenAlpha:PlayForward()
  else
    local node = GetPositionNode(tb.actorProcess)
    node:GetComponent(typeof(CS.UISprite)).spriteName = "position_0" .. tb.positionPostfix
    REF.ActorPos.TweenAlpha.enabled = false
    REF.ActorPos.UIWidget.alpha = 1.0
  end
end

local function GetFightTalkNode(actorProcess)
  local uniqueId = actorProcess:GetUniqueID()
  local node = m_fightTalkMap[uniqueId]
  if node == nil then
    node = CS.NGUITools.AddChild(REF.FightTalk.gameObject, REF.FightTalkTemplate.gameObject)
    m_fightTalkMap[uniqueId] = node
    local actorId = actorProcess:GetActorID()
    local actorConfig = PB.get("ActorConfig", actorId)
    local visualTrans = actorProcess.m_visual:GetVisualObject().m_visualObject
    local followTarget = node:GetComponent(typeof(CS.UIFollowTarget))
    local offset = CS.UnityEngine.Vector3.up * actorConfig.height * 1.1
    offset = offset + CS.UnityEngine.Vector3.left * 0.8
    followTarget:Init(visualTrans, CS.SceneFight.Instance.mCamera, CS.UIBaseProcess.Instance:GetOriginalCamera(), offset)
  end
  return node
end

function OnFightTalk(tb)
  if tb == nil then
    return
  end
  WU.SetActive(REF.FightTalk, not tb.hideUI)
  if not tb.hideUI then
    local node = GetFightTalkNode(tb.actorProcess)
    local ref = _ENV["$"](node)
    local performanceInfo = tb.performanceInfo
    ref.TalkBG.UISprite.spriteName = "bubble_frame_bg_" .. performanceInfo.textStyle
    ref.TalkHtmlLabel.UIHtmlLabel.text = WU.GetString(performanceInfo.textContent)
    ref["$TweenAlpha"].delay = performanceInfo.textDisplayDelayTime
    ref["$TweenAlpha"]:ResetToBeginning()
    ref["$TweenAlpha"]:PlayForward()
    this:DelayInvokeInScaledSeconds(performanceInfo.performanceDuration, function()
      ref["$TweenAlpha"]:PlayReverse()
    end)
  end
end

function FightAutoSettingOpen()
  m_preTimeScale = CS.GameTime.timeScale
  sceneInstance:PauseGame(true)
  HideAllSmallWindow()
end

function ShowWeaponTriggeredSpecial()
  local function ShowTeam(team, oldRecords)
    local fightActiveData = m_fightLuaRef.MainLogic["$fightActiveData"]()
    
    local teamInfo = FH.getTeamInfo(fightActiveData.teamList, team)
    local curRecords = teamInfo.statistic.specialTriggerList
    local isEqual = table.compare(oldRecords, curRecords)
    if not isEqual then
      local sliceResult = table.slice(curRecords, #oldRecords + 1, #curRecords - #oldRecords - 1)
      for i = 1, #sliceResult do
        local specialTriggered = sliceResult[i]
        if specialTriggered.talentFlag > DEFINE.WeaponTalentFlagThreshold then
          local roundActorInfo = FH.getActorByUid(teamInfo, specialTriggered.uniqueId, true)
          if roundActorInfo and not DEFINE.IsWeapon(roundActorInfo) then
            if specialTriggered.weaponPosition == PB.enum.ActorType.Main then
              if team == CS.FightLuaLogic.Instance.SelfTeam then
                REF.WeaponSkills["$PlayEffectPassive"](roundActorInfo)
              end
            else
              local actorStateList = fif(team == CS.FightLuaLogic.Instance.SelfTeam, mPlayerActorStateList, mEnemyActorStateList)
              for i = 1, #actorStateList do
                local actorState = actorStateList[i]
                if actorState.uniqueID == roundActorInfo.uniqueID or actorState.uniqueID == roundActorInfo.uniqueID - DEFINE.HALF_ACTOR_NUM then
                  _ENV["$"](actorState.btn)["$$WeaponTriggeredSpecial"]()
                end
              end
            end
          end
        end
      end
    end
    return curRecords
  end
  
  table.copy(ShowTeam(1, m_specialTriggerListTeam1), m_specialTriggerListTeam1, true)
  table.copy(ShowTeam(2, m_specialTriggerListTeam2), m_specialTriggerListTeam2, true)
end

function OnActorBuffChange(uniqueId, buffList)
  for i = 1, #mPlayerActorStateList do
    local actorState = mPlayerActorStateList[i]
    if actorState.uniqueID == uniqueId then
      _ENV["$"](actorState.btn)["$$OnActorBuffChange"](buffList)
    end
  end
  for i = 1, #mEnemyActorStateList do
    local actorState = mEnemyActorStateList[i]
    if actorState.uniqueID == uniqueId then
      _ENV["$"](actorState.btn)["$$OnActorBuffChange"](buffList)
    end
  end
end

function FightEffectInCameraUI(effectObjectData)
  local effectGenerator = REF.FightEffectInCameraUI.EffectGenerator
  if effectGenerator.Duration > 0 then
    warning("GamePlay", "FightEffectInCameraUI can only play one effect at the same time.")
  else
    effectGenerator.m_EffectName = effectObjectData.name
    effectGenerator:Reset()
    effectGenerator:Play()
  end
end

function InitGMTool(flag)
  m_debugMode = flag
  WU.SetActive(REF.DebugShow, flag and not CS.FightConfig.Instance.pureFightRound)
  if __EditorMode then
    this:RegisterGameEvent("DebugActorState", function(actorProcess)
      if actorProcess == nil then
        return
      end
      local uniqueId = actorProcess:GetUniqueID()
      local node = m_debugActorState[uniqueId]
      if node == nil then
        node = CS.NGUITools.AddChild(REF.DebugActorState.gameObject, REF.DebugActorStateTemplate.gameObject)
        m_debugActorState[uniqueId] = node
        local visualTrans = actorProcess.m_visual:GetVisualObject().m_visualObject
        local followTarget = node:GetComponent(typeof(CS.UIFollowTarget))
        followTarget:Init(visualTrans, CS.SceneFight.Instance.mCamera, CS.UIBaseProcess.Instance:GetOriginalCamera())
      end
      node:GetComponent(typeof(CS.UILabel)).text = string.sub(actorProcess.m_stateManager.mCurState.Name, 11)
    end)
  end
  WU.BindButtonEvent(REF.DebugWin, function()
    if not IsButtonClickEnable() then
      return
    end
    if CS.GameLogic.IsLocalMode() then
      if dungeonType == PB.enum.DungeonType.AssistGuild or dungeonType == PB.enum.DungeonType.ChallengeGuild then
        this:SetData("GMTool/DungeonDamage", -1)
      end
      local FightLuaLogic = CS.FightLuaLogic.Instance
      FightLuaLogic.WinTeam = FightLuaLogic.SelfTeam
    end
  end)
  WU.BindButtonEvent(REF.DebugLose, function()
    if not IsButtonClickEnable() then
      return
    end
    if CS.GameLogic.IsLocalMode() then
      if dungeonType == PB.enum.DungeonType.AssistGuild or dungeonType == PB.enum.DungeonType.ChallengeGuild then
        local damage = math.floor(REF.DebugDamage.UISlider.value * 1000000)
        this:SetData("GMTool/DungeonDamage", damage)
      end
      local FightLuaLogic = CS.FightLuaLogic.Instance
      FightLuaLogic.WinTeam = FightLuaLogic.EnemyTeam
    end
  end)
  
  local function AllCardModeDisplay(isAllCardMode)
    REF.DebugAllCardMode.UISprite.alpha = fif(isAllCardMode, 1.0, 0.2)
    REF.AllCardModelabel.UILabel.text = fif(isAllCardMode, [[
All Card
ON]], [[
All Card
OFF]])
  end
  
  AllCardModeDisplay(CS.FightConfig.Instance.AllCardMode)
  WU.BindButtonEvent(REF.DebugAllCardMode, function()
    local FightConfig = CS.FightConfig.Instance
    if FightConfig then
      local isAllCardMode = not FightConfig.AllCardMode
      AllCardModeDisplay(isAllCardMode)
      FightConfig.AllCardMode = isAllCardMode
    end
  end)
  if dungeonType == PB.enum.DungeonType.AssistGuild or dungeonType == PB.enum.DungeonType.ChallengeGuild then
    REF.DebugDamage.UISlider.value = 0.1
    REF.labelDamage.UILabel.text = math.floor(REF.DebugDamage.UISlider.value * 1000000)
    CS.EventDelegate.Add(REF.DebugDamage.UISlider.onChange, function()
      local value = REF.DebugDamage.UISlider.value
      REF.labelDamage.UILabel.text = math.floor(REF.DebugDamage.UISlider.value * 1000000)
    end)
    REF.DebugDamage.gameObject:SetActive(true)
  else
    REF.DebugDamage.gameObject:SetActive(false)
  end
end
