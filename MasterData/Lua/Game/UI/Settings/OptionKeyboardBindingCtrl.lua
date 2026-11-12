local OptionKeyboardBindingCtrl = class("OptionKeyboardBindingCtrl", BaseCtrl)
local InputManager = CS.InputManager
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local ImageKey = {backspace = 1, enter = 2}
local MouseName = {
  leftButton = 1,
  rightButton = 2,
  middleButton = 3,
  backButton = 4,
  forwardButton = 5
}
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
OptionKeyboardBindingCtrl._mapNodeConfig = {
  txtOptionTitle = {sComponentName = "TMP_Text"},
  btnBind = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Bind"
  },
  Placeholder = {nCount = 2},
  goBind = {nCount = 2},
  bindBg = {nCount = 2},
  holderBg = {nCount = 2},
  keynone = {nCount = 2},
  Keyboard = {nCount = 2},
  goKey = {nCount = 2},
  imgKeyboard = {nCount = 2, sComponentName = "Image"},
  txtKeyboard = {nCount = 2, sComponentName = "TMP_Text"},
  Mouse = {nCount = 2},
  imgMouse = {nCount = 2, sComponentName = "Image"}
}
OptionKeyboardBindingCtrl._mapEventConfig = {
  LuaEventName_KeyboardButtonPress = "OnEvent_KeyboardButtonPress",
  LuaEventName_MouseButtonPress = "OnEvent_MouseButtonPress",
  LuaEventName_GamepadButtonPress = "OnEvent_GamepadButtonPress",
  SettingsSwitchKeyboardBind = "OnEvent_SwitchBind"
}

function OptionKeyboardBindingCtrl:SetText(sTitle)
  NovaAPI.SetTMPText(self._mapNode.txtOptionTitle, sTitle)
end

function OptionKeyboardBindingCtrl:Init(sAction)
  self.nActiveBindingIndex = 0
  self.sAction = sAction
  for i = 1, 2 do
    self:SwitchState(i, false)
    self:RefreshButton(i)
  end
end

function OptionKeyboardBindingCtrl:SwitchState(nIndex, bholder)
  self._mapNode.Placeholder[nIndex]:SetActive(bholder)
  self._mapNode.holderBg[nIndex]:SetActive(bholder)
  self._mapNode.goBind[nIndex]:SetActive(not bholder)
  self._mapNode.bindBg[nIndex]:SetActive(not bholder)
end

function OptionKeyboardBindingCtrl:RefreshButton(nIndex)
  local mapInput = self._panel.mapKeyboardBind[self.sAction][nIndex]
  if mapInput.name == "" then
    self._mapNode.Keyboard[nIndex]:SetActive(false)
    self._mapNode.Mouse[nIndex]:SetActive(false)
    self._mapNode.keynone[nIndex]:SetActive(true)
    return
  end
  self._mapNode.keynone[nIndex]:SetActive(false)
  local bMouse = MouseName[mapInput.name]
  self._mapNode.Keyboard[nIndex]:SetActive(not bMouse)
  self._mapNode.Mouse[nIndex]:SetActive(bMouse)
  if not bMouse then
    if ImageKey[mapInput.name] then
      self._mapNode.imgKeyboard[nIndex].gameObject:SetActive(true)
      self._mapNode.goKey[nIndex]:SetActive(false)
      local sIcon = ConfigTable.GetField("GamepadButton", mapInput.name, "XboxIcon")
      self:SetPngSprite(self._mapNode.imgKeyboard[nIndex], sIcon)
      NovaAPI.SetImageNativeSize(self._mapNode.imgKeyboard[nIndex])
    else
      self._mapNode.imgKeyboard[nIndex].gameObject:SetActive(false)
      self._mapNode.goKey[nIndex]:SetActive(true)
      local sName = GamepadUIManager.GetInputName(mapInput)
      NovaAPI.SetTMPText(self._mapNode.txtKeyboard[nIndex], sName)
    end
  elseif bMouse then
    local sIcon = ConfigTable.GetField("GamepadButton", mapInput.name, "XboxIcon")
    self:SetPngSprite(self._mapNode.imgMouse[nIndex], sIcon)
  end
end

function OptionKeyboardBindingCtrl:OpenDeviceWarning()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Settings_Tip_IllegalDevice"))
  self:QuitBinding()
end

function OptionKeyboardBindingCtrl:OpenKeyWarning()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Settings_Tip_IllegalInput"))
  self:QuitBinding()
end

function OptionKeyboardBindingCtrl:ChangeInGroup()
  local mapFirst = self._panel.mapKeyboardBind[self.sAction][1]
  self._panel.mapKeyboardBind[self.sAction][1] = self._panel.mapKeyboardBind[self.sAction][2]
  self._panel.mapKeyboardBind[self.sAction][2] = mapFirst
  for i = 1, 2 do
    self:RefreshButton(i)
  end
  self:QuitBinding()
end

function OptionKeyboardBindingCtrl:OpenConflictWarning(sBeforeAction, nBeforIndex, inputInfo)
  local nSelectIndex = self.nActiveBindingIndex
  local mapInput = self._panel.mapKeyboardBind[self.sAction][nSelectIndex]
  local sActionName = ConfigTable.GetUIText("Action_" .. sBeforeAction)
  local sTip = ConfigTable.GetUIText("Settings_Tip_ConflictInput") or ""
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = orderedFormat(sTip, sActionName),
    callbackConfirm = function()
      EventManager.Hit("SettingsSwitchKeyboardBind", sBeforeAction, nBeforIndex, {
        name = mapInput.name,
        displayName = mapInput.displayName
      })
      self:SwitchState(nSelectIndex, false)
      self:UpdateBindConfig(inputInfo, nSelectIndex)
      self:RefreshButton(nSelectIndex)
    end,
    callbackCancel = function()
      self:SwitchState(nSelectIndex, false)
    end,
    bBlur = false
  }
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.nActiveBindingIndex = 0
    EventManager.Hit(EventId.BlockInput, false)
    InputManager.Instance.IsVirtualMouseEnabled = true
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  cs_coroutine.start(wait)
end

function OptionKeyboardBindingCtrl:OnBindingSuccess(inputInfo)
  self:UpdateBindConfig(inputInfo, self.nActiveBindingIndex)
  self:RefreshButton(self.nActiveBindingIndex)
  self:QuitBinding()
end

function OptionKeyboardBindingCtrl:UpdateBindConfig(inputInfo, nIndex)
  self._panel.mapKeyboardBind[self.sAction][nIndex] = {
    name = inputInfo.name,
    displayName = inputInfo.displayName
  }
end

function OptionKeyboardBindingCtrl:QuitBinding()
  self:SwitchState(self.nActiveBindingIndex, false)
  self.nActiveBindingIndex = 0
  self:AddTimer(1, 0.1, function()
    EventManager.Hit(EventId.BlockInput, false)
    InputManager.Instance.IsVirtualMouseEnabled = true
  end, true, true, true)
end

function OptionKeyboardBindingCtrl:Awake()
  self.nActiveBindingIndex = 0
end

function OptionKeyboardBindingCtrl:OnBtnClick_Bind(btn, nIndex)
  self.nActiveBindingIndex = nIndex
  self:SwitchState(nIndex, true)
  EventManager.Hit(EventId.BlockInput, true)
  InputManager.Instance.IsVirtualMouseEnabled = false
end

function OptionKeyboardBindingCtrl:OnEvent_KeyboardButtonPress(inputInfo)
  if self.nActiveBindingIndex == 0 then
    return
  end
  if table.indexof(IllegalKeyboardKey, inputInfo.displayName) ~= 0 then
    self:OpenKeyWarning()
    return
  end
  local mapInput = self._panel.mapKeyboardBind[self.sAction][self.nActiveBindingIndex]
  if inputInfo.name == mapInput.name then
    self:QuitBinding()
    return
  end
  local mapInputInGroup = self._panel.mapKeyboardBind[self.sAction][self.nActiveBindingIndex == 1 and 2 or 1]
  if inputInfo.name == mapInputInGroup.name then
    self:ChangeInGroup()
    return
  end
  local sBeforeAction, nBeforIndex = nil, 0
  for k, v in pairs(self._panel.mapKeyboardBind) do
    for i = 1, 2 do
      if v[i].name and inputInfo.name == v[i].name then
        sBeforeAction = k
        nBeforIndex = i
        break
      end
    end
  end
  if sBeforeAction then
    self:OpenConflictWarning(sBeforeAction, nBeforIndex, inputInfo)
    return
  end
  self:OnBindingSuccess(inputInfo)
end

function OptionKeyboardBindingCtrl:OnEvent_MouseButtonPress(inputInfo)
  if self.nActiveBindingIndex == 0 then
    return
  end
  local mapInput = self._panel.mapKeyboardBind[self.sAction][self.nActiveBindingIndex]
  if inputInfo.name == mapInput.name then
    self:QuitBinding()
    return
  end
  local mapInputInGroup = self._panel.mapKeyboardBind[self.sAction][self.nActiveBindingIndex == 1 and 2 or 1]
  if inputInfo.name == mapInputInGroup.name then
    self:ChangeInGroup()
    return
  end
  local sBeforeAction, nBeforIndex = nil, 0
  for k, v in pairs(self._panel.mapKeyboardBind) do
    for i = 1, 2 do
      if v[i].name and inputInfo.name == v[i].name then
        sBeforeAction = k
        nBeforIndex = i
        break
      end
    end
  end
  if sBeforeAction then
    self:OpenConflictWarning(sBeforeAction, nBeforIndex, inputInfo)
    return
  end
  self:OnBindingSuccess(inputInfo)
end

function OptionKeyboardBindingCtrl:OnEvent_GamepadButtonPress(inputInfo)
  if self.nActiveBindingIndex == 0 then
    return
  end
  self:OpenDeviceWarning()
end

function OptionKeyboardBindingCtrl:OnEvent_SwitchBind(nAction, nIndex, inputInfo)
  if self.sAction ~= nAction then
    return
  end
  self:UpdateBindConfig(inputInfo, nIndex)
  self:RefreshButton(nIndex)
end

return OptionKeyboardBindingCtrl
