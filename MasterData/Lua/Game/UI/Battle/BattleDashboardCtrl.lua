local BattleDashboardCtrl = class("BattleDashboardCtrl", BaseCtrl)
local PlayerCharData = PlayerData.Char
local AdventureModuleHelper = CS.AdventureModuleHelper
local v3SkillBtnScale = Vector3(0.85, 0.85, 0.85)
local InteractiveManagerIns = CS.InteractiveManager.Instance
local InputManagerIns = CS.InputManager.Instance
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local HINT_EFFECT_PREFAB_PATH = "UI/GuideProloguel/GuideProloguelEffect.prefab"
local HINT_EFFECT_INDEX = 1
local HINT_EFFECT_SHOW_DELAY = 0.5
local HINT_EFFECT_SCALE = 0.8
BattleDashboardCtrl._mapNodeConfig = {
  ShowBtn = {sComponentName = "Button"},
  cgMainRole = {
    sNodeName = "--main_role--",
    sComponentName = "CanvasGroup"
  },
  dodge = {
    sNodeName = "btnDodge",
    sCtrlName = "Game.UI.Battle.SkillBtnCtrl"
  },
  RUN = {},
  skill = {
    sNodeName = "btnSkill",
    sCtrlName = "Game.UI.Battle.SkillBtnCtrl"
  },
  ultra = {
    sNodeName = "btnUltra",
    sCtrlName = "Game.UI.Battle.SkillBtnCtrl"
  },
  cgSupRole = {
    sNodeName = "--support_role--",
    sComponentName = "CanvasGroup"
  },
  imgBg_SupportRole = {},
  supSkill1 = {
    sNodeName = "btnSuportSkill1",
    sCtrlName = "Game.UI.Battle.SkillBtnCtrl"
  },
  supUltra1 = {
    sNodeName = "btnSupportUltra1",
    sCtrlName = "Game.UI.Battle.SkillBtnCtrl"
  },
  imgSupRole1 = {
    sNodeName = "suportRole1",
    sComponentName = "Image"
  },
  supSkill2 = {
    sNodeName = "btnSuportSkill2",
    sCtrlName = "Game.UI.Battle.SkillBtnCtrl"
  },
  supUltra2 = {
    sNodeName = "btnSupportUltra2",
    sCtrlName = "Game.UI.Battle.SkillBtnCtrl"
  },
  imgSupRole2 = {
    sNodeName = "suportRole2",
    sComponentName = "Image"
  },
  btnHand = {
    sComponentName = "ButtonEx",
    callback = "OnBtn_ClickHand"
  },
  trHand = {sNodeName = "btnHand", sComponentName = "Transform"},
  cgHand = {
    sComponentName = "CanvasGroup"
  },
  imgHandIcon = {sComponentName = "Image"},
  tmpInteract = {nCount = 2, sComponentName = "TMP_Text"},
  animBtnHand = {sNodeName = "btnHand", sComponentName = "Animator"},
  ActionHand = {
    sCtrlName = "Game.UI.Battle.SkillActionIconCtrl"
  },
  trSkillHint = {
    sComponentName = "Transform",
    sNodeName = "--skill_hint--"
  },
  trHoldSkill = {sComponentName = "Transform"},
  imgSkillIHintcon = {sComponentName = "Image"},
  rtSkillHintProgress = {
    sComponentName = "RectTransform"
  },
  trSkillChange = {sComponentName = "Transform"},
  goJoystick = {
    sNodeName = "--joystick--"
  },
  rtJoystick = {
    sNodeName = "--joystick--",
    sComponentName = "RectTransform"
  },
  cgJoystick = {
    sNodeName = "--joystick--",
    sComponentName = "CanvasGroup"
  },
  trAvgBubbleRoot = {
    sNodeName = "--AvgBubble--",
    sComponentName = "Transform"
  },
  SupSkill1_Pos = {sComponentName = "Transform"},
  SupUltra1_Pos = {sComponentName = "Transform"},
  SupRole1_Pos = {sComponentName = "Transform"},
  SupSkill2_Pos = {sComponentName = "Transform"},
  SupUltra2_Pos = {sComponentName = "Transform"},
  SupRole2_Pos = {sComponentName = "Transform"},
  MainDodge_Pos = {sComponentName = "Transform"},
  MainSkill_Pos = {sComponentName = "Transform"},
  MainUltra_Pos = {sComponentName = "Transform"},
  SupSkill1_Pos_Hor = {sComponentName = "Transform"},
  SupUltra1_Pos_Hor = {sComponentName = "Transform"},
  SupRole1_Pos_Hor = {sComponentName = "Transform"},
  SupSkill2_Pos_Hor = {sComponentName = "Transform"},
  SupUltra2_Pos_Hor = {sComponentName = "Transform"},
  SupRole2_Pos_Hor = {sComponentName = "Transform"},
  MainDodge_Pos_Hor = {sComponentName = "Transform"},
  MainSkill_Pos_Hor = {sComponentName = "Transform"},
  MainUltra_Pos_Hor = {sComponentName = "Transform"}
}
BattleDashboardCtrl._mapEventConfig = {
  [EventId.BattleDashboardVisible] = "OnEvent_BattleDashboardVisible",
  TimeLineFinishBattleDashboardVisible = "OnEvent_BattleDashboardVisible",
  ADVENTURE_LEVEL_UNLOAD_COMPLETE = "OnEvent_LevelUnloadComplete",
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  InputEnable = "OnEvent_InputEnable",
  AliveChanged = "OnEvent_AliveChanged",
  EnableBtnControl = "OnEvent_EnableBtnControl",
  HintUltraButton = "OnEvent_HintUltraButton",
  HintButton = "OnEvent_HintButton",
  interactiveUI = "OnEvent_ShowHand",
  InteractiveEnable = "OnEvent_ClickHand",
  SkillHintStart = "OnEvent_SkillHintStart",
  SkillHintEnd = "OnEvent_SkillHintEnd",
  SkillHintActive = "OnEvent_SkillHintActive",
  PlayerAdventureActorCastSkill = "OnEvent_UseSkillSucc",
  PrologueBattleOpenBattleDash = "OnEvent_PrologueBattleOpenBattleDash",
  SkillUnExecutableTips = "OnEvent_SkillUnExecutableTips",
  SupUltraState = "OnEvent_SupUltraState",
  SupportSkillUnExecutableTips = "OnEvent_SupportSkillUnExecutableTips",
  ShowOrHideBattleDash = "OnEvent_ShowOrHideBattleDash",
  ButtonStateChange = "OnEvent_BtnStateChange",
  CanRush = "OnEvent_CanRush",
  SetVariableJoystickMode = "OnEvent_SetVariableJoystickMode",
  BattleSettingsBindingOverride = "OnEvent_BattleSettingsBindingOverride",
  TestSwitchUI = "OnEvent_SwitchUI",
  TestSwitchSkillBtn = "OnEvent_SwitchSkillBtn",
  ProloguelEnableBtnControl = "OnEvent_ProloguelEnableBtnControl",
  [EventId.MoveAvgBubbleRoot] = "OnEvent_MoveAvgBubbleRoot",
  [EventId.SettingsBattleClose] = "OnEvent_ChangeKeyLayout",
  ChangeSkillIcon = "OnEvent_ChangeSkillIcon"
}

function BattleDashboardCtrl:Awake()
  self.tbDefine_SkillBtn = {
    [1] = {
      skillBtnCtrl = self._mapNode.dodge,
      sName = "Fire1",
      nHoldThreshold = 0.1
    },
    [2] = {
      skillBtnCtrl = self._mapNode.skill,
      sName = "Fire2",
      nHoldThreshold = 0.1
    },
    [3] = {
      skillBtnCtrl = nil,
      goBtn = self._mapNode.RUN,
      sName = "Fire3",
      nHoldThreshold = 0.2
    },
    [4] = {
      skillBtnCtrl = self._mapNode.ultra,
      sName = "Fire4",
      nHoldThreshold = 0.1
    }
  }
  self.tbDefine_FunctionBtn = {
    [1] = {
      sName = "Interactive",
      nHoldThreshold = 0.1
    }
  }
  self.tbDefine_SupportSkillBtn = {
    [1] = {
      skillBtnCtrl = self._mapNode.supSkill1,
      sName = "ActorSwitch1",
      nHoldThreshold = 0.1
    },
    [2] = {
      skillBtnCtrl = self._mapNode.supSkill2,
      sName = "ActorSwitch2",
      nHoldThreshold = 0.1
    }
  }
  self.tbDefine_SupportUltraBtn = {
    [1] = {
      skillBtnCtrl = self._mapNode.supUltra1,
      sName = "SwitchWithUltra1",
      nHoldThreshold = 0.1,
      nPressThreshold = 0.3
    },
    [2] = {
      skillBtnCtrl = self._mapNode.supUltra2,
      sName = "SwitchWithUltra2",
      nHoldThreshold = 0.1,
      nPressThreshold = 0.3
    }
  }
  self.nCurPlayerId = nil
  self.nCurCharId = nil
  self.v2SkillHintStart = Vector2(0, 19)
  self.v2SkillHintEnd = Vector2(352, 19)
  if NovaAPI.IsMobilePlatform() or NovaAPI.IsEditorPlatform() then
    self._mapNode.goJoystick:SetActive(true)
    NovaAPI.RegisterVirtualJoystick("Horizontal", "Vertical", self._mapNode.goJoystick)
  else
    self._mapNode.goJoystick:SetActive(false)
  end
  local nW = math.floor(Settings.CURRENT_CANVAS_FULL_RECT_WIDTH)
  local nH = math.floor(Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT)
  self._mapNode.rtJoystick.sizeDelta = Vector2(nW / 2, nH * 2 / 3)
  for i, v in ipairs(self.tbDefine_SkillBtn) do
    NovaAPI.RegisterRealButton(v.sName, v.nHoldThreshold)
    local go = v.skillBtnCtrl ~= nil and v.skillBtnCtrl.gameObject or v.goBtn
    NovaAPI.RegisterVirtualButton(v.sName, go)
    NovaAPI.SetButtonExHoldThreshold(go, v.nHoldThreshold)
  end
  for nIndex, v in ipairs(self.tbDefine_FunctionBtn) do
    NovaAPI.RegisterRealButton(v.sName, v.nHoldThreshold)
  end
  for nIndex, v in ipairs(self.tbDefine_SupportSkillBtn) do
    NovaAPI.RegisterVirtualButton(v.sName, v.skillBtnCtrl.gameObject)
    NovaAPI.RegisterRealButton(v.sName, v.nHoldThreshold)
  end
  for nIndex, v in ipairs(self.tbDefine_SupportUltraBtn) do
    NovaAPI.RegisterVirtualButton(v.sName, v.skillBtnCtrl.gameObject)
    NovaAPI.RegisterRealAxisButton(v.sName, v.nHoldThreshold, v.nPressThreshold)
  end
  self:SetKeyLayout()
  self:SetAllVisible(false, false)
  self:SetHandVisible(false)
  self:SetActionBind()
  self.skillTipTime = 0
  self.dodgeTipTime = 0
  self.supportSkillTimeTab = {}
  self.bInteractiveInCD = false
  self.tbBtnHintFx = {}
  self.tbBtnHintTimer = {}
end

function BattleDashboardCtrl:OnEnable()
  self:Refresh(AdventureModuleHelper.GetCurrentActivePlayer())
  self._mapNode.ShowBtn.gameObject:SetActive(false)
  EventManager.Hit("ShowSettingsG", self._mapNode.ShowBtn)
end

function BattleDashboardCtrl:OnPreExit()
  if self.nCurPlayerId ~= nil then
    self:Remove_Skill_EntityEvent(self.nCurPlayerId)
    self.nCurPlayerId = nil
  end
  for i, v in ipairs(self.tbDefine_SupportSkillBtn) do
    if v.nPlayerId ~= nil then
      self:Remove_SupportSkill_EntityEvent(v.nPlayerId, i)
      v.nPlayerId = nil
    end
  end
end

function BattleDashboardCtrl:OnDestroy()
  self:RemoveAllBtnHintEffect()
  NovaAPI.DispatchEventWithData("BlockTouchEffect", nil, {false})
  NovaAPI.UnRegisterVirtualJoystick("Horizontal", "Vertical")
  for nIndex, v in ipairs(self.tbDefine_SkillBtn) do
    NovaAPI.UnRegisterRealButton(v.sName)
    NovaAPI.UnRegisterVirtualButton(v.sName)
  end
  self.tbDefine_SkillBtn = nil
  for nIndex, v in ipairs(self.tbDefine_FunctionBtn) do
    NovaAPI.UnRegisterRealButton(v.sName)
  end
  self.tbDefine_FunctionBtn = nil
  for nIndex, v in ipairs(self.tbDefine_SupportSkillBtn) do
    NovaAPI.UnRegisterVirtualButton(v.sName)
    NovaAPI.UnRegisterRealButton(v.sName)
  end
  self.tbDefine_SupportSkillBtn = nil
  for nIndex, v in ipairs(self.tbDefine_SupportUltraBtn) do
    NovaAPI.UnRegisterVirtualButton(v.sName)
    NovaAPI.UnRegisterRealAxisButton(v.sName)
  end
  self.tbDefine_SupportUltraBtn = nil
end

function BattleDashboardCtrl:SetKeyLayout()
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self:SetKeyPos(self._mapNode.supSkill1.gameObject:GetComponent("RectTransform"), self._mapNode.SupSkill1_Pos_Hor)
    self:SetKeyPos(self._mapNode.supUltra1.gameObject:GetComponent("RectTransform"), self._mapNode.SupUltra1_Pos_Hor)
    self:SetKeyPos(self._mapNode.imgSupRole1.gameObject:GetComponent("RectTransform"), self._mapNode.SupRole1_Pos_Hor)
    self:SetKeyPos(self._mapNode.supSkill2.gameObject:GetComponent("RectTransform"), self._mapNode.SupSkill2_Pos_Hor)
    self:SetKeyPos(self._mapNode.supUltra2.gameObject:GetComponent("RectTransform"), self._mapNode.SupUltra2_Pos_Hor)
    self:SetKeyPos(self._mapNode.imgSupRole2.gameObject:GetComponent("RectTransform"), self._mapNode.SupRole2_Pos_Hor)
    self:SetKeyPos(self._mapNode.dodge.gameObject:GetComponent("RectTransform"), self._mapNode.MainDodge_Pos_Hor)
    self:SetKeyPos(self._mapNode.skill.gameObject:GetComponent("RectTransform"), self._mapNode.MainSkill_Pos_Hor)
    self:SetKeyPos(self._mapNode.ultra.gameObject:GetComponent("RectTransform"), self._mapNode.MainUltra_Pos_Hor)
    local runTra = self._mapNode.RUN.gameObject:GetComponent("RectTransform")
    runTra:SetParent(self._mapNode.MainDodge_Pos_Hor)
    runTra.anchoredPosition = Vector2.zero
  else
    self:SetKeyPos(self._mapNode.supSkill1.gameObject:GetComponent("RectTransform"), self._mapNode.SupSkill1_Pos)
    self:SetKeyPos(self._mapNode.supUltra1.gameObject:GetComponent("RectTransform"), self._mapNode.SupUltra1_Pos)
    self:SetKeyPos(self._mapNode.imgSupRole1.gameObject:GetComponent("RectTransform"), self._mapNode.SupRole1_Pos)
    self:SetKeyPos(self._mapNode.supSkill2.gameObject:GetComponent("RectTransform"), self._mapNode.SupSkill2_Pos)
    self:SetKeyPos(self._mapNode.supUltra2.gameObject:GetComponent("RectTransform"), self._mapNode.SupUltra2_Pos)
    self:SetKeyPos(self._mapNode.imgSupRole2.gameObject:GetComponent("RectTransform"), self._mapNode.SupRole2_Pos)
    self:SetKeyPos(self._mapNode.dodge.gameObject:GetComponent("RectTransform"), self._mapNode.MainDodge_Pos)
    self:SetKeyPos(self._mapNode.skill.gameObject:GetComponent("RectTransform"), self._mapNode.MainSkill_Pos)
    self:SetKeyPos(self._mapNode.ultra.gameObject:GetComponent("RectTransform"), self._mapNode.MainUltra_Pos)
    local runTra = self._mapNode.RUN.gameObject:GetComponent("RectTransform")
    runTra:SetParent(self._mapNode.MainDodge_Pos)
    runTra.anchoredPosition = Vector2.zero
  end
  self._mapNode.supSkill1:SetCDTextSize()
  self._mapNode.supUltra1:SetCDTextSize()
  self._mapNode.supSkill2:SetCDTextSize()
  self._mapNode.supUltra2:SetCDTextSize()
  self._mapNode.dodge:SetCDTextSize()
  self._mapNode.skill:SetCDTextSize()
  self._mapNode.ultra:SetCDTextSize()
  self._mapNode.imgBg_SupportRole:SetActive(nType == AllEnum.BattleHudType.Sector)
end

function BattleDashboardCtrl:SetKeyPos(btnTra, parentTra)
  btnTra:SetParent(parentTra)
  btnTra.anchoredPosition = Vector2.zero
  btnTra.localScale = Vector3.one
end

function BattleDashboardCtrl:SetAllVisible(bVisible, bInteractable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgJoystick, bVisible == true and 0.3 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgJoystick, bInteractable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgJoystick, bInteractable == true)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgMainRole, bVisible == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgMainRole, bVisible == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgMainRole, bVisible == true)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgSupRole, bVisible == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgSupRole, bVisible == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgSupRole, bVisible == true)
end

function BattleDashboardCtrl:SetHandVisible(bVisible)
  if self._mapNode.trHand.localScale.x == 0 and bVisible == true then
    self._mapNode.animBtnHand:SetTrigger("tPlay")
  end
  self._mapNode.trHand.localScale = bVisible == true and Vector3.one or Vector3.zero
end

function BattleDashboardCtrl:SetHandEnable(bEnable)
  self._mapNode.btnHand.interactable = bEnable == true
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgHand, bEnable == true and 1 or 0.3)
end

function BattleDashboardCtrl:OnEvent_BattleDashboardVisible(bVisible)
  if bVisible then
    local bEnable = NovaAPI.IsInputEnabled()
    self:SetAllVisible(bEnable, bEnable)
  else
    self:SetAllVisible(false, false)
  end
end

function BattleDashboardCtrl:OnEvent_LevelUnloadComplete()
  self:RemoveAllBtnHintEffect()
end

function BattleDashboardCtrl:OnEvent_LoadLevelRefresh()
  self:Refresh(AdventureModuleHelper.GetCurrentActivePlayer())
end

function BattleDashboardCtrl:OnEvent_InputEnable(bEnable, bEnableByTrans)
  if bEnableByTrans == true then
    if bEnable == true and self.ENABLE == false then
      return
    end
  else
    self.ENABLE = bEnable
  end
  NovaAPI.DispatchEventWithData("BlockTouchEffect", nil, {bEnable})
  self:SetAllVisible(bEnable == true, true)
  NovaAPI.SetRealButtonActive("Fire1", bEnable and self.tbDefine_SkillBtn[1].skillBtnCtrl:GetBtnVisible())
  local fire2Btn = self.tbDefine_SkillBtn[2].skillBtnCtrl
  NovaAPI.SetRealButtonActive("Fire2", bEnable and fire2Btn:GetBtnVisible() and fire2Btn.canFresh)
  NovaAPI.SetRealButtonActive("Fire4", bEnable and self.tbDefine_SkillBtn[4].skillBtnCtrl:GetBtnVisible())
  NovaAPI.SetRealButtonActive("Interactive", bEnable)
  NovaAPI.SetRealButtonActive("ActorSwitch1", bEnable and self.tbDefine_SupportSkillBtn[1].skillBtnCtrl:GetBtnVisible())
  NovaAPI.SetRealButtonActive("ActorSwitch2", bEnable and self.tbDefine_SupportSkillBtn[2].skillBtnCtrl:GetBtnVisible())
  NovaAPI.SetRealButtonActive("SwitchWithUltra1", bEnable and self.tbDefine_SupportUltraBtn[1].skillBtnCtrl:GetBtnVisible())
  NovaAPI.SetRealButtonActive("SwitchWithUltra2", bEnable and self.tbDefine_SupportUltraBtn[2].skillBtnCtrl:GetBtnVisible())
  self._mapNode.trSkillHint.localScale = bEnable == true and Vector3.one or Vector3.zero
end

function BattleDashboardCtrl:OnEvent_AliveChanged(nPlayerId, bAlive)
end

function BattleDashboardCtrl:OnEvent_EnableBtnControl(sBtnNames, bEnable)
  local tbName = string.split(sBtnNames, "+")
  if tbName ~= nil then
    for i, sName in pairs(tbName) do
      if type(sName) == "string" and sName ~= "" then
        if sName == "Fire1" then
          self.tbDefine_SkillBtn[1].skillBtnCtrl:SetBtnVisible(bEnable)
        elseif sName == "Fire2" then
          self.tbDefine_SkillBtn[2].skillBtnCtrl:SetBtnVisible(bEnable)
        elseif sName == "Fire4" then
          self.tbDefine_SkillBtn[4].skillBtnCtrl:SetBtnVisible(bEnable)
        elseif sName == "Interactive" then
          self:SetHandEnable(bEnable)
        elseif sName == "ActorSwitch1" then
          self.tbDefine_SupportSkillBtn[1].skillBtnCtrl:SetBtnVisible(bEnable)
          self._mapNode.imgSupRole1.gameObject:SetActive(bEnable)
          local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
          self._mapNode.imgBg_SupportRole:SetActive(bEnable and nType == AllEnum.BattleHudType.Sector)
        elseif sName == "ActorSwitch2" then
          self.tbDefine_SupportSkillBtn[2].skillBtnCtrl:SetBtnVisible(bEnable)
          self._mapNode.imgSupRole2.gameObject:SetActive(bEnable)
        elseif sName == "SwitchWithUltra1" then
          self.tbDefine_SupportUltraBtn[1].skillBtnCtrl:SetBtnVisible(bEnable)
        elseif sName == "SwitchWithUltra2" then
          self.tbDefine_SupportUltraBtn[2].skillBtnCtrl:SetBtnVisible(bEnable)
        end
        NovaAPI.SetRealButtonActive(sName, bEnable)
      end
    end
  end
end

function BattleDashboardCtrl:OnEvent_HintButton(sBtnNames, bPlayHintEffect)
  local tbName = string.split(sBtnNames, "+")
  if tbName ~= nil then
    for i, sName in pairs(tbName) do
      if type(sName) == "string" and sName ~= "" then
        self:ScheduleBtnHintEffect(sName, bPlayHintEffect == true)
      end
    end
  end
end

function BattleDashboardCtrl:GetBtnHintRoot(sName)
  if sName == "Fire1" then
    return self.tbDefine_SkillBtn[1].skillBtnCtrl.gameObject.transform
  elseif sName == "Fire2" then
    return self.tbDefine_SkillBtn[2].skillBtnCtrl.gameObject.transform
  elseif sName == "Fire4" then
    return self.tbDefine_SkillBtn[4].skillBtnCtrl.gameObject.transform
  elseif sName == "Interactive" then
    return self._mapNode.trHand
  elseif sName == "ActorSwitch1" then
    return self.tbDefine_SupportSkillBtn[1].skillBtnCtrl.gameObject.transform
  elseif sName == "ActorSwitch2" then
    return self.tbDefine_SupportSkillBtn[2].skillBtnCtrl.gameObject.transform
  elseif sName == "SwitchWithUltra1" then
    return self.tbDefine_SupportUltraBtn[1].skillBtnCtrl.gameObject.transform
  elseif sName == "SwitchWithUltra2" then
    return self.tbDefine_SupportUltraBtn[2].skillBtnCtrl.gameObject.transform
  end
  return nil
end

function BattleDashboardCtrl:ScheduleBtnHintEffect(sName, bImmediate)
  self:RemoveBtnHintEffect(sName)
  if bImmediate == true then
    self:PlayBtnHintEffect(sName)
    return
  end
  self.tbBtnHintTimer[sName] = self:AddTimer(1, HINT_EFFECT_SHOW_DELAY, function()
    self.tbBtnHintTimer[sName] = nil
    self:PlayBtnHintEffect(sName)
  end, true, true, true)
end

function BattleDashboardCtrl:OnEvent_HintUltraButton(sName)
  if type(sName) ~= "string" or sName == "" then
    return
  end
  self:ScheduleBtnHintEffect(sName, true)
end

function BattleDashboardCtrl:PlayBtnHintEffect(sName)
  local trRoot = self:GetBtnHintRoot(sName)
  if trRoot == nil then
    return
  end
  local goFx = self:CreatePrefabInstance(HINT_EFFECT_PREFAB_PATH, trRoot)
  if goFx == nil then
    return
  end
  goFx.transform.localScale = Vector3(HINT_EFFECT_SCALE, HINT_EFFECT_SCALE, 1)
  goFx.transform.localPosition = Vector3.zero
  local trEffect = goFx.transform:Find("Effect" .. HINT_EFFECT_INDEX)
  if trEffect ~= nil then
    trEffect.gameObject:SetActive(true)
  end
  self._mapPrefab[HINT_EFFECT_PREFAB_PATH] = nil
  self.tbBtnHintFx[sName] = goFx
end

function BattleDashboardCtrl:RemoveBtnHintEffect(sName)
  local timer = self.tbBtnHintTimer[sName]
  if timer ~= nil then
    timer:Cancel()
    self.tbBtnHintTimer[sName] = nil
  end
  local goFx = self.tbBtnHintFx[sName]
  if goFx ~= nil then
    destroy(goFx)
    self.tbBtnHintFx[sName] = nil
  end
end

function BattleDashboardCtrl:RemoveAllBtnHintEffect()
  if self.tbBtnHintTimer ~= nil then
    for _, timer in pairs(self.tbBtnHintTimer) do
      if timer ~= nil then
        timer:Cancel()
      end
    end
    self.tbBtnHintTimer = {}
  end
  if self.tbBtnHintFx ~= nil then
    for _, goFx in pairs(self.tbBtnHintFx) do
      if goFx ~= nil then
        destroy(goFx)
      end
    end
    self.tbBtnHintFx = {}
  end
end

function BattleDashboardCtrl:OnEvent_ShowHand(nInteractiveId, bShowUI, sIcon, sText, nDuration)
  if bShowUI ~= true and self.nInteractiveId ~= nInteractiveId then
    return
  end
  printLog("交互id" .. tostring(nInteractiveId))
  self.nInteractiveId = nInteractiveId
  self.bShowUI = bShowUI
  self:SetHandVisible(self.bShowUI)
  self:SetHandEnable(self.bInteractiveInCD ~= true and bShowUI == true)
  NovaAPI.SetTMPText(self._mapNode.tmpInteract[1], sText)
  NovaAPI.SetTMPText(self._mapNode.tmpInteract[2], sText)
  if type(sIcon) == "string" and sIcon ~= "" then
    self:SetPngSprite(self._mapNode.imgHandIcon, sIcon)
    NovaAPI.SetImageNativeSize(self._mapNode.imgHandIcon)
  end
end

function BattleDashboardCtrl:OnEvent_ClickHand()
  self:OnBtn_ClickHand()
end

function BattleDashboardCtrl:OnEvent_SkillHintStart(nSkillId, nMax, bReverse, nRemain)
  if self.nHoldSkillId == nil or self.nHoldSkillId ~= nSkillId then
    if self.tweenerHoldSkill ~= nil then
      self.tweenerHoldSkill:Kill()
      self.tweenerHoldSkill = nil
    end
    self.nHoldSkillId = nSkillId
    local mapCfgData_Skill = ConfigTable.GetData_Skill(nSkillId)
    if mapCfgData_Skill ~= nil then
      self:SetPngSprite(self._mapNode.imgSkillIHintcon, mapCfgData_Skill.Icon)
    else
      NovaAPI.SetImageSpriteAsset(self._mapNode.imgSkillIHintcon, nil)
    end
    local v2Start, v2End = self.v2SkillHintStart, self.v2SkillHintEnd
    if bReverse == true then
      v2Start, v2End = self.v2SkillHintEnd, self.v2SkillHintStart
    end
    if nMax == nil then
      nMax = 1
    end
    if nMax <= 0 then
      nMax = 1
    end
    if nRemain ~= nil and 0 <= nRemain and nRemain <= nMax then
      local nCur = nMax - nRemain
      if bReverse == true then
        local nPercent = 1 - nCur / nMax
        v2Start = Vector2(v2Start.x * nPercent, v2Start.y)
      else
        local nPercent = nCur / nMax
        v2Start = Vector2(v2End.x * nPercent, v2End.y)
      end
    end
    self._mapNode.rtSkillHintProgress.sizeDelta = v2Start
    self._mapNode.trHoldSkill.localScale = Vector3.one
    self.tweenerHoldSkill = self._mapNode.rtSkillHintProgress:DOSizeDelta(v2End, nMax):SetEase(Ease.Linear)
    self.tweenerHoldSkill:SetUpdate(CS.DG.Tweening.UpdateType.Manual)
  end
end

function BattleDashboardCtrl:OnEvent_SkillHintEnd(nSkillId)
  if self.tweenerHoldSkill ~= nil then
    self.tweenerHoldSkill:Kill()
    self.tweenerHoldSkill = nil
  end
  self.nHoldSkillId = nil
  self._mapNode.rtSkillHintProgress.sizeDelta = self.v2SkillHintStart
  self._mapNode.trHoldSkill.localScale = Vector3.zero
end

function BattleDashboardCtrl:OnEvent_SkillHintActive(nSkillId, bActive)
  for i, v in ipairs(self.tbDefine_SkillBtn) do
    if v.nSkillId == nSkillId and v.skillBtnCtrl ~= nil then
      v.skillBtnCtrl:Set_SkillHintActive(bActive)
    end
  end
end

function BattleDashboardCtrl:OnEvent_UseSkillSucc(nCharId, nSkillId)
  for i, v in ipairs(self.tbDefine_SkillBtn) do
    if v.nCharId == nCharId and v.nSkillId == nSkillId and v.skillBtnCtrl ~= nil then
      v.skillBtnCtrl:SetMainAlpha(false)
      self:RemoveBtnHintEffect(v.sName)
    end
  end
  for i, v in ipairs(self.tbDefine_SupportSkillBtn) do
    if v.nSkillId == nSkillId and v.skillBtnCtrl ~= nil then
      v.skillBtnCtrl:SetMainAlpha(false)
      self:RemoveBtnHintEffect(v.sName)
    end
  end
  for i, v in ipairs(self.tbDefine_SupportUltraBtn) do
    if v.nSkillId == nSkillId and v.skillBtnCtrl ~= nil then
      v.skillBtnCtrl:SetMainAlpha(false)
      self:RemoveBtnHintEffect(v.sName)
    end
  end
end

function BattleDashboardCtrl:OnEvent_EnableTeamUltra(b)
end

function BattleDashboardCtrl:OnEvent_PrologueBattleOpenBattleDash(bEnable)
  self:SetAllVisible(bEnable, bEnable)
end

function BattleDashboardCtrl:Refresh(nCurPlayerId)
  if nCurPlayerId == nil or nCurPlayerId <= 0 or nCurPlayerId == self.nCurPlayerId then
    self:SetAllVisible(false)
    return
  end
  if self.nCurPlayerId ~= nil then
    self:Remove_Skill_EntityEvent(self.nCurPlayerId)
  end
  self.nCurPlayerId = nCurPlayerId
  self.nCurCharId = AdventureModuleHelper.GetCharacterId(self.nCurPlayerId)
  for i, v in ipairs(self.tbDefine_SkillBtn) do
    if v.skillBtnCtrl ~= nil then
      v.nPlayerId = self.nCurPlayerId
      v.nCharId = self.nCurCharId
      v.nSkillId = AdventureModuleHelper.GetCurrentActorBindSkillId(self.nCurPlayerId, i)
      local EET = 0
      if i == 2 or i == 4 then
        EET = ConfigTable.GetData_Character(self.nCurCharId).EET
      end
      local skilldata = ConfigTable.GetData_Skill(v.nSkillId)
      if skilldata ~= nil then
        v.skillBtnCtrl:InitSkillBtn(EET, skilldata.Icon, skilldata.SectionAmount > 1, self.nCurCharId, i, false, 0 < skilldata.UltraEnergy)
      end
    end
  end
  self:Add_Skill_EntityEvent(self.nCurPlayerId)
  AdventureModuleHelper.ForceSyncSkillBtnToLua(self.nCurPlayerId)
  for i = 1, 2 do
    local bSuccess, nSupportCharId, nSupportPlayerId, nSkillId_support, nSkillId_ultra, skilldata = false, 0, 0, 0, 0
    if i == 1 then
      bSuccess, nSupportCharId, nSupportPlayerId = AdventureModuleHelper.GetFirstSlotPlayer()
    elseif i == 2 then
      bSuccess, nSupportCharId, nSupportPlayerId = AdventureModuleHelper.GetSecondSlotPlayer()
    end
    if nSupportPlayerId ~= 0 then
      nSkillId_support = AdventureModuleHelper.GetCurrentActorBindSkillId(nSupportPlayerId, 2)
      nSkillId_ultra = AdventureModuleHelper.GetCurrentActorBindSkillId(nSupportPlayerId, 4)
    end
    if self.tbDefine_SupportSkillBtn[i].nPlayerId ~= nil then
      self:Remove_SupportSkill_EntityEvent(self.tbDefine_SupportSkillBtn[i].nPlayerId, i)
    end
    if nSupportCharId ~= 0 and nSupportPlayerId ~= 0 then
      self.tbDefine_SupportSkillBtn[i].nPlayerId = nSupportPlayerId
      self.tbDefine_SupportSkillBtn[i].nCharId = nSupportCharId
      self.tbDefine_SupportUltraBtn[i].nPlayerId = nSupportPlayerId
      self.tbDefine_SupportUltraBtn[i].nCharId = nSupportCharId
      self.supportSkillTimeTab[nSupportCharId] = 0
      local supportCharEET = ConfigTable.GetData_Character(nSupportCharId).EET
      skilldata = ConfigTable.GetData_Skill(nSkillId_support)
      if skilldata ~= nil then
        self.tbDefine_SupportSkillBtn[i].nSkillId = nSkillId_support
        self.tbDefine_SupportSkillBtn[i].skillBtnCtrl:InitSkillBtn(supportCharEET, skilldata.Icon, skilldata.SectionAmount > 1, nSupportCharId, 2, true, 0 < skilldata.UltraEnergy)
      else
        self.tbDefine_SupportSkillBtn[i].skillBtnCtrl:SetEmptySkillBtn()
        self.tbDefine_SupportSkillBtn[i].skillBtnCtrl:SetBtnEnable(false)
      end
      skilldata = ConfigTable.GetData_Skill(nSkillId_ultra)
      if skilldata ~= nil then
        self.tbDefine_SupportUltraBtn[i].nSkillId = nSkillId_ultra
        self.tbDefine_SupportUltraBtn[i].skillBtnCtrl:InitSkillBtn(supportCharEET, skilldata.Icon, skilldata.SectionAmount > 1, nSupportCharId, 4, true, 0 < skilldata.UltraEnergy)
      else
        self.tbDefine_SupportUltraBtn[i].skillBtnCtrl:SetEmptySkillBtn()
        self.tbDefine_SupportUltraBtn[i].skillBtnCtrl:SetBtnEnable(false)
      end
      local nSkinId = PlayerCharData:GetCharSkinId(nSupportCharId)
      local mapCfgData_Skin = ConfigTable.GetData_CharacterSkin(nSkinId)
      local img
      if i == 1 then
        img = self._mapNode.imgSupRole1
      elseif i == 2 then
        img = self._mapNode.imgSupRole2
      end
      local spHead = mapCfgData_Skin ~= nil and self:GetPngSprite(mapCfgData_Skin.Icon, AllEnum.CharHeadIconSurfix.L, img) or nil
      NovaAPI.SetImageSpriteAsset(img, spHead)
      NovaAPI.SetImageColor(img, Color(1, 1, 1, 1))
      self:Add_SupportSkill_EntityEvent(nSupportPlayerId, i)
      AdventureModuleHelper.ForceSyncSkillBtnToLua(nSupportPlayerId)
    else
      self.tbDefine_SupportSkillBtn[i].skillBtnCtrl:SetEmptySkillBtn()
      self.tbDefine_SupportUltraBtn[i].skillBtnCtrl:SetEmptySkillBtn()
      NovaAPI.SetImageColor(self._mapNode["imgSupRole" .. i], Color(0, 0, 0, 0))
    end
  end
  self._mapNode.RUN.transform.localScale = Vector3.zero
end

function BattleDashboardCtrl:Add_Skill_EntityEvent(nPlayerId)
  EventManager.AddEntityEvent("SkillBind", nPlayerId, self, self.OnEvent_SkillBind)
  EventManager.AddEntityEvent("SyncSkillBtnToLua", nPlayerId, self, self.OnEvent_SyncSkillBtnToLua)
  EventManager.AddEntityEvent("SkillUseableByActionKey", nPlayerId, self, self.OnEvent_SkillEnableByActionKey)
  EventManager.AddEntityEvent("SkillResidentHint", nPlayerId, self, self.OnEvent_SkillResidentHint)
end

function BattleDashboardCtrl:Remove_Skill_EntityEvent(nPlayerId)
  EventManager.RemoveEntityEvent("SkillBind", nPlayerId, self, self.OnEvent_SkillBind)
  EventManager.RemoveEntityEvent("SyncSkillBtnToLua", nPlayerId, self, self.OnEvent_SyncSkillBtnToLua)
  EventManager.RemoveEntityEvent("SkillUseableByActionKey", nPlayerId, self, self.OnEvent_SkillEnableByActionKey)
  EventManager.RemoveEntityEvent("SkillResidentHint", nPlayerId, self, self.OnEvent_SkillResidentHint)
end

function BattleDashboardCtrl:Add_SupportSkill_EntityEvent(nPlayerId, nIdx)
  EventManager.AddEntityEvent("SkillBind", nPlayerId, self, self.OnEvent_SkillBind)
  EventManager.AddEntityEvent("SyncSkillBtnToLua", nPlayerId, self, self.OnEvent_SyncSkillBtnToLua)
  if nIdx == 1 then
    EventManager.AddEntityEvent("SkillUseableByActionKey", nPlayerId, self, self.OnEvent_Support1SkillEnableByActionKey)
  else
    EventManager.AddEntityEvent("SkillUseableByActionKey", nPlayerId, self, self.OnEvent_Support2SkillEnableByActionKey)
  end
  EventManager.AddEntityEvent("SkillResidentHint", nPlayerId, self, self.OnEvent_SupportSkillResidentHint)
end

function BattleDashboardCtrl:Remove_SupportSkill_EntityEvent(nPlayerId, nIdx)
  EventManager.RemoveEntityEvent("SkillBind", nPlayerId, self, self.OnEvent_SkillBind)
  EventManager.RemoveEntityEvent("SyncSkillBtnToLua", nPlayerId, self, self.OnEvent_SyncSkillBtnToLua)
  if nIdx == 1 then
    EventManager.RemoveEntityEvent("SkillUseableByActionKey", nPlayerId, self, self.OnEvent_Support1SkillEnableByActionKey)
  else
    EventManager.RemoveEntityEvent("SkillUseableByActionKey", nPlayerId, self, self.OnEvent_Support2SkillEnableByActionKey)
  end
  EventManager.RemoveEntityEvent("SkillResidentHint", nPlayerId, self, self.OnEvent_SupportSkillResidentHint)
end

function BattleDashboardCtrl:OnEvent_SkillBind(nActionId, nSkillId, nCharId)
  local data
  if self.tbDefine_SkillBtn[nActionId] ~= nil and self.tbDefine_SkillBtn[nActionId].nCharId == nCharId then
    data = self.tbDefine_SkillBtn[nActionId]
  end
  if data == nil and nActionId == 2 then
    for i, v in ipairs(self.tbDefine_SupportSkillBtn) do
      if v.nCharId == nCharId then
        data = v
        break
      end
    end
  end
  if data == nil and nActionId == 4 then
    for i, v in ipairs(self.tbDefine_SupportUltraBtn) do
      if v.nCharId == nCharId then
        data = v
        break
      end
    end
  end
  if data == nil then
    return
  end
  data.nSkillId = nSkillId
  local EET = 0
  if nActionId == 2 or nActionId == 4 then
    EET = ConfigTable.GetData_Character(nCharId).EET
  end
  local skilldata = ConfigTable.GetData_Skill(nSkillId)
  if skilldata ~= nil then
    data.skillBtnCtrl:InitSkillBtn(EET, skilldata.Icon, skilldata.SectionAmount > 1, nCharId, nActionId, false, 0 < skilldata.UltraEnergy)
  end
end

function BattleDashboardCtrl:OnEvent_SyncSkillBtnToLua(arrayData, bLocking, bBeginResume, bCanUseAssitSkill)
  local nSkillId = arrayData[0]
  local skillBtnCtrl
  local bIsUltra = false
  local bIsAssitSkill = false
  for i, v in ipairs(self.tbDefine_SkillBtn) do
    if v.nSkillId == nSkillId then
      skillBtnCtrl = v.skillBtnCtrl
      bIsUltra = i == 4
      break
    end
  end
  if skillBtnCtrl == nil then
    for i, v in ipairs(self.tbDefine_SupportSkillBtn) do
      if v.nSkillId == nSkillId then
        skillBtnCtrl = v.skillBtnCtrl
        bIsAssitSkill = true
        break
      end
    end
  end
  if skillBtnCtrl == nil then
    bIsUltra = true
    for i, v in ipairs(self.tbDefine_SupportUltraBtn) do
      if v.nSkillId == nSkillId then
        skillBtnCtrl = v.skillBtnCtrl
        break
      end
    end
  end
  if skillBtnCtrl ~= nil then
    local nIntervalPercent = arrayData[1]
    local nSectionPercent = arrayData[2]
    local nUseTimeHintPercent = arrayData[3]
    local nEnergyPercent = arrayData[4]
    local nInterval = arrayData[5]
    local nSectionResume = arrayData[6]
    local nSectionNum = math.floor(arrayData[7])
    local nTotalSectionNum = math.floor(arrayData[8])
    if nSectionNum <= 0 then
      nIntervalPercent = 1 - nSectionPercent
      nInterval = nSectionResume
    end
    if bIsUltra == true then
      nSectionPercent = nEnergyPercent
    end
    if bIsAssitSkill ~= true then
      bCanUseAssitSkill = true
    end
    skillBtnCtrl:RefreshBtn(bCanUseAssitSkill, nUseTimeHintPercent, nIntervalPercent, nInterval, nSectionPercent, nSectionNum, nTotalSectionNum, bBeginResume)
  end
end

function BattleDashboardCtrl:OnEvent_SkillEnableByActionKey(nActionId, bEnable)
  local data = self.tbDefine_SkillBtn[nActionId]
  data.skillBtnCtrl:SetForbidden(bEnable == false)
end

function BattleDashboardCtrl:OnEvent_Support1SkillEnableByActionKey(nActionId, bEnable)
  if nActionId == 2 then
    local data = self.tbDefine_SupportSkillBtn[1]
    data.skillBtnCtrl:SetBtnEnable(bEnable)
  elseif nActionId == 4 then
    local data = self.tbDefine_SupportUltraBtn[1]
    data.skillBtnCtrl:SetBtnEnable(bEnable)
  end
end

function BattleDashboardCtrl:OnEvent_Support2SkillEnableByActionKey(nActionId, bEnable)
  if nActionId == 2 then
    local data = self.tbDefine_SupportSkillBtn[2]
    data.skillBtnCtrl:SetBtnEnable(bEnable)
  elseif nActionId == 4 then
    local data = self.tbDefine_SupportUltraBtn[2]
    data.skillBtnCtrl:SetBtnEnable(bEnable)
  end
end

function BattleDashboardCtrl:OnEvent_SkillResidentHint(nSkillId, bEnable)
  for k, v in pairs(self.tbDefine_SkillBtn) do
    if v.nSkillId == nSkillId and v.skillBtnCtrl ~= nil then
      v.skillBtnCtrl:Set_LightGroup(bEnable == true)
      return
    end
  end
end

function BattleDashboardCtrl:OnEvent_SupportSkillResidentHint(nSkillId, bEnable)
  for k, v in pairs(self.tbDefine_SupportSkillBtn) do
    if v.nSkillId == nSkillId and v.skillBtnCtrl ~= nil then
      v.skillBtnCtrl:Set_LightGroup(bEnable == true)
      return
    end
  end
end

function BattleDashboardCtrl:OnBtn_ClickHand(btn)
  if self.bInteractiveInCD == true then
    return
  end
  if self.bShowUI ~= true then
    return
  end
  printLog("发送时交互id" .. tostring(self.nInteractiveId))
  local bSuccess = safe_call_cs_func(InteractiveManagerIns.setInteractiveObjState, InteractiveManagerIns, self.nInteractiveId)
  self._mapNode.trHand.localScale = bSuccess == true and Vector3.zero or Vector3.one
  self.bInteractiveInCD = true
  self._mapNode.btnHand.interactable = false
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgHand, 0.3)
  self:AddTimer(1, 0.2, "SetBtnHandInteractable", true, true, true)
  EventManager.Hit("InteractiveBtnClick")
end

function BattleDashboardCtrl:SetBtnHandInteractable()
  self.bInteractiveInCD = false
  self._mapNode.btnHand.interactable = true
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgHand, 1)
end

function BattleDashboardCtrl:SetProgressFx(tr1, tr2, nPercent)
  if 0.02 <= nPercent and nPercent < 1 then
    local v3 = Vector3(0, 0, -nPercent * 360)
    tr1.localScale = Vector3.one
    tr1.localEulerAngles = v3
    tr2.localScale = Vector3.one
    tr2.localEulerAngles = v3
  else
    tr1.localScale = Vector3.zero
    tr2.localScale = Vector3.zero
  end
end

function BattleDashboardCtrl:PlaySkillInLineAnim(nSkillId)
  if nSkillId == self.nSkillInLineStartId then
    self.bInLineStarted = nil
    for i = 0, 2 do
      local trChild = self._mapNode.trSkillChange:GetChild(i)
      local anim = trChild:GetComponent("Animator")
      local stateInfo = anim:GetCurrentAnimatorStateInfo()
      if stateInfo:IsName("skill_line_1st_in") == true or stateInfo:IsName("skill_line_in") == true or stateInfo:IsName("skill_line_already_in") == true then
        anim:SetTrigger("tHide")
      end
    end
  elseif self.bInLineStarted == nil then
    self.bInLineStarted = true
    local tr_0 = self._mapNode.trSkillChange:GetChild(0)
    local anim_0 = tr_0:GetComponent("Animator")
    local img_0 = tr_0:Find("imgBg/imgIcon"):GetComponent("Image")
    local mapCfgData_0 = ConfigTable.GetData_Skill(self.nSkillInLineStartId)
    if mapCfgData_0 ~= nil then
      self:SetPngSprite(img_0, mapCfgData_0.Icon)
    else
      NovaAPI.SetImageSpriteAsset(img_0, nil)
    end
    local tr_1 = self._mapNode.trSkillChange:GetChild(1)
    local anim_1 = tr_1:GetComponent("Animator")
    local img_1 = tr_1:Find("imgBg/imgIcon"):GetComponent("Image")
    local mapCfgData_1 = ConfigTable.GetData_Skill(nSkillId)
    if mapCfgData_1 ~= nil then
      self:SetPngSprite(img_1, mapCfgData_1.Icon)
    else
      NovaAPI.SetImageSpriteAsset(img_1, nil)
    end
    tr_0.gameObject.name = tostring(self.nSkillInLineStartId)
    tr_0:SetAsLastSibling()
    anim_0:SetTrigger("t1stIn")
    tr_1.gameObject.name = tostring(nSkillId)
    tr_1:SetAsLastSibling()
    anim_1:SetTrigger("tIn")
  else
    local tr_0 = self._mapNode.trSkillChange:GetChild(0)
    local anim_0 = tr_0:GetComponent("Animator")
    local img_0 = tr_0:Find("imgBg/imgIcon"):GetComponent("Image")
    local mapCfgData_0 = ConfigTable.GetData_Skill(nSkillId)
    if mapCfgData_0 ~= nil then
      self:SetPngSprite(img_0, mapCfgData_0.Icon)
    else
      NovaAPI.SetImageSpriteAsset(img_0, nil)
    end
    local tr_1 = self._mapNode.trSkillChange:GetChild(1)
    local anim_1 = tr_1:GetComponent("Animator")
    local tr_2 = self._mapNode.trSkillChange:GetChild(2)
    local anim_2 = tr_2:GetComponent("Animator")
    tr_0:SetAsLastSibling()
    anim_0:SetTrigger("tIn")
    anim_1:SetTrigger("tOut")
    anim_2:SetTrigger("tAlreadyIn")
  end
end

function BattleDashboardCtrl:OnEvent_SkillUnExecutableTips(skillType, duration)
  local timeNow = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  if skillType == 4 then
    if duration > timeNow - self.skillTipTime then
      return
    end
    local strTips = ConfigTable.GetUIText("Character_UnExecutable_Skill")
    EventManager.Hit(EventId.OpenMessageBox, strTips)
    self.skillTipTime = timeNow
  else
    if duration > timeNow - self.dodgeTipTime then
      return
    end
    local strTips = ConfigTable.GetUIText("Character_UnExecutable_Dodge")
    EventManager.Hit(EventId.OpenMessageBox, strTips)
    self.dodgeTipTime = timeNow
  end
end

function BattleDashboardCtrl:OnEvent_SupUltraState(charId, isForbidden)
  for i, v in pairs(self.tbDefine_SupportSkillBtn) do
    if v.nCharId == charId then
      v.skillBtnCtrl:SetSupSkillStateByUltimate(isForbidden)
    end
  end
end

function BattleDashboardCtrl:OnEvent_SupportSkillUnExecutableTips(dataID, duration)
  local timeNow = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  if duration > timeNow - self.supportSkillTimeTab[dataID] then
    return
  end
  for i, v in pairs(self.tbDefine_SupportSkillBtn) do
    if v.nCharId == dataID and v.skillBtnCtrl:GetSupSkillForbidden() then
      return
    end
  end
  local strTips = ConfigTable.GetUIText("Character_UnExecutable_Skill")
  EventManager.Hit(EventId.OpenMessageBox, strTips)
  self.supportSkillTimeTab[dataID] = timeNow
end

function BattleDashboardCtrl:OnEvent_ShowOrHideBattleDash(isShow)
  self.gameObject:SetActive(isShow)
end

function BattleDashboardCtrl:OnEvent_ChangeSkillIcon(nSkillId, nIconIdx)
  if type(nSkillId) ~= "number" or type(nIconIdx) ~= "number" then
    return
  end
  local ctrl
  if ctrl == nil then
    for k, v in pairs(self.tbDefine_SkillBtn) do
      if v.nSkillId == nSkillId then
        ctrl = v.skillBtnCtrl
        break
      end
    end
  end
  if ctrl == nil then
    for k, v in pairs(self.tbDefine_SupportSkillBtn) do
      if v.nSkillId == nSkillId then
        ctrl = v.skillBtnCtrl
        break
      end
    end
  end
  if ctrl == nil then
    for k, v in pairs(self.tbDefine_SupportUltraBtn) do
      if v.nSkillId == nSkillId then
        ctrl = v.skillBtnCtrl
        break
      end
    end
  end
  if ctrl ~= nil then
    local mapCfgData = ConfigTable.GetData_Skill(nSkillId)
    if mapCfgData ~= nil then
      if nIconIdx == -1 then
        ctrl:ChangeSkillIcon(mapCfgData.Icon)
      elseif type(mapCfgData.IconEx) == "table" then
        ctrl:ChangeSkillIcon(mapCfgData.IconEx[nIconIdx])
      end
    end
  end
end

function BattleDashboardCtrl:OnEvent_BtnStateChange(sBtnName, nBtnState)
  local function func_CheckBtnState(tb)
    for i, v in ipairs(tb) do
      if v.sName == sBtnName and v.skillBtnCtrl ~= nil then
        v.skillBtnCtrl:BtnStateChange(nBtnState)
      end
    end
  end
  
  func_CheckBtnState(self.tbDefine_SkillBtn)
  func_CheckBtnState(self.tbDefine_SupportSkillBtn)
  func_CheckBtnState(self.tbDefine_SupportUltraBtn)
end

function BattleDashboardCtrl:OnEvent_CanRush(bEnableRush)
  self._mapNode.RUN.transform.localScale = bEnableRush == true and Vector3.one or Vector3.zero
end

function BattleDashboardCtrl:OnEvent_SetVariableJoystickMode()
  if not NovaAPI.IsMobilePlatform() then
    return
  end
  NovaAPI.SetVariableJoystickMode(self._mapNode.goJoystick)
end

function BattleDashboardCtrl:OnEvent_SwitchUI()
  PanelManager.SwitchUI()
end

function BattleDashboardCtrl:OnEvent_SwitchSkillBtn()
  PanelManager.SwitchSkillBtn()
end

function BattleDashboardCtrl:SetActionBind()
  local function set(config)
    local bHas, tbControl = InputManagerIns:GetInputActionConfig(config.sName)
    
    if bHas then
      local sGamepadBind, mapKeyboardBind = "", {name = "", displayName = ""}
      for i = 0, tbControl.Count - 1 do
        local mapControl = tbControl[i]
        if mapControl.isGamepad then
          sGamepadBind = mapControl.name
        elseif (mapControl.isKeyboard or mapControl.isMouse) and mapKeyboardBind.name == "" then
          mapKeyboardBind.name = mapControl.name
          mapKeyboardBind.displayName = mapControl.displayName
        end
      end
      if config.skillBtnCtrl then
        config.skillBtnCtrl:SetActionBind(sGamepadBind, mapKeyboardBind)
      elseif config.sName == "Interactive" then
        self._mapNode.ActionHand:SetActionBind(sGamepadBind, mapKeyboardBind)
      end
    end
  end
  
  for _, v in ipairs(self.tbDefine_SkillBtn) do
    set(v)
  end
  for _, v in ipairs(self.tbDefine_FunctionBtn) do
    set(v)
  end
  for _, v in ipairs(self.tbDefine_SupportSkillBtn) do
    set(v)
  end
  for _, v in ipairs(self.tbDefine_SupportUltraBtn) do
    set(v)
  end
end

function BattleDashboardCtrl:OnEvent_BattleSettingsBindingOverride()
  self:SetActionBind()
end

function BattleDashboardCtrl:OnEvent_ExecuteRealButton(key)
  if key == "A" then
    local bEnable = NovaAPI.IsInputEnabled()
    if bEnable == false then
      return
    end
    if self.tbDefine_SkillBtn and self.tbDefine_SkillBtn[1].skillBtnCtrl.bInCD == false then
      local nUIType = GamepadUIManager.GetCurUIType()
      if nUIType == AllEnum.GamepadUIType.Keyboard then
        EventManager.Hit("Upload_Dodge_Event", "Keyboard")
      elseif nUIType == AllEnum.GamepadUIType.Mouse then
        EventManager.Hit("Upload_Dodge_Event", "Mouse")
      else
        EventManager.Hit("Upload_Dodge_Event", "Other")
      end
    end
  end
end

function BattleDashboardCtrl:OnEvent_ProloguelEnableBtnControl(nActionId, bEnable)
  local btnName = self.tbDefine_SkillBtn[nActionId].sName
  NovaAPI.SetRealButtonActive(btnName, bEnable)
  local data = self.tbDefine_SkillBtn[nActionId]
  data.skillBtnCtrl:SetbtnEnable_Prologuel(bEnable)
end

function BattleDashboardCtrl:OnEvent_MoveAvgBubbleRoot(trBubble)
  if trBubble ~= nil and trBubble:IsNull() == false then
    NovaAPI.SetParentAndNormalized(trBubble, self._mapNode.trAvgBubbleRoot)
  end
end

function BattleDashboardCtrl:OnEvent_ChangeKeyLayout()
  self:SetKeyLayout()
end

return BattleDashboardCtrl
