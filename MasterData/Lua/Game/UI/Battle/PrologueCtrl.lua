local PrologueCtrl = class("PrologueCtrl", BaseCtrl)
local ConfigData = require("GameCore.Data.ConfigData")
local PlayerCharData = PlayerData.Char
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local AdventureModuleHelper = CS.AdventureModuleHelper
local InteractiveManagerIns = CS.InteractiveManager.Instance
PrologueCtrl._mapNodeConfig = {
  cgRoot = {
    sNodeName = "--safe_area--",
    sComponentName = "CanvasGroup"
  },
  btnHand = {
    sComponentName = "ButtonEx",
    callback = "OnBtn_ClickHand"
  },
  trHand = {sNodeName = "btnHand", sComponentName = "Transform"},
  imgHandIcon = {sComponentName = "Image"},
  tmpInteract = {nCount = 2, sComponentName = "TMP_Text"},
  animBtnHand = {sNodeName = "btnHand", sComponentName = "Animator"},
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
  }
}
PrologueCtrl._mapEventConfig = {
  InputEnable = "OnEvent_InputEnable",
  interactiveUI = "OnUIInfoShow",
  InteractiveEnable = "OnBtn_ClickHand",
  FadeIn = "OnFadeIn"
}

function PrologueCtrl:Awake()
  self.tbDefine_FunctionBtn = {
    [1] = {
      sName = "Interactive",
      nHoldThreshold = 0.1
    }
  }
  NovaAPI.RegisterVirtualJoystick("Horizontal", "Vertical", self._mapNode.goJoystick)
  local nW = math.floor(Settings.CURRENT_CANVAS_FULL_RECT_WIDTH)
  local nH = math.floor(Settings.CURRENT_CANVAS_FULL_RECT_HEIGHT)
  self._mapNode.rtJoystick.sizeDelta = Vector2(nW / 2, nH * 2 / 3)
  for nIndex, v in ipairs(self.tbDefine_FunctionBtn) do
    NovaAPI.RegisterRealButton(v.sName, v.nHoldThreshold)
  end
  self:SetVisible(false)
  self._mapNode.trHand.localScale = Vector3.zero
end

function PrologueCtrl:OnPreExit()
  NovaAPI.UnRegisterVirtualJoystick("Horizontal", "Vertical")
  for nIndex, v in ipairs(self.tbDefine_FunctionBtn) do
    NovaAPI.UnRegisterRealButton(v.sName)
  end
end

function PrologueCtrl:OnDestroy()
end

function PrologueCtrl:OnFadeIn()
end

function PrologueCtrl:OnEvent_InputEnable(bEnable)
  self:SetVisible(bEnable == true)
end

function PrologueCtrl:SetVisible(bVisible)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgRoot, bVisible == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.cgRoot, bVisible == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.cgRoot, bVisible == true)
end

function PrologueCtrl:OnBtn_ClickHand(btn)
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
  self:AddTimer(1, 0.2, "SetBtnHandInteractable", true, true, true)
end

function PrologueCtrl:SetBtnHandInteractable()
  self.bInteractiveInCD = false
  self._mapNode.btnHand.interactable = true
end

function PrologueCtrl:OnUIInfoShow(nInteractiveId, bShowUI, sIcon, sText, nDuration)
  if bShowUI ~= true and self.nInteractiveId ~= nInteractiveId then
    return
  end
  printLog("交互id" .. tostring(nInteractiveId))
  self.nInteractiveId = nInteractiveId
  self.bShowUI = bShowUI
  if self.bInteractiveInCD ~= true then
    self._mapNode.btnHand.interactable = true
  end
  if self._mapNode.trHand.localScale.x == 0 and bShowUI == true then
    self._mapNode.animBtnHand:SetTrigger("tPlay")
  end
  self._mapNode.trHand.localScale = bShowUI == true and Vector3.one or Vector3.zero
  NovaAPI.SetTMPText(self._mapNode.tmpInteract[1], sText)
  NovaAPI.SetTMPText(self._mapNode.tmpInteract[2], sText)
  if type(sIcon) == "string" and sIcon ~= "" then
    self:SetPngSprite(self._mapNode.imgHandIcon, sIcon)
    NovaAPI.SetImageNativeSize(self._mapNode.imgHandIcon)
  end
end

return PrologueCtrl
