require("elemental_run_data")
_class("DifficultyMissionRunData", TestRobotElementalRunData)
DifficultyMissionRunData = DifficultyMissionRunData

function DifficultyMissionRunData:ParseLevelData(rawargs)
  local args = string.split(rawargs, ",")
  self._nodeID = tonumber(args[1])
  self._missionID = tonumber(args[2])
  self._mission_component_id = tonumber(args[3])
  self._campaign_component_cfg_id = tonumber(args[4])
  self._componentConfigID = tonumber(args[5])
  self._needMissionID = tonumber(args[6])
  self:ParseConfigID()
end

function DifficultyMissionRunData:GetMissionID()
  return self._missionID
end

function DifficultyMissionRunData:GetNodeID()
  return self._nodeID
end

function DifficultyMissionRunData:GetMissionComponentID()
  return self._mission_component_id
end

function DifficultyMissionRunData:GetCampaignComponentCfgID()
  return self._campaign_component_cfg_id
end

function DifficultyMissionRunData:GetComponentConfigID()
  return self._componentConfigID
end

function DifficultyMissionRunData:GetNeedMissionID()
  return self._needMissionID
end

function DifficultyMissionRunData:ParseConfigID()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  if self._componentConfigID then
    self._campaignID, self._componentID, self._componentType = campaignModule:ParseCfgComponentID(self._componentConfigID)
  end
end

function DifficultyMissionRunData:GetCampaignID()
  return self._campaignID
end
