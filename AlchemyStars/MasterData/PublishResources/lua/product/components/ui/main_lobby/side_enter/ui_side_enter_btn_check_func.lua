_class("UISideEnterBtnCheckFunc", Object)
UISideEnterBtnCheckFunc = UISideEnterBtnCheckFunc

function UISideEnterBtnCheckFunc._GetCampaignSample(btnCfg)
  local campaignType, campaignId = btnCfg.CampaignType, btnCfg.CampaignId
  return UIActivityHelper.LoadCampaign_Local(campaignType, campaignId)
end

function UISideEnterBtnCheckFunc.GetFunc(name)
  local func = UISideEnterBtnCheckFunc[name]
  if func == nil then
    Log.exception("UISideEnterBtnCheckFunc.GetFunc() == nil, name = ", name)
  end
  return func
end

function UISideEnterBtnCheckFunc.FixedTime(TT, btnCfg)
  local beginTime, endTime = btnCfg.BeginTime, btnCfg.EndTime
  local isOpen = UISideEnterItem_FixedTime.CheckOpen(beginTime, endTime)
  return isOpen
end

function UISideEnterBtnCheckFunc.ServerTime(TT, btnCfg)
  local beginTime, endTime = btnCfg.BeginTime, btnCfg.EndTime
  local isOpen = UISideEnterItem_FixedTime.CheckServerTimeOpen(beginTime, endTime)
  return isOpen
end

function UISideEnterBtnCheckFunc.Sample(TT, btnCfg)
  local campaign = UISideEnterBtnCheckFunc._GetCampaignSample(btnCfg)
  local isOpen = campaign:CheckCampaignOpen()
  return isOpen
end

function UISideEnterBtnCheckFunc.SampleHide(TT, btnCfg)
  local campaign = UISideEnterBtnCheckFunc._GetCampaignSample(btnCfg)
  local sample = campaign:GetSample()
  local hide = not sample or sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_HIDE)
  return not hide
end

function UISideEnterBtnCheckFunc.Channel(TT, btnCfg)
  if EDITOR then
    return true
  end
  local current_channel_id = GCloud.MSDK.MSDKTools.GetConfigChannel()
  Log.info("###[UISideEnterBtnCheckFunc.Channel] CheckChannelOpen channel:", current_channel_id)
  local cfg_msdk_channel = Cfg.cfg_msdk_channel[current_channel_id]
  local campaign = UISideEnterBtnCheckFunc._GetCampaignSample(btnCfg)
  local campaignid = campaign._id
  if cfg_msdk_channel then
    local openlist = cfg_msdk_channel.ChannelActivityOpenList
    if openlist and table.icontains(openlist, campaignid) then
      return true
    end
  end
  return false
end

function UISideEnterBtnCheckFunc.Author(TT, btnCfg)
  if EDITOR then
    return true
  end
  local info = GameGlobal.GameLogic().ClientInfo
  local source = info.m_login_source
  Log.debug("###[UISideEnterBtnCheckFunc.Author] source:", source)
  if not source then
    return false
  end
  local cfg = Cfg.cfg_activity_author[source]
  if not cfg then
    Log.error("###[UISideEnterBtnCheckFunc.Author] cfg_activity_author is nil !")
    return false
  end
  local openlist = cfg.AuthorActivityOpenList
  local campaign = UISideEnterBtnCheckFunc._GetCampaignSample(btnCfg)
  local campaignid = campaign._id
  if openlist and table.icontains(openlist, campaignid) then
    return true
  end
  return false
end
