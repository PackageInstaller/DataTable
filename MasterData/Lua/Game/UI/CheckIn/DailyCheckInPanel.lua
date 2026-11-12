local DailyCheckInPanel = class("DailyCheckInPanel", BasePanel)
DailyCheckInPanel._bIsMainPanel = false
DailyCheckInPanel._tbDefine = {
  {
    sPrefabPath = "CheckIn/DailyCheckInPanel.prefab",
    sCtrlName = "Game.UI.CheckIn.DailyCheckInCtrl"
  }
}

function DailyCheckInPanel:Awake()
end

function DailyCheckInPanel:OnEnable()
end

function DailyCheckInPanel:OnDisable()
end

function DailyCheckInPanel:OnDestroy()
end

return DailyCheckInPanel
