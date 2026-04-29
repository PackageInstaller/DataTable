_class("EliminateHelper", Object)
EliminateHelper = EliminateHelper

function EliminateHelper.CheckFetter(groupID, petList, petID)
  if petID == 0 then
    return false
  end
  local petModule = GameGlobal.GetModule(PetModule)
  local curPetID = petModule:GetPet(petID):GetTemplateID()
  local curPetList = {}
  for _, v in pairs(petList) do
    local pet = petModule:GetPet(v)
    if pet then
      table.insert(curPetList, pet:GetTemplateID())
    end
  end
  local eliminateGroup = EliminateHelper.GetPetFetter(groupID, curPetID)
  for _, eliminateID in pairs(eliminateGroup) do
    if table.icontains(curPetList, eliminateID) then
      return true, eliminateID
    end
  end
  return false
end

function EliminateHelper.GetPetFetter(groupID, petID)
  local fetterAInfos = Cfg.cfg_anipop_fetters({FettersID = groupID, PetAID = petID}) or {}
  local fetterBInfos = Cfg.cfg_anipop_fetters({FettersID = groupID, PetBID = petID}) or {}
  local eliminateGroup = {}
  for _, fetterAInfo in pairs(fetterAInfos) do
    table.insert(eliminateGroup, fetterAInfo.PetBID)
  end
  for _, fetterBInfo in pairs(fetterBInfos) do
    table.insert(eliminateGroup, fetterBInfo.PetAID)
  end
  return eliminateGroup
end

function EliminateHelper.GuideCheckFetter(missionID, groupID, petID)
  local guideCfg = Cfg.cfg_mission_guide[missionID]
  local petList = guideCfg.BattlePetList
  local pets = {}
  for _, v in pairs(petList) do
    table.insert(pets, v[1])
  end
  local eliminateGroup = EliminateHelper.GetPetFetter(groupID, petID)
  for _, eliminateID in pairs(eliminateGroup) do
    if table.icontains(pets, eliminateID) then
      return true, eliminateID
    end
  end
  return false
end

function EliminateHelper.GetCampIcon(campID)
  local icons = {
    [1001] = "qdhl_new_logo06",
    [1002] = "qdhl_new_logo05",
    [1005] = "qdhl_new_logo01",
    [1003] = "qdhl_new_logo04",
    [1006] = "qdhl_new_logo03",
    [1004] = "qdhl_new_logo02",
    [1009] = "qdhl_new_logo07"
  }
  return icons[campID]
end

function EliminateHelper.GetAwardList()
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local anipopInfo = anipopModule:GetAniPopInfo()
  local curSeason = anipopInfo.cur_season
  local hardID = anipopInfo.week_info.hard_id
  local hardCfg = Cfg.cfg_anipop_hard[hardID]
  local scoreSequenceId = Cfg.cfg_anipop_season[curSeason].ScoreSequenceId
  local awardList = {}
  local groupID = hardCfg.ScoreGroupId
  if EliminateHelper.IsAniPopUseNewCfg() then
    groupID = hardCfg.NewScoreGroupId
  end
  local awardCfgs = Cfg.cfg_anipop_score({})
  for _, cfg in pairs(awardCfgs) do
    if cfg.GroupId == groupID and cfg.ScoreSequenceId == scoreSequenceId then
      for __, v in pairs(cfg.ItemList) do
        local itemInfo = {}
        itemInfo.ID = v[1]
        itemInfo.Num = v[2]
        itemInfo.Score = cfg.Score
        itemInfo.CfgID = cfg.ID
        table.insert(awardList, itemInfo)
        break
      end
    end
  end
  return awardList
end

function EliminateHelper.CheckAwardRed()
  local awardList = EliminateHelper.GetAwardList()
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local anipopInfo = anipopModule:GetAniPopInfo()
  local weekInfo = anipopInfo.week_info
  for _, award in pairs(awardList) do
    if award.Score <= weekInfo.total_score and not table.icontains(weekInfo.score_received, award.CfgID) then
      return true
    end
  end
  return false
end

function EliminateHelper.CheckExistFetter(groupID, petID)
  if petID == 0 then
    return false
  end
  local petModule = GameGlobal.GetModule(PetModule)
  local curPetID = petModule:GetPet(petID):GetTemplateID()
  local eliminateGroup = EliminateHelper.GetPetFetter(groupID, curPetID)
  for _, petID in pairs(eliminateGroup) do
    local pet = petModule:GetPetByTemplateId(petID)
    if pet then
      return true
    end
  end
  return false
end

function EliminateHelper.IsAniPopUseNewCfg()
  local loginModule = GameGlobal.GetModule(LoginModule)
  local timeTransform = 1
  local timeStr = "2024-06-17 05:00:00"
  local switchTime = 0
  if timeTransform == 0 then
    switchTime = loginModule:GetTimeStampByTimeStr(timeStr, Enum_DateTimeZoneType.E_ZoneType_GMT)
  elseif timeTransform == 1 then
    switchTime = loginModule:GetTimeStampByTimeStr(timeStr, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local svrTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if switchTime <= svrTime then
    return true
  else
    return false
  end
end
