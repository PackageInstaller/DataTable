require("common_async_base")
_class("GoldbergEvent_Cheat_AddActionPoint", Common_AsyncBase)
GoldbergEvent_Cheat_AddActionPoint = GoldbergEvent_Cheat_AddActionPoint

function GoldbergEvent_Cheat_AddActionPoint:Constructor(_manager, count)
  self._count = count
end

function GoldbergEvent_Cheat_AddActionPoint:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  local componentID = runData:GetComponentConfigID()
  local cfgMap = Cfg.cfg_component_action_point({ComponentID = componentID})
  local cfgActionPoint = cfgMap and cfgMap[1] or nil
  if cfgActionPoint then
    self._manager:AsyncGM_AddAsset(TT, status, cfgActionPoint.ItemID, self._count)
    return
  end
  local missionID = runData:GetMissionID()
  local cfgCampaignMission = Cfg.cfg_campaign_mission[missionID]
  if cfgCampaignMission and type(cfgCampaignMission.NeedAP) == "table" then
    local itemID = cfgCampaignMission.NeedAP[1]
    local amount = cfgCampaignMission.NeedAP[2]
    self._manager:AsyncGM_AddAsset(TT, status, itemID, amount)
    return
  end
end
