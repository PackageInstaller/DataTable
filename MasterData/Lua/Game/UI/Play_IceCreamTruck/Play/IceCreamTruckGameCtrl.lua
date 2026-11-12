local IceCreamTruckGameCtrl = class("IceCreamTruckGameCtrl", BaseCtrl)
local ScoreCalculationCtrl = require("Game.UI.Play_IceCreamTruck.Play.ScoreCalculationCtrl")
local IceCreamUtils = require("Game.UI.Play_IceCreamTruck.Play.IceCreamUtils")
local IceCreamBuffRuntimeCtrl = require("Game.UI.Play_IceCreamTruck.Play.IceCreamBuffRuntimeCtrl")
local TimerManager = require("GameCore.Timer.TimerManager")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local SpineManager = require("Game.Spine.SpineManager")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local PlayerBaseData = PlayerData.Base
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
IceCreamTruckGameCtrl._mapNodeConfig = {
  btn_Pause = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Pause",
    sAction = "Map"
  },
  PausePanel = {
    sCtrlName = "Game.UI.Play_IceCreamTruck.Play.IceCreamTruckPauseCtrl"
  },
  ResultPanel = {
    sCtrlName = "Game.UI.Play_IceCreamTruck.Play.IceCreamResultCtrl"
  },
  IceCreamBackPackPanel = {
    sCtrlName = "Game.UI.Play_IceCreamTruck.Play.IceCreamBackPackCtrl"
  },
  CustomerQueue = {
    sCtrlName = "Game.UI.Play_IceCreamTruck.Play.CustomerQueueCtrl"
  },
  txt_LevelScore = {sComponentName = "TMP_Text"},
  iconCert = {},
  obj_DoubleBg = {},
  txt_LevelScoreTitle = {sComponentName = "TMP_Text"},
  txt_DoubleTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_DoubleTitle"
  },
  txt_ComboCount = {sComponentName = "TMP_Text"},
  obj_Combo = {},
  anim_Combo = {sNodeName = "obj_Combo", sComponentName = "Animator"},
  txt_PeopleNum = {sComponentName = "TMP_Text"},
  obj_Hp = {},
  RedHeart = {nCount = 3},
  RedHeartAnimator = {
    nCount = 3,
    sNodeName = "RedHeart",
    sComponentName = "Animator"
  },
  btn_Condiment_A = {
    sComponentName = "NaviButton",
    callback = "OnBtn_ClickCondiment",
    sAction = "IceCream_Condiment1"
  },
  btn_Condiment_S = {
    sComponentName = "NaviButton",
    callback = "OnBtn_ClickCondiment",
    sAction = "IceCream_Condiment2"
  },
  btn_Condiment_D = {
    sComponentName = "NaviButton",
    callback = "OnBtn_ClickCondiment",
    sAction = "IceCream_Condiment3"
  },
  btn_Condiment_F = {
    sComponentName = "NaviButton",
    callback = "OnBtn_ClickCondiment",
    sAction = "IceCream_Condiment4"
  },
  btn_Condiment_H = {
    sComponentName = "NaviButton",
    callback = "OnBtn_ClickCondiment",
    sAction = "IceCream_Condiment5"
  },
  btn_Condiment_J = {
    sComponentName = "NaviButton",
    callback = "OnBtn_ClickCondiment",
    sAction = "IceCream_Condiment6"
  },
  btn_Condiment_K = {
    sComponentName = "NaviButton",
    callback = "OnBtn_ClickCondiment",
    sAction = "IceCream_Condiment7"
  },
  btn_Condiment_L = {
    sComponentName = "NaviButton",
    callback = "OnBtn_ClickCondiment",
    sAction = "IceCream_Condiment8"
  },
  txt_GiveFood = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_FeedPG"
  },
  btn_GiveFood = {
    sComponentName = "NaviButton",
    callback = "OnBtn_GiveFood",
    sAction = "IceCream_GiveFood"
  },
  PGFXBoom = {},
  FX_IceCreamBoom = {nCount = 8},
  obj_Icon = {nCount = 6},
  obj_BadIceCream = {},
  NewGuides = {},
  tr_Condiment_A = {},
  tr_Condiment_S = {},
  tr_Condiment_D = {},
  tr_Condiment_F = {},
  tr_Condiment_H = {},
  tr_Condiment_J = {},
  tr_Condiment_K = {},
  tr_Condiment_L = {},
  btn_Garbage = {
    sComponentName = "NaviButton",
    callback = "OnBtn_DropGarbage",
    sAction = "IceCream_Rubbish"
  },
  obj_BuffBag = {},
  btn_Bag = {
    sComponentName = "NaviButton",
    callback = "OnBtn_OpenBagPanel",
    sAction = "IceCream_BackPack"
  },
  txt_Bag = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_Bag"
  },
  btn_BuffItem1 = {
    sComponentName = "NaviButton",
    callback = "OnBtn_UseBuffItem1",
    sAction = "IceCream_Buff1"
  },
  btn_BuffItem2 = {
    sComponentName = "NaviButton",
    callback = "OnBtn_UseBuffItem2",
    sAction = "IceCream_Buff2"
  },
  rtBuff = {nCount = 5},
  TMPBuffTime = {nCount = 5, sComponentName = "TMP_Text"},
  BuffCool = {sNodeName = "imgColor_B"},
  BuffDouble = {sNodeName = "imgColor_Y"},
  BuffAutomatic = {
    sNodeName = "rtColorAutomatic"
  },
  txt_Automatic = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_BuffAutomaticTips"
  },
  obj_Fever = {},
  img_ProgressBarMask = {sComponentName = "Image"},
  img_ProgressBar = {sComponentName = "Image"},
  img_ProgressBar1 = {
    sComponentName = "CanvasGroup"
  },
  obj_FeverSpecial = {},
  img_ProgressBarFeverMask = {sComponentName = "Image"},
  img_ProgressBarFever = {sComponentName = "Image"},
  EffectRootAnim = {sNodeName = "EffectRoot", sComponentName = "Animator"},
  spCat = {},
  anCutin = {sNodeName = "rtCutin", sComponentName = "Animator"},
  imgFemale = {},
  imgMale = {},
  txt_Fever = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_Fever"
  },
  txt_F = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_F"
  },
  txt_E1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_E1"
  },
  txt_V = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_V"
  },
  txt_E2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_E2"
  },
  txt_R = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_R"
  },
  txtStartTMP = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_StarOpen"
  },
  obj_Start = {},
  ani_Start = {sNodeName = "obj_Start", sComponentName = "Animator"},
  btn_Start = {
    sComponentName = "NaviButton",
    callback = "OnBtn_Star",
    sAction = "Confirm"
  },
  obj_Time = {},
  ImgTime = {nCount = 3},
  obj_Octopus = {},
  obj_OctopusFoot = {},
  obj_Caution = {},
  btn_Foot = {
    nCount = 6,
    sComponentName = "NaviButton",
    callback = "OnBtn_ClickOctopus",
    sAction = "IceCream_OctopusFoot"
  },
  txtCaution = {
    sComponentName = "TMP_Text",
    sLanguageId = "IceCreamTruck_OctopusFoot"
  }
}
IceCreamTruckGameCtrl._mapEventConfig = {
  Event_GetNewItem = "Event_GetNewItem",
  Event_CustomerLeave_False = "Event_CustomerLeave_False",
  Event_SpecialPGLeave = "Event_SpecialPGLeave",
  Event_FeverModeChanged = "On_FeverModeChanged",
  Event_SetPause = "Event_SetPause",
  Event_BagUseItem = "Event_BagUseItem",
  Event_ShowOctopus = "OnEvent_ShowOctopus",
  IceCream_Continue_OnClick = "OnEvent_Continue",
  IceCream_Restart_OnClick = "OnEvent_Restart",
  IceCream_Exit_OnClick = "OnEvent_Exit",
  Event_RestartIceCreamTruckGame = "Event_RestartIceCreamTruckGame",
  Event_ExitIceCreamTruckGame = "Event_ExitIceCreamTruckGame",
  IceCream_NextLevel = "IceCream_NextLevel",
  Event_IceCreamBuffStart = "OnEvent_IceCreamBuffStart",
  Event_IceCreamBuffTick = "OnEvent_IceCreamBuffTick",
  Event_IceCreamBuffEnd = "OnEvent_IceCreamBuffEnd",
  [EventId.ClosePanel] = "OnEvent_CloseDic",
  GMEvent_GetNewBuffItem = "GM_GetNewBuffItem",
  GMEvent_ChangeScoreOrder = "GM_ChangeScoreOrder",
  GMEvent_AddPatienceVal = "GM_AddPatienceVal",
  GMEvent_ChangeComboNum = "GM_ChangeComboNum",
  GMEvent_ChangeFeverTime = "GM_ChangeFeverTime",
  GMEvent_RefreshCustomer = "GM_RefreshCustomer"
}

function IceCreamTruckGameCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.nLevelId = param[2]
  end
  self:InitPlayLevel(self.nActId, self.nLevelId)
  IceCreamUtils.InitIconPath()
  self.tbGamepadUINode = self:GetGamepadUINode()
  self.SpecialScore = ConfigTable.GetConfigNumber("IceCreamScoreShylock")
end

function IceCreamTruckGameCtrl:OnEnable()
  GamepadUIManager.EnterAdventure(true)
  GamepadUIManager.EnableGamepadUI("IceCreamTruckGameCtrl", self.tbGamepadUINode)
  IceCreamTruckGameCtrl._instance = self
  self._nRestartGen = self._nRestartGen or 0
  self._bIsExiting = false
  self:ReInitData()
  self:RefreshGameplayUI()
  self.animatorRoot = self.gameObject:GetComponent("Animator")
end

function IceCreamTruckGameCtrl:OnDisable()
  GamepadUIManager.DisableGamepadUI("IceCreamTruckGameCtrl")
  GamepadUIManager.QuitAdventure()
  if self.BuffRuntime then
    self.BuffRuntime:Clear()
    self.BuffRuntime = nil
  end
  if IceCreamTruckGameCtrl._instance == self then
    IceCreamTruckGameCtrl._instance = nil
  end
  self:_ClearSafeHitQueue()
  self:_GuideClear()
  self._tbGuideObjs = nil
  self:_GuideClearGarbage()
  self._goGarbageGuide = nil
  self:UnregisterCondimentSpines()
  self:_DestroyAllSauceInstances()
  if self._progressBarTailTweener ~= nil then
    self._progressBarTailTweener:Kill()
    self._progressBarTailTweener = nil
  end
  self:_KillFeverBarTween()
  if self.timerFeverCutinHide ~= nil then
    TimerManager.Remove(self.timerFeverCutinHide)
    self.timerFeverCutinHide = nil
  end
  if self.timerFeverCutinDeactivate ~= nil then
    TimerManager.Remove(self.timerFeverCutinDeactivate)
    self.timerFeverCutinDeactivate = nil
  end
  self._nRestartGen = (self._nRestartGen or 0) + 1
end

function IceCreamTruckGameCtrl:ReInitData()
  self:InitData()
  self:GameEnd_Pre(true)
  self.IceCreamActData.IceCreamLevelData:InitData(self.nLevelId, self.nActId)
  local nMaxFever = self.IceCreamActData.IceCreamLevelData:GetCurrentLevelFever()
  local IceCreamFeverTime = ConfigTable.GetConfigNumber("IceCreamFeverTime")
  self.ScoreCalc = ScoreCalculationCtrl.new()
  self.ScoreCalc:Init(nMaxFever, false, IceCreamFeverTime)
  self.BuffRuntime = IceCreamBuffRuntimeCtrl.new()
  self.BuffRuntime:Init(self:BuildBuffCtrl())
  self.bIsOperateMiss = false
  self._mapNode.obj_BadIceCream:SetActive(self.bIsOperateMiss)
  self:ClearIceCreamIcon()
  self:ClearOctopus()
  self:RegisterCondimentSpines()
  self:InitFeedPGFXBoomPool()
  self._fGuideIdleSec = ConfigTable.GetConfigNumber("IceCreamGuidanceDuration")
end

function IceCreamTruckGameCtrl:RefreshGameplayUI()
  self:RefreshScoreUI()
  self:RefreshBuffItems()
  self:SetBuffBag()
  self:SetFeedPGState(false)
  self:RefreshBuffRoot()
  self:SetFeverPattern()
  self:SetHpPattern()
  self:SetScoreTarget()
  self:EnterPreOpenState()
end

function IceCreamTruckGameCtrl:EnterPreOpenState()
  self._bIsOpening = false
  self.bIPause = true
  self._mapNode.obj_Start:SetActive(true)
  local imgBlurredBg = self._mapNode.obj_Start.transform:Find("t_fullscreen_blur_black")
  local Start = self._mapNode.obj_Start.transform:Find("btn_Start")
  local nGen = self._nRestartGen or 0
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
      return
    end
    Start.gameObject:SetActive(true)
  end
  
  cs_coroutine.start(wait)
  imgBlurredBg.gameObject:SetActive(true)
  self._mapNode.obj_Start:SetActive(true)
  EventManager.Hit("Event_SetPause", true)
  self:TryOpenDicAfterIntro()
end

function IceCreamTruckGameCtrl:TryOpenDicAfterIntro()
  if self.nDicId == nil or self.nDicId == 0 then
    return
  end
  local levelData = self.IceCreamActData and self.IceCreamActData.IceCreamLevelData
  if levelData == nil then
    return
  end
  if levelData:GetFloorHasOpenDic(self.nLevelId) then
    return
  end
  local nGen = self._nRestartGen or 0
  local objStart = self._mapNode.obj_Start
  local nAnimTime = NovaAPI.GetAnimClipLength(objStart:GetComponent("Animator"), {
    "btn_Start_in"
  })
  if type(nAnimTime) ~= "number" or nAnimTime <= 0 then
    nAnimTime = 1.5
  end
  local nDicOpenBuffer = 0.8
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime + nDicOpenBuffer)
  
  local function wait()
    local nMax = 120
    while not PanelManager.CheckPanelOpen(PanelId.IceCreamTruckGamePanel) do
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if IceCreamTruckGameCtrl.GetRestartGen() ~= nGen then
        return
      end
      nMax = nMax - 1
      if nMax <= 0 then
        break
      end
    end
    if IceCreamTruckGameCtrl.GetRestartGen() ~= nGen then
      return
    end
    local animator = objStart and objStart:GetComponent("Animator") or nil
    if animator ~= nil then
      local nMax2 = 90
      while animator.gameObject ~= nil and animator.gameObject.activeInHierarchy do
        local info = animator:GetCurrentAnimatorStateInfo(0)
        if not info:IsName("btn_Start_in") or 1 <= info.normalizedTime then
          break
        end
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        if IceCreamTruckGameCtrl.GetRestartGen() ~= nGen then
          return
        end
        nMax2 = nMax2 - 1
        if nMax2 <= 0 then
          break
        end
      end
      if IceCreamTruckGameCtrl.GetRestartGen() ~= nGen then
        return
      end
    end
    self:OnEvent_OpenDic()
  end
  
  cs_coroutine.start(wait)
end

function IceCreamTruckGameCtrl.GetRestartGen()
  local inst = IceCreamTruckGameCtrl._instance
  return inst and inst._nRestartGen or 0
end

function IceCreamTruckGameCtrl:InitData()
  self.tbItems = {
    [1] = 0,
    [2] = 0
  }
  self.tbCurrentSlots = {}
  self.CurrentScore = 0
  self.NumOrder = 0
  self.PropCount = 0
  self.MaxStreakCount = 0
  self.OrderBaseScore = 100
  self.CurrentMaxOrderNum = self.LevelData.CustomerCount
  self.PeopleNum = self.CurrentMaxOrderNum
  self.MaxHp = self.LevelData.Health
  self.CurrentHP = self.MaxHp
  self.ServeCustomer = nil
  self.ServeCustomerId = nil
  self.bIsSpecial = false
  self.CurrentOrders = nil
  self.TargetScore = self.LevelData.PassScore
  self.TargetOrderNum = self.LevelData.OrderNum
  self.fSpeedScale = 1
  self.bFreezePatience = false
  self.bAutoOrder = false
  self.nDicId = self.LevelData.DictionaryId
  if 0 < self.CurrentMaxOrderNum then
    NovaAPI.SetTMPText(self._mapNode.txt_PeopleNum, self.CurrentMaxOrderNum)
  else
    local sTip = ConfigTable.GetUIText("IceCreamTruck_Endless")
    NovaAPI.SetTMPText(self._mapNode.txt_PeopleNum, sTip)
  end
end

function IceCreamTruckGameCtrl:InitPlayLevel(nActId, nLevelId)
  self.IceCreamActData = PlayerData.Activity:GetActivityDataById(nActId)
  if self.IceCreamActData == nil then
    printError("没有冰淇淋活动数据")
    return
  end
  self.IceCreamActData:EnterLevel(nLevelId)
  self.LevelData = ConfigTable.GetData("ActivityIceCreamLevel", nLevelId)
  if self.LevelData == nil then
    printError("关卡ID：" .. nLevelId .. "对应信息不存在")
    return
  end
end

function IceCreamTruckGameCtrl.GetInstance()
  if IceCreamTruckGameCtrl._instance == nil then
    printWarn("[IceCream] GameCtrl 单例为空：可能尚未 OnEnable 或已 OnDisable")
  end
  return IceCreamTruckGameCtrl._instance
end

function IceCreamTruckGameCtrl:RecoverPlay()
  EventManager.Hit("Event_SetPause", true)
  EventManager.Hit(EventId.BlockInput, true)
  self._mapNode.obj_Time:SetActive(true)
  local imgBlurredBg = self._mapNode.obj_Time.transform:Find("t_fullscreen_blur_black")
  local Times = self._mapNode.obj_Time.transform:Find("AnimRoot")
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    Times.gameObject:SetActive(true)
  end
  
  cs_coroutine.start(wait)
  imgBlurredBg.gameObject:SetActive(true)
  WwiseAudioMgr:PostEvent("mode_400013_count")
  self.nTimeRecover = 1
  self:_RefreshRecoverImage()
  if self.timerRecover == nil then
    self.timerRecover = self:AddTimer(0, 1, self.OnEvent_RecoverPlay, true, true, false)
  end
end

function IceCreamTruckGameCtrl:_RefreshRecoverImage()
  for k, _ in ipairs(self._mapNode.ImgTime) do
    self._mapNode.ImgTime[k]:SetActive(self.nTimeRecover == k)
  end
end

function IceCreamTruckGameCtrl:OnEvent_RecoverPlay()
  self.nTimeRecover = self.nTimeRecover + 1
  if self.nTimeRecover > 3 then
    if self.timerRecover then
      TimerManager.Remove(self.timerRecover)
      self.timerRecover = nil
    end
    self._mapNode.obj_Time:SetActive(false)
    local imgBlurredBg = self._mapNode.obj_Time.transform:Find("t_fullscreen_blur_black")
    local Times = self._mapNode.obj_Time.transform:Find("AnimRoot")
    Times.gameObject:SetActive(false)
    imgBlurredBg.gameObject:SetActive(false)
    EventManager.Hit(EventId.BlockInput, false)
    EventManager.Hit("Event_SetPause", false)
    return
  end
  self:_RefreshRecoverImage()
end

local _tbBuffItemId2Slot = {
  [101] = 1,
  [102] = 2,
  [103] = 3,
  [105] = 4
}

function IceCreamTruckGameCtrl:RefreshBuffRoot()
  for k, _ in ipairs(self._mapNode.rtBuff) do
    self._mapNode.rtBuff[k].gameObject:SetActive(false)
  end
  self._mapNode.obj_DoubleBg:SetActive(false)
  self._mapNode.BuffCool:SetActive(false)
  self._mapNode.BuffDouble:SetActive(false)
  self._mapNode.BuffAutomatic:SetActive(false)
end

function IceCreamTruckGameCtrl:SetBuffShow(nBuffId, bShow)
  local nSlot = _tbBuffItemId2Slot[nBuffId]
  if nSlot == nil then
    return
  end
  self._mapNode.rtBuff[nSlot]:SetActive(bShow)
  if nBuffId == 103 then
    self._mapNode.obj_DoubleBg:SetActive(bShow)
    self._mapNode.BuffDouble:SetActive(bShow)
  elseif nBuffId == 101 then
    self._mapNode.BuffCool:SetActive(bShow)
  elseif nBuffId == 105 then
    self._mapNode.BuffAutomatic:SetActive(bShow)
    self.bAutoFeedPG = bShow
  end
end

function IceCreamTruckGameCtrl:SetBuffTime(nBuffId, nTime)
  local nSlot = _tbBuffItemId2Slot[nBuffId]
  if nSlot == nil then
    return
  end
  local ntime = math.floor(nTime)
  if ntime < 0 then
    ntime = 0
  end
  local nMin = math.floor(ntime / 60)
  local nSec = ntime % 60
  NovaAPI.SetTMPText(self._mapNode.TMPBuffTime[nSlot], string.format("%02d:%02d", nMin, nSec))
end

function IceCreamTruckGameCtrl:OnEvent_IceCreamBuffStart(nBuffType, nItemId, nDuration)
  if nDuration == nil or nDuration <= 0 then
    return
  end
  self:SetBuffShow(nItemId, true)
  self:SetBuffTime(nItemId, nDuration)
end

function IceCreamTruckGameCtrl:OnEvent_IceCreamBuffTick(nBuffType, nItemId, nLeftSec)
  self:SetBuffTime(nItemId, nLeftSec or 0)
end

function IceCreamTruckGameCtrl:OnEvent_IceCreamBuffEnd(nBuffType, nItemId)
  self:SetBuffShow(nItemId, false)
end

function IceCreamTruckGameCtrl:SetBuffBag()
  local bShow = self.LevelData.LevelType ~= GameEnum.ActivityIceCreamLevelType.Teaching
  self._mapNode.obj_BuffBag:SetActive(bShow)
end

function IceCreamTruckGameCtrl:IsHaveNewGuide()
  if self.LevelData == nil then
    return false
  end
  local nLevelType = self.LevelData.LevelType
  if nLevelType == GameEnum.ActivityIceCreamLevelType.Teaching or nLevelType == GameEnum.ActivityIceCreamLevelType.Common then
    return true
  end
  return false
end

function IceCreamTruckGameCtrl:GetNewGuideObj(nEnum)
  self._tbGuideObjs = self._tbGuideObjs or {}
  local cached = self._tbGuideObjs[nEnum]
  if cached ~= nil then
    return cached
  end
  local trCondiment = self:GetCondimentTrByEnum(nEnum)
  if trCondiment == nil then
    return nil
  end
  local trGuide = trCondiment.transform:Find("obj_New")
  if trGuide == nil or trGuide:IsNull() then
    return nil
  end
  local go = trGuide.gameObject
  go:SetActive(false)
  self._tbGuideObjs[nEnum] = go
  return go
end

function IceCreamTruckGameCtrl:_GuideArm()
  if not self:IsHaveNewGuide() then
    return
  end
  if self.bAutoOrder or self._bAutoFinishing then
    return
  end
  if self.bIsOperateMiss then
    return
  end
  if self.CurrentOrders == nil then
    return
  end
  if self.CurrentOrders:GetNextStepIndex() == nil then
    return
  end
  self:_GuideHide()
  if self.guideTimer ~= nil then
    self.guideTimer:Reset()
  else
    self.guideTimer = self:AddTimer(1, self._fGuideIdleSec, "_GuideShow", true, true)
  end
end

function IceCreamTruckGameCtrl:_GuideShow()
  self.guideTimer = nil
  if not self:IsHaveNewGuide() then
    return
  end
  if self.bIPause then
    return
  end
  if self.bAutoOrder or self._bAutoFinishing then
    return
  end
  if self.bIsOperateMiss then
    return
  end
  if self.CurrentOrders == nil then
    return
  end
  local nNextStep = self.CurrentOrders:GetNextStepIndex()
  if nNextStep == nil then
    return
  end
  local nValue = self.tbCurrentSlots and self.tbCurrentSlots[nNextStep]
  if nValue == nil or nValue == 0 then
    return
  end
  local go = self:GetNewGuideObj(nValue)
  if go == nil then
    return
  end
  go:SetActive(true)
  self._nGuideCurEnum = nValue
end

function IceCreamTruckGameCtrl:_GuideHide()
  if self._nGuideCurEnum == nil then
    return
  end
  local go = self._tbGuideObjs and self._tbGuideObjs[self._nGuideCurEnum]
  if go ~= nil then
    go:SetActive(false)
  end
  self._nGuideCurEnum = nil
end

function IceCreamTruckGameCtrl:_GuideClear()
  self:_GuideHide()
  if self.guideTimer ~= nil then
    TimerManager.Remove(self.guideTimer)
    self.guideTimer = nil
  end
end

function IceCreamTruckGameCtrl:_GetGarbageGuideObj()
  if self._goGarbageGuide ~= nil then
    return self._goGarbageGuide
  end
  local btn = self._mapNode.btn_Garbage
  if btn == nil then
    return nil
  end
  local trGuide = btn.gameObject.transform:Find("AnimRoot/obj_New")
  if trGuide == nil or trGuide:IsNull() then
    return nil
  end
  local go = trGuide.gameObject
  go:SetActive(false)
  self._goGarbageGuide = go
  return go
end

function IceCreamTruckGameCtrl:_GuideArmGarbage()
  if not self:IsHaveNewGuide() then
    return
  end
  if not self.bIsOperateMiss then
    return
  end
  self:_GuideHideGarbage()
  if self.garbageGuideTimer ~= nil then
    self.garbageGuideTimer:Reset()
  else
    self.garbageGuideTimer = self:AddTimer(1, self._fGuideIdleSec, "_GuideShowGarbage", true, true)
  end
end

function IceCreamTruckGameCtrl:_GuideShowGarbage()
  self.garbageGuideTimer = nil
  if not self:IsHaveNewGuide() then
    return
  end
  if self.bIPause then
    return
  end
  if not self.bIsOperateMiss then
    return
  end
  local go = self:_GetGarbageGuideObj()
  if go == nil then
    return
  end
  go:SetActive(true)
  self._bGarbageGuideShow = true
end

function IceCreamTruckGameCtrl:_GuideHideGarbage()
  if not self._bGarbageGuideShow then
    return
  end
  if self._goGarbageGuide ~= nil then
    self._goGarbageGuide:SetActive(false)
  end
  self._bGarbageGuideShow = false
end

function IceCreamTruckGameCtrl:_GuideClearGarbage()
  self:_GuideHideGarbage()
  if self.garbageGuideTimer ~= nil then
    TimerManager.Remove(self.garbageGuideTimer)
    self.garbageGuideTimer = nil
  end
end

function IceCreamTruckGameCtrl:OnBtn_ClickCondiment(_btn)
  if self.bInIcon1Ani then
    return
  end
  if self._bAutoFinishing then
    return
  end
  if self.bInFeedPG then
    return
  end
  if self.bInOctopus then
    return
  end
  local nValue = tonumber(_btn.gameObject.transform:GetChild(0).name)
  if nValue == nil then
    printError("没有拿到节点下存放的枚举数字")
    return
  end
  self:_ClickCondiment(nValue)
end

function IceCreamTruckGameCtrl:OnBtn_Star()
  if self._bIsOpening then
    return
  end
  self:GameEnd_Pre(false)
  self._bIsOpening = true
  self._mapNode.ani_Start:Play("btn_Start_out", 0, 0)
  EventManager.Hit("Event_SetPause", false)
  EventManager.Hit("Event_StartBusiness")
  self.animatorRoot:Play("IceCreamPlayPanel_in", 0, 0)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  local nDur = NovaAPI.GetAnimClipLength(self._mapNode.ani_Start, {
    "btn_Start_out"
  })
  if type(nDur) ~= "number" or nDur <= 0 then
    nDur = 1.0
  end
  cs_coroutine.start(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(nDur))
    self._mapNode.obj_Start:SetActive(false)
  end)
end

function IceCreamTruckGameCtrl:_ClickCondiment(nValue)
  if self.CurrentOrders == nil then
    return
  end
  if self.bIsOperateMiss then
    local sTip = ConfigTable.GetUIText("IceCreamTruck_IceCreamBadTips")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  self:Cline_Spine(nValue)
  self:_GuideHide()
  local nNextStep = self.CurrentOrders:GetNextStepIndex()
  if nNextStep == nil then
    return
  end
  self.nSlotIndex = nNextStep
  if self.CurrentOrders:CheckStep(self.nSlotIndex, nValue) then
    self:CreatIceCreamIcon(self.nSlotIndex, self.tbCurrentSlots[self.nSlotIndex])
    if self.CurrentOrders:IsOrderComplete() then
      local nOrderState = self.CurrentOrders:GetOrderState()
      local nCharacterId = self.CurrentOrders:GetCharacterId()
      self:_ScheduleClearIconsDelayed(0.5)
      self:_GuideClear()
      self:Event_FinishCurrentOrder(nOrderState, nCharacterId)
    else
      self:_GuideArm()
    end
  else
    self.bIsOperateMiss = true
    self:ClearIceCreamIcon(self.bIsOperateMiss)
    self._mapNode.obj_BadIceCream:SetActive(self.bIsOperateMiss)
    self._mapNode.obj_Combo.gameObject:SetActive(false)
    self:_GuideClear()
    self:_GuideArmGarbage()
    EventManager.Hit("Event_OrderMakeMistake", self.ServeCustomerId)
    self.ScoreCalc:OnMistake()
    if self.bInFever then
      self:_SetProgressBarPercent(self._rtProgressBarFever, self._fProgressBarFeverWidth, self.ScoreCalc:GetFeverPercent())
    else
      self:RefreshFever()
    end
    self:RefreshScoreUI()
  end
end

function IceCreamTruckGameCtrl:_ScheduleClearIconsDelayed(fDelay)
  local nGen = self._nRestartGen or 0
  cs_coroutine.start(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(fDelay or 0.5))
    if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
      return
    end
    self:ClearIceCreamIcon()
  end)
end

function IceCreamTruckGameCtrl:_ScheduleClearAfterFail(fDelay)
  local nGen = self._nRestartGen or 0
  cs_coroutine.start(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(fDelay or 1.0))
    if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
      return
    end
    self:ClearIceCreamIcon()
    self._mapNode.obj_BadIceCream:SetActive(false)
    WwiseAudioMgr:PostEvent("mode_400013_rubbish")
    self._mapNode.btn_Garbage.transform:Find("AnimRoot").gameObject:GetComponent("Animator"):Play("btn_Garbage_in", 0, 0)
  end)
end

function IceCreamTruckGameCtrl:OnBtn_DropGarbage(_btn)
  if not self.bIsOperateMiss then
    return
  end
  WwiseAudioMgr:PostEvent("mode_400013_rubbish")
  self:_GuideClearGarbage()
  self.bIsOperateMiss = false
  self._mapNode.obj_BadIceCream:SetActive(self.bIsOperateMiss)
  self:ClearIceCreamIcon()
  self._mapNode.btn_Garbage.transform:Find("AnimRoot").gameObject:GetComponent("Animator"):Play("btn_Garbage_in", 0, 0)
  self:BeginMakeNewIceCream()
end

function IceCreamTruckGameCtrl:OnBtn_UseBuffItem1(_btn)
  local ItemId = tonumber(_btn.gameObject.transform:GetChild(0).name)
  local nIndex = 1
  self:UseBuffItem(ItemId, nIndex)
end

function IceCreamTruckGameCtrl:OnBtn_UseBuffItem2(_btn)
  local ItemId = tonumber(_btn.gameObject.transform:GetChild(0).name)
  local nIndex = 2
  self:UseBuffItem(ItemId, nIndex)
end

function IceCreamTruckGameCtrl:UseBuffItem(ItemId, nIndex)
  if self.BuffRuntime == nil then
    if not self._bIsExiting then
      printError("BuffRuntime 未初始化")
    end
    return
  end
  local bOk = self.BuffRuntime:TryUseBuff(ItemId)
  if not bOk then
    local sTip = ConfigTable.GetUIText("IceCreamTruck_BuffUseTips")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  self:OpenTips(ItemId)
  self.PropCount = self.PropCount + 1
  self.IceCreamActData.IceCreamLevelData:UseBuffsItem(ItemId, nIndex)
  self:RefreshBuffItems(nIndex)
end

function IceCreamTruckGameCtrl:OpenTips(nBuffId)
  local sUItextId = ""
  if nBuffId == 101 then
    sUItextId = ConfigTable.GetUIText("IceCreamTruck_BuffTips_101")
  elseif nBuffId == 102 then
    sUItextId = ConfigTable.GetUIText("IceCreamTruck_BuffTips_102")
  elseif nBuffId == 103 then
    sUItextId = ConfigTable.GetUIText("IceCreamTruck_BuffTips_103")
  elseif nBuffId == 104 then
    sUItextId = ConfigTable.GetUIText("IceCreamTruck_BuffTips_104")
  elseif nBuffId == 105 then
    sUItextId = ConfigTable.GetUIText("IceCreamTruck_BuffTips_105")
  end
  if sUItextId == "" then
    return
  end
  EventManager.Hit(EventId.OpenMessageBox, sUItextId)
end

function IceCreamTruckGameCtrl:BeginMakeNewIceCream()
  if self.CurrentOrders == nil then
    printError("BeginMakeNewIceCream: 没有当前订单")
    return
  end
  self.nSlotIndex = 0
  self.tbCurrentSlots = self.CurrentOrders:GetSlots()
  local nFirstStep = self.CurrentOrders:GetNextStepIndex()
  if nFirstStep == nil then
    printError("订单是空的")
    return
  end
  self.nSlotIndex = nFirstStep
  self.CurrentOrders:CheckStep(self.nSlotIndex, self.tbCurrentSlots[self.nSlotIndex])
  printLog("生成蛋筒" .. self.tbCurrentSlots[self.nSlotIndex])
  self:CreatIceCreamIcon(self.nSlotIndex, self.tbCurrentSlots[self.nSlotIndex])
  self._fConePlacedTime = CS.UnityEngine.Time.time
  self:_GuideArm()
end

function IceCreamTruckGameCtrl:CreatIceCreamIcon(nStep, CondimentType)
  if CondimentType == 0 then
    return
  end
  if self.CurrentOrders == nil then
    return
  end
  local nDisplay = self.CurrentOrders:GetDisplayIndex(nStep)
  if nDisplay == nil then
    return
  end
  local objIcon = self._mapNode.obj_Icon[nDisplay]
  if objIcon == nil then
    printError("[IceCream] obj_Icon 节点缺失 display=" .. tostring(nDisplay))
    return
  end
  local IconPath = IceCreamUtils.SetCondimentIcon(nStep, CondimentType)
  if IconPath == "" then
    printError("资源路径是空的 step=" .. tostring(nStep) .. " condiment=" .. tostring(CondimentType))
    objIcon:SetActive(false)
    return
  end
  if nDisplay == 1 then
    self.bInIcon1Ani = true
    local imgIconBall = objIcon.transform:Find("IconBall"):GetComponent("Image")
    self:SetActivityAtlasSprite_New(imgIconBall, "_400013/SpriteAtlas/Item", IconPath)
    objIcon:SetActive(true)
    local nGen = self._nRestartGen or 0
    cs_coroutine.start(function()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(self:_GetAutoIcon1ClipSec()))
      if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
        return
      end
      self.bInIcon1Ani = false
    end)
  else
    objIcon:SetActive(true)
    self:SetWorkIceBall(nDisplay, nStep, IconPath)
  end
end

function IceCreamTruckGameCtrl:SetWorkIceBall(nDisplay, nStep, IconPath)
  local objIcon = self._mapNode.obj_Icon[nDisplay]
  if objIcon == nil then
    return
  end
  local trIconBall = objIcon.transform:Find("IconBall")
  local trIconSauce = objIcon.transform:Find("IconSauce")
  if trIconBall == nil or trIconSauce == nil then
    printError("[IceCream] obj_Icon[" .. tostring(nDisplay) .. "] 缺少 IconBall / IconSauce 子节点")
    return
  end
  self:_DestroySauceInstance(nDisplay)
  if nStep == IceCreamUtils.EnumSlotType.SLOT_TOPPING then
    trIconBall.gameObject:SetActive(false)
    trIconSauce.gameObject:SetActive(true)
    local sPath = "UI_Activity/_400013/" .. IconPath .. ".prefab"
    local prefab = GameResourceLoader.LoadAsset(ResTypeAny, Settings.AB_ROOT_PATH .. sPath, typeof(Object))
    if prefab == nil then
      printError("[IceCream] 加载淋酱预制体失败 path=" .. sPath)
      return
    end
    local goSauce = instantiate(prefab, trIconSauce)
    if goSauce == nil then
      printError("[IceCream] instantiate 淋酱预制体失败 path=" .. sPath)
      return
    end
    self._tbSauceInstance = self._tbSauceInstance or {}
    self._tbSauceInstance[nDisplay] = goSauce
  else
    trIconSauce.gameObject:SetActive(false)
    trIconBall.gameObject:SetActive(true)
    local imgIconBall = trIconBall:GetComponent("Image")
    self:SetActivityAtlasSprite_New(imgIconBall, "_400013/SpriteAtlas/Item", IconPath)
  end
end

function IceCreamTruckGameCtrl:ClearIceCreamIcon(bSetBadIceCream)
  if self._mapNode.obj_Icon == nil then
    return
  end
  for key, objIcon in ipairs(self._mapNode.obj_Icon) do
    if not bSetBadIceCream or key ~= 1 then
      if objIcon ~= nil then
        objIcon:SetActive(false)
      end
      self:_DestroySauceInstance(key)
    end
  end
end

function IceCreamTruckGameCtrl:_DestroySauceInstance(nDisplay)
  if self._tbSauceInstance == nil then
    return
  end
  local go = self._tbSauceInstance[nDisplay]
  if go ~= nil then
    destroy(go)
    self._tbSauceInstance[nDisplay] = nil
  end
end

function IceCreamTruckGameCtrl:_DestroyAllSauceInstances()
  if self._tbSauceInstance == nil then
    return
  end
  for k, go in pairs(self._tbSauceInstance) do
    if go ~= nil then
      destroy(go)
    end
    self._tbSauceInstance[k] = nil
  end
end

function IceCreamTruckGameCtrl:RefreshBuffItems(nIndex)
  local tbCurrentItems = self.IceCreamActData.IceCreamLevelData:GetCurrentBuffs()
  if not tbCurrentItems then
    return
  end
  self:RefreshBuffItemSlot(self._mapNode.btn_BuffItem1, tbCurrentItems[1])
  self:RefreshBuffItemSlot(self._mapNode.btn_BuffItem2, tbCurrentItems[2])
  if nIndex == nil then
    self:RefreshBuffItemSlot(self._mapNode.btn_BuffItem1, tbCurrentItems[1], true)
    self:RefreshBuffItemSlot(self._mapNode.btn_BuffItem2, tbCurrentItems[2], true)
  else
    self:RefreshBuffItemSlot(self._mapNode.btn_BuffItem1, tbCurrentItems[1], nIndex == 1)
    self:RefreshBuffItemSlot(self._mapNode.btn_BuffItem2, tbCurrentItems[2], nIndex == 2)
  end
end

function IceCreamTruckGameCtrl:RefreshBuffItemSlot(btn_BuffItem, tbCurrentItem, bPlayAni)
  btn_BuffItem.gameObject:SetActive(tbCurrentItem ~= 0)
  btn_BuffItem.transform:GetChild(0).name = tostring(tbCurrentItem or 0)
  if tbCurrentItem ~= 0 then
    local IconPath = ConfigTable.GetData("IceCreamBuff", tbCurrentItem).Icon
    if IconPath == nil then
      btn_BuffItem.gameObject:SetActive(false)
      printError("道具资源路径为空,ID: " .. tbCurrentItem)
    else
      local ItemIcon = btn_BuffItem.transform:Find("imgItem"):GetComponent("Image")
      if bPlayAni then
        btn_BuffItem.transform:GetComponent("Animator"):Play("BuffItem_in", 0, 0)
      end
      self:SetActivityAtlasSprite_New(ItemIcon, "_400013/SpriteAtlas", IconPath)
    end
  end
end

function IceCreamTruckGameCtrl:OnBtn_OpenBagPanel()
  if PanelManager.CheckPanelOpen(PanelId.IceCreamBackPackPanel) then
    return
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
  local tbCurrentItems = self.IceCreamActData.IceCreamLevelData:GetCurrentBuffs()
  self._mapNode.IceCreamBackPackPanel:OpenBackPack(tbCurrentItems)
end

function IceCreamTruckGameCtrl:BuildBuffCtrl()
  return {
    scoreCalc = self.ScoreCalc,
    getSpeedScale = function()
      return self.fSpeedScale or 1
    end,
    setSpeedScale = function(f)
      self.fSpeedScale = f or 1
      EventManager.Hit("Event_IceCreamSpeedScaleChanged", self.fSpeedScale)
      self:_ApplySpeedScaleToLocalTimers(self.fSpeedScale)
    end,
    resetCustomerPatience = function()
      if self.ServeCustomer then
        self.ServeCustomer.PatienceValue = self.ServeCustomer.MaxPatienceValue
      end
    end,
    freezeCustomerPatience = function(bFreeze)
      self.bFreezePatience = bFreeze and true or false
      EventManager.Hit("Event_IceCreamPatienceFreeze", self.bFreezePatience)
    end,
    addHp = function(nAdd)
      self:AddHp(nAdd or 0)
    end,
    setAutoOrderMode = function(bOn)
      self:SetAutoOrderMode(bOn and true or false)
    end
  }
end

function IceCreamTruckGameCtrl:AddHp(nAdd)
  if nAdd <= 0 then
    return
  end
  if 0 >= self.MaxHp then
    return
  end
  self:RefreshHP(nAdd)
end

function IceCreamTruckGameCtrl:SetAutoOrderMode(bOn)
  if bOn then
    if self.bIsOperateMiss then
      self:OnBtn_DropGarbage()
    end
    self.bAutoOrder = true
    self:TryAutoFinishCurrentOrder()
  else
    self:TryAutoFinishCurrentOrder()
    self.bAutoOrder = false
    self:ResyncServeCustomer()
    self:_GuideArm()
  end
end

function IceCreamTruckGameCtrl:TryAutoFinishCurrentOrder()
  if not self.bAutoOrder then
    return
  end
  if self._bAutoFinishing then
    return
  end
  local orders = self.CurrentOrders
  local nServeId = self.ServeCustomerId
  if orders == nil or nServeId == nil then
    return
  end
  if orders:IsFinished() then
    return
  end
  self._bAutoFinishing = true
  local nLockedServeId = nServeId
  local nGen = self._nRestartGen or 0
  local fStepInterval = 0.25
  cs_coroutine.start(function()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local fIcon1 = self:_GetAutoIcon1ClipSec()
    if 0 < fIcon1 and self._fConePlacedTime ~= nil then
      local fRemain = self._fConePlacedTime + fIcon1 - CS.UnityEngine.Time.time
      if 0 < fRemain then
        coroutine.yield(CS.UnityEngine.WaitForSeconds(fRemain))
      end
    end
    while true do
      if self.bIPause then
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
          self._bAutoFinishing = false
          return
        end
        if self.ServeCustomerId ~= nLockedServeId then
          self._bAutoFinishing = false
          return
        end
      else
        if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() or self.ServeCustomerId ~= nLockedServeId or self.CurrentOrders == nil or self.bIsOperateMiss then
          break
        end
        if self.bInFeedPG then
          if self.bAutoFeedPG then
            self:_GiveFood()
            coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
          else
            break
          end
        else
          local nNextStep = self.CurrentOrders:GetNextStepIndex()
          if nNextStep == nil then
            break
          end
          local nValue = self.tbCurrentSlots and self.tbCurrentSlots[nNextStep]
          if nValue == nil or nValue == 0 then
            break
          end
          self:_ClickCondiment(nValue)
          coroutine.yield(CS.UnityEngine.WaitForSeconds(fStepInterval))
        end
      end
    end
    self._bAutoFinishing = false
  end)
end

function IceCreamTruckGameCtrl:_GetAutoIcon1ClipSec()
  local fSec = 0
  local objIcon = self._mapNode.obj_Icon and self._mapNode.obj_Icon[1]
  if objIcon ~= nil then
    if self._fAutoIcon1ClipSec ~= nil then
      return self._fAutoIcon1ClipSec
    end
    local trIconBall = objIcon.transform:Find("IconBall")
    if trIconBall ~= nil and not trIconBall:IsNull() then
      local animator = trIconBall:GetComponent("Animator")
      if animator ~= nil then
        local fDur = NovaAPI.GetAnimClipLength(animator, {
          "WorkIceCream_Icon1_in"
        })
        if type(fDur) == "number" and 0 < fDur then
          fSec = fDur
        end
      end
    end
  end
  self._fAutoIcon1ClipSec = fSec
  return fSec
end

local tbHitQueue = {}
local tbHitWorker = {}

function IceCreamTruckGameCtrl:SafeHitNextFrame(sEventId, ...)
  local q = tbHitQueue[sEventId]
  if q == nil then
    q = {}
    tbHitQueue[sEventId] = q
  end
  local pack = {
    n = select("#", ...),
    ...
  }
  table.insert(q, pack)
  if tbHitWorker[sEventId] then
    return
  end
  tbHitWorker[sEventId] = true
  local nGen = self._nRestartGen or 0
  cs_coroutine.start(function()
    while true do
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
        return
      end
      local queue = tbHitQueue[sEventId]
      if queue == nil or #queue == 0 then
        break
      end
      local args = table.remove(queue, 1)
      local ok, err = pcall(EventManager.Hit, sEventId, table.unpack(args, 1, args.n))
      if not ok then
        printError(string.format("[SafeHitNextFrame] Hit %s 失败:%s", tostring(sEventId), tostring(err)))
      end
    end
    tbHitWorker[sEventId] = nil
  end)
end

function IceCreamTruckGameCtrl:Event_BagUseItem(nItemId, nIndex)
  self:UseBuffItem(nItemId, nIndex)
end

function IceCreamTruckGameCtrl:Event_GetNewItem(ItemId)
  local nIndex = self.IceCreamActData.IceCreamLevelData:GetNewBuffItem(ItemId)
  self:RefreshBuffItems(nIndex)
end

function IceCreamTruckGameCtrl:Event_CustomerReadyToServe(customerItem)
  if customerItem == nil then
    printError("没有顾客就绪")
    return
  end
  if self.ServeCustomer == customerItem then
    if self.bAutoOrder then
      self:TryAutoFinishCurrentOrder()
    end
    return
  end
  self:BindServeCustomer(customerItem)
  if self.bAutoOrder then
    self:TryAutoFinishCurrentOrder()
  end
end

function IceCreamTruckGameCtrl:BindServeCustomer(customerItem)
  if customerItem == nil then
    return
  end
  self.ServeCustomer = customerItem
  self.ServeCustomerId = customerItem:GetCustomerId()
  self.bIsSpecial = customerItem:IsSpecial()
  self.CurrentOrders = customerItem:GetOrdersCtrl()
  if customerItem._SyncGlobalRuntimeState ~= nil then
    customerItem:_SyncGlobalRuntimeState()
  else
    customerItem:FeverModeChanged(self.bInFever)
  end
  if self.bIsSpecial then
    self:SetFeedPGState(true)
  elseif self.CurrentOrders and self.CurrentOrders:IsFresh() then
    self:BeginMakeNewIceCream()
  else
    self.tbCurrentSlots = self.CurrentOrders and self.CurrentOrders:GetSlots() or nil
    self:_GuideArm()
  end
end

function IceCreamTruckGameCtrl:ResyncServeCustomer()
  if self.ServeCustomer ~= nil then
    return
  end
  local queue = self._mapNode and self._mapNode.CustomerQueue
  if queue == nil then
    return
  end
  local customerItem = queue:GetServingCustomer()
  if customerItem == nil then
    return
  end
  if not customerItem:IsReadyToServe() then
    return
  end
  self:BindServeCustomer(customerItem)
end

function IceCreamTruckGameCtrl:Event_FinishCurrentOrder(OrderState, nCharacterId, bIsOrderSpecial)
  printLog(string.format("[IceCream] Event_FinishCurrentOrder IN state=%s argId=%s serveId=%s", tostring(OrderState), tostring(nCharacterId), tostring(self.ServeCustomerId)))
  if self.ServeCustomerId == nil then
    printLog("[IceCream] Event_FinishCurrentOrder 拦截：ServeCustomerId 为空")
    return
  end
  if nCharacterId ~= nil and nCharacterId ~= self.ServeCustomerId then
    nCharacterId = self.ServeCustomerId
  end
  self:RefreshPeopleNumber()
  local bSucceed = OrderState ~= IceCreamUtils.EnumOrderState.Lose
  if bSucceed then
    local bJustEnteredFever = self.ScoreCalc:OnOrderSuccess(self.bIsSpecial)
    if not bJustEnteredFever then
      WwiseAudioMgr:PostEvent("mode_400013_feverup")
    end
    self.NumOrder = self.NumOrder + 1
    if self.ScoreCalc:GetCombo() > self.MaxStreakCount then
      self.MaxStreakCount = self.ScoreCalc:GetCombo()
    end
    if bIsOrderSpecial ~= nil and bIsOrderSpecial then
    else
      local nScore, tbDetail = self.ScoreCalc:CalcOrderScore(self.OrderBaseScore)
      self.CurrentScore = self.IceCreamActData.IceCreamLevelData:GetProtectScore(self.CurrentScore + nScore)
      self:ShowScorePopup(tbDetail)
    end
    if bJustEnteredFever then
      self.bInFever = true
      EventManager.Hit("Event_FeverModeChanged", true)
    elseif self.ScoreCalc:HasFever() then
      if not self.bInFever then
        self._mapNode.EffectRootAnim:Play("EffectRoot_trail")
      end
      self:RefreshFever()
    end
  else
    self.ScoreCalc:OnOrderFail()
    self:RefreshFever()
    if self.MaxHp > 0 and 0 < self.CurrentHP then
      self:RefreshHP(-1)
      if self.CurrentHP == 0 then
        self:FeverModeFinish()
      end
    end
    self:_ScheduleClearAfterFail()
    if self.bIsOperateMiss then
      self.bIsOperateMiss = false
      self:_GuideClearGarbage()
    end
  end
  local nLeavingId = self.ServeCustomerId
  local lastServeCustomer = self.ServeCustomer
  self.ServeCustomer = nil
  self.ServeCustomerId = nil
  self.bIsSpecial = false
  self.CurrentOrders = nil
  self.tbCurrentSlots = nil
  self:SafeHitNextFrame("Event_FirstCustomerLeave", nLeavingId, bSucceed)
  self:RefreshScoreUI()
  self.CurrentMaxOrderNum = self.CurrentMaxOrderNum - 1
  if self.CurrentMaxOrderNum == 0 then
    self:GameEnd_Pre(true)
    local nGen = self._nRestartGen or 0
    if lastServeCustomer ~= nil and lastServeCustomer.SetOnOrderOutDone ~= nil then
      lastServeCustomer:SetOnOrderOutDone(function()
        if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
          return
        end
        self:AllCustomersFinish()
      end)
    else
      self:AllCustomersFinish()
    end
  end
end

function IceCreamTruckGameCtrl:Event_CustomerLeave_False(nCharacterId)
  if self.ServeCustomerId == nil or nCharacterId ~= self.ServeCustomerId then
    return
  end
  self:Event_FinishCurrentOrder(IceCreamUtils.EnumOrderState.Lose, nCharacterId)
end

function IceCreamTruckGameCtrl:Event_SpecialPGLeave(nCharacterId)
  if self.ServeCustomerId == nil or nCharacterId ~= self.ServeCustomerId or self.CurrentOrders == nil then
    return
  end
  if self.CurrentOrders:GetOrderState() == IceCreamUtils.EnumOrderState.Null then
    self.CurrentOrders:SetFeedPG(false)
  end
  self:SetFeedPGState(false)
  self:Event_FinishCurrentOrder(self.CurrentOrders:GetOrderState(), nCharacterId)
end

function IceCreamTruckGameCtrl:Event_SetPause(bPause)
  self.bIPause = bPause
  if self.feverTimer ~= nil then
    self.feverTimer:Pause(self.bIPause)
  end
  if self._feverBarTweener ~= nil then
    if bPause then
      self._feverBarTweener:Pause()
    else
      self._feverBarTweener:Play()
    end
  end
  if self.guideTimer ~= nil then
    self.guideTimer:Pause(bPause)
  end
  if self.garbageGuideTimer ~= nil then
    self.garbageGuideTimer:Pause(bPause)
  end
  if self.BuffRuntime == nil then
    if not self._bIsExiting then
      printError("BuffRuntime 未初始化")
    end
    return
  end
  self.BuffRuntime:InPause(bPause)
  if not bPause and self._nGuideCurEnum == nil and self.guideTimer == nil then
    self:_GuideArm()
  end
  if not bPause and self.bIsOperateMiss and not self._bGarbageGuideShow and self.garbageGuideTimer == nil then
    self:_GuideArmGarbage()
  end
  if bPause then
    WwiseAudioMgr:PostEvent("mode_400013_pause")
    WwiseAudioMgr:PlaySound("activityMinGame_icecream_allstop_vo", WwiseAudioMgr.AkListener, true)
  else
    WwiseAudioMgr:PostEvent("mode_400013_re")
  end
  if self.timerFeverCutinHide ~= nil then
    self.timerFeverCutinHide:Pause(bPause)
  end
  if self.timerFeverCutinDeactivate ~= nil then
    self.timerFeverCutinDeactivate:Pause(bPause)
  end
end

function IceCreamTruckGameCtrl:RefreshScoreUI()
  self._mapNode.txt_LevelScore.gameObject.transform:GetComponent("Animator"):Play("txt_LevelScore_in", 0, 0)
  if 0 < self.TargetScore and self.CurrentScore >= self.TargetScore then
    self._mapNode.iconCert:SetActive(true)
  else
    self._mapNode.iconCert:SetActive(false)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_LevelScore, self.CurrentScore)
  if not self.bInFeedPG then
    self:RefreshComboNumber()
  end
end

function IceCreamTruckGameCtrl:RefreshPeopleNumber()
  if self.CurrentMaxOrderNum > 0 then
    self.PeopleNum = self.PeopleNum - 1
    NovaAPI.SetTMPText(self._mapNode.txt_PeopleNum, self.PeopleNum)
  end
end

function IceCreamTruckGameCtrl:_InitFeverProgressBarWidth()
  local rtMask = self._mapNode.img_ProgressBarMask.gameObject:GetComponent("RectTransform")
  self._fProgressBarWidth = rtMask.rect.width
  self._rtProgressBar = self._mapNode.img_ProgressBar.gameObject:GetComponent("RectTransform")
  local rtMaskFever = self._mapNode.img_ProgressBarFeverMask.gameObject:GetComponent("RectTransform")
  self._fProgressBarFeverWidth = rtMaskFever.rect.width
  self._rtProgressBarFever = self._mapNode.img_ProgressBarFever.gameObject:GetComponent("RectTransform")
end

function IceCreamTruckGameCtrl:_SetProgressBarPercent(rtBar, fWidth, fPercent)
  if rtBar == nil or fWidth == nil then
    return
  end
  if rtBar == self._rtProgressBarFever then
    self:_KillFeverBarTween()
  end
  fPercent = math.max(0, math.min(1, fPercent or 0))
  local vPos = rtBar.anchoredPosition
  rtBar.anchoredPosition = Vector2(-fWidth * (1 - fPercent), vPos.y)
end

function IceCreamTruckGameCtrl:_SetProgressBarPercentSmooth(rtBar, fWidth, fPercent, fDur)
  if rtBar == nil or fWidth == nil then
    return
  end
  fPercent = math.max(0, math.min(1, fPercent or 0))
  fDur = fDur or 1
  local fTargetX = -fWidth * (1 - fPercent)
  self:_KillFeverBarTween()
  self._feverBarTweener = rtBar:DOAnchorPosX(fTargetX, fDur)
  if self._feverBarTweener ~= nil then
    self._feverBarTweener:SetEase(CS.DG.Tweening.Ease.Linear)
    if self.bIPause then
      self._feverBarTweener:Pause()
    end
    local fScale = self.fSpeedScale or 1
    if 0 < fScale and fScale ~= 1 then
      self._feverBarTweener.timeScale = fScale
    end
  end
end

function IceCreamTruckGameCtrl:_KillFeverBarTween()
  if self._feverBarTweener ~= nil then
    self._feverBarTweener:Kill()
    self._feverBarTweener = nil
  end
end

function IceCreamTruckGameCtrl:SetFeverPattern()
  local bHasFeverMode = self.ScoreCalc:HasFever()
  self._mapNode.obj_Fever:SetActive(bHasFeverMode)
  self._mapNode.obj_FeverSpecial:SetActive(bHasFeverMode)
  self:Fever_ShowSpecialSpine(bHasFeverMode)
  if bHasFeverMode then
    self:_InitFeverProgressBarWidth()
    self:_SetProgressBarPercent(self._rtProgressBar, self._fProgressBarWidth, 0)
    self:_SetProgressBarPercent(self._rtProgressBarFever, self._fProgressBarFeverWidth, 1)
    self.bInFever = false
    self._mapNode.obj_FeverSpecial:SetActive(self.bInFever)
    self:Fever_ShowSpecialSpine(self.bInFever)
  end
end

function IceCreamTruckGameCtrl:SetHpPattern()
  self._mapNode.obj_Hp:SetActive(self.MaxHp > 0)
  if self.MaxHp > 0 then
    for key = 1, self.MaxHp do
      self._mapNode.RedHeartAnimator[key]:Play("RedHeart_in", 0, 0)
    end
  end
end

function IceCreamTruckGameCtrl:SetScoreTarget()
  if self.TargetScore <= 0 then
    self._mapNode.iconCert:SetActive(false)
    local tips = ConfigTable.GetUIText("IceCreamTruck_AllScore")
    NovaAPI.SetTMPText(self._mapNode.txt_LevelScoreTitle, tips)
  else
    local nScoreTarget = self.TargetScore
    local scoreTargetTips = orderedFormat(ConfigTable.GetUIText("IceCreamTruck_ScoreTarget") or "", nScoreTarget)
    NovaAPI.SetTMPText(self._mapNode.txt_LevelScoreTitle, scoreTargetTips)
  end
end

function IceCreamTruckGameCtrl:RefreshHP(nAdd)
  if 0 < nAdd then
    if self.CurrentHP == self.MaxHp then
      return
    end
    self.CurrentHP = math.min(self.CurrentHP + nAdd, self.MaxHp)
    self._mapNode.RedHeartAnimator[self.CurrentHP]:Play("RedHeart_in", 0, 0)
    WwiseAudioMgr:PostEvent("mode_400013_heal")
  else
    self._mapNode.RedHeartAnimator[self.CurrentHP]:Play("RedHeart_out", 0, 0)
    self.CurrentHP = self.CurrentHP - 1
    WwiseAudioMgr:PostEvent("mode_400013_pain")
  end
end

function IceCreamTruckGameCtrl:_FlashProgressBarTail()
  local cg = self._mapNode.img_ProgressBar1
  if cg == nil then
    return
  end
  if self._progressBarTailTweener ~= nil then
    self._progressBarTailTweener:Kill()
    self._progressBarTailTweener = nil
  end
  NovaAPI.SetCanvasGroupAlpha(cg, 1)
  self._progressBarTailTweener = cg:DOFade(0, 1)
end

function IceCreamTruckGameCtrl:RefreshFever()
  self:_SetProgressBarPercent(self._rtProgressBar, self._fProgressBarWidth, self.ScoreCalc:GetFeverPercent())
  self:_FlashProgressBarTail()
end

function IceCreamTruckGameCtrl:RefreshFever_Special()
  self:_SetProgressBarPercentSmooth(self._rtProgressBarFever, self._fProgressBarFeverWidth, self.ScoreCalc:GetFeverPercent(), 1)
end

function IceCreamTruckGameCtrl:Fever_ShowSpecialSpine(bShow)
  self._mapNode.spCat:SetActive(bShow)
  self._mapNode.anCutin.transform.gameObject:SetActive(bShow)
  if not bShow then
    return
  end
  self:SetStatusSwitch(self._mapNode.spCat, "in", false, "idle")
  self._mapNode.imgFemale:SetActive(not PlayerBaseData:GetPlayerSex())
  self._mapNode.imgMale:SetActive(PlayerBaseData:GetPlayerSex())
  if bShow then
    self._mapNode.anCutin:Play("rtCutin_in")
    if self.timerFeverCutinHide ~= nil then
      TimerManager.Remove(self.timerFeverCutinHide)
      self.timerFeverCutinHide = nil
    end
    self.timerFeverCutinHide = self:AddTimer(1, 3, "Fever_UnShowSpecialAnimator_Cutin", true, true)
  end
end

local CAT_OUT_FALLBACK_DURATION = 0.5

function IceCreamTruckGameCtrl:Fever_UnShowSpecialSpine_Cat()
  local CatSpine = self._mapNode.spCat
  if CatSpine == nil or CatSpine:IsNull() then
    return
  end
  self:SetStatusSwitch(self._mapNode.spCat, "out", false, nil)
  local nGen = self._nRestartGen or 0
  local fDur = SpineManager.GetAnimDuration(CatSpine, "out")
  if fDur == nil or fDur <= 0 then
    fDur = CAT_OUT_FALLBACK_DURATION
  end
  cs_coroutine.start(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(fDur))
    if nGen ~= IceCreamTruckGameCtrl.GetRestartGen() then
      return
    end
    if CatSpine ~= nil and not CatSpine:IsNull() then
      CatSpine:SetActive(false)
    end
  end)
end

function IceCreamTruckGameCtrl:Fever_UnShowSpecialAnimator_Cutin()
  self.timerFeverCutinHide = nil
  if self._mapNode.anCutin == nil then
    return
  end
  local goAnCutin = self._mapNode.anCutin.transform.gameObject
  if goAnCutin == nil or goAnCutin:IsNull() then
    return
  end
  if not goAnCutin.activeInHierarchy then
    return
  end
  self._mapNode.anCutin:Play("rtCutin_out")
  local nDur = NovaAPI.GetAnimClipLength(self._mapNode.anCutin, {
    "rtCutin_out"
  })
  if type(nDur) ~= "number" or nDur <= 0 then
    nDur = 1.0
  end
  if self.timerFeverCutinDeactivate ~= nil then
    TimerManager.Remove(self.timerFeverCutinDeactivate)
    self.timerFeverCutinDeactivate = nil
  end
  self.timerFeverCutinDeactivate = self:AddTimer(1, nDur, "_Fever_HideCutinNode", true, true)
end

function IceCreamTruckGameCtrl:_Fever_HideCutinNode()
  self.timerFeverCutinDeactivate = nil
  if self._mapNode.anCutin == nil then
    return
  end
  local goAnCutin = self._mapNode.anCutin.transform.gameObject
  if goAnCutin == nil or goAnCutin:IsNull() then
    return
  end
  goAnCutin:SetActive(false)
end

function IceCreamTruckGameCtrl:ShowScorePopup(tbDetail)
  if self.ServeCustomer then
    self.ServeCustomer:ShowCompleteRoot(tbDetail.nBase, tbDetail.fComboMul, tbDetail.fFeverMul, tbDetail.fBuffMul)
  end
end

function IceCreamTruckGameCtrl:RefreshInFever()
  if not self.bInFever then
    return
  end
  local nDeltaTime = 1
  local bActive = self.ScoreCalc:UpdateFeverDecay(nDeltaTime)
  self:RefreshFever_Special()
  if not bActive then
    EventManager.Hit("Event_FeverModeChanged", false)
    self.bInFever = false
  end
end

function IceCreamTruckGameCtrl:On_FeverModeChanged(bInFever)
  self._mapNode.obj_Fever:SetActive(not bInFever)
  self._mapNode.obj_FeverSpecial:SetActive(bInFever)
  if bInFever then
    self:_SetProgressBarPercent(self._rtProgressBarFever, self._fProgressBarFeverWidth, 1)
    self:Fever_ShowSpecialSpine(true)
    WwiseAudioMgr:PostEvent("mode_400013_power_lp")
  else
    self:_SetProgressBarPercent(self._rtProgressBar, self._fProgressBarWidth, 0)
    self:Fever_UnShowSpecialSpine_Cat()
    WwiseAudioMgr:PostEvent("mode_400013_power_lp_stop")
  end
  if bInFever then
    if nil == self.feverTimer then
      self.feverTimer = self:AddTimer(0, 1, "RefreshInFever", true, true, false)
      if self.feverTimer ~= nil and (self.fSpeedScale or 1) ~= 1 then
        self.feverTimer:SetSpeed(self.fSpeedScale)
      end
    end
  elseif self.feverTimer then
    TimerManager.Remove(self.feverTimer)
    self.feverTimer = nil
  end
end

function IceCreamTruckGameCtrl:_ApplySpeedScaleToLocalTimers(fScale)
  fScale = fScale or 1
  if fScale <= 0 then
    fScale = 1
  end
  if self.feverTimer ~= nil then
    self.feverTimer:SetSpeed(fScale)
  end
  if self._feverBarTweener ~= nil then
    self._feverBarTweener.timeScale = fScale
  end
  if self.BuffRuntime ~= nil and self.BuffRuntime.SetTimersSpeed ~= nil then
    self.BuffRuntime:SetTimersSpeed(fScale)
  end
end

function IceCreamTruckGameCtrl:OnBtnClick_Pause()
  if PanelManager.CheckPanelOpen(PanelId.IceCreamPausePanel) then
    return
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
  local nMaxScore = self.IceCreamActData:GetLevelMaxScore(self.nLevelId)
  local bShowMaxScore = false
  if self.LevelData.LevelType == GameEnum.ActivityIceCreamLevelType.Advanced then
    bShowMaxScore = true
  end
  self._mapNode.PausePanel:Open(self.LevelData.Name, self.CurrentScore, self.NumOrder, self.MaxStreakCount, nMaxScore, bShowMaxScore, self.nDicId)
end

function IceCreamTruckGameCtrl:AllCustomersFinish()
  local bResult = self:IsFinishTarget()
  self:OnEvent_FinishGame(bResult)
end

function IceCreamTruckGameCtrl:FeverModeFinish()
  local bResult = true
  self:OnEvent_FinishGame(bResult)
end

function IceCreamTruckGameCtrl:OnEvent_FinishGame(bResult)
  if self.IceCreamActData == nil then
    printError("活动数据丢失：", self.nActId)
    return
  end
  self.IceCreamActData:SetLevelMaxScore(self.nLevelId, self.CurrentScore)
  
  local function callback(mapChangeInfo)
    WwiseAudioMgr:PostEvent("mode_400013_all_stop")
    NovaAPI.SetCanvasGroupAlpha(self.Canvas, 0)
    local nMaxScore = self.IceCreamActData:GetLevelMaxScore(self.nLevelId)
    self._bIsExiting = true
    self:_TeardownForRestart()
    self:OpenResultPanel(mapChangeInfo.Passed, nMaxScore, mapChangeInfo)
  end
  
  self.IceCreamActData:SendActivityIceCreamLevelSettleReq(self:BuildFinishData(), bResult, callback)
end

function IceCreamTruckGameCtrl:OnEvent_Exit()
  self:ExitGame()
end

function IceCreamTruckGameCtrl:OpenResultPanel(bResult, nMaxScore, mapChangeInfo)
  local bShowMaxScore = false
  if self.LevelData.LevelType == GameEnum.ActivityIceCreamLevelType.Advanced then
    bShowMaxScore = true
  end
  local bNextTimeLock = true
  local nNextLevel = self.nLevelId + 1
  local MaxLevel = ConfigTable.GetConfigNumber("IceCreamMaxLevelId")
  if nNextLevel <= MaxLevel then
    bNextTimeLock = self.IceCreamActData:CheckLevelIsLockByTime(nNextLevel)
  else
    nNextLevel = nil
  end
  self._mapNode.ResultPanel:ShowResultPanel(bResult, self.CurrentScore, self.NumOrder, self.MaxStreakCount, nMaxScore, bShowMaxScore, mapChangeInfo, bNextTimeLock, nNextLevel)
end

function IceCreamTruckGameCtrl:OnEvent_Restart()
  self:RestartLevel()
end

function IceCreamTruckGameCtrl:OnEvent_Continue()
  self._mapNode.PausePanel:Close()
  self:RecoverPlay()
end

function IceCreamTruckGameCtrl:Event_RestartIceCreamTruckGame()
  self:DoRestart()
end

function IceCreamTruckGameCtrl:Event_ExitIceCreamTruckGame()
  self._bIsExiting = true
  self:_TeardownForRestart()
  EventManager.Hit(EventId.ClosePanel, PanelId.IceCreamTruckGamePanel)
end

function IceCreamTruckGameCtrl:IceCream_NextLevel(nNextLevelId)
  if nNextLevelId == nil then
    printError("[IceCream] IceCream_NextLevel 缺少 levelId")
    return
  end
  if ConfigTable.GetData("ActivityIceCreamLevel", nNextLevelId) == nil then
    printError("[IceCream] 下一关配置不存在 levelId=" .. tostring(nNextLevelId))
    return
  end
  self:_TeardownForRestart()
  local nActId = self.nActId
  EventManager.Hit(EventId.ClosePanel, PanelId.IceCreamTruckGamePanel)
  EventManager.Hit(EventId.OpenPanel, PanelId.IceCreamTruckGamePanel, nActId, nNextLevelId)
end

function IceCreamTruckGameCtrl:RestartLevel()
  local sTip = ConfigTable.GetUIText("IceCreamTruck_Re_Confirm")
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    callbackConfirm = function()
      self:GameEnd_Pre(true)
      WwiseAudioMgr:PostEvent("mode_400013_all_stop")
      self._mapNode.PausePanel:Close()
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.55))
        self:DoRestart()
      end
      
      cs_coroutine.start(wait)
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function IceCreamTruckGameCtrl:DoRestart()
  self:_TeardownForRestart()
  self:InitPlayLevel(self.nActId, self.nLevelId)
  self:ReInitData()
  self:RefreshGameplayUI()
  if self._mapNode.CustomerQueue and self._mapNode.CustomerQueue.Restart then
    self._mapNode.CustomerQueue:Restart()
  end
  self.animatorRoot:Play("IceCreamPlayPanel_idle", 0, 0)
end

function IceCreamTruckGameCtrl:_TeardownForRestart()
  self._nRestartGen = (self._nRestartGen or 0) + 1
  if self.feverTimer ~= nil then
    TimerManager.Remove(self.feverTimer)
    self.feverTimer = nil
  end
  if self.timerFeverCutinHide ~= nil then
    TimerManager.Remove(self.timerFeverCutinHide)
    self.timerFeverCutinHide = nil
  end
  if self.timerFeverCutinDeactivate ~= nil then
    TimerManager.Remove(self.timerFeverCutinDeactivate)
    self.timerFeverCutinDeactivate = nil
  end
  if self.BuffRuntime then
    self.BuffRuntime:Clear()
    self.BuffRuntime = nil
  end
  self.ScoreCalc = nil
  self.ServeCustomer = nil
  self.ServeCustomerId = nil
  self.bIsSpecial = false
  self.CurrentOrders = nil
  self.tbCurrentSlots = nil
  self._bAutoFinishing = false
  self._bIsOpening = false
  self.bInFever = false
  self.bIPause = false
  self:_ClearSafeHitQueue()
  self:_GuideClear()
  self._tbGuideObjs = nil
  self:_GuideClearGarbage()
  self._goGarbageGuide = nil
  self:UnregisterCondimentSpines()
  self:_DestroyAllSauceInstances()
end

function IceCreamTruckGameCtrl:_ClearSafeHitQueue()
  for k in pairs(tbHitQueue) do
    tbHitQueue[k] = nil
  end
  for k in pairs(tbHitWorker) do
    tbHitWorker[k] = nil
  end
end

function IceCreamTruckGameCtrl:ExitGame()
  if self.IceCreamActData == nil then
    printError("活动数据丢失：", self.nActId)
    return
  end
  
  local function confirmCallback()
    WwiseAudioMgr:PostEvent("mode_400013_all_stop")
    self._bIsExiting = true
    self._mapNode.PausePanel:Close()
    self:_TeardownForRestart()
    
    local function callback(mapChangeInfo)
      NovaAPI.SetCanvasGroupAlpha(self.Canvas, 0)
      local nMaxScore = self.IceCreamActData:GetLevelMaxScore(self.nLevelId)
      self:OpenResultPanel(mapChangeInfo.Passed, nMaxScore, mapChangeInfo)
    end
    
    self.IceCreamActData:SetLevelMaxScore(self.nLevelId, self.CurrentScore)
    self.IceCreamActData:SendActivityIceCreamLevelSettleReq(self:BuildFinishData(), self:IsFinishTarget(), callback)
  end
  
  local sTip = ConfigTable.GetUIText("IceCreamTruck_Exit_Confirm")
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sTip,
    callbackConfirmAfterClose = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function IceCreamTruckGameCtrl:IsFinishTarget()
  local nNumOrder = self.NumOrder or 0
  local nCurrentScore = self.CurrentScore or 0
  local bOrderOk = 0 <= self.TargetOrderNum and nNumOrder >= self.TargetOrderNum
  local bScoreOk = 0 <= self.TargetScore and nCurrentScore >= self.TargetScore
  local bFinishTarget = bOrderOk and bScoreOk
  return bFinishTarget
end

function IceCreamTruckGameCtrl:BuildFinishData()
  return {
    ActivityId = self.nActId,
    LevelId = self.nLevelId,
    LevelType = self.LevelData.LevelType,
    OrderCount = self.NumOrder,
    TotalScore = self.CurrentScore,
    StreakCount = self.MaxStreakCount,
    PropCount = self.PropCount
  }
end

IceCreamTruckGameCtrl._tbCondimentBtnKeys = {
  "btn_Condiment_A",
  "btn_Condiment_S",
  "btn_Condiment_D",
  "btn_Condiment_F",
  "btn_Condiment_H",
  "btn_Condiment_J",
  "btn_Condiment_K",
  "btn_Condiment_L"
}
IceCreamTruckGameCtrl._tbCondimentTrKeys = {
  "tr_Condiment_A",
  "tr_Condiment_S",
  "tr_Condiment_D",
  "tr_Condiment_F",
  "tr_Condiment_H",
  "tr_Condiment_J",
  "tr_Condiment_K",
  "tr_Condiment_L"
}

function IceCreamTruckGameCtrl:RegisterCondimentSpines()
  self.tbCondimentSpineIds = self.tbCondimentSpineIds or {}
  for _, sBtnKey in ipairs(self._tbCondimentBtnKeys) do
    local btn = self._mapNode[sBtnKey]
    if btn ~= nil then
      local nEnum = tonumber(btn.transform:GetChild(0).name)
      local trSpine = btn.transform:Find("AnimRoot/Spine_Icon")
      if nEnum ~= nil and trSpine ~= nil and trSpine:IsNull() == false then
        SpineManager.PlayAnim(trSpine, "idle", true)
      end
    end
  end
  self._tbCondimentTrByEnum = {}
  for _, sTrKey in ipairs(self._tbCondimentTrKeys) do
    local tr = self._mapNode[sTrKey]
    if tr ~= nil then
      local nEnum = tonumber(tr.transform:GetChild(0).name)
      if nEnum ~= nil then
        self._tbCondimentTrByEnum[nEnum] = tr
      end
    end
  end
end

function IceCreamTruckGameCtrl:GetCondimentTrByEnum(nEnum)
  return self._tbCondimentTrByEnum and self._tbCondimentTrByEnum[nEnum] or nil
end

function IceCreamTruckGameCtrl:UnregisterCondimentSpines()
  self.tbCondimentSpineIds = nil
  self._tbCondimentTrByEnum = nil
end

function IceCreamTruckGameCtrl:Cline_Spine(nEnum)
  if self.tbCondimentSpineIds == nil then
    return
  end
  local spineObj = self.tbCondimentSpineIds[nEnum]
  if spineObj == nil then
    return
  end
  self:SetStatusSwitch(spineObj, "in", false, "idle")
end

function IceCreamTruckGameCtrl:SetStatusSwitch(spineObj, eState, bLoop, sNextLoop)
  if not spineObj then
    return
  end
  if bLoop == nil then
    bLoop = true
  end
  SpineManager.PlayAnim(spineObj, eState, bLoop)
  if not bLoop and sNextLoop then
    SpineManager.AddAnim(spineObj, sNextLoop, true, 0)
  end
end

function IceCreamTruckGameCtrl:OnEvent_OpenDic()
  if self.nDicId ~= nil and self.nDicId ~= 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, self.nDicId, false)
  end
end

function IceCreamTruckGameCtrl:OnEvent_CloseDic(panelId)
  if panelId == PanelId.DictionaryEntry then
    self.IceCreamActData.IceCreamLevelData:OnEvent_SetFloorHasDic(self.nLevelId)
  end
end

function IceCreamTruckGameCtrl:RefreshLockCondiment()
  local tbUnlockSlot = self.LevelData.UnlockSlot
  if tbUnlockSlot == nil then
    return
  end
  for _, sBtnKey in ipairs(self._tbCondimentBtnKeys) do
    local btn = self._mapNode[sBtnKey]
    if btn ~= nil then
      local nEnum = tonumber(btn.transform:GetChild(0).name)
      if table.indexof(tbUnlockSlot, nEnum) == 0 then
        btn.interactable = false
      end
    end
  end
end

function IceCreamTruckGameCtrl:RefreshComboNumber()
  local nCombo = self.ScoreCalc:GetCombo()
  self._mapNode.obj_Combo.gameObject:SetActive(nCombo ~= 0)
  if 0 < nCombo then
    self._mapNode.anim_Combo:Play("obj_Combo_in", 0, 0)
    
    local function OutAnimFinish()
      self._mapNode.obj_Combo.gameObject:SetActive(false)
    end
    
    self:SetAnimationCallback(self._mapNode.anim_Combo, OutAnimFinish)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_ComboCount, nCombo)
end

function IceCreamTruckGameCtrl:OnEvent_ShowOctopus()
  EventManager.Hit(EventId.TemporaryBlockInput, 3)
  if self.IceCreamActData.IceCreamLevelData == nil then
    return
  end
  if self.tbOctopus then
    self.tbOctopus = nil
  end
  self.tbOctopus = self.IceCreamActData.IceCreamLevelData:CreatOctopusFoots()
  if self.tbOctopus == nil then
    printError("章鱼 失败，中断后续")
    return
  end
  self.bInOctopus = true
  self:ActiveBtn(not self.bInOctopus)
  self._mapNode.obj_Octopus.gameObject:SetActive(true)
  self._mapNode.obj_OctopusFoot.gameObject:SetActive(true)
  for index = 1, 6 do
    local bShow = table.indexof(self.tbOctopus, index) ~= 0
    self._mapNode.btn_Foot[index].gameObject:SetActive(bShow)
    self._mapNode.btn_Foot[index].gameObject.transform:Find("AnimRoot").gameObject:SetActive(bShow)
    local trSpine = self._mapNode.btn_Foot[index].gameObject.transform:GetChild(0):Find("Spine_OctopusFoot").transform
    SpineManager.PlayAnim(trSpine, "in", false, 0)
    SpineManager.AddAnim(trSpine, "idle", true, 0)
    self._mapNode.btn_Foot[index].interactable = bShow
  end
end

function IceCreamTruckGameCtrl:OnBtn_ClickOctopus(_btn)
  if self.tbOctopus == nil or #self.tbOctopus == 0 then
    self:FinishOctopus()
    return
  end
  local animBtn = _btn.gameObject.transform:Find("AnimRoot"):GetComponent("Animator")
  local nIndex = tonumber(_btn.gameObject.transform:GetChild(0).name)
  if nIndex == nil then
    printError("没有拿到节点下存放的枚举数字")
    return
  end
  local nUIType = GamepadUIManager.GetCurUIType()
  local bClickAny = nUIType == AllEnum.GamepadUIType.Mouse or nUIType == AllEnum.GamepadUIType.Other
  if bClickAny then
    local nPos = table.indexof(self.tbOctopus, nIndex)
    if nPos ~= 0 then
      self._mapNode.btn_Foot[nIndex].interactable = false
      animBtn:Play("btn_Foot_out", 0, 0)
      table.remove(self.tbOctopus, nPos)
    end
  else
    local nFrame = CS.UnityEngine.Time.frameCount
    if self._nOctopusFireFrame == nFrame then
      return
    end
    self._nOctopusFireFrame = nFrame
    local nHead = self.tbOctopus[1]
    self._mapNode.btn_Foot[nHead].interactable = false
    animBtn:Play("btn_Foot_out", 0, 0)
    table.remove(self.tbOctopus, 1)
  end
  local trSpine = _btn.gameObject.transform:GetChild(0):Find("Spine_OctopusFoot").transform
  SpineManager.PlayAnim(trSpine, "out", false)
  if #self.tbOctopus == 0 then
    self:FinishOctopus()
    return
  end
end

function IceCreamTruckGameCtrl:FinishOctopus()
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self._mapNode.obj_Octopus.transform:GetComponent("Animator"):Play("obj_Octopus_out")
  
  function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.3))
    self:ClearOctopus()
  end
  
  cs_coroutine.start(wait)
end

function IceCreamTruckGameCtrl:ClearOctopus()
  self.bInOctopus = false
  self:ActiveBtn(not self.bInOctopus)
  self._mapNode.obj_Octopus.gameObject:SetActive(false)
  self._mapNode.obj_OctopusFoot.gameObject:SetActive(false)
end

function IceCreamTruckGameCtrl:SetFeedPGState(bInFeed)
  if bInFeed then
    local sTip = ConfigTable.GetUIText("IceCreamTruck_FeedPGTips")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
  self._mapNode.btn_GiveFood.gameObject:SetActive(bInFeed)
  self.bInFeedPG = bInFeed
end

function IceCreamTruckGameCtrl:OnBtn_GiveFood()
  if self._bAutoFinishing then
    return
  end
  self:_GiveFood()
end

function IceCreamTruckGameCtrl:_GiveFood()
  if self.CurrentOrders == nil then
    return
  end
  self:Show_FeedPGFXBoom()
  self.CurrentOrders:SetFeedPG(true)
  local FeedScore = self.ScoreCalc:CalcFeedPGScore(self.SpecialScore)
  self.CurrentScore = self.IceCreamActData.IceCreamLevelData:GetProtectScore(self.CurrentScore + FeedScore)
  self:RefreshScoreUI()
end

function IceCreamTruckGameCtrl:InitFeedPGFXBoomPool()
  self.tbFreeBoomIndex = {}
  for i = 1, 8 do
    if self._mapNode.FX_IceCreamBoom[i] then
      self._mapNode.FX_IceCreamBoom[i].gameObject:SetActive(false)
      table.insert(self.tbFreeBoomIndex, i)
    end
  end
end

function IceCreamTruckGameCtrl:Show_FeedPGFXBoom()
  local nFreeCount = #self.tbFreeBoomIndex
  if nIndex == 0 then
    return
  end
  local nRandom = math.random(1, nFreeCount)
  local nIndex = self.tbFreeBoomIndex[nRandom]
  table.remove(self.tbFreeBoomIndex, nRandom)
  if self._mapNode.FX_IceCreamBoom[nIndex] then
    local objBoom = self._mapNode.FX_IceCreamBoom[nIndex]
    self:SetFeedPGFXBoom_Scale(objBoom)
    self:SetFeedPGFXBoom_Trans(objBoom)
    objBoom.gameObject:SetActive(true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
      objBoom.gameObject:SetActive(false)
      table.insert(self.tbFreeBoomIndex, nIndex)
    end
    
    cs_coroutine.start(wait)
  else
  end
end

function IceCreamTruckGameCtrl:SetFeedPGFXBoom_Trans(objBoom)
  local nPosX = math.random(-900, 900)
  local nPosY = math.random(-445, 445)
  objBoom.transform.localPosition = Vector3(nPosX, nPosY, 0)
end

function IceCreamTruckGameCtrl:SetFeedPGFXBoom_Scale(objBoom)
  local nScale = math.random(8, 12) * 0.1
  objBoom.transform.localScale = Vector3(nScale, nScale, nScale)
end

function IceCreamTruckGameCtrl:GM_GetNewBuffItem(nBuffId, nIndex)
  if self.IceCreamActData.IceCreamLevelData then
    self.IceCreamActData.IceCreamLevelData:GM_GetNewBuffItem(nBuffId, nIndex)
    self:RefreshBuffItems()
  end
end

function IceCreamTruckGameCtrl:GM_ChangeScoreOrder(nScore, nOrder)
  self.CurrentScore = nScore
  self.NumOrder = nOrder
  self:RefreshScoreUI()
end

function IceCreamTruckGameCtrl:GM_AddPatienceVal(nPatienceVal)
  if self.ServeCustomer then
    self.ServeCustomer:AddPatienceVal(nPatienceVal)
  else
    local sTip = string.format("当前没有正在服务的顾客")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
end

function IceCreamTruckGameCtrl:GM_ChangeComboNum(nComboNum)
  if self.ScoreCalc then
    self.MaxStreakCount = nComboNum
    self.ScoreCalc:ChangeCombo(nComboNum)
  end
end

function IceCreamTruckGameCtrl:GM_ChangeFeverTime(nFeverTime)
  if self.ScoreCalc then
    if not self.bInFever then
      local sTip = string.format("热力模式未开启")
      EventManager.Hit(EventId.OpenMessageBox, sTip)
      return
    end
    self.ScoreCalc:ChangeFeverTime(nFeverTime)
  end
end

function IceCreamTruckGameCtrl:GM_RefreshCustomer(CustomerId)
  if self.ServeCustomer then
    self.ServeCustomer:RefreshCurrentCustomer(CustomerId)
  end
end

function IceCreamTruckGameCtrl:GameEnd_Pre(bIsEnd)
  self:ActiveBtnAll(not bIsEnd)
end

function IceCreamTruckGameCtrl:ActiveBtnAll(bEnable)
  self._mapNode.btn_Pause.interactable = bEnable
  self._mapNode.btn_Condiment_A.interactable = bEnable
  self._mapNode.btn_Condiment_S.interactable = bEnable
  self._mapNode.btn_Condiment_D.interactable = bEnable
  self._mapNode.btn_Condiment_F.interactable = bEnable
  self._mapNode.btn_Condiment_H.interactable = bEnable
  self._mapNode.btn_Condiment_J.interactable = bEnable
  self._mapNode.btn_Condiment_K.interactable = bEnable
  self._mapNode.btn_Condiment_L.interactable = bEnable
  self:ActiveBtn(bEnable)
end

function IceCreamTruckGameCtrl:ActiveBtn(bEnable)
  self._mapNode.btn_Bag.interactable = bEnable
  self._mapNode.btn_BuffItem1.interactable = bEnable
  self._mapNode.btn_BuffItem2.interactable = bEnable
  self._mapNode.btn_Garbage.interactable = bEnable
  self._mapNode.btn_GiveFood.interactable = bEnable
end

return IceCreamTruckGameCtrl
