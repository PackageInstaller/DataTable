_class("UISeasonPhaseHelper", Object)
UISeasonPhaseHelper = UISeasonPhaseHelper

function UISeasonPhaseHelper._GetCfg(seasonId)
  local cfgs = Cfg.cfg_season_campaign_phase({SeasonId = seasonId}) or {}
  table.sort(cfgs, function(a, b)
    return a.Phase < b.Phase
  end)
  return cfgs
end

function UISeasonPhaseHelper.CheckPhase()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonId = seasonModule:GetCurSeasonID()
  local seasonObj = seasonModule:GetCurSeasonObj()
  if seasonId == -1 or seasonObj == nil then
    return 1
  end
  local cfgs = UISeasonPhaseHelper._GetCfg(seasonId)
  for i, cfg in ipairs(cfgs) do
    if not UISeasonPhaseHelper.CheckPhase_Init(seasonObj, cfg) then
    elseif not UISeasonPhaseHelper.CheckPhase_Pass(seasonObj, cfg) then
      return i - 1
    elseif not UISeasonPhaseHelper.CheckPhase_Mask(seasonObj, cfg) then
      return i - 1
    elseif not UISeasonPhaseHelper.CheckPhase_Quest(seasonObj, cfg) then
      return i - 1
    end
  end
  return #cfgs
end

function UISeasonPhaseHelper.CheckPhase_Init(seasonObj, cfg)
  local checkInit = cfg.CheckInit
  if not checkInit then
    return true
  end
end

function UISeasonPhaseHelper.CheckPhase_Pass(seasonObj, cfg)
  local missionId = cfg.MissionId
  local checkPass = cfg.CheckPass
  if not checkPass then
    return true
  end
  local component = seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  if not component then
    local str = "UISeasonPhaseHelper.CheckPhase_Pass() SeasonMissionComponent = nil"
    Log.exception(str)
    return true
  end
  if component:IsPassCamMissionID(missionId) then
    return true
  end
end

function UISeasonPhaseHelper.CheckPhase_Mask(seasonObj, cfg)
  local missionId = cfg.MissionId
  local checkMask = cfg.CheckMask
  if checkMask == nil then
    return true
  end
  local component = seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  if not component then
    local str = "UISeasonPhaseHelper.CheckPhase_Mask() SeasonMissionComponent = nil"
    Log.exception(str)
    return true
  end
  local mask = component:GetMask(missionId)
  if mask ~= nil and checkMask <= mask then
    return true
  end
end

function UISeasonPhaseHelper.CheckPhase_Quest(seasonObj, cfg)
  local questId = cfg.QuestId
  local checkQuest = cfg.CheckQuest
  if checkQuest == nil then
    return true
  end
  local component = seasonObj:GetComponent(ECCampaignSeasonComponentID.QUEST_STORY)
  if not component then
    local str = "UISeasonPhaseHelper.CheckPhase_Quest() CampaignQuestComponent = nil"
    Log.exception(str)
    return true
  end
  local quest = component:GetQuestInfoById(questId)
  if not quest then
    local fmt = "UISeasonPhaseHelper.CheckPhase_Quest() cfg_season_campaign_phase[%s] Quest[%s] = nil"
    local str = string.format(fmt, cfg.ID, questId)
    Log.exception(str)
    return true
  end
  local questStatus = component:CheckCampaignQuestStatus(quest._questInfo)
  if checkQuest <= questStatus then
    return true
  end
end

function UISeasonPhaseHelper.GetPhaseSpine(phase)
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonId = seasonModule:GetCurSeasonID()
  if seasonId == -1 then
    return 1
  end
  local cfgs = UISeasonPhaseHelper._GetCfg(seasonId)
  local spine = cfgs and cfgs[phase] and cfgs[phase].Spine
  return spine
end
