local BasePanel = require("GameCore.UI.BasePanel")
local UnchartedMapPanel = class("UnchartedMapPanel", BasePanel)
UnchartedMapPanel._sUIResRootPath = "UI_Activity/"
UnchartedMapPanel._tbDefine = {
  {
    sPrefabPath = "10113/UnchartedMapPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.10113.UnchartedMapCtrl"
  }
}

function UnchartedMapPanel:Awake()
end

function UnchartedMapPanel:OnEnable()
end

function UnchartedMapPanel:OnDisable()
end

function UnchartedMapPanel:OnDestroy()
end

function UnchartedMapPanel:OnRelease()
end

return UnchartedMapPanel
