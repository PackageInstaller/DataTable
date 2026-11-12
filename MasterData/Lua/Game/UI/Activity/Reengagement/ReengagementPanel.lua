local BasePanel = require("GameCore.UI.BasePanel")
local ReengagementPanel = class("ReengagementPanel", BasePanel)
ReengagementPanel._sUIResRootPath = "UI_Activity/"
ReengagementPanel._bIsMainPanel = true
ReengagementPanel._tbDefine = {
  {
    sPrefabPath = "_101004/ReengagementPanel.prefab",
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementCtrl"
  }
}

function ReengagementPanel:Awake()
end

function ReengagementPanel:OnEnable()
end

function ReengagementPanel:OnDisable()
end

function ReengagementPanel:OnDestroy()
end

function ReengagementPanel:OnRelease()
end

return ReengagementPanel
