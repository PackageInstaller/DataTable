_class("UIActivityBlackBoxMainContent", UISideEnterCenterContentBase)
UIActivityBlackBoxMainContent = UIActivityBlackBoxMainContent

function UIActivityBlackBoxMainContent:Constructor()
end

function UIActivityBlackBoxMainContent:DoInit(params)
  self._campaignType = params and params.campaign_type
  self._componentIds = params and params.component_ids or {}
  self._campaignId = params and params.campaign_id
  self._componentId = ECampaignDiffcultyWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_DIFFICULT_MISSION
  self._campaign = self._data
  UIActivityDiffLevelCupData.CreateEntiesDesc()
end

function UIActivityBlackBoxMainContent:DoShow(params)
  self._createInfo = params
  local localProcess = self._campaign:GetLocalProcess()
  self._blackHardComponent = localProcess:GetComponent(self._componentId)
  self._blackHardCompInfo = localProcess:GetComponentInfo(self._componentId)
  self._cfg = Cfg.cfg_blackbox_main({
    ComponentID = self._blackHardComponent:GetComponentCfgId()
  })[1]
  self:_GetComponent()
  local isNew = self._campaign:CheckCampaignNew()
  if isNew then
    self:StartTask(function(TT)
      self._campaign:ClearCampaignNew(TT)
    end, self)
    self:ShowDialog("UIIntroLoader", self._cfg.IntroPage, MaskType.MT_BlurMask)
  end
  self:AttachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
end

function UIActivityBlackBoxMainContent:DoHide()
  self:DetachEvent(GameEventType.OnCampDiffTeamReset, self.OnTeamReset)
  self:StartTask(self._CloseAnim, self)
  if self._diffLevel then
    self._diffLevel:Destroy()
  end
end

function UIActivityBlackBoxMainContent:DoDestroy()
end

function UIActivityBlackBoxMainContent:_CloseAnim(TT)
end

function UIActivityBlackBoxMainContent:_GetComponent()
  self._bg = self:GetUIComponent("RawImageLoader", "BG")
  self._titlePic = self:GetUIComponent("RawImageLoader", "TitlePic")
  self._intro = self:GetUIComponent("UILocalizationText", "intro")
  self:InitComponent()
end

function UIActivityBlackBoxMainContent:InitComponent()
  if self._cfg then
    self._bg:LoadImage(self._cfg.BG)
    self._titlePic:LoadImage(self._cfg.Title)
    self._intro:SetText(StringTable.Get(self._cfg.Intro))
  else
    Log.fatal("未配置本次活动信息，请配cfg_blackbox_main")
  end
  self._diffLevel = UIActivityBlackBoxMainDiffLevel:New(self)
  self._diffLevel:SetData(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  self._diffLevel:SetActive(true)
  if self._createInfo then
    self._diffLevel:OpenLevel(self._createInfo)
  end
end

function UIActivityBlackBoxMainContent:OnTeamReset()
  self:StartTask(self.OnTeamResetCoro, self)
end

function UIActivityBlackBoxMainContent:OnTeamResetCoro(TT)
  self:Lock("UIActivityBlackBoxMainContent_OnTeamResetCoro")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_DIFFICULTY_WEEK_TOWER, ECampaignDiffcultyWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_DIFFICULT_MISSION)
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    CutsceneManager.ExcuteCutsceneOut_Shot()
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._campaignID = self._campaign._id
  local localProcess = self._campaign:GetLocalProcess()
  self._blackHardComponent = localProcess:GetComponent(ECampaignDiffcultyWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_DIFFICULT_MISSION)
  self._blackHardCompInfo = localProcess:GetComponentInfo(ECampaignDiffcultyWeekTowerComponentID.ECAMPAIGN_WEEK_TOWER_DIFFICULT_MISSION)
  self._diffLevel:Refresh(self._campaign, self._blackHardComponent, self._blackHardCompInfo)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampDiffTeamResetInternal)
  self:UnLock("UIActivityBlackBoxMainContent_OnTeamResetCoro")
end

function UIActivityBlackBoxMainContent:GetCampaign()
  return self._campaign
end

function UIActivityBlackBoxMainContent:IntroBtnOnClick()
  self:ShowDialog("UIIntroLoader", self._cfg.IntroPage, MaskType.MT_BlurMask)
end
