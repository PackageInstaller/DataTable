local CookieGamePanel = class("CookieGamePanel", BasePanel)
CookieGamePanel._bIsMainPanel = true
CookieGamePanel._sUIResRootPath = "UI_Activity/"
CookieGamePanel._tbDefine = {
  {
    sPrefabPath = "_400016/CookieGamePanel.prefab",
    sCtrlName = "Game.UI.Play_Cookie.CookieGameCtrl"
  }
}

function CookieGamePanel:Awake()
end

function CookieGamePanel:OnEnable()
end

function CookieGamePanel:OnAfterEnter()
end

function CookieGamePanel:OnDisable()
end

function CookieGamePanel:OnDestroy()
end

function CookieGamePanel:OnRelease()
end

return CookieGamePanel
