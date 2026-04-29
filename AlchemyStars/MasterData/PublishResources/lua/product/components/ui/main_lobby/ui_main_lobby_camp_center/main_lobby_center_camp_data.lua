_class("MainLobbyCenterCampData", Object)
MainLobbyCenterCampData = MainLobbyCenterCampData

function MainLobbyCenterCampData:Constructor(cfg)
  self._cfg = cfg
end

function MainLobbyCenterCampData:GetCfgID()
  return self._cfg.ID
end

function MainLobbyCenterCampData:LoadData(TT)
end

function MainLobbyCenterCampData:CheckOpen()
  local btnKey = self._cfg.BtnKey
  local cfg = Cfg.cfg_main_side_enter_btn[btnKey]
  local checkType = cfg.CheckType
  local succ = true
  if checkType and next(checkType) then
    for key, value in pairs(checkType) do
      if value == "Sample" then
        local campType = cfg.CampaignType
        local campID = cfg.CampaignId
        succ = MainLobbyCenterData.Sample(campType, campID)
      elseif value == "FixedTime" then
        local beginTime = cfg.BeginTime
        local endTime = cfg.EndTime
        succ = MainLobbyCenterData.FixedTime(beginTime, endTime)
      elseif value == "ServerTime" then
        local beginTime = cfg.BeginTime
        local endTime = cfg.EndTime
        succ = MainLobbyCenterData.ServerTime(beginTime, endTime)
      elseif value == "SampleHide" then
        local campType = cfg.CampaignType
        local campID = cfg.CampaignId
        succ = MainLobbyCenterData.SampleHide(campType, campID)
      elseif value == "Channel" then
        local campType = cfg.CampaignType
        local campID = cfg.CampaignId
        succ = MainLobbyCenterData.Channel(campType, campID)
      elseif value == "Author" then
        local campType = cfg.CampaignType
        local campID = cfg.CampaignId
        succ = MainLobbyCenterData.Author(campType, campID)
      end
      if not succ then
        break
      end
    end
  end
  return succ
end

function MainLobbyCenterCampData:CheckRed()
  local btnKey = self._cfg.BtnKey
  local cfg = Cfg.cfg_main_side_enter_btn[btnKey]
  local campType = cfg.CampaignType
  local campID = cfg.CampaignId
  local campModule = GameGlobal.GetModule(CampaignModule)
  local sampleInfo
  if campID then
    sampleInfo = campModule:GetReviewCampaignSampleByCampaignId(campID)
  else
    sampleInfo = campModule:GetSampleByType(campType)
  end
  return sampleInfo and sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD) and 1 or 0
end

function MainLobbyCenterCampData:CheckNew()
  local btnKey = self._cfg.BtnKey
  local cfg = Cfg.cfg_main_side_enter_btn[btnKey]
  local campType = cfg.CampaignType
  local notNew = UIActivityHelper.CheckCampaignSampleNewPoint_Nonuse(campType)
  if notNew then
    return 0
  end
  local campID = cfg.CampaignId
  local campModule = GameGlobal.GetModule(CampaignModule)
  local sampleInfo
  if campID then
    sampleInfo = campModule:GetReviewCampaignSampleByCampaignId(campID)
  else
    sampleInfo = campModule:GetSampleByType(campType)
  end
  return sampleInfo and sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) and 1 or 0
end
