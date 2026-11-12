local SettingsGamepadCtrl = class("SettingsGamepadCtrl", BaseCtrl)
local InputManager = CS.InputManager
SettingsGamepadCtrl._mapNodeConfig = {
  txtPageTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Gamepad"
  },
  txtBindingTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Gamepad_Binding"
  },
  OptionBinding = {
    nCount = 8,
    sCtrlName = "Game.UI.Settings.OptionBindingCtrl"
  },
  txtBtnReset = {sComponentName = "TMP_Text", sLanguageId = "Reset"},
  btnReset = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reset"
  },
  Xbox = {},
  txtXbox_LT = {sComponentName = "TMP_Text"},
  txtXbox_LB = {sComponentName = "TMP_Text"},
  txtXbox_Left_Stick = {
    sComponentName = "TMP_Text",
    sLanguageId = "Action_Move"
  },
  txtXbox_Menu = {sComponentName = "TMP_Text", sLanguageId = "Action_Map"},
  txtXbox_Windows = {
    sComponentName = "TMP_Text",
    sLanguageId = "Action_Depot"
  },
  txtXbox_AutoBattle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Action_AutoBattle"
  },
  txtXbox_RT = {sComponentName = "TMP_Text"},
  txtXbox_RB = {sComponentName = "TMP_Text"},
  txtXbox_Y = {sComponentName = "TMP_Text"},
  txtXbox_B = {sComponentName = "TMP_Text"},
  txtXbox_A = {sComponentName = "TMP_Text"},
  txtXbox_X = {sComponentName = "TMP_Text"},
  PlayStation = {},
  txtPS_L2 = {sComponentName = "TMP_Text"},
  txtPS_L1 = {sComponentName = "TMP_Text"},
  txtPS_Left_Stick = {
    sComponentName = "TMP_Text",
    sLanguageId = "Action_Move"
  },
  txtPS_Share = {
    sComponentName = "TMP_Text",
    sLanguageId = "Action_Depot"
  },
  txtPS_Options = {sComponentName = "TMP_Text", sLanguageId = "Action_Map"},
  txtPS_AutoBattle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Action_AutoBattle"
  },
  txtPS_R2 = {sComponentName = "TMP_Text"},
  txtPS_R1 = {sComponentName = "TMP_Text"},
  txtPS_Triangle = {sComponentName = "TMP_Text"},
  txtPS_Circle = {sComponentName = "TMP_Text"},
  txtPS_Cross = {sComponentName = "TMP_Text"},
  txtPS_Square = {sComponentName = "TMP_Text"}
}
SettingsGamepadCtrl._mapEventConfig = {
  LuaEventName_LastInputDeviceChange = "OnEvent_LastInputDeviceChange",
  LuaEventName_OnDeviceChange = "OnEvent_DeviceChange",
  SettingsRefreshDisplay = "OnEvent_RefreshDisplay"
}

function SettingsGamepadCtrl:RefreshText()
  for i = 1, 8 do
    self._mapNode.OptionBinding[i]:SetText(ConfigTable.GetUIText("Action_" .. self._panel.Action[i]))
  end
end

function SettingsGamepadCtrl:Init()
  if self.bInit then
    return
  end
  self.bInit = true
  self:LoadSetting()
end

function SettingsGamepadCtrl:Quit()
  if not self.bInit then
    return
  end
end

function SettingsGamepadCtrl:LoadSetting()
  self._panel.mapGamepadBind = {}
  for _, v in ipairs(self._panel.Action) do
    local bHas, tbControl = InputManager.Instance:GetInputActionConfig(v)
    if bHas then
      for i = 0, tbControl.Count - 1 do
        local mapControl = tbControl[i]
        if mapControl.isGamepad then
          self._panel.mapGamepadBind[v] = mapControl.name
          break
        end
      end
    end
  end
  self:InitGamepadType()
end

function SettingsGamepadCtrl:SaveSetting()
  for _, v in ipairs(self._panel.Action) do
    InputManager.Instance:OverrideButtonBinding(v, self._panel.ControlType.Gamepad, "<Gamepad>/" .. self._panel.mapGamepadBind[v])
    if v == "Fire1" then
      InputManager.Instance:OverrideButtonBinding("Fire3", self._panel.ControlType.Gamepad, "<Gamepad>/" .. self._panel.mapGamepadBind[v])
    end
  end
end

function SettingsGamepadCtrl:InitGamepadType()
  self._mapNode.PlayStation:SetActive(self.bPS)
  self._mapNode.Xbox:SetActive(not self.bPS)
  for i = 1, 8 do
    local sAction = self._panel.Action[i]
    self._mapNode.OptionBinding[i]:Init(3, sAction, self._panel.mapGamepadBind[sAction], nil, self.bPS)
  end
  self:RefreshDisplay()
end

function SettingsGamepadCtrl:ChangeGamepadType(bPS)
  self.bPS = bPS
  self._mapNode.PlayStation:SetActive(self.bPS)
  self._mapNode.Xbox:SetActive(not self.bPS)
  for i = 1, 8 do
    self._mapNode.OptionBinding[i]:ChangeGamepad(bPS)
  end
  self:RefreshDisplay()
end

function SettingsGamepadCtrl:RefreshDisplay()
  local sLTAction = table.keyof(self._panel.mapGamepadBind, "leftTrigger")
  local sLBAction = table.keyof(self._panel.mapGamepadBind, "leftShoulder")
  local sRTAction = table.keyof(self._panel.mapGamepadBind, "rightTrigger")
  local sRBAction = table.keyof(self._panel.mapGamepadBind, "rightShoulder")
  local sYAction = table.keyof(self._panel.mapGamepadBind, "buttonNorth")
  local sBAction = table.keyof(self._panel.mapGamepadBind, "buttonEast")
  local sAAction = table.keyof(self._panel.mapGamepadBind, "buttonSouth")
  local sXAction = table.keyof(self._panel.mapGamepadBind, "buttonWest")
  if self.bPS then
    NovaAPI.SetTMPText(self._mapNode.txtPS_L2, ConfigTable.GetUIText("Action_" .. sLTAction))
    NovaAPI.SetTMPText(self._mapNode.txtPS_L1, ConfigTable.GetUIText("Action_" .. sLBAction))
    NovaAPI.SetTMPText(self._mapNode.txtPS_R2, ConfigTable.GetUIText("Action_" .. sRTAction))
    NovaAPI.SetTMPText(self._mapNode.txtPS_R1, ConfigTable.GetUIText("Action_" .. sRBAction))
    NovaAPI.SetTMPText(self._mapNode.txtPS_Triangle, ConfigTable.GetUIText("Action_" .. sYAction))
    NovaAPI.SetTMPText(self._mapNode.txtPS_Circle, ConfigTable.GetUIText("Action_" .. sBAction))
    NovaAPI.SetTMPText(self._mapNode.txtPS_Cross, ConfigTable.GetUIText("Action_" .. sAAction))
    NovaAPI.SetTMPText(self._mapNode.txtPS_Square, ConfigTable.GetUIText("Action_" .. sXAction))
  else
    NovaAPI.SetTMPText(self._mapNode.txtXbox_LT, ConfigTable.GetUIText("Action_" .. sLTAction))
    NovaAPI.SetTMPText(self._mapNode.txtXbox_LB, ConfigTable.GetUIText("Action_" .. sLBAction))
    NovaAPI.SetTMPText(self._mapNode.txtXbox_RT, ConfigTable.GetUIText("Action_" .. sRTAction))
    NovaAPI.SetTMPText(self._mapNode.txtXbox_RB, ConfigTable.GetUIText("Action_" .. sRBAction))
    NovaAPI.SetTMPText(self._mapNode.txtXbox_Y, ConfigTable.GetUIText("Action_" .. sYAction))
    NovaAPI.SetTMPText(self._mapNode.txtXbox_B, ConfigTable.GetUIText("Action_" .. sBAction))
    NovaAPI.SetTMPText(self._mapNode.txtXbox_A, ConfigTable.GetUIText("Action_" .. sAAction))
    NovaAPI.SetTMPText(self._mapNode.txtXbox_X, ConfigTable.GetUIText("Action_" .. sXAction))
  end
end

function SettingsGamepadCtrl:Awake()
  self.bInit = false
  self:RefreshText()
  local nType = InputManager.Instance:CheckGamepadType()
  self.bPS = nType == InputManager.GamepadType.PS
end

function SettingsGamepadCtrl:OnEnable()
end

function SettingsGamepadCtrl:OnDisable()
  if not self.bInit then
    return
  end
  self:SaveSetting()
end

function SettingsGamepadCtrl:OnDestroy()
end

function SettingsGamepadCtrl:OnBtnClick_Reset()
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Settings_Tip_Reset"),
    callbackConfirm = function()
      local nUID = PlayerData.Base:GetPlayerId()
      InputManager.Instance:ResetBindingOverrides(nUID)
      self:LoadSetting()
      local mapMsg = {
        nType = AllEnum.MessageBox.Tips,
        bPositive = true,
        sContent = ConfigTable.GetUIText("Settings_KeyReset")
      }
      EventManager.Hit(EventId.OpenMessageBox, mapMsg)
    end,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function SettingsGamepadCtrl:OnEvent_LastInputDeviceChange(nType)
  if not self.bInit then
    return
  end
  if nType == InputManager.InputDeviceType.PSGamepad then
    self:ChangeGamepadType(true)
  elseif nType == InputManager.InputDeviceType.XBoxGamepad or nType == InputManager.InputDeviceType.Other then
    self:ChangeGamepadType(false)
  end
end

function SettingsGamepadCtrl:OnEvent_DeviceChange(changeType)
  if not self.bInit then
    return
  end
  if changeType.value__ == 0 or changeType.value__ == 1 then
    local nType = InputManager.Instance:CheckGamepadType()
    self:ChangeGamepadType(nType == InputManager.GamepadType.PS)
  end
end

function SettingsGamepadCtrl:OnEvent_RefreshDisplay(sAction, sName)
  local sTitle = ConfigTable.GetUIText("Action_" .. sAction)
  if sName == "leftTrigger" then
    NovaAPI.SetTMPText(self._mapNode.txtPS_L2, sTitle)
    NovaAPI.SetTMPText(self._mapNode.txtXbox_LT, sTitle)
  elseif sName == "leftShoulder" then
    NovaAPI.SetTMPText(self._mapNode.txtPS_L1, sTitle)
    NovaAPI.SetTMPText(self._mapNode.txtXbox_LB, sTitle)
  elseif sName == "rightTrigger" then
    NovaAPI.SetTMPText(self._mapNode.txtPS_R2, sTitle)
    NovaAPI.SetTMPText(self._mapNode.txtXbox_RT, sTitle)
  elseif sName == "rightShoulder" then
    NovaAPI.SetTMPText(self._mapNode.txtPS_R1, sTitle)
    NovaAPI.SetTMPText(self._mapNode.txtXbox_RB, sTitle)
  elseif sName == "buttonNorth" then
    NovaAPI.SetTMPText(self._mapNode.txtPS_Triangle, sTitle)
    NovaAPI.SetTMPText(self._mapNode.txtXbox_Y, sTitle)
  elseif sName == "buttonEast" then
    NovaAPI.SetTMPText(self._mapNode.txtPS_Circle, sTitle)
    NovaAPI.SetTMPText(self._mapNode.txtXbox_B, sTitle)
  elseif sName == "buttonSouth" then
    NovaAPI.SetTMPText(self._mapNode.txtPS_Cross, sTitle)
    NovaAPI.SetTMPText(self._mapNode.txtXbox_A, sTitle)
  elseif sName == "buttonWest" then
    NovaAPI.SetTMPText(self._mapNode.txtPS_Square, sTitle)
    NovaAPI.SetTMPText(self._mapNode.txtXbox_X, sTitle)
  end
end

return SettingsGamepadCtrl
