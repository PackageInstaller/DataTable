_class("ConfigServiceHelper", Object)
ConfigServiceHelper = ConfigServiceHelper

function ConfigServiceHelper._GetConfigService()
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  local configService = mainWorld:GetService("Config")
  return configService
end

function ConfigServiceHelper.GetLevelConfigData()
  local configService = ConfigServiceHelper._GetConfigService()
  return configService:GetLevelConfigData()
end

function ConfigServiceHelper.ClearSkillConfigData()
  local configService = ConfigServiceHelper._GetConfigService()
  configService:ClearSkillConfigData()
end

function ConfigServiceHelper.GetMonsterConfigData()
  local configService = ConfigServiceHelper._GetConfigService()
  return configService:GetMonsterConfigData()
end

function ConfigServiceHelper.GetBuffConfigData(buffID)
  local configService = ConfigServiceHelper._GetConfigService()
  return configService:GetBuffConfigData(buffID)
end

function ConfigServiceHelper.GetSkillConfigData(skillID, pstID)
  local entity
  if pstID then
    local gameGlobal = GameGlobal:GetInstance()
    local mainWorld = gameGlobal:GetMainWorld()
    local eTeam = mainWorld:Player():GetLocalTeamEntity()
    local cTeam = eTeam:Team()
    entity = cTeam:GetPetEntityByPetPstID(pstID)
    if not entity then
      Log.error()
    end
  end
  local configService = ConfigServiceHelper._GetConfigService()
  return configService:GetSkillConfigData(skillID, entity)
end

function ConfigServiceHelper.GetMission3StarCondition(missionID)
  local configService = ConfigServiceHelper._GetConfigService()
  return configService:GetMission3StarCondition(missionID)
end

function ConfigServiceHelper.GetCampaignMission3StarCondition(missionID)
  local configService = ConfigServiceHelper._GetConfigService()
  return configService:GetCampaignMission3StarCondition(missionID)
end

function ConfigServiceHelper.GetChessMission3StarCondition(missionID)
  local configService = ConfigServiceHelper._GetConfigService()
  return configService:GetChessMission3StarCondition(missionID)
end

function ConfigServiceHelper.GetPopStar3StarCondition(missionID)
  local configService = ConfigServiceHelper._GetConfigService()
  return configService:GetPopStar3StarCondition(missionID)
end

function ConfigServiceHelper.GetPopStarPro3StarCondition(missionID)
  local configService = ConfigServiceHelper._GetConfigService()
  return configService:GetPopStarPro3StarCondition(missionID)
end

function ConfigServiceHelper.GetSeasonMission3StarCondition(missionID)
  local configService = ConfigServiceHelper._GetConfigService()
  return configService:GetSeasonMission3StarCondition(missionID)
end

function ConfigServiceHelper.GetChangeTeamLeaderCount()
  local configService = ConfigServiceHelper._GetConfigService()
  local leftCount = configService:GetChangeTeamLeaderCount()
  return leftCount
end

function ConfigServiceHelper.GetConfigMessageByAttr(tab, attr, comp)
  if not tab then
    return
  end
  local tabNew = {}
  for index, value in ipairs(tab) do
    if value[attr] and value[attr] == comp then
      table.insert(tabNew, value)
    end
  end
  return tabNew
end
