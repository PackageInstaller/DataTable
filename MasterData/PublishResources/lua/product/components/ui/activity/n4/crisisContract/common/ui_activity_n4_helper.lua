_class("UIActivityN4CCHelper", Object)
UIActivityN4CCHelper = UIActivityN4CCHelper
UIActivityN4CCHelper.DiffultyState = {
  Lock = 1,
  Open = 2,
  Pass = 3
}
UIActivityN4CCHelper.DiffultyBgImg = {
  [1] = {
    [1] = "activity_wjyz_zjm_icon6",
    [2] = "activity_wjyz_zjm_icon7",
    [3] = "activity_wjyz_zjm_icon8"
  },
  [2] = {
    [1] = "activity_wjyz_zjm_icon3",
    [2] = "activity_wjyz_zjm_icon4",
    [3] = "activity_wjyz_zjm_icon5"
  },
  [3] = {
    [1] = "activity_wjyz_zjm_icon9",
    [2] = "activity_wjyz_zjm_icon10",
    [3] = "activity_wjyz_zjm_icon11"
  }
}

function UIActivityN4CCHelper.GetAffixDesc(cfg, color)
  local paramsCfg = cfg.EntryParam
  local params = {}
  if paramsCfg and paramsCfg[1] then
    local p = paramsCfg[1]
    for k, v in ipairs(p) do
      if type(v) == "string" then
        params[#params + 1] = StringTable.Get(v)
      elseif type(v) == "number" then
        params[#params + 1] = v
      end
    end
  end
  local strDesc = StringTable.Get(cfg.Desc, table.unpack(params))
  if color then
    strDesc = string.gsub(strDesc, "FFFFFF", color)
  end
  return strDesc
end

function UIActivityN4CCHelper.GetKey(str)
  local mRole = GameGlobal.GetModule(RoleModule)
  local key = mRole:GetPstId() .. str
  return key
end

function UIActivityN4CCHelper.SetPrefsStr(key, str)
  UnityEngine.PlayerPrefs.SetString(key, str)
end

function UIActivityN4CCHelper.GetPrefsStr(key)
  return UnityEngine.PlayerPrefs.GetString(key, nil)
end

function UIActivityN4CCHelper.SaveTeamInfo(TT, id, name, pets)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_N4_CHALLENGE, ECCampaignInlandN4ChallengeComponentID.CHALLENGE)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, campaign._id, nil, nil)
    return false
  end
  local localProcess = campaign:GetLocalProcess()
  if not localProcess then
    return false
  end
  local challengeComponent = localProcess:GetComponent(ECCampaignInlandN4ChallengeComponentID.CHALLENGE)
  local teamInfo = ChallengeFormationItem:New()
  teamInfo.id = id
  teamInfo.name = name
  teamInfo.pet_list = pets
  challengeComponent:HandleChallengeChangeFormationReq(TT, res, teamInfo)
  if res:GetSucc() then
    return true
  end
  return false
end

_class("UIActivityN4ConText", Object)
UIActivityN4ConText = UIActivityN4ConText

function UIActivityN4ConText:SetComponent(campaign)
  self._campaign = campaign
  self._localProcess = self._campaign:GetLocalProcess()
  self._component = self._localProcess:GetComponent(ECCampaignInlandN4ChallengeComponentID.CHALLENGE)
  self._componentInfo = self._localProcess:GetComponentInfo(ECCampaignInlandN4ChallengeComponentID.CHALLENGE)
  self._taskComponent = self._localProcess:GetComponent(ECCampaignInlandN4ChallengeComponentID.QUEST)
  self._taskComponentInfo = self._localProcess:GetComponentInfo(ECCampaignInlandN4ChallengeComponentID.QUEST)
  self.componentId = UIActivityHelper.GetComponentID(self._componentInfo)
end

function UIActivityN4ConText:GetComponentId()
  return self.componentId
end

function UIActivityN4ConText:GetComponent()
  return self._component
end

function UIActivityN4ConText:GetComponentInfo()
  return self._componentInfo
end

function UIActivityN4ConText:GetCampaign()
  return self._campaign
end

function UIActivityN4ConText:GetUnlockTime(cfg)
  local missionId = cfg.CampaignMissionId
  return self._componentInfo.m_challenge_unlock_time[missionId]
end

function UIActivityN4ConText:GetMissionState(cfg)
  local missionId = cfg.CampaignMissionId
  local isPass = self._componentInfo.m_pass_mission_info[missionId] ~= nil
  if isPass then
    return UIActivityN4CCHelper.DiffultyState.Pass
  end
  local preMissionId = cfg.UnlockMissionId
  if preMissionId and 0 < preMissionId and self._componentInfo.m_pass_mission_info[preMissionId] == nil then
    return UIActivityN4CCHelper.DiffultyState.Lock
  end
  return UIActivityN4CCHelper.DiffultyState.Open
end

function UIActivityN4ConText:GetAffix(missionId)
  local key = self:_GetKey(missionId)
  local str = UIActivityN4CCHelper.GetPrefsStr(key)
  if str and 0 < #str then
    local tempIds = string.split(str, ",")
    local ids = {}
    for i, v in ipairs(tempIds) do
      table.insert(ids, tonumber(v))
    end
    return ids
  end
  return nil
end

function UIActivityN4ConText:SetAffix(missionId, ids)
  local key = self:_GetKey(missionId)
  local value = ""
  if ids and 0 < #ids then
    value = table.concat(ids, ",")
  end
  UIActivityN4CCHelper.SetPrefsStr(key, value)
end

function UIActivityN4ConText:_GetKey(missionId)
  return UIActivityN4CCHelper.GetKey("aff_" .. missionId .. "_" .. self.componentId)
end

function UIActivityN4ConText:CheckTaskRed(cfg)
  local questIds = cfg.Quest
  if not questIds then
    return false
  end
  for k, questId in pairs(questIds) do
    local quest = self._taskComponent:GetQuestInfoById(questId)
    if quest then
      local red = self._taskComponent:HasQuestCanClaim({quest})
      if red then
        return true
      end
    end
  end
  return false
end

function UIActivityN4ConText:CheckLevelRed(cfgs)
  if not self._component then
    return false
  end
  local ids = self._component:HaveNewIds()
  if not ids then
    return false
  end
  for k, cfg in pairs(cfgs) do
    if ids[cfg.ID] then
      return true
    end
  end
  return false
end
