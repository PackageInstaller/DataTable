local OptionBindingCtrl = class("OptionBindingCtrl", BaseCtrl)
local InputManager = CS.InputManager
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local BasicDevice = {
  Keyboard = 1,
  Mouse = 2,
  Gamepad = 3
}
local ImageKey = {backspace = 1, enter = 2}
local IllegalKeyboardKey = {
  "Caps Lock",
  "Left Windows",
  "Right Windows",
  "Prnt Scrn",
  "Scroll Lock",
  "Break",
  "Num Lock",
  "Alt",
  "Left Alt",
  "Right Alt",
  "Esc",
  "Application",
  "B"
}
local LegalGamepadKey = {
  "buttonSouth",
  "buttonWest",
  "buttonEast",
  "buttonNorth",
  "leftShoulder",
  "rightShoulder",
  "leftTrigger",
  "rightTrigger"
}
OptionBindingCtrl._mapNodeConfig = {
  txtOptionTitle = {sComponentName = "TMP_Text"},
  btnBind = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Bind"
  },
  Placeholder = {},
  goBind = {},
  bindBg = {},
  holderBg = {},
  Keyboard = {},
  goKey = {},
  imgKeyboard = {sComponentName = "Image"},
  txtKeyboard = {sComponentName = "TMP_Text"},
  Mouse = {},
  imgMouse = {sComponentName = "Image"},
  Gamepad = {},
  imgGamepad = {sComponentName = "Image"}
}
OptionBindingCtrl._mapEventConfig = {
  LuaEventName_KeyboardButtonPress = "OnEvent_KeyboardButtonPress",
  LuaEventName_MouseButtonPress = "OnEvent_MouseButtonPress",
  LuaEventName_GamepadButtonPress = "OnEvent_GamepadButtonPress",
  SettingsSwitchBind = "OnEvent_SwitchBind"
}

function OptionBindingCtrl:SetText(sTitle)
  NovaAPI.SetTMPText(self._mapNode.txtOptionTitle, sTitle)
end

function OptionBindingCtrl:Init(nType, sAction, sName, sDisplayName, bPS)
  self.bActiveBinding = false
  self.nDeviceType = nType
  self.sAction = sAction
  self.sName = sName
  self.sDisplayName = sDisplayName
  self.bPS = bPS
  self:SwitchState(false)
  self:RefreshButton()
end

function OptionBindingCtrl:SwitchState(bholder)
  self._mapNode.Placeholder:SetActive(bholder)
  self._mapNode.holderBg:SetActive(bholder)
  self._mapNode.goBind:SetActive(not bholder)
  self._mapNode.bindBg:SetActive(not bholder)
end

function OptionBindingCtrl:ChangeGamepad(bPS)
  self.bPS = bPS
  if self.bActiveBinding then
    return
  end
  self:RefreshButton()
end

function OptionBindingCtrl:RefreshButton()
  self._mapNode.Keyboard:SetActive(self.nDeviceType == BasicDevice.Keyboard)
  self._mapNode.Mouse:SetActive(self.nDeviceType == BasicDevice.Mouse)
  self._mapNode.Gamepad:SetActive(self.nDeviceType == BasicDevice.Gamepad)
  if self.nDeviceType == BasicDevice.Keyboard then
    if ImageKey[self.sName] then
      self._mapNode.imgKeyboard.gameObject:SetActive(true)
      self._mapNode.goKey:SetActive(false)
      local sIcon = ConfigTable.GetField("GamepadButton", self.sName, "XboxIcon")
      self:SetPngSprite(self._mapNode.imgKeyboard, sIcon)
      NovaAPI.SetImageNativeSize(self._mapNode.imgKeyboard)
    else
      self._mapNode.imgKeyboard.gameObject:SetActive(false)
      self._mapNode.goKey:SetActive(true)
      local sName = GamepadUIManager.GetInputName({
        name = self.sName,
        displayName = self.sDisplayName
      })
      NovaAPI.SetTMPText(self._mapNode.txtKeyboard, sName)
    end
  elseif self.nDeviceType == BasicDevice.Mouse then
    local sIcon = ConfigTable.GetField("GamepadButton", self.sName, "XboxIcon")
    self:SetPngSprite(self._mapNode.imgMouse, sIcon)
  elseif self.nDeviceType == BasicDevice.Gamepad then
    local sIcon
    if self.bPS then
      sIcon = ConfigTable.GetField("GamepadButton", self.sName, "PlayStationIcon")
    else
      sIcon = ConfigTable.GetField("GamepadButton", self.sName, "XboxIcon")
    end
    self:SetPngSprite(self._mapNode.imgGamepad, sIcon)
  end
end

function OptionBindingCtrl:OpenDeviceWarning()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Settings_Tip_IllegalDevice"))
  self:QuitBinding()
end

function OptionBindingCtrl:OpenKeyWarning()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Settings_Tip_IllegalInput"))
  self:QuitBinding()
end

function OptionBindingCtrl:OpenConflictWarning(sBeforeAction, inputInfo, nType)
  local sActionName = ConfigTable.GetUIText("Action_" .. sBeforeAction)
  local sTip = ConfigTable.GetUIText("Settings_Tip_ConflictInput") or ""
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = orderedFormat(sTip, sActionName),
    callbackConfirm = function()
      EventManager.Hit("SettingsSwitchBind", self.nDeviceType, inputInfo, {
        name = self.sName,
        displayName = self.sDisplayName
      })
      self:SwitchState(false)
      self.nDeviceType = nType
      self.sName = inputInfo.name
      self.sDisplayName = inputInfo.displayName
      self:UpdateBindConfig(inputInfo, nType)
      self:RefreshButton()
    end,
    callbackCancel = function()
      self:SwitchState(false)
    end,
    bBlur = false
  }
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.bActiveBinding = false
    EventManager.Hit(EventId.BlockInput, false)
    InputManager.Instance.IsVirtualMouseEnabled = true
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  cs_coroutine.start(wait)
end

function OptionBindingCtrl:OnBindingSuccess(inputInfo, nType)
  self.nDeviceType = nType
  self.sName = inputInfo.name
  self.sDisplayName = inputInfo.displayName
  self:UpdateBindConfig(inputInfo, nType)
  self:RefreshButton()
  self:QuitBinding()
end

function OptionBindingCtrl:UpdateBindConfig(inputInfo, nType)
  if nType == BasicDevice.Gamepad then
    self._panel.mapGamepadBind[self.sAction] = inputInfo.name
    EventManager.Hit("SettingsRefreshDisplay", self.sAction, inputInfo.name)
  else
    self._panel.mapKeyboardBind[self.sAction] = {
      name = inputInfo.name,
      displayName = inputInfo.displayName
    }
  end
end

function OptionBindingCtrl:QuitBinding()
  self.bActiveBinding = false
  self:SwitchState(false)
  InputManager.Instance.IsVirtualMouseEnabled = true
  self._mapNode.btnBind.interactable = false
  self:AddTimer(1, 0.4, function()
    self._mapNode.btnBind.interactable = true
    EventManager.Hit(EventId.BlockInput, false)
  end, true, true, true)
end

function OptionBindingCtrl:OnBtnClick_Bind()
  self.bActiveBinding = true
  self:SwitchState(true)
  EventManager.Hit(EventId.BlockInput, true)
  InputManager.Instance.IsVirtualMouseEnabled = false
end

function OptionBindingCtrl:OnEvent_KeyboardButtonPress(inputInfo)
  if not self.bActiveBinding then
    return
  end
  if self.nDeviceType == BasicDevice.Gamepad then
    self:OpenDeviceWarning()
    return
  end
  if table.indexof(IllegalKeyboardKey, inputInfo.displayName) ~= 0 then
    self:OpenKeyWarning()
    return
  end
  if inputInfo.name == self.sName then
    self:QuitBinding()
    return
  end
  local sBeforeAction
  for k, v in pairs(self._panel.mapKeyboardBind) do
    if v.name == inputInfo.name then
      sBeforeAction = k
    end
  end
  if sBeforeAction then
    self:OpenConflictWarning(sBeforeAction, inputInfo, BasicDevice.Keyboard)
    return
  end
  self:OnBindingSuccess(inputInfo, BasicDevice.Keyboard)
end

function OptionBindingCtrl:OnEvent_MouseButtonPress(inputInfo)
  if not self.bActiveBinding then
    return
  end
  if self.nDeviceType == BasicDevice.Gamepad then
    self:OpenDeviceWarning()
    return
  end
  if inputInfo.name == self.sName then
    self:QuitBinding()
    return
  end
  local sBeforeAction
  for k, v in pairs(self._panel.mapKeyboardBind) do
    if v.name == inputInfo.name then
      sBeforeAction = k
    end
  end
  if sBeforeAction then
    self:OpenConflictWarning(sBeforeAction, inputInfo, BasicDevice.Mouse)
    return
  end
  self:OnBindingSuccess(inputInfo, BasicDevice.Mouse)
end

function OptionBindingCtrl:OnEvent_GamepadButtonPress(inputInfo)
  if not self.bActiveBinding then
    return
  end
  if self.nDeviceType ~= BasicDevice.Gamepad then
    self:OpenDeviceWarning()
    return
  end
  if inputInfo.name == "leftTriggerButton" then
    inputInfo.name = "leftTrigger"
  elseif inputInfo.name == "rightTriggerButton" then
    inputInfo.name = "rightTrigger"
  end
  if table.indexof(LegalGamepadKey, inputInfo.name) == 0 then
    self:OpenKeyWarning()
    return
  end
  if inputInfo.name == self.sName then
    self:QuitBinding()
    return
  end
  local sBeforeAction = table.keyof(self._panel.mapGamepadBind, inputInfo.name)
  if sBeforeAction then
    self:OpenConflictWarning(sBeforeAction, inputInfo, BasicDevice.Gamepad)
    return
  end
  self:OnBindingSuccess(inputInfo, BasicDevice.Gamepad)
end

function OptionBindingCtrl:OnEvent_SwitchBind(nType, inputInfoBefore, inputInfo)
  if not self.sName or self.sName ~= inputInfoBefore.name then
    return
  end
  self.nDeviceType = nType
  self.sName = inputInfo.name
  self.sDisplayName = inputInfo.displayName
  self:UpdateBindConfig(inputInfo, nType)
  self:RefreshButton()
end

return OptionBindingCtrl
