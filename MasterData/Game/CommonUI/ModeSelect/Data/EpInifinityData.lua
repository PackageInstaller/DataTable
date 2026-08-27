local EpInifinityData = class("EpInifinityData")
local EpFormationSaveData = require("Game.Exploration.UI.FormationSave.Data.EpFormationSaveData")

function EpInifinityData:ctor()
  self.teamId = nil
  self.envId = nil
  self.epFormationSaveData = nil
end

function EpInifinityData:InitEpInifinityDataByTeamId(teamId)
  self.teamId = teamId
  self.envId = EpInifinityData.TeamId2EnvId(teamId)
  self.epFormationSaveData = nil
  self:__RequireData()
end

function EpInifinityData:__RequireData()
  local envCfg = ConfigData.act_general_ep_env[self.envId]
  local net = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  net:CS_EXPLORATION_HERO_Formation_Detail(self.envId, function(objList)
    if objList == nil or objList.Count == 0 then
      error("objList error")
      return
    end
    local msg = objList[0]
    self.epFormationSaveData = EpFormationSaveData.CreateFmtSvDataByMsg(msg, envCfg)
  end)
end

function EpInifinityData:InitEpInifinityData(envId, epFormationSaveData)
  self.envId = envId
  self.epFormationSaveData = epFormationSaveData
end

function EpInifinityData:GetEpFormationSaveDataEnvId()
  return self.envId
end

function EpInifinityData:SetEpFormationSaveData()
  return self.epFormationSaveData
end

function EpInifinityData:GetEpFormationSaveData()
  return self.epFormationSaveData
end

function EpInifinityData.TeamId2EnvId(teamId)
  local envId = ConfigData.act_general_ep_env.saveTeamId2EnvIdMap[teamId]
  return envId
end

return EpInifinityData
