local DailyInstanceLevelSelectPanel = class("DailyInstanceLevelSelectPanel", BasePanel)
DailyInstanceLevelSelectPanel._tbDefine = {
  {
    sPrefabPath = "DailyInstanceLevelSelect/DailyInstanceLevelSelectEx.prefab",
    sCtrlName = "Game.UI.DailyInstanceLevelSelect.DailyInstanceLevelSelectCtrl"
  }
}

function DailyInstanceLevelSelectPanel:Awake()
end

function DailyInstanceLevelSelectPanel:OnEnable()
end

function DailyInstanceLevelSelectPanel:OnDisable()
end

function DailyInstanceLevelSelectPanel:OnDestroy()
end

function DailyInstanceLevelSelectPanel:OnRelease()
end

return DailyInstanceLevelSelectPanel
