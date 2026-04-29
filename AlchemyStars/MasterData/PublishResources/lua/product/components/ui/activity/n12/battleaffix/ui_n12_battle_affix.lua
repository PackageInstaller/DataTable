_class("UIN12BattleAffix", UIController)
UIN12BattleAffix = UIN12BattleAffix

function UIN12BattleAffix:Constructor()
  self._campaignModule = self:GetModule(CampaignModule)
end

function UIN12BattleAffix:OnShow(uiParams)
  self:_GetComponent()
  self:_OnValue()
end

function UIN12BattleAffix:_GetComponent()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._bottom = self:GetGameObject("Bottom")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._score = self:GetUIComponent("UILocalizationText", "Score")
  self._bossImg = self:GetUIComponent("RawImageLoader", "BossImg")
  self._bossImgRect = self:GetUIComponent("RectTransform", "BossImg")
end

function UIN12BattleAffix:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIN12BattleAffix:_OnValue()
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  local missionInfo = matchEnterData:GetMissionCreateInfo()
  local cfgs, bossImageResName, pwh
  self._levelType = N12LevelType.Daily
  self._campaignMissionId = missionInfo.nCampaignMissionId
  if missionInfo.nMissionComId == ECampaignMissionComponentId.ECampaignMissionComponentId_DailyMission then
    cfgs = Cfg.cfg_component_daily_mission({
      CampaignMissionId = missionInfo.nCampaignMissionId
    })
  elseif missionInfo.nMissionComId == ECampaignMissionComponentId.ECampaignMissionComponentId_ChallengeMission then
    cfgs = Cfg.cfg_component_challenge_mission({
      CampaignMissionId = missionInfo.nCampaignMissionId
    })
    self._levelType = N12LevelType.Challenge
  end
  self._bottom:SetActive(self._levelType == N12LevelType.Challenge)
  self._data = {}
  if cfgs and 0 < #cfgs then
    if self._levelType == N12LevelType.Daily then
      for key, value in pairs(cfgs[1].Affix) do
        table.insert(self._data, value)
      end
      bossImageResName = cfgs[1].MonsterIcon
      pwh = cfgs[1].PositionWH2
    elseif self._levelType == N12LevelType.Challenge then
      local localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N12)
      local curMissionSelectedAffix = localProcess._challengeMissionCompInfo.m_select_affix[self._campaignMissionId]
      for key, value in pairs(curMissionSelectedAffix) do
        table.insert(self._data, value)
      end
      local score = cfgs[1].BaseScore
      for i = 1, #curMissionSelectedAffix do
        local cfgAffix = Cfg.cfg_component_mission_affix[curMissionSelectedAffix[i]]
        if cfgAffix then
          score = score + cfgAffix.AffixScore
        end
      end
      self._score:SetText(score)
      bossImageResName = cfgs[1].MonsterIcon2
      pwh = cfgs[1].PositionWH
    end
    local cfg_campaign_mission = Cfg.cfg_campaign_mission[missionInfo.nCampaignMissionId]
    self._name:SetText(StringTable.Get(cfg_campaign_mission.Name))
  end
  if bossImageResName and pwh then
    self._bossImg:LoadImage(bossImageResName)
    self._bossImgRect.anchoredPosition = Vector2(pwh[1], pwh[2])
    self._bossImgRect.sizeDelta = Vector2(pwh[3], pwh[4])
  end
  table.insert(self._data, 1, {})
  table.insert(self._data, 2, {})
  table.insert(self._data, 3, {})
  self:_InitDynamicScrollView()
end

function UIN12BattleAffix:_InitDynamicScrollView()
  self._scrollView:InitListView(#self._data, function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
end

function UIN12BattleAffix:_OnGetItemByIndex(scrollview, index)
  if index == 0 or index == 2 then
    local item = scrollview:NewListViewItem("UIN12BattleAffixSpecialItem")
    local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    if not item.IsInitHandlerCalled then
      item.IsInitHandlerCalled = true
      itemPool:SpawnObjects("UIN12BattleAffixSpecialItem", 1)
    end
    local ItemWidgets = itemPool:GetAllSpawnList()
    local itemWidget = ItemWidgets[1]
    if itemWidget then
      itemWidget:SetData(self._levelType, index)
    end
    return item
  else
    local item = scrollview:NewListViewItem("UIN12BattleAffixItem")
    local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    if not item.IsInitHandlerCalled then
      item.IsInitHandlerCalled = true
      itemPool:SpawnObjects("UIN12BattleAffixItem", 1)
    end
    local ItemWidgets = itemPool:GetAllSpawnList()
    local itemWidget = ItemWidgets[1]
    if itemWidget then
      itemWidget:SetData(self._levelType, index == 1, self._campaignMissionId, self._data[index + 1])
    end
    return item
  end
end
