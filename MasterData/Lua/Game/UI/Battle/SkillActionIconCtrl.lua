local SkillActionIconCtrl = class("SkillActionIconCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local MouseName = {
  leftButton = 1,
  rightButton = 2,
  middleButton = 3,
  backButton = 4,
  forwardButton = 5
}
local ImageKey = {backspace = 1, enter = 2}
SkillActionIconCtrl._mapNodeConfig = {
  Keyboard = {},
  goKey = {},
  imgKeyboard = {sComponentName = "Image"},
  txtKeyboard = {sComponentName = "TMP_Text"},
  Mouse = {},
  imgMouse = {sComponentName = "Image"},
  Gamepad = {},
  imgGamepad = {sComponentName = "Image"},
  KeyNone = {}
}
SkillActionIconCtrl._mapEventConfig = {
  GamepadUIChange = "OnEvent_GamepadUIChange"
}

function SkillActionIconCtrl:Awake()
  self.bMobile = NovaAPI.IsMobilePlatform()
end

function SkillActionIconCtrl:SetActionBind(sGamepadBind, mapKeyboardBind)
  self.sGamepadBind = sGamepadBind
  self.mapKeyboardBind = mapKeyboardBind
  self:RefreshActionBind()
end

function SkillActionIconCtrl:RefreshActionBind()
  local nUIType = GamepadUIManager.GetCurUIType()
  self._mapNode.KeyNone:SetActive(false)
  self._mapNode.Gamepad:SetActive(nUIType == AllEnum.GamepadUIType.PS or nUIType == AllEnum.GamepadUIType.Xbox)
  self._mapNode.Keyboard:SetActive((nUIType == AllEnum.GamepadUIType.Other or nUIType == AllEnum.GamepadUIType.Keyboard or nUIType == AllEnum.GamepadUIType.Mouse) and not self.bMobile and not MouseName[self.mapKeyboardBind.name])
  self._mapNode.Mouse:SetActive((nUIType == AllEnum.GamepadUIType.Other or nUIType == AllEnum.GamepadUIType.Keyboard or nUIType == AllEnum.GamepadUIType.Mouse) and not self.bMobile and MouseName[self.mapKeyboardBind.name])
  if nUIType == AllEnum.GamepadUIType.Other or nUIType == AllEnum.GamepadUIType.Keyboard or nUIType == AllEnum.GamepadUIType.Mouse then
    if not self.bMobile then
      if self.mapKeyboardBind.name == "" then
        self._mapNode.Keyboard:SetActive(false)
        self._mapNode.Mouse:SetActive(false)
        self._mapNode.KeyNone:SetActive(true)
      elseif MouseName[self.mapKeyboardBind.name] then
        local sIcon = ConfigTable.GetField("GamepadButton", self.mapKeyboardBind.name, "XboxIcon")
        self:SetPngSprite(self._mapNode.imgMouse, sIcon)
      elseif ImageKey[self.mapKeyboardBind.name] then
        self._mapNode.imgKeyboard.gameObject:SetActive(true)
        self._mapNode.goKey:SetActive(false)
        local sIcon = ConfigTable.GetField("GamepadButton", self.mapKeyboardBind.name, "XboxIcon")
        self:SetPngSprite(self._mapNode.imgKeyboard, sIcon)
        NovaAPI.SetImageNativeSize(self._mapNode.imgKeyboard)
      else
        self._mapNode.imgKeyboard.gameObject:SetActive(false)
        self._mapNode.goKey:SetActive(true)
        local sName = GamepadUIManager.GetInputName(self.mapKeyboardBind)
        NovaAPI.SetTMPText(self._mapNode.txtKeyboard, sName)
      end
    end
  else
    local sIcon
    if nUIType == AllEnum.GamepadUIType.PS then
      sIcon = ConfigTable.GetField("GamepadButton", self.sGamepadBind, "PlayStationIcon")
    elseif nUIType == AllEnum.GamepadUIType.Xbox then
      sIcon = ConfigTable.GetField("GamepadButton", self.sGamepadBind, "XboxIcon")
    end
    self:SetPngSprite(self._mapNode.imgGamepad, sIcon)
  end
end

function SkillActionIconCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  self:RefreshActionBind()
end

return SkillActionIconCtrl
