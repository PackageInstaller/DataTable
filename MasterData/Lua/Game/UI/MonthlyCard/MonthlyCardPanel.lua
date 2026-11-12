local MonthlyCardPanel = class("MonthlyCardPanel", BasePanel)
MonthlyCardPanel._bIsMainPanel = false
MonthlyCardPanel._tbDefine = {
  {
    sPrefabPath = "MonthlyCard/MonthlyCardPanel.prefab",
    sCtrlName = "Game.UI.MonthlyCard.MonthlyCardCtrl"
  }
}

function MonthlyCardPanel:Awake()
end

function MonthlyCardPanel:OnEnable()
end

function MonthlyCardPanel:OnDisable()
end

function MonthlyCardPanel:OnDestroy()
end

return MonthlyCardPanel
