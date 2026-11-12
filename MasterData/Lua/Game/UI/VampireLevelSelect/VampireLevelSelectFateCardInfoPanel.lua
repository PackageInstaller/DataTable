local VampireLevelSelectPanel = class("VampireLevelSelectPanel", BasePanel)
VampireLevelSelectPanel._tbDefine = {
  {
    sPrefabPath = "VampireLevelSelect/VampireLevelSelectPanel.prefab",
    sCtrlName = "Game.UI.VampireLevelSelect.VampireLevelSelectCtrl"
  }
}

function VampireLevelSelectPanel:Awake()
end

function VampireLevelSelectPanel:OnEnable()
end

function VampireLevelSelectPanel:OnAfterEnter()
end

function VampireLevelSelectPanel:OnDisable()
end

function VampireLevelSelectPanel:OnDestroy()
end

function VampireLevelSelectPanel:OnRelease()
end

return VampireLevelSelectPanel
