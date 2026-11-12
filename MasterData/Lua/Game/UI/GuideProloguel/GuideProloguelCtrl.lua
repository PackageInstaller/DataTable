local GuideProloguelCtrl = class("GuideProloguelCtrl", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local AdventureModuleHelper = CS.AdventureModuleHelper
local typeof = _ENV.typeof
local TimerManager = require("GameCore.Timer.TimerManager")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
GuideProloguelCtrl._mapNodeConfig = {
  GuideUIHelp = {sComponentName = "GameObject"},
  block = {sComponentName = "GameObject"},
  typeMask = {sComponentName = "GameObject"},
  obj_texBgRoot = {
    sComponentName = "RectTransform"
  },
  texDesc = {sComponentName = "TMP_Text"},
  typeMaskNotForce = {},
  obj_texBgNotForceAni = {
    sNodeName = "obj_texBgNotForce",
    sComponentName = "Animator"
  },
  texDescNotForce = {sComponentName = "TMP_Text"},
  joystickRoot = {
    sNodeName = "--joystick--"
  },
  EditorDebug = {sComponentName = "GameObject"},
  InputFieldDebug = {sComponentName = "InputField"},
  btnEditorDebug = {
    sComponentName = "UIButton",
    callback = "DebugEditorStep"
  }
}

function GuideProloguelCtrl:Awake()
  self.fxStartPath = "UI/GuideProloguel/GuideProloguelEffect.prefab"
  self.GuideUIHelpCS = self._mapNode.GuideUIHelp:GetComponent("GuideUIHelp")
  self.objGuild = {}
  self.objGuildBtn = {}
  self.objFxList = {}
  self.corGuideEnd = nil
  self.corDelayTrigger = nil
  self.isRunGuide = false
  self.addClickCb = nil
  self.isOnPress = false
  self.isPauseLogic = false
  self.commonId = ""
  self.waitAutoEndTime = 8
  self.waitEndFXTime = 1
  self.fxOffsetPos = Vector3.zero
  self.isAddEndFx = true
end

function GuideProloguelCtrl:OnEnable()
  self._mapNode.EditorDebug:SetActive(false)
  self._mapNode.block:SetActive(false)
end

function GuideProloguelCtrl:OnDisable()
end

function GuideProloguelCtrl:OnDestroy()
end

GuideProloguelCtrl._mapEventConfig = {
  Trigger_Guide_Index = "TriggerGuideIndex",
  Trigger_Guide_Index_FX = "TriggerGuideIndexFX",
  PrologueBattleReload = "OnEvent_PrologueBattleReload",
  ExecuteRealButton = "OnEvent_ExecuteRealButton",
  Trigger_Guide_AttackRange = "TriggerGuide_Guide_AttackRange"
}

function GuideProloguelCtrl:TriggerGuideIndex(index)
  self.isOnPress = false
  self.isPauseLogic = false
  self.commonId = ""
  self.fxOffsetPos = Vector3.zero
  self.isAddEndFx = true
  self.RealButtonKey = nil
  self.tabRealButtonActive = nil
  self.Desc = ""
  self.DescDeviation = nil
  self.DelayTriggerTime = 0
  local funName = "TriggerGuide_" .. index
  local func = handler(self, self[funName])
  func()
end

function GuideProloguelCtrl:TriggerGuideIndexFX(index, isOpen)
  if isOpen then
    local funName = "TriggerGuideFX_" .. index
    local func = handler(self, self[funName])
    func()
  else
    self:CloseTypeMaskNotForce()
    self:RemoveFx()
  end
end

function GuideProloguelCtrl:TriggerGuide_1()
  self.RealButtonKey = {"A"}
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self.DelayTriggerTime = 0.3
    self.Desc = "Dash"
    self.DescDeviation = {-400, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainDodge_Pos_Hor/btnDodge").gameObject
  else
    self.DelayTriggerTime = 0.3
    self.Desc = "Dash"
    self.DescDeviation = {-545, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainDodge_Pos/btnDodge").gameObject
  end
  self:GuideUIShow(true, 3)
end

function GuideProloguelCtrl:TriggerGuide_2()
  self.RealButtonKey = {"B"}
  self.tabRealButtonActive = {"Fire1"}
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self.DelayTriggerTime = 0.3
    self.Desc = "Skill_Open"
    self.DescDeviation = {-400, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainSkill_Pos_Hor/btnSkill").gameObject
  else
    self.DelayTriggerTime = 0.3
    self.Desc = "Skill_Open"
    self.DescDeviation = {-545, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainSkill_Pos/btnSkill").gameObject
  end
  self:GuideUIShow(true, 2)
end

function GuideProloguelCtrl:TriggerGuide_12()
  self.RealButtonKey = {"B"}
  self.tabRealButtonActive = {
    "Fire1",
    "Fire4",
    "ActorSwitch1",
    "ActorSwitch2",
    "ActorSwitch2",
    "SwitchWithUltra1"
  }
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self.DelayTriggerTime = 0.2
    self.Desc = "Tutorial_MarkBurst"
    self.DescDeviation = {-400, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainSkill_Pos_Hor/btnSkill").gameObject
  else
    self.DelayTriggerTime = 0.2
    self.Desc = "Tutorial_MarkBurst"
    self.DescDeviation = {-545, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainSkill_Pos/btnSkill").gameObject
  end
  self:GuideUIShow(true, 2)
end

function GuideProloguelCtrl:TriggerGuide_22()
  self.RealButtonKey = {"B"}
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self.DelayTriggerTime = 0.3
    self.Desc = "Skill_Open"
    self.DescDeviation = {-400, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainSkill_Pos_Hor/btnSkill").gameObject
  else
    self.DelayTriggerTime = 0.3
    self.Desc = "Skill_Open"
    self.DescDeviation = {-545, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainSkill_Pos/btnSkill").gameObject
  end
  self:GuideUIShow(true, 2)
end

function GuideProloguelCtrl:TriggerGuide_3()
  self.RealButtonKey = {"D"}
  self.tabRealButtonActive = {"Fire1", "Fire2"}
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self.DelayTriggerTime = 0.6
    self.Desc = "UltraSkill"
    self.DescDeviation = {-400, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainUltra_Pos_Hor/btnUltra").gameObject
  else
    self.DelayTriggerTime = 0.6
    self.Desc = "UltraSkill"
    self.DescDeviation = {-523, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainUltra_Pos/btnUltra").gameObject
  end
  self:GuideUIShow(true, 1)
end

function GuideProloguelCtrl:TriggerGuide_4()
  self.RealButtonKey = {
    "SwitchPreActor"
  }
  self.tabRealButtonActive = {
    "Fire1",
    "Fire2",
    "Fire4",
    "ActorSwitch2"
  }
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self.DelayTriggerTime = 0.3
    self.Desc = "SupportSkill"
    self.DescDeviation = {-400, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--support_role--/suport1/SupSkill1_Pos_Hor/btnSuportSkill1").gameObject
  else
    self.DelayTriggerTime = 0.3
    self.Desc = "SupportSkill"
    self.DescDeviation = {-545, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--support_role--/suport1/SupSkill1_Pos/btnSuportSkill1").gameObject
  end
  self:GuideUIShow(true, 2)
end

function GuideProloguelCtrl:TriggerGuide_11()
  self.RealButtonKey = {
    "SwitchPreActor"
  }
  self.tabRealButtonActive = {
    "Fire1",
    "Fire2",
    "Fire4",
    "ActorSwitch2",
    "SwitchWithUltra1",
    "SwitchWithUltra2"
  }
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self.DelayTriggerTime = 0.2
    self.Desc = "Tutorial_MarkAdd"
    self.DescDeviation = {-400, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--support_role--/suport1/SupSkill1_Pos_Hor/btnSuportSkill1").gameObject
  else
    self.DelayTriggerTime = 0.2
    self.Desc = "Tutorial_MarkAdd"
    self.DescDeviation = {-545, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--support_role--/suport1/SupSkill1_Pos/btnSuportSkill1").gameObject
  end
  self:GuideUIShow(true, 2)
end

function GuideProloguelCtrl:TriggerGuide_5()
  self.RealButtonKey = {
    "SwitchNextWithUltra"
  }
  self.tabRealButtonActive = {
    "Fire1",
    "Fire2",
    "Fire4",
    "ActorSwitch1",
    "ActorSwitch2",
    "SwitchWithUltra1"
  }
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self.DelayTriggerTime = 0.3
    self.Desc = "SupportUltraSkill"
    self.DescDeviation = {-400, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--support_role--/suport2/SupUltra2_Pos_Hor/btnSupportUltra2").gameObject
  else
    self.DelayTriggerTime = 0.3
    self.Desc = "SupportUltraSkill"
    self.DescDeviation = {-523, 0}
    self.delayTimeCloseTime = 3
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--support_role--/suport2/SupUltra2_Pos/btnSupportUltra2").gameObject
  end
  self:GuideUIShow(true, 1)
end

function GuideProloguelCtrl:TriggerGuide_6()
  self.Desc = "Move"
  self.delayTimeCloseTime = 3
  self:Step_6()
end

function GuideProloguelCtrl:TriggerGuideFX_1()
  self.Desc = "FastRun"
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainDodge_Pos_Hor/btnDodge").gameObject
  else
    self.objGuild[1] = GameObject.Find("==== UI ROOT ====/---- UI ----/BattleDashboard/--safe_area--/--main_role--/MainDodge_Pos/btnDodge").gameObject
  end
  self:StepFX_1()
end

function GuideProloguelCtrl:TriggerGuide_Guide_AttackRange()
  self.Desc = "Attack"
  self.delayTimeCloseTime = 3
  local tmpDest = self.Desc
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other or nUIType == AllEnum.GamepadUIType.Keyboard or nUIType == AllEnum.GamepadUIType.Mouse then
    if NovaAPI.IsMobilePlatform() then
      tmpDest = tmpDest .. "_Mobile"
    else
      tmpDest = tmpDest .. "_PC"
    end
  elseif nUIType == AllEnum.GamepadUIType.PS then
    tmpDest = tmpDest .. "_PS"
  elseif nUIType == AllEnum.GamepadUIType.Xbox then
    tmpDest = tmpDest .. "_Xbox"
  end
  self._mapNode.typeMaskNotForce:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.texDescNotForce, ConfigTable.GetUIText(tmpDest))
  
  local function delayTrigger()
    self:CloseTypeMaskNotForce()
  end
  
  TimerManager.Add(1, self.delayTimeCloseTime, self, delayTrigger, true, true, true, nil)
end

function GuideProloguelCtrl:Step_6()
  local tmpDest = self.Desc
  local isMobile = false
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other or nUIType == AllEnum.GamepadUIType.Keyboard or nUIType == AllEnum.GamepadUIType.Mouse then
    if NovaAPI.IsMobilePlatform() then
      tmpDest = tmpDest .. "_Mobile"
      isMobile = true
    else
      tmpDest = tmpDest .. "_PC"
    end
  elseif nUIType == AllEnum.GamepadUIType.PS then
    tmpDest = tmpDest .. "_PS"
  elseif nUIType == AllEnum.GamepadUIType.Xbox then
    tmpDest = tmpDest .. "_Xbox"
  end
  self._mapNode.typeMaskNotForce:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.texDescNotForce, ConfigTable.GetUIText(tmpDest))
  if isMobile then
    self._mapNode.joystickRoot:SetActive(true)
  end
  
  local function Prologue_Move()
    if isMobile then
      self._mapNode.joystickRoot:SetActive(false)
    end
    EventManager.Remove("Trigger_Prologue_Move", self, Prologue_Move)
    
    local function delayTrigger()
      self:CloseTypeMaskNotForce()
    end
    
    TimerManager.Add(1, self.delayTimeCloseTime, self, delayTrigger, true, true, true, nil)
  end
  
  EventManager.Add("Trigger_Prologue_Move", self, Prologue_Move)
end

function GuideProloguelCtrl:StepFX_1()
  local tmpDest = self.Desc
  local isMobile = false
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other or nUIType == AllEnum.GamepadUIType.Keyboard or nUIType == AllEnum.GamepadUIType.Mouse then
    if NovaAPI.IsMobilePlatform() then
      tmpDest = tmpDest .. "_Mobile"
      isMobile = true
    else
      tmpDest = tmpDest .. "_PC"
    end
  elseif nUIType == AllEnum.GamepadUIType.PS then
    tmpDest = tmpDest .. "_PS"
  elseif nUIType == AllEnum.GamepadUIType.Xbox then
    tmpDest = tmpDest .. "_Xbox"
  end
  self._mapNode.typeMaskNotForce:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.texDescNotForce, ConfigTable.GetUIText(tmpDest))
  self:AddStartFx(3)
end

function GuideProloguelCtrl:CloseTypeMaskNotForce()
  self._mapNode.obj_texBgNotForceAni:Play("obj_texBgNotForce_out")
  
  local function delayCloseNotForce()
    self._mapNode.typeMaskNotForce:SetActive(false)
  end
  
  TimerManager.Add(1, 1, self, delayCloseNotForce, true, true, true, nil)
end

function GuideProloguelCtrl:GuideUIShow(isForce, fxIndex)
  self:EnableBtnActive(false)
  self.isOnPress = true
  self.isRunGuide = true
  self.isForceGuide = isForce
  self.addClickCb = handler(self, self.ClickEnd)
  self.objGuildBtn[1] = self.objGuild[1]
  self.objGuildBtn[1]:GetComponent("Button").onPress:AddListener(self.addClickCb)
  local tmpDest = self.Desc
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other or nUIType == AllEnum.GamepadUIType.Keyboard or nUIType == AllEnum.GamepadUIType.Mouse then
    if NovaAPI.IsMobilePlatform() then
      tmpDest = tmpDest .. "_Mobile"
    else
      tmpDest = tmpDest .. "_PC"
    end
  elseif nUIType == AllEnum.GamepadUIType.PS then
    tmpDest = tmpDest .. "_PS"
  elseif nUIType == AllEnum.GamepadUIType.Xbox then
    tmpDest = tmpDest .. "_Xbox"
  end
  
  local function delayTrigger()
    if isForce then
      self.pre = self.gameObject.transform.localScale.x
      self._mapNode.typeMask:SetActive(true)
      self._mapNode.obj_texBgRoot.gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.texDesc, ConfigTable.GetUIText(tmpDest))
      local offsetTexXPre = self.DescDeviation[1] * self.pre
      local offsetTexYPre = self.DescDeviation[2] * self.pre
      local objGuildPos = self.objGuild[1]:GetComponent("RectTransform").position
      self._mapNode.obj_texBgRoot.position = objGuildPos + Vector3(offsetTexXPre, offsetTexYPre, 0)
      self._mapNode.block:SetActive(true)
      self.isPauseLogic = true
      AdventureModuleHelper.SetGuideLogicTimeScale(0)
      self.GuideUIHelpCS:AddCanvas(self.objGuild[1].gameObject, false)
      self:AddStartFx(fxIndex)
    else
      self._mapNode.typeMask:SetActive(false)
      self._mapNode.typeMaskNotForce:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.texDescNotForce, ConfigTable.GetUIText(tmpDest))
      self:AddStartFx(fxIndex)
    end
    self:AutoEnd()
    self.corDelayTrigger = nil
  end
  
  self.corDelayTrigger = TimerManager.Add(1, self.DelayTriggerTime, self, delayTrigger, true, true, true, nil)
end

function GuideProloguelCtrl:AutoEnd()
  local function waitGuideEnd()
    self:GuideEnd(true)
  end
  
  self.corGuideEnd = TimerManager.Add(1, self.waitAutoEndTime, self, waitGuideEnd, true, true, true, nil)
end

function GuideProloguelCtrl:ClickEnd()
  self.RealButtonKey = nil
  if self.corGuideEnd ~= nil then
    TimerManager.Remove(self.corGuideEnd)
    self.corGuideEnd = nil
  end
  local isClosePop = true
  if self.corDelayTrigger ~= nil then
    TimerManager.Remove(self.corDelayTrigger)
    self.corDelayTrigger = nil
    if self.isForceGuide then
      isClosePop = false
      local tmpDest = self.Desc
      local nUIType = GamepadUIManager.GetCurUIType()
      if nUIType == AllEnum.GamepadUIType.Other or nUIType == AllEnum.GamepadUIType.Keyboard or nUIType == AllEnum.GamepadUIType.Mouse then
        if NovaAPI.IsMobilePlatform() then
          tmpDest = tmpDest .. "_Mobile"
        else
          tmpDest = tmpDest .. "_PC"
        end
      elseif nUIType == AllEnum.GamepadUIType.PS then
        tmpDest = tmpDest .. "_PS"
      elseif nUIType == AllEnum.GamepadUIType.Xbox then
        tmpDest = tmpDest .. "_Xbox"
      end
      self._mapNode.typeMaskNotForce:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.texDescNotForce, ConfigTable.GetUIText(tmpDest))
      
      local function delayTrigger()
        self:CloseTypeMaskNotForce()
      end
      
      TimerManager.Add(1, self.delayTimeCloseTime, self, delayTrigger, true, true, true, nil)
    end
  end
  self:GuideEnd(isClosePop)
end

function GuideProloguelCtrl:GuideEnd(isClosePop)
  if self.commonId ~= "" then
    safe_call_cs_func(CS.InteractiveManager.Instance.triggerOpLisener, CS.InteractiveManager.Instance, self.commonId)
  end
  if self.isPauseLogic and isClosePop then
    AdventureModuleHelper.SetGuideLogicTimeScale(1)
    EventManager.Hit("BattlePopupTips", 0, 0, false)
  end
  self:EnableBtnActive(true)
  self.tabRealButtonActive = nil
  self:RemoveFx()
  self.isRunGuide = false
  self._mapNode.typeMask:SetActive(false)
  if not self.isForceGuide then
    local function delayTrigger()
      self:CloseTypeMaskNotForce()
    end
    
    TimerManager.Add(1, self.delayTimeCloseTime, self, delayTrigger, true, true, true, nil)
  end
  self._mapNode.block:SetActive(false)
  if self.addClickCb ~= nil then
    for i, v in pairs(self.objGuildBtn) do
      if self.isOnPress then
        v:GetComponent("Button").onPress:RemoveListener(self.addClickCb)
      else
        v:GetComponent("Button").onClick:RemoveListener(self.addClickCb)
      end
    end
  end
  self.addClickCb = nil
  self.objGuildBtn = {}
  
  local function waitEnd()
    self:RemoveFx()
    for i, v in pairs(self.objGuild) do
      self.GuideUIHelpCS:RemoveCanvas(v)
    end
    self.objGuild = {}
    EventManager.Hit("GuideEnd")
  end
  
  TimerManager.Add(1, self.waitEndFXTime, self, waitEnd, true, true, true, nil)
end

function GuideProloguelCtrl:AddStartFx(fxIndex)
  for i, v in pairs(self.objGuild) do
    local root = v.transform:Find("GuideFxRoot").gameObject
    local objStart = self:CreatePrefabInstance(self.fxStartPath, root.transform)
    objStart.transform.localScale = Vector3.one
    objStart.transform.localPosition = self.fxOffsetPos
    objStart.transform:Find("Effect" .. fxIndex).gameObject:SetActive(true)
    table.insert(self.objFxList, objStart)
  end
end

function GuideProloguelCtrl:RemoveFx()
  for i, v in pairs(self.objFxList) do
    destroy(v)
  end
  self.objFxList = {}
end

function GuideProloguelCtrl:OnEvent_PrologueBattleReload()
  self:ClickEnd()
end

function GuideProloguelCtrl:OnEvent_ExecuteRealButton(key)
  if self.isRunGuide and self.RealButtonKey ~= nil then
    for i, v in ipairs(self.RealButtonKey) do
      if v == key then
        self:ClickEnd()
        if key == "B" then
          local nUIType = GamepadUIManager.GetCurUIType()
          if nUIType == AllEnum.GamepadUIType.Other or nUIType == AllEnum.GamepadUIType.Keyboard or nUIType == AllEnum.GamepadUIType.Mouse then
            NovaAPI.GuideProloguelSkill()
          end
        end
        break
      end
    end
  end
end

function GuideProloguelCtrl:EnableBtnActive(bEnable)
  if self.tabRealButtonActive ~= nil then
    for i, v in ipairs(self.tabRealButtonActive) do
      NovaAPI.SetRealButtonActive(v, bEnable)
    end
  end
end

function GuideProloguelCtrl:DebugEditorStep()
  PlayerData.Guide.guideProcessingNewbie = tonumber(NovaAPI.GetInputFieldText(self._mapNode.InputFieldDebug))
  self:TriggerGuideIndex(tonumber(NovaAPI.GetInputFieldText(self._mapNode.InputFieldDebug)))
end

return GuideProloguelCtrl
