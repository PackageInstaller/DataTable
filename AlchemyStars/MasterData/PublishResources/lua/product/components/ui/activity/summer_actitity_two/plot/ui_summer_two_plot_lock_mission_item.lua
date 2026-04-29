_class("UISummerTwoPlotLockMissionItem", UICustomWidget)
UISummerTwoPlotLockMissionItem = UISummerTwoPlotLockMissionItem

function UISummerTwoPlotLockMissionItem:OnShow(uiParams)
  self:_GetComponents()
end

function UISummerTwoPlotLockMissionItem:_GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._go = self:GetGameObject("go")
end

function UISummerTwoPlotLockMissionItem:SetData(index, data)
  self._idx = index
  self._missionData = data
  self:_OnValue()
end

function UISummerTwoPlotLockMissionItem:SetActive(active)
  self._go:SetActive(active)
end

function UISummerTwoPlotLockMissionItem:_OnValue()
  local missionid = self._missionData.missionid
  local cfgs = Cfg.cfg_campaign_mission({CampaignMissionId = missionid})
  if not cfgs then
    Log.error("###[UISummerTwoPlotLockMissionItem] cfgs is nil ! id --> ", missionid)
    return
  end
  local name = cfgs[1].Name
  self._name:SetText(StringTable.Get("str_summer_activity_two_plot_pass_mission_unlock", StringTable.Get(name)))
end
