_class("UIReviewActivityN8", UIReviewActivityBase)
UIReviewActivityN8 = UIReviewActivityN8

function UIReviewActivityN8:Constructor(id, sample)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._n8Campaign = UIActivityCampaign:New()
  local res = AsyncRequestRes:New()
  TaskManager:GetInstance():StartTask(function(TT)
    self._n8Campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_REVIEW_N8, ECampaignReviewN8ComponentID.ECAMPAIGN_REVIEW_ReviewN8_LINE_MISSION)
    self._n8Campaign:ReLoadCampaignInfo_Force(TT, res)
    if res and not res:GetSucc() then
      Log.fatal("获取n8活动信息失败")
    end
  end, self)
end

function UIReviewActivityN8:AssetPackageID()
  return 8
end

function UIReviewActivityN8:ActivityOnOpen()
  local controller = GameGlobal.UIStateManager():GetController("UIActivityReview")
  local rt = controller:GetShotImage()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  cache_rt.format = UnityEngine.RenderTextureFormat.RGB111110Float
  GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIActivityN8MainController_Review, cache_rt)
  end)
end

function UIReviewActivityN8:GetBattleExitParam(comID, missionCreateInfo, isWin, battleresultRt)
  if comID == ECampaignReviewN8ComponentID.ECAMPAIGN_REVIEW_ReviewN8_LINE_MISSION then
    return UIStateType.UIActivityN8LineMissionController_Review, nil
  end
end

function UIReviewActivityN8:IsFinished()
  if self:IsUnlock() then
    local lineComp = self._n8Campaign:GetComponent(ECampaignReviewN8ComponentID.ECAMPAIGN_REVIEW_ReviewN8_LINE_MISSION)
    local lineInfo = self._n8Campaign:GetComponentInfo(ECampaignReviewN8ComponentID.ECAMPAIGN_REVIEW_ReviewN8_LINE_MISSION)
    if not lineInfo then
      return false
    end
    local cmpID = lineComp:GetComponentCfgId()
    local missionCfgs_temp = Cfg.cfg_component_line_mission({ComponentID = cmpID})
    local missionCfgs = {}
    for _, cfg in pairs(missionCfgs_temp) do
      missionCfgs[cfg.CampaignMissionId] = cfg
    end
    for Id, v in pairs(missionCfgs) do
      if not lineInfo.m_pass_mission_info[Id] then
        return false
      end
    end
    return true
  else
    return false
  end
end
