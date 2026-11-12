local CookieQuestPanel = class("CookieQuestPanel", BasePanel)
CookieQuestPanel._bIsMainPanel = true
CookieQuestPanel._sUIResRootPath = "UI_Activity/"
CookieQuestPanel._tbDefine = {
  {
    sPrefabPath = "_400016/CookieQuestPanel.prefab",
    sCtrlName = "Game.UI.Play_Cookie.CookieQuestCtrl"
  }
}

function CookieQuestPanel:Awake()
end

function CookieQuestPanel:OnEnable()
end

function CookieQuestPanel:OnAfterEnter()
end

function CookieQuestPanel:OnDisable()
end

function CookieQuestPanel:OnDestroy()
end

function CookieQuestPanel:OnRelease()
end

return CookieQuestPanel
