local CookieBoardPanel = class("CookieBoardPanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
CookieBoardPanel._sUIResRootPath = "UI_Activity/"
CookieBoardPanel._bIsMainPanel = true
CookieBoardPanel._tbDefine = {
  {
    sPrefabPath = "_400010/CookieBoardPanel.prefab",
    sCtrlName = "Game.UI.Play_Cookie.CookieBoardCtrl"
  }
}

function CookieBoardPanel:Awake()
  GamepadUIManager.EnterAdventure(true)
end

function CookieBoardPanel:OnEnable()
end

function CookieBoardPanel:OnAfterEnter()
end

function CookieBoardPanel:OnDisable()
end

function CookieBoardPanel:OnDestroy()
  GamepadUIManager.QuitAdventure()
end

function CookieBoardPanel:OnRelease()
end

return CookieBoardPanel
