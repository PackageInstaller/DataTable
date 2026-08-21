_class("UICN13PerfectPuzzlePlanItem", UICustomWidget)
UICN13PerfectPuzzlePlanItem = UICN13PerfectPuzzlePlanItem

function UICN13PerfectPuzzlePlanItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN13PerfectPuzzlePlanItem:InitWidget()
  self.planTypeText = self:GetUIComponent("UILocalizationText", "PlanTypeText")
  self.planTipsText = self:GetUIComponent("UILocalizationText", "PlanTipsText")
  self.planStateText = self:GetUIComponent("UILocalizationText", "PlanStateText")
  self.overRoot = self:GetUIComponent("Image", "OverRoot")
  self.getBtn = self:GetUIComponent("Image", "GetBtn")
  self.getBtnText = self:GetUIComponent("UILocalizationText", "GetBtnText")
  self.beingText = self:GetUIComponent("UILocalizationText", "BeingText")
  self.awardRoot = self:GetUIComponent("UISelectObjectPath", "AwardRoot")
end

function UICN13PerfectPuzzlePlanItem:SetData(campaign, index, progress, callback, tipsCallback)
  self._index = index
  self._campaign = campaign
  self._progress = progress
  self._callback = callback
  self._tipsCallback = tipsCallback
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS, 1)
  self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_INLAND_PERFECT_PUZZLE)
  self.personProcessInfo = self._localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
  self._state = self._component:CheckItemStatus(self._progress)
  self:_Refresh()
end

function UICN13PerfectPuzzlePlanItem:_Refresh()
  self:_SetState(self._state)
  self:_SetStateCount(self._state)
  local val = {}
  val[CampaignPersonProgressStatus.CPPS_Completed] = 0
  val[CampaignPersonProgressStatus.CPPS_Accepted] = 1
  val[CampaignPersonProgressStatus.CPPS_Taken] = 2
  local curProg = self._component:GetCurrentProgress()
  if curProg >= self._progress then
    curProg = self._progress
  end
  self.planStateText:SetText(StringTable.Get("str_cn13_PerfectPuzzle_cur_process", curProg .. "/" .. self._progress))
  self.planTipsText:SetText(StringTable.Get("str_eliminate_round_level") .. ":" .. self._progress)
  if self._state == CampaignPersonProgressStatus.CPPS_Completed then
    self.beingText.gameObject:SetActive(false)
    self.getBtn.gameObject:SetActive(true)
    self.overRoot.gameObject:SetActive(false)
  elseif self._state == CampaignPersonProgressStatus.CPPS_Accepted then
    self.beingText.gameObject:SetActive(true)
    self.getBtn.gameObject:SetActive(false)
    self.overRoot.gameObject:SetActive(false)
  elseif self._state == CampaignPersonProgressStatus.CPPS_Taken then
    self.beingText.gameObject:SetActive(false)
    self.getBtn.gameObject:SetActive(false)
    self.overRoot.gameObject:SetActive(true)
  end
  if 0 < #self.personProcessInfo.m_progress_rewards[self._progress] then
    self.awardList = self.awardRoot:SpawnObjects("UIPerfectPuzzleRewardItem", #self.personProcessInfo.m_progress_rewards[self._progress])
    for i = 1, #self.awardList do
      local award = self.awardList[i]
      local cfgAward = self.personProcessInfo.m_progress_rewards[self._progress][i]
      award:SetData(cfgAward, function(matid, pos)
        if self._tipsCallback then
          self._tipsCallback(matid, pos)
        end
      end)
    end
  end
end

function UICN13PerfectPuzzlePlanItem:_SetState(state)
end

function UICN13PerfectPuzzlePlanItem:_SetStateCount(state)
end

function UICN13PerfectPuzzlePlanItem:GetBtnOnClick(go)
  if self._callback then
    self._callback(self._progress)
  end
end
