_class("UIN12NormalLevel", UIController)
UIN12NormalLevel = UIN12NormalLevel

function UIN12NormalLevel:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._curLevelType = N12ToolFunctions.GetLocalDBInt(N12OperationRecordKey.NormalLevelType, 1)
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._element_cfg = Cfg.cfg_pet_element({})
  self._cfgs_boss = nil
end

function UIN12NormalLevel:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N12, ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._dailyMissionComponent = self._campaign:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION)
  self._dailyMissionComponentInfo = self._dailyMissionComponent:GetComponentInfo()
  local unlockTime = self._dailyMissionComponentInfo.m_unlock_time
  local closeTime = self._dailyMissionComponentInfo.m_close_time
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  if unlockTime > curTime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN
    self._campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
  if closeTime < curTime then
    res.m_result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED
    self._campaignModule:ShowErrorToast(res.m_result, true)
    return
  end
end

function UIN12NormalLevel:OnShow(uiParams)
  self:_GetComponent()
  self:_OnValue()
end

function UIN12NormalLevel:_GetComponent()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end)
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._bossName = self:GetUIComponent("UILocalizationText", "BossName")
  self._resetTime = self:GetUIComponent("UILocalizationText", "ResetTime")
  self._recommendInfoText = self:GetUIComponent("UILocalizationText", "RecommendInfoText")
  self._notice = self:GetUIComponent("UILocalizationText", "Notice")
  self._challengeUpperLimit = self:GetUIComponent("UILocalizationText", "ChallengeUpperLimit")
  self._passReward = self:GetUIComponent("UILocalizationText", "PassReward")
  self._bossImg = self:GetUIComponent("RawImageLoader", "BossImg")
  self._bossImgRect = self:GetUIComponent("RectTransform", "BossImg")
  self._element = {}
  self._element[1] = self:GetUIComponent("Image", "Element1")
  self._element[2] = self:GetUIComponent("Image", "Element2")
  self._elementObj = {}
  self._elementObj[1] = self:GetGameObject("Element1")
  self._elementObj[2] = self:GetGameObject("Element2")
  self._levelTypeBtnMark = {}
  self._levelTypeBtnMark[NormalLevelType.Easy] = self:GetGameObject("EasyBtnMark")
  self._levelTypeBtnMark[NormalLevelType.Normal] = self:GetGameObject("NormalBtnMark")
  self._levelTypeBtnMark[NormalLevelType.Hard] = self:GetGameObject("HardBtnMark")
  self._levelTypeBtnText = {}
  self._levelTypeBtnText[NormalLevelType.Easy] = self:GetUIComponent("UILocalizationText", "EasyBtnText")
  self._levelTypeBtnText[NormalLevelType.Normal] = self:GetUIComponent("UILocalizationText", "NormalBtnText")
  self._levelTypeBtnText[NormalLevelType.Hard] = self:GetUIComponent("UILocalizationText", "HardBtnText")
  self._passRewardunLimit = self:GetGameObject("PassRewardunLimit")
  self._passRewardLimit = self:GetGameObject("PassRewardLimit")
end

function UIN12NormalLevel:_OnValue()
  self:_RefreshUIInfo(self._curLevelType)
  self:_InitDynamicScrollView()
end

function UIN12NormalLevel:_RefreshUIInfo(levelType)
  local levelIndex = self._dailyMissionComponentInfo.m_cur_day_index
  local campaignMissionId = self._dailyMissionComponentInfo.m_daily_mission[levelType]
  local tempDailyMissionCfgs = Cfg.cfg_component_daily_mission({LeveIndex = levelIndex, CampaignMissionId = campaignMissionId})
  if not tempDailyMissionCfgs then
    Log.error("cfg_component_daily_mission error! " .. levelIndex .. " " .. campaignMissionId)
    return
  end
  self._curDailyMissionCfg = tempDailyMissionCfgs[1]
  if not self._curDailyMissionCfg then
    Log.error("cfg_component_daily_mission dont not exist." .. levelIndex .. " " .. campaignMissionId)
    return
  end
  self._affix = self._curDailyMissionCfg.Affix
  local cfg_campaign_mission = Cfg.cfg_campaign_mission[campaignMissionId]
  if cfg_campaign_mission then
    self._bossName:SetText(StringTable.Get(cfg_campaign_mission.Name))
  end
  self._recommendInfoText:SetText(StringTable.Get("str_n12_recommend_info", self._curDailyMissionCfg.RecommendAwaken, self._curDailyMissionCfg.RecommendLV))
  self._bossImg:LoadImage(self._curDailyMissionCfg.MonsterIcon)
  self._bossImgRect.anchoredPosition = Vector2(self._curDailyMissionCfg.PositionWH[1], self._curDailyMissionCfg.PositionWH[2])
  self._bossImgRect.sizeDelta = Vector2(self._curDailyMissionCfg.PositionWH[3], self._curDailyMissionCfg.PositionWH[4])
  self._cfgs_boss = N12ToolFunctions.GetBossCfgs(self._curDailyMissionCfg.CampaignMissionId)
  if self._cfgs_boss then
    local elementType = {}
    for i = 1, #self._cfgs_boss do
      if not table.icontains(elementType, self._cfgs_boss[i].ElementType) then
        table.insert(elementType, self._cfgs_boss[i].ElementType)
      end
    end
    if #elementType == 1 then
      self._element[2].sprite = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(ElementIcon[elementType[1]]))
      self._elementObj[2]:SetActive(true)
      self._elementObj[1]:SetActive(false)
    elseif #elementType == 2 then
      self._element[1].sprite = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(ElementIcon[elementType[1]]))
      self._elementObj[1]:SetActive(true)
      self._element[2].sprite = self._atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(ElementIcon[elementType[2]]))
      self._elementObj[2]:SetActive(true)
    else
      self._elementObj[1]:SetActive(false)
      self._elementObj[2]:SetActive(false)
    end
  else
    for i = 1, #self._element do
      self._elementObj[i]:SetActive(false)
    end
  end
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local remainTime = self._dailyMissionComponentInfo.m_daily_mission_reset_time - curtime
  self._resetTime:SetText(StringTable.Get("str_n12_normal_level_reset_time", N12ToolFunctions.GetRemainTime(remainTime)))
  self._passReward:SetText(self._curDailyMissionCfg.AwardScore)
  self._challengeUpperLimit:SetText(self._dailyMissionComponentInfo.m_total_score .. "/" .. self._dailyMissionComponentInfo.m_score_limit)
  self._passRewardunLimit:SetActive(self._dailyMissionComponentInfo.m_total_score < self._dailyMissionComponentInfo.m_score_limit)
  self._passRewardLimit:SetActive(self._dailyMissionComponentInfo.m_total_score >= self._dailyMissionComponentInfo.m_score_limit)
  self:_RefreshDiffBtn(levelType)
  N12ToolFunctions.SetLocalDBInt("N12NormalLevelCurDay", self._dailyMissionComponentInfo.m_cur_day_index)
end

function UIN12NormalLevel:_RefreshDiffBtn(levelType)
  for key, value in pairs(NormalLevelType) do
    local color = Color(0.6509803921568628, 0.6274509803921569, 0.6196078431372549)
    if value == levelType then
      color = Color.black
    end
    self._levelTypeBtnMark[value]:SetActive(value == levelType)
    self._levelTypeBtnText[value].color = color
  end
end

function UIN12NormalLevel:_InitDynamicScrollView()
  self._scrollView:InitListView(#self._affix, function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
end

function UIN12NormalLevel:_OnGetItemByIndex(scrollview, index)
  local item = scrollview:NewListViewItem("Item")
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UIN12NormalLevelItem", 1)
  end
  local ItemWidgets = itemPool:GetAllSpawnList()
  local itemWidget = ItemWidgets[1]
  if itemWidget then
    itemWidget:SetData(self._affix[index + 1], index)
  end
  return item
end

function UIN12NormalLevel:_Close()
  self:SwitchState(UIStateType.UIN12MainController)
end

function UIN12NormalLevel:EasyBtnOnClick(go)
  self:_SelectLevel(go, NormalLevelType.Easy)
end

function UIN12NormalLevel:NormalBtnOnClick(go)
  self:_SelectLevel(go, NormalLevelType.Normal)
end

function UIN12NormalLevel:HardBtnOnClick(go)
  self:_SelectLevel(go, NormalLevelType.Hard)
end

function UIN12NormalLevel:_SelectLevel(go, levelType)
  if self._curLevelType == levelType then
    return
  end
  self._curLevelType = levelType
  N12ToolFunctions.SetLocalDBInt(N12OperationRecordKey.NormalLevelType, self._curLevelType)
  self:_RefreshUIInfo(self._curLevelType)
  self:_RefreshScrollView()
end

function UIN12NormalLevel:_RefreshScrollView()
  self._scrollView:SetListItemCount(#self._affix)
  self._scrollView:MovePanelToItemIndex(0, 0)
end

function UIN12NormalLevel:BattleBtnOnClick(go)
  local ctx = self._missionModule:TeamCtx()
  local param = {
    self._dailyMissionComponentInfo.m_daily_mission[self._curLevelType],
    self._dailyMissionComponent:GetCampaignMissionComponentId(),
    self._dailyMissionComponent:GetCampaignMissionParamKeyMap()
  }
  ctx:Init(TeamOpenerType.Campaign, param)
  ctx:ShowDialogUITeams()
end

function UIN12NormalLevel:RestrainBtnOnClick(go)
  self:ShowDialog("UIRestrainTips")
end

function UIN12NormalLevel:BossInfoBtnOnClick(go)
  if self._cfgs_boss then
    local ids = {}
    for i = 1, #self._cfgs_boss do
      table.insert(ids, self._cfgs_boss[i].ID)
    end
    self:ShowDialog("UIEnemyTip", ids)
  end
end
