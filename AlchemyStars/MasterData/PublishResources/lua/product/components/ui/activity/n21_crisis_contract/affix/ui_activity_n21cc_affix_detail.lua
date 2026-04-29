_class("UIActivityN21CCAffixDetail", UIController)
UIActivityN21CCAffixDetail = UIActivityN21CCAffixDetail

function UIActivityN21CCAffixDetail:LoadDataOnEnter(TT, res, uiParams)
end

function UIActivityN21CCAffixDetail:OnShow(uiParams)
  self._bossIconLoader = self:GetUIComponent("RawImageLoader", "BossIcon")
  self._bossNameLabel = self:GetUIComponent("UILocalizationText", "BossName")
  self._awakenLabel = self:GetUIComponent("UILocalizationText", "Awaken")
  self._levelLabel = self:GetUIComponent("UILocalizationText", "Level")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._affixLoader = self:GetUIComponent("UISelectObjectPath", "AffixList")
  self._hardIndexLabel = self:GetUIComponent("UILocalizationText", "HardIndex")
  local campaignModule = self:GetModule(CampaignModule)
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  local missionInfo = matchEnterData:GetMissionCreateInfo()
  local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N21_CHALLENGE)
  local challengeCmpInfo = localProcess:GetComponentInfo(ECampaignN21ChallengeComponentID.CHALLENGE)
  local selectedAffixs = challengeCmpInfo.m_select_affix[missionInfo.nCampaignMissionId]
  self._affixs = {}
  if selectedAffixs then
    for i = 1, #selectedAffixs do
      local config = Cfg.cfg_component_mission_affix[selectedAffixs[i]]
      local affix = UIActivityN21CCAffixData:New(config, true)
      self._affixs[#self._affixs + 1] = affix
    end
  end
  local cfgs = Cfg.cfg_component_challenge_mission({
    CampaignMissionId = missionInfo.nCampaignMissionId
  })
  if not cfgs or #cfgs < 1 then
    return
  end
  local cfg = cfgs[1]
  local monsterIcon = cfg.MonsterIcon2
  self._bossIconLoader:LoadImage(monsterIcon)
  self._bossNameLabel:SetText(StringTable.Get(cfg.MonsterName))
  local recommendAwaken = cfg.RecommendAwaken
  if recommendAwaken == nil or recommendAwaken == 0 then
    self._awakenLabel.gameObject:SetActive(false)
  else
    self._awakenLabel.gameObject:SetActive(true)
    self._awakenLabel:SetText(StringTable.Get("str_pet_config_common_advance") .. "<size=29>" .. recommendAwaken .. "</size>")
  end
  local recommendLV = cfg.RecommendLV
  if recommendLV then
    self._levelLabel:SetText("LV." .. recommendLV)
    self._levelLabel.gameObject:SetActive(true)
  else
    self._levelLabel.gameObject:SetActive(false)
  end
  local totalScore = cfg.BaseScore
  self._affixLoader:SpawnObjects("UIActivityN21CCAffixDetailItem", #self._affixs)
  local items = self._affixLoader:GetAllSpawnList()
  for i = 1, #items do
    local affix = self._affixs[i]
    local item = items[i]
    item:Refresh(affix)
    totalScore = totalScore + affix:GetScroe()
  end
  self._scoreLabel:SetText(totalScore)
  local hardIndex = UIActivityN21CCConst.GetEnterBattleHardIndex()
  local hardIndexStr = StringTable.Get("str_n20_crisis_contract_hard_title" .. hardIndex)
  self._hardIndexLabel:SetText(hardIndexStr)
end

function UIActivityN21CCAffixDetail:OnHide()
end

function UIActivityN21CCAffixDetail:BtnCloseOnClick()
  self:CloseDialog()
end
