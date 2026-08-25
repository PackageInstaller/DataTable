local TeamDataUtils = {}

function TeamDataUtils.ResetAll()
  DataCenter.teamData.Team = {}
end

function TeamDataUtils.SetTeam(roles)
  if not roles then
    return
  end
  local team = TeamDataUtils.GetTeamData()
  team.awakerTids = {}
  for index, value in ipairs(roles) do
    table.insert(team.awakerTids, value)
  end
  team.schoolTid = 1
  local schoolTid = 1
  for _, value in ipairs(team) do
    local config = DT.AwakerConfig[value]
    if config.School > 1 then
      schoolTid = config.School
    end
  end
  team.schoolTid = schoolTid
end

function TeamDataUtils.GetTeamData()
  return DataCenter.teamData.Team
end

function TeamDataUtils.GetCurTeamAtk()
  local teamAtk, awakerNum = 0, 0
  for _, value in ipairs(DataCenter.teamData.Team.awakerTids) do
    if value > 0 then
      local awaker = AwakerDataUtils.GetAwakerData(value)
      local atk = AttrUtils.GetAwakerAttr(value, awaker.level, "atk", true)
      local atk_i = AttrUtils.GetAwakerAttr(value, awaker.level, "atk_per", true)
      local final_atk = AttrUtils.GetAwakerFinalAttr(atk, atk_i)
      teamAtk = teamAtk + final_atk
      awakerNum = awakerNum + 1
    end
  end
  do return math.ceil end
  return math.ceil, teamAtk / awakerNum, ipairs(DataCenter.teamData.Team.awakerTids)
end

function TeamDataUtils.GetCurTeamLevel()
  local teamLevel, awakerNum = 0, 0
  for _, value in ipairs(DataCenter.teamData.Team.awakerTids) do
    if value > 0 then
      local awaker = AwakerDataUtils.GetAwakerData(value)
      teamLevel = awaker.level + teamLevel
      awakerNum = awakerNum + 1
    end
  end
  do return math.ceil end
  return math.ceil, teamLevel / awakerNum, ipairs(DataCenter.teamData.Team.awakerTids)
end

function TeamDataUtils.GetTeamAwakerTids()
  return DataCenter.teamData.Team.awakerTids or {}
end

function TeamDataUtils.GetTeamAwakeHp()
  local hp = 0
  for _, value in ipairs(DataCenter.teamData.Team.awakerTids) do
    if value > 0 then
      local awaker = AwakerDataUtils.GetAwakerData(value)
      local attrConfig = AwakerDataUtils.GetAttr(value, awaker.level)
      hp = hp + attrConfig.hp
    end
  end
  return hp
end

function TeamDataUtils.GetTeamOccMaster()
  local occMaster = 0
  for _, value in ipairs(DataCenter.teamData.Team.awakerTids or {}) do
    if value > 0 then
      local awaker = AwakerDataUtils.GetAwakerData(value)
      local attrConfig = AwakerDataUtils.GetAttr(value, awaker.level)
      occMaster = occMaster + attrConfig.occupation_master * (1 + (attrConfig.occupation_master_final_per or 0) / 100)
    end
  end
  return occMaster
end

function TeamDataUtils.IsBanTid(stageGroupType, tid)
  do return PlayerDataUtils.IsBanTidByStageType, stageGroupType end
  return PlayerDataUtils.IsBanTidByStageType, stageGroupType, tid
end

return TeamDataUtils
