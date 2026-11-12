local PenguinCardPanel = class("PenguinCardPanel", BasePanel)
PenguinCardPanel._tbDefine = {
  {
    sPrefabPath = "Play_PenguinCard/PenguinCard_Normal.prefab",
    sCtrlName = "Game.UI.Play_PenguinCard.NormalMode.PenguinCardCtrl"
  }
}

function PenguinCardPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapLevel = tbParam[1]
  end
end

function PenguinCardPanel:OnEnable()
  PlayerData.Base:SetSkipNewDayWindow(true)
end

function PenguinCardPanel:OnDisable()
  PlayerData.Base:SetSkipNewDayWindow(false)
  PlayerData.Base:OnBackToMainMenuModule()
end

function PenguinCardPanel:OnDestroy()
end

return PenguinCardPanel
