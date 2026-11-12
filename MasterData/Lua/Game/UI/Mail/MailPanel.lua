local MailPanel = class("MailPanel", BasePanel)
MailPanel._tbDefine = {
  {
    sPrefabPath = "Mail/MailPanel.prefab",
    sCtrlName = "Game.UI.Mail.MailCtrl"
  }
}

function MailPanel:Awake()
end

function MailPanel:OnEnable()
end

function MailPanel:OnDisable()
end

function MailPanel:OnDestroy()
end

return MailPanel
