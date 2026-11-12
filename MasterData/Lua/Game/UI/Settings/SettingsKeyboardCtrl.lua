local SettingsKeyboardCtrl = class("SettingsKeyboardCtrl", BaseCtrl)
local InputManager = CS.InputManager
local MouseName = {
  leftButton = 1,
  rightButton = 2,
  middleButton = 3,
  backButton = 4,
  forwardButton = 5
}
SettingsKeyboardCtrl._mapNodeConfig = {
  txtPageTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Keyboard"
  },
  txtBindingTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Keyboard_Binding"
  },
  OptionBinding = {
    nCount = 8,
    sCtrlName = "Game.UI.Settings.OptionKeyboardBindingCtrl"
  },
  OptionBindingMove = {
    nCount = 4,
    sCtrlName = "Game.UI.Settings.OptionKeyboardBindingCtrl"
  },
  txtBtnReset = {sComponentName = "TMP_Text", sLanguageId = "Reset"},
  btnReset = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reset"
  },
  txtBindTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Keyboard_BindingGroup1"
  },
  txtBindTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Keyboard_BindingGroup2"
  },
  txtOptionTitleBack = {
    sComponentName = "TMP_Text",
    sLanguageId = "Action_Back"
  },
  txtKeyboardBack = {sComponentName = "TMP_Text"}
}
SettingsKeyboardCtrl._mapEventConfig = {}

function SettingsKeyboardCtrl:RefreshText()
  for i = 1, 4 do
    self._mapNode.OptionBindingMove[i]:SetText(ConfigTable.GetUIText("Action_" .. self._panel.Move[i]))
  end
  for i = 1, 8 do
    self._mapNode.OptionBinding[i]:SetText(ConfigTable.GetUIText("Action_" .. self._panel.Action[i]))
  end
  NovaAPI.SetTMPText(self._mapNode.txtKeyboardBack, "Esc")
end

function SettingsKeyboardCtrl:Init()
  if self.bInit then
    return
  end
  self.bInit = true
  self:LoadSetting()
end

function SettingsKeyboardCtrl:Quit()
  if not self.bInit then
    return
  end
end

function SettingsKeyboardCtrl:LoadSetting()
  self._panel.mapKeyboardBind = {}
  for _, v in ipairs(self._panel.Action) do
    local bHas, tbControl = InputManager.Instance:GetInputActionConfig(v)
    if bHas then
      if tbControl.Count ~= 3 then
        printError("input config数量不为3，缺失配置")
        return
      end
      self._panel.mapKeyboardBind[v] = {}
      for i = 0, tbControl.Count - 1 do
        local mapControl = tbControl[i]
        local bEmpty = not mapControl.isKeyboard and not mapControl.isMouse and not mapControl.isGamepad
        if mapControl.isKeyboard or mapControl.isMouse or bEmpty then
          self._panel.mapKeyboardBind[v][i] = {
            name = mapControl.name,
            displayName = mapControl.displayName
          }
        end
      end
    end
  end
  local bHorizontal, tbHorizontal = InputManager.Instance:GetInputActionConfig("Horizontal")
  if bHorizontal then
    if tbHorizontal.Count ~= 7 then
      printError("input config数量不为7，缺失配置")
      return
    end
    self._panel.mapKeyboardBind.Right = {}
    self._panel.mapKeyboardBind.Left = {}
    local nPositiveIndex, nNegativeIndex = 1, 1
    for i = 0, tbHorizontal.Count - 1 do
      local mapControl = tbHorizontal[i]
      local bEmpty = not mapControl.isKeyboard and not mapControl.isMouse and not mapControl.isGamepad
      if mapControl.isKeyboard or mapControl.isMouse or bEmpty then
        if mapControl.isPositive then
          self._panel.mapKeyboardBind.Right[nPositiveIndex] = {
            name = mapControl.name,
            displayName = mapControl.displayName
          }
          nPositiveIndex = nPositiveIndex + 1
        elseif mapControl.isNegative then
          self._panel.mapKeyboardBind.Left[nNegativeIndex] = {
            name = mapControl.name,
            displayName = mapControl.displayName
          }
          nNegativeIndex = nNegativeIndex + 1
        end
      end
    end
  end
  local bVertical, tbVertical = InputManager.Instance:GetInputActionConfig("Vertical")
  if bVertical then
    if tbVertical.Count ~= 7 then
      printError("input config数量不为7，缺失配置")
      return
    end
    self._panel.mapKeyboardBind.Up = {}
    self._panel.mapKeyboardBind.Down = {}
    local nPositiveIndex, nNegativeIndex = 1, 1
    for i = 0, tbVertical.Count - 1 do
      local mapControl = tbVertical[i]
      local bEmpty = not mapControl.isKeyboard and not mapControl.isMouse and not mapControl.isGamepad
      if mapControl.isKeyboard or mapControl.isMouse or bEmpty then
        if mapControl.isPositive then
          self._panel.mapKeyboardBind.Up[nPositiveIndex] = {
            name = mapControl.name,
            displayName = mapControl.displayName
          }
          nPositiveIndex = nPositiveIndex + 1
        elseif mapControl.isNegative then
          self._panel.mapKeyboardBind.Down[nNegativeIndex] = {
            name = mapControl.name,
            displayName = mapControl.displayName
          }
          nNegativeIndex = nNegativeIndex + 1
        end
      end
    end
  end
  self:RefreshOption()
end

function SettingsKeyboardCtrl:RefreshOption()
  for i = 1, 4 do
    local sAction = self._panel.Move[i]
    self._mapNode.OptionBindingMove[i]:Init(sAction)
  end
  for i = 1, 8 do
    local sAction = self._panel.Action[i]
    self._mapNode.OptionBinding[i]:Init(sAction)
  end
end

function SettingsKeyboardCtrl:SaveSetting()
  local function device(sAction, nIndex)
    local mapInput = self._panel.mapKeyboardBind[sAction][nIndex]
    
    if mapInput.name == "" then
      return ""
    end
    local bMouse = MouseName[mapInput.name] ~= nil
    local sPre = bMouse and "<Mouse>/" or "<Keyboard>/"
    return sPre .. mapInput.name
  end
  
  for _, v in ipairs(self._panel.Action) do
    for i = 1, 2 do
      InputManager.Instance:OverrideButtonBinding(v, i, device(v, i))
      if v == "Fire1" then
        InputManager.Instance:OverrideButtonBinding("Fire3", i, device(v, i))
      end
    end
  end
  for i = 1, 2 do
    InputManager.Instance:OverrideButtonBinding("Horizontal", i * 3, device("Right", i))
    InputManager.Instance:OverrideButtonBinding("Horizontal", i * 3 - 1, device("Left", i))
    InputManager.Instance:OverrideButtonBinding("Vertical", i * 3, device("Up", i))
    InputManager.Instance:OverrideButtonBinding("Vertical", i * 3 - 1, device("Down", i))
  end
end

function SettingsKeyboardCtrl:Awake()
  self.bInit = false
  self:RefreshText()
end

function SettingsKeyboardCtrl:OnEnable()
end

function SettingsKeyboardCtrl:OnDisable()
  if not self.bInit then
    return
  end
  self:SaveSetting()
end

function SettingsKeyboardCtrl:OnDestroy()
end

function SettingsKeyboardCtrl:OnBtnClick_Reset()
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

return SettingsKeyboardCtrl
