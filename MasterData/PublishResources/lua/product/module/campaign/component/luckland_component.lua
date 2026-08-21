require("component_base")
_class("LuckLandComponent", ICampaignComponent)
LuckLandComponent = LuckLandComponent

function LuckLandComponent:Constructor()
  self.m_component_info = LuckLandComponentInfo:New()
  self.m_rank_top = {}
end

function LuckLandComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = LuckLandComponentInfo:New()
  end
  return self.m_component_info
end

function LuckLandComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function LuckLandComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_LUCK_LAND
end

function LuckLandComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function LuckLandComponent:HandleCompleteLuckLandMission(TT, asyncRes, mission_id, money, cur_hp, build_map)
  local request = CompleteLuckLandMissionReq:New()
  request.mission_id = mission_id
  request.money = money
  request.cur_hp = cur_hp
  request.build_map = build_map
  local response = CompleteLuckLandMissionRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][LuckLandComponent] HandleCompleteLuckLandMission ret:", asyncRes.m_result)
    return nil
  end
  response.m_info.cur_star = self:CheckGetStar(mission_id, response.m_result.total_score, build_map, cur_hp)
  self.m_component_info.m_pass_mission_info[mission_id] = response.m_info
  return response.ret, response.reward, response.m_result, response.three_reward
end

function LuckLandComponent:HandleLuckLandGetRankList(TT, asyncRes, mission_id)
  local request = LuckLandGetRankListReq:New()
  request.mission_id = mission_id
  local response = LuckLandGetRankListRes:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][LuckLandComponent] HandleLuckLandGetRankList ret:", asyncRes.m_result)
    return nil
  end
  self.m_rank_top[mission_id] = response.show_list
  return response.ret
end

function LuckLandComponent:CheckGetStar(mission_id, score, buildlist, hp)
  local cfgs = Cfg.cfg_component_luck_land({MissionID = mission_id})
  local star = 0
  if cfgs and cfgs[1] then
    for index = 1, #cfgs[1].ThreeCondDesc do
      local cfg_cond = Cfg.cfg_luckland_client_threestarcondition[cfgs[1].ThreeCondDesc[index]]
      if cfg_cond and self:CheckCond(cfg_cond, score, buildlist, hp) then
        star = star | 1 << index - 1
      end
    end
  end
  return star
end

function LuckLandComponent:CheckCond(cfg_cond, score, buildlist, hp)
  if cfg_cond.Type == LuckLandThreeStarType.Score then
    if score >= cfg_cond.Value[1] then
      return true
    end
  elseif cfg_cond.Type == LuckLandThreeStarType.BuildingLevel then
    local buildingID = cfg_cond.Value[1]
    local buildingLevel = cfg_cond.Value[2]
    if buildlist and buildlist[buildingID] and buildingLevel <= buildlist[buildingID] then
      return true
    end
  elseif cfg_cond.Type == LuckLandThreeStarType.HP and hp >= cfg_cond.Value[1] then
    return true
  end
  return false
end
