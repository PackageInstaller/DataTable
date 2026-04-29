_class("UIActivityN4CCAffixDetail", UIController)
UIActivityN4CCAffixDetail = UIActivityN4CCAffixDetail

function UIActivityN4CCAffixDetail:LoadDataOnEnter(TT, res, uiParams)
end

function UIActivityN4CCAffixDetail:OnShow(uiParams)
  self._bossIconLoader = self:GetUIComponent("RawImageLoader", "BossIcon")
  self._bossNameLabel = self:GetUIComponent("UILocalizationText", "BossName")
  self._affixLoader = self:GetUIComponent("UISelectObjectPath", "AffixList")
  self._wordLoader = self:GetUIComponent("UISelectObjectPath", "WordList")
  self._anim = self:GetGameObject():GetComponent("Animation")
  local campaignModule = self:GetModule(CampaignModule)
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  local missionInfo = matchEnterData:GetMissionCreateInfo()
  local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_INLAND_N4_CHALLENGE)
  local challengeCmpInfo = localProcess:GetComponentInfo(ECCampaignInlandN4ChallengeComponentID.CHALLENGE)
  local selectedAffixs = challengeCmpInfo.m_select_affix[missionInfo.nCampaignMissionId]
  self._affixs = {}
  if selectedAffixs then
    for i = 1, #selectedAffixs do
      local config = Cfg.cfg_component_mission_affix[selectedAffixs[i]]
      local affix = UIActivityN4CCAffixData:New(config)
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
  local wordStrList = cfg.BossDesc
  if wordStrList then
    self._wordLoader:SpawnObjects("UIActivityN4CCAffixDetailItem", #wordStrList)
    local items = self._wordLoader:GetAllSpawnList()
    self._wordItems = items
    for i = 1, #items do
      local desStr = StringTable.Get(wordStrList[i])
      local item = items[i]
      item:Refresh(desStr)
    end
  end
  self._affixLoader:SpawnObjects("UIActivityN4CCAffixDetailItem", #self._affixs)
  local items = self._affixLoader:GetAllSpawnList()
  self._affixItems = items
  for i = 1, #items do
    local affix = self._affixs[i]
    local item = items[i]
    local desStr = affix:GetDes()
    item:Refresh(desStr)
  end
  self:PlayItemsInAni()
end

function UIActivityN4CCAffixDetail:OnHide()
end

function UIActivityN4CCAffixDetail:PlayItemsInAni()
  if self._wordItems then
    local itemCount = #self._wordItems
    for i = 1, itemCount do
      local item = self._wordItems[i]
      local delayMs = (i - 1) * 60
      item:PlayInAni(delayMs)
    end
  end
  if self._affixItems then
    local itemCount = #self._affixItems
    for i = 1, itemCount do
      local item = self._affixItems[i]
      local delayMs = (i - 1) * 60
      item:PlayInAni(delayMs)
    end
  end
end

function UIActivityN4CCAffixDetail:BtnCloseOnClick()
  self:CloseWithAnimation()
end

function UIActivityN4CCAffixDetail:CloseWithAnimation()
  self:StartTask(function(TT)
    local key = "UIActivityN4CCAffixDetail_Close"
    self:Lock(key)
    self._anim:Play("uianim_UIActivityN4CCAffixDetail_out")
    if self._allItems then
      local itemCount = #self._allItems
      for i = 1, itemCount do
        local item = self._allItems[i]
        item:PlayOutAni()
      end
    end
    YIELD(TT, 500)
    self:UnLock(key)
    self:CloseDialog()
  end)
end
