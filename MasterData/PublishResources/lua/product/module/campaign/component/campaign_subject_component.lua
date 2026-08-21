_class("CampaignSubjectComponent", ICampaignComponent)
CampaignSubjectComponent = CampaignSubjectComponent

function CampaignSubjectComponent:Constructor()
  self.m_component_info = SubjectComponentInfo:New()
end

function CampaignSubjectComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = SubjectComponentInfo:New()
  end
  return self.m_component_info
end

function CampaignSubjectComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CampaignSubjectComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_SUBJECT
end

function CampaignSubjectComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  Log.debug("test score:", self.m_component_info.test_score)
  return ret
end

function CampaignSubjectComponent:GetRewardedLevels()
  return self.m_component_info.rewarded_levels
end

function CampaignSubjectComponent:GetTestScore()
  return self.m_component_info.test_score
end

function CampaignSubjectComponent:HandleReward(TT, asyncRes, level_id, grade)
  local request = SubjectComponentRewardReq:New()
  request.level_id = level_id
  request.grade = grade
  local response = SubjectComponentRewardRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignSubjectComponent] HandleReward ret:", asyncRes.m_result)
    return asyncRes
  end
  self.m_component_info.rewarded_levels = response.rewarded_levels
  return asyncRes
end

function CampaignSubjectComponent:HandleTestScore(TT, asyncRes, score)
  local request = SubjectComponentTestScoreReq:New()
  request.score = score
  local response = SubjectComponentTestScoreRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignSubjectComponent] HandleTestScore ret:", asyncRes.m_result)
    return asyncRes
  end
  self.m_component_info.test_score = score
  return asyncRes
end
