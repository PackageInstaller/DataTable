local BreakOutPlaySkillCtrl = class("BreakOutPlaySkillCtrl", BaseCtrl)
local AdventureModuleHelper = CS.AdventureModuleHelper
local InputManagerIns = CS.InputManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
BreakOutPlaySkillCtrl._mapNodeConfig = {
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
  Skill_Pos = {sComponentName = "Transform"},
  Shoot_Pos = {sComponentName = "Transform"},
  cgSafeAreaRoot = {
    sNodeName = "--safeAreaRoot--",
    sComponentName = "CanvasGroup"
  },
  break_Skill = {
    sNodeName = "btnSkill",
    sCtrlName = "Game.UI.Play_BreakOut_30101.BreakOutSkillBtnCtrl"
  },
  break_Shoot = {
    sNodeName = "btnShoot",
    sCtrlName = "Game.UI.Play_BreakOut_30101.BreakOutSkillBtnCtrl"
  }
}
local SKILL_SHOOT = 1
local SKILL_ULTRA = 4
BreakOutPlaySkillCtrl._mapEventConfig = {
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  PlayerAdventureActorCastSkill = "OnEvent_UseSkillSuc",
  ButtonStateChange = "OnEvent_BtnStateChange",
  SetVariableJoystickMode = "OnEvent_SetVariableJoystickMode",
  BrickActorEnergy = "OnEvent_RefreshSkillState",
  Brick_ShootButtonState = "OnEvent_RefreshShootState",
  SetBreakOutPlaySkill_Visible = "OnEvent_BreakOutPlaySkillVisible",
  OnEvent_ClearState = "OnEvent_ClearState"
}

function BreakOutPlaySkillCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.nLevelId = param[2]
    self.nCurCharId = param[3]
  end
  self.BreakOutData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.tbDefine_BreakOutPlayBtn = {
    [1] = {
      btnTyp = SKILL_SHOOT,
      BreakOutSkillBtnCtrl = self._mapNode.break_Shoot,
      sName = "Fire1",
      nHoldThreshold = 0.1
    },
    [2] = {
      btnTyp = SKILL_ULTRA,
      BreakOutSkillBtnCtrl = self._mapNode.break_Skill,
      sName = "Fire4",
      nHoldThreshold = 0.1
    }
  }
  self.nCurPlayerId = nil
  self.skillTipTime = 0
  self.dodgeTipTime = 0
end

function BreakOutPlaySkillCtrl:OnEnable()
  if NovaAPI.IsMobilePlatform() or NovaAPI.IsEditorPlatform() then
    self._mapNode.goJoystick:SetActive(true)
    NovaAPI.RegisterVirtualJoystick("Horizontal", "Vertical", self._mapNode.goJoystick)
  else
    self._mapNode.goJoystick:SetActive(false)
  end
  local nW = math.floor(Settings.CURRENT_CANVAS_FULL_RECT_WIDTH)
  local nH = math.floor(Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT)
  self._mapNode.rtJoystick.sizeDelta = Vector2(nW / 2, nH * 2 / 3)
  for _, v in ipairs(self.tbDefine_BreakOutPlayBtn) do
    NovaAPI.RegisterRealButton(v.sName, v.nHoldThreshold)
    local go = v.BreakOutSkillBtnCtrl ~= nil and v.BreakOutSkillBtnCtrl.gameObject or v.goBtn
    NovaAPI.RegisterVirtualButton(v.sName, go)
    NovaAPI.SetButtonExHoldThreshold(go, v.nHoldThreshold)
  end
  self:SetKeyLayout()
  self:SetActionBind()
  self:Refresh()
  self:OnEvent_BreakOutPlaySkillVisible(false)
end

function BreakOutPlaySkillCtrl:OnDisable()
  NovaAPI.UnRegisterVirtualJoystick("Horizontal", "Vertical")
  for _, v in ipairs(self.tbDefine_BreakOutPlayBtn) do
    NovaAPI.UnRegisterRealButton(v.sName)
    NovaAPI.UnRegisterVirtualButton(v.sName)
  end
end

function BreakOutPlaySkillCtrl:SetKeyLayout()
  self:SetKeyPos(self._mapNode.break_Skill.gameObject:GetComponent("RectTransform"), self._mapNode.Skill_Pos)
  self:SetKeyPos(self._mapNode.break_Shoot.gameObject:GetComponent("RectTransform"), self._mapNode.Shoot_Pos)
  self._mapNode.break_Skill:SetCDTextSize()
  self._mapNode.break_Shoot:SetCDTextSize()
end

function BreakOutPlaySkillCtrl:SetKeyPos(btnTra, parentTra)
  btnTra:SetParent(parentTra)
  btnTra.anchoredPosition = Vector2.zero
  btnTra.localScale = Vector3.one
end

function BreakOutPlaySkillCtrl:OnEvent_LoadLevelRefresh()
  self:Refresh()
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
    self:OnEvent_BreakOutPlaySkillVisible(true)
  end
  
  cs_coroutine.start(wait)
end

function BreakOutPlaySkillCtrl:OnEvent_UseSkillSuc(nCharId, nSkillId)
  for i, v in ipairs(self.tbDefine_BreakOutPlayBtn) do
    if v.nCharId == nCharId and v.nSkillId == nSkillId and v.BreakOutSkillBtnCtrl ~= nil then
      v.BreakOutSkillBtnCtrl:SetMainAlpha(false)
    end
  end
end

function BreakOutPlaySkillCtrl:OnEvent_BtnStateChange(sBtnName, nBtnState)
  local function func_CheckBtnState(tb)
    for i, v in ipairs(tb) do
      if v.sName == sBtnName and v.BreakOutSkillBtnCtrl ~= nil then
        v.BreakOutSkillBtnCtrl:BtnStateChange(nBtnState)
      end
    end
  end
  
  func_CheckBtnState(self.tbDefine_BreakOutPlayBtn)
end

function BreakOutPlaySkillCtrl:Refresh()
  for _, v in ipairs(self.tbDefine_BreakOutPlayBtn) do
    if v.BreakOutSkillBtnCtrl ~= nil then
      v.nCharId = self.nCurCharId
      local tCharacterData = self.BreakOutData:GetDataFromBreakOutCharacter(self.nCurCharId)
      if tCharacterData == nil then
        printError("角色ID:" .. self.nCurCharId .. "在表中不存在数据信息")
        return
      end
      v.nSkillId = tCharacterData.SkillId
      local EET = tCharacterData.EET
      local skillData = ConfigTable.GetData("Skill", v.nSkillId)
      if skillData ~= nil then
        v.BreakOutSkillBtnCtrl:InitSkillBtn(EET, skillData.Icon, v.nSkillId, v.btnTyp, self.nCurCharId, self.BreakOutData.BreakOutLevelData)
      end
    end
  end
end

function BreakOutPlaySkillCtrl:OnEvent_ClearState()
  local breakOutSkillBtnCtrl = self.tbDefine_BreakOutPlayBtn[2].BreakOutSkillBtnCtrl
  if breakOutSkillBtnCtrl ~= nil then
    local tCharacterData = self.BreakOutData:GetDataFromBreakOutCharacter(self.nCurCharId)
    if tCharacterData == nil then
      printError("角色ID:" .. self.nCurCharId .. "在表中不存在数据信息")
      return
    end
    local nMaxSkillEnergy = tCharacterData.MP
    local skillData = ConfigTable.GetData("Skill", tCharacterData.SkillId)
    local nTotalCDTime = skillData.SkillCD
    breakOutSkillBtnCtrl:RefreshSkillBtn(0.0, nMaxSkillEnergy, 0.0, nTotalCDTime)
  end
end

function BreakOutPlaySkillCtrl:SetActionBind()
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
      if config.BreakOutSkillBtnCtrl then
        config.BreakOutSkillBtnCtrl:SetActionBind(sGamepadBind, mapKeyboardBind)
      end
    end
  end
  
  for _, v in ipairs(self.tbDefine_BreakOutPlayBtn) do
    set(v)
  end
end

function BreakOutPlaySkillCtrl:OnEvent_RefreshShootState(bEnableShoot, bNeedSkillUseTip)
  self.tbDefine_BreakOutPlayBtn[1].BreakOutSkillBtnCtrl:SetMainAlpha(bEnableShoot)
end

function BreakOutPlaySkillCtrl:OnEvent_RefreshSkillState(CharacterId, SkillId, nCurSkillEnergy, nMaxSkillEnergy, nCurCDTime)
  local breakOutSkillBtnCtrl = self.tbDefine_BreakOutPlayBtn[2].BreakOutSkillBtnCtrl
  if CharacterId ~= self.nCurCharId then
    return
  end
  local tCharacterData = self.BreakOutData:GetDataFromBreakOutCharacter(CharacterId)
  if tCharacterData == nil then
    printError("角色ID:" .. CharacterId .. "在表中不存在数据信息")
    return
  end
  local skillData = ConfigTable.GetData("Skill", SkillId)
  local nTotalCDTime = skillData.SkillCD
  if breakOutSkillBtnCtrl ~= nil then
    breakOutSkillBtnCtrl:RefreshSkillBtn(nCurSkillEnergy, nMaxSkillEnergy, nCurCDTime, nTotalCDTime)
  end
end

function BreakOutPlaySkillCtrl:EnableBtnControl()
  for _, v in ipairs(self.tbDefine_BreakOutPlayBtn) do
    NovaAPI.SetRealButtonActive(v.sName, true)
  end
end

function BreakOutPlaySkillCtrl:OnEvent_SetVariableJoystickMode()
  if not NovaAPI.IsMobilePlatform() then
    return
  end
  NovaAPI.SetVariableJoystickMode(self._mapNode.goJoystick)
end

function BreakOutPlaySkillCtrl:OnEvent_BreakOutPlaySkillVisible(bVisible)
  self:SetAllVisible(bVisible)
end

function BreakOutPlaySkillCtrl:SetAllVisible(bVisible)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgJoystick, bVisible == true and 0.3 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgJoystick, true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgJoystick, true)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgSafeAreaRoot, bVisible == true and 1 or 0)
end

function BreakOutPlaySkillCtrl:OnEvent_SwitchUI()
  PanelManager.SwitchUI()
end

function BreakOutPlaySkillCtrl:OnEvent_SwitchSkillBtn()
  PanelManager.SwitchSkillBtn()
end

return BreakOutPlaySkillCtrl
