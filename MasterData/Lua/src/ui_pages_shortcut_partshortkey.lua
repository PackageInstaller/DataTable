local this = class("partShortKey", G_UIPartBase)
local _keyCodeTpl = L_GameTpl:getKeyCodeTpl()
local keyCodeImg = {
  LMB = "UI/Icon/GuideIcon/tex_guide_fight_icon_sb1",
  MMB = "UI/Icon/GuideIcon/tex_guide_fight_icon_sb2"
}
local keyCodeName = {RMB = "R-MOUSE"}
local specialButtonName = {
  [L_Const.gamepadSpecialButtonName.D_Pad] = true,
  [L_Const.gamepadSpecialButtonName.D_PadAndLeftRight] = true,
  [L_Const.gamepadSpecialButtonName.D_PadAndUpDown] = true
}
for buttonName, _ in pairs(specialButtonName) do
  keyCodeImg[buttonName] = ""
end
local durationPattern = "duration=([%d%.]+)"

function this.bind()
  return {
    txtDes = "",
    imgKey = "",
    panelKeyboardActive = true,
    panelKeySingleActive = false,
    imgKeySingle = "",
    panelKeyDoubleActive = false,
    imgKeyDouble = "",
    imgAddActive = false,
    panelLongPressActive = false,
    go_activeSelf = true,
    imgActive = false,
    txtBGEnable = false
  }
end

function this.methods()
end

function this:open()
  self.bind.go_activeSelf = not L_DeviceTpl:getIsPc() and L_DeviceTpl:getIsMobile() and C_InputManager.IsEnableGamePad
  L_SettingStore:listenCallFunc(L_SettingStore.event.changeKey, self.onEvent_changeKey, self)
  self.onEvent_controlSchemeChangeHandle = self.onEvent_controlSchemeChangeHandle or handler(self, self.onEvent_controlSchemeChange)
  CS.Lens.Gameplay.Modules.BigWorld.ExternalManager.AddEvent(CS.Lens.Gameplay.Modules.BigWorld.EExternalEventType.ControlSchemeChange, self.onEvent_controlSchemeChangeHandle)
end

function this:close()
  L_SettingStore:unListenCallFunc(L_SettingStore.event.changeKey, self.onEvent_changeKey, self)
  CS.Lens.Gameplay.Modules.BigWorld.ExternalManager.RemoveEvent(CS.Lens.Gameplay.Modules.BigWorld.EExternalEventType.ControlSchemeChange, self.onEvent_controlSchemeChangeHandle)
  self:clearInputActionListener()
end

function this:onEvent_changeKey(settingId)
  if self.settingId ~= settingId then
    return
  end
  self:refreshKey(settingId)
end

function this:onEvent_controlSchemeChange(args)
  self:refreshKey(self.settingId)
end

function this:refreshTransform(parent, anchorType, offset, scale)
  local rTrans = self.bindComponents.rTrans
  rTrans:SetParent(parent)
  if anchorType then
    local cfg = L_Const.AnchorCfg[anchorType]
    rTrans.anchorMin = cfg.anchorMin
    rTrans.anchorMax = cfg.anchorMax
    rTrans.pivot = cfg.pivot
  end
  L_Vector3.setAnchored(rTrans, offset or L_Vector3.getTemp())
  L_Vector3.setSize(rTrans, scale or 1)
end

function this:getActionBinding(id, fallbackScheme)
  if id == nil then
    printf("ShortCut", "[getActionBinding] id is nil")
    return nil
  end
  local playerInput = C_InputManager.PlayerInput
  local currentControlScheme = playerInput and playerInput.currentControlScheme or fallbackScheme
  local actionName
  if type(id) == "number" then
    local success, info = C_SettingMap.TryGet(id)
    if success then
      actionName = info.Action
    end
  end
  local bindingDisplayName, bindingDisplayName2
  local isLongPress = false
  local holdDuration = 0.0
  if C_InputManager.IsEnableGamePad and C_InputManager.IsSpecialGamepadKey(actionName or id) then
    bindingDisplayName = actionName or id
  else
    local action = C_InputManager.GetAction(actionName or id)
    local bindingIndex = -1
    local candidates = {}
    if action then
      local isMatchingComposite = false
      for i = 0, action.bindings.Count - 1 do
        local binding = action.bindings[i]
        if binding.isComposite then
          isMatchingComposite = true
          candidates = {}
        elseif isMatchingComposite then
          if binding.isPartOfComposite and string.find(binding.groups, currentControlScheme, 1, true) and C_InputManager.IsBindingMatchCurrentDevice(binding) then
            bindingIndex = i
            table.insert(candidates, binding)
          else
            isMatchingComposite = false
            if 1 < #candidates then
              break
            end
          end
        elseif not binding.isPartOfComposite and string.find(binding.groups, currentControlScheme, 1, true) and C_InputManager.IsBindingMatchCurrentDevice(binding) then
          bindingIndex = i
          table.insert(candidates, binding)
          break
        end
      end
    end
    if action then
      if 0 <= bindingIndex and bindingIndex < action.bindings.Count and 0 < #candidates then
        if #candidates == 1 and fallbackScheme == "Keyboard&Mouse" then
          bindingDisplayName = C_InputManager.GetKeyDisplayName(action, bindingIndex)
          return bindingDisplayName
        end
        local option = CS.UnityEngine.InputSystem.InputBinding.DisplayStringOptions.DontIncludeInteractions
        bindingDisplayName = candidates[1]:ToDisplayString(option)
        isLongPress = string.find(candidates[1].interactions, "Hold") ~= nil
        local durationStr = isLongPress and string.match(candidates[1].interactions, durationPattern) or nil
        if 1 < #candidates then
          bindingDisplayName2 = candidates[2]:ToDisplayString(option)
          isLongPress = isLongPress or string.find(candidates[2].interactions, "Hold") ~= nil
          durationStr = not durationStr and string.match(candidates[2].interactions, durationPattern) or durationStr
        end
        if durationStr then
          holdDuration = tonumber(durationStr) or 0.0
        end
      else
        bindingDisplayName = ""
      end
    end
  end
  return bindingDisplayName, bindingDisplayName2, isLongPress, holdDuration
end

function this:refreshKey(id)
  self.settingId = id
  self.bind.txtBGEnable = true
  self.bind.imgAddActive = false
  self.bind.panelKeyDoubleActive = false
  self.bind.panelKeySingleActive = C_InputManager.IsEnableGamePad
  self.bind.panelKeyboardActive = not C_InputManager.IsEnableGamePad
  self.bind.panelLongPressActive = false
  self:clearInputActionListener()
  if L_DeviceTpl:getIsMobile() then
    if self._explicitActive ~= nil then
      self.bind.go_activeSelf = self._explicitActive and C_InputManager.IsEnableGamePad
    else
      self.bind.go_activeSelf = C_InputManager.IsEnableGamePad
    end
  end
  if C_InputManager.IsEnableGamePad then
    local buttonName, buttonName2, isLongPress, holdDuration = self:getActionBinding(id, "Gamepad")
    local imgPath = CS.Lens.Framework.Managers.InputManager.GetKeyImagePath(buttonName)
    if buttonName and imgPath then
      self.bind.txtDes = ""
      self.bind.imgKeySingle = imgPath
    elseif specialButtonName[id] then
      self.bind.txtDes = ""
      self.bind.imgKeySingle = CS.Lens.Framework.Managers.InputManager.GetKeyImagePath(id) or ""
    else
      self.bind.txtDes = buttonName or ""
      self.bind.imgKeySingle = ""
    end
    local imgPath2 = CS.Lens.Framework.Managers.InputManager.GetKeyImagePath(buttonName2)
    if buttonName2 and imgPath2 then
      self.bind.imgKeyDouble = imgPath2
    end
    self.bind.imgAddActive = buttonName2 ~= nil
    self.bind.panelKeyDoubleActive = buttonName2 ~= nil
    self.bind.panelLongPressActive = isLongPress
    if isLongPress then
      self:refreshInputActionListener(holdDuration)
    end
    self.bind.txtBGEnable = false
  else
    if L_DeviceTpl:getIsPc() then
      local name = self:getActionBinding(id, "Keyboard&Mouse") or tostring(id)
      if keyCodeImg[name] then
        self.bind.txtDes = ""
        self.bind.imgKey = keyCodeImg[name]
        self.bind.imgActive = true
      else
        self.bind.txtDes = keyCodeName[name] or name
        self.bind.imgKey = ""
        self.bind.imgActive = false
      end
    elseif L_DeviceTpl:getIsMobile() then
      self.bind.txtDes = ""
      self.bind.imgKey = ""
      self.bind.imgActive = false
    end
    self.bind.txtBGEnable = self.bind.txtDes ~= "" or self.bind.imgKey ~= ""
  end
  if L_CommonUtil.isValid(self.gameObject) then
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.gameObject.transform)
    Unity.UI.LayoutRebuilder.MarkLayoutForRebuild(self.gameObject.transform)
  end
end

function this:clearInputActionListener()
  self.holdDuration = 0.0
  if self.cachedAction ~= nil and self.inputActionHandle then
    self.cachedAction:started("-", self.inputActionHandle)
    self.cachedAction:canceled("-", self.inputActionHandle)
  end
end

function this:refreshInputActionListener(holdDuration)
  self.inputActionHandle = self.inputActionHandle or handler(self, self.onInputActionStateChange)
  local actionName = self.settingId
  if type(actionName) == "number" then
    local success, info = C_SettingMap.TryGet(actionName)
    if success then
      actionName = info.Action
    end
  end
  self.cachedAction = C_InputManager.GetAction(actionName)
  if self.cachedAction ~= nil then
    self.cachedAction:started("+", self.inputActionHandle)
    self.cachedAction:canceled("+", self.inputActionHandle)
    self.holdDuration = holdDuration
  end
end

function this:onInputActionStateChange(context)
  if context.started and self.gameObject.activeInHierarchy then
    self.bindComponents.ani_GamepadKeyLongPress.speed = self.holdDuration > 0 and 1.0 / self.holdDuration or 1.0
    self.bindComponents.ani_GamepadKeyLongPress:SetBool("Press", true)
  elseif context.canceled then
    self.bindComponents.ani_GamepadKeyLongPress.speed = 1.0
    self.bindComponents.ani_GamepadKeyLongPress:SetBool("Press", false)
  end
end

return this
