_class("UIN12HardlLevelInfo", UIController)
UIN12HardlLevelInfo = UIN12HardlLevelInfo

function UIN12HardlLevelInfo:Constructor()
  self._loginModule = self:GetModule(LoginModule)
  self._missionModule = self:GetModule(MissionModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._curLevelIndex = N12ToolFunctions.GetLocalDBInt(N12OperationRecordKey.HardLevelIndex, 1)
  local key = self._curLevelIndex .. N12OperationRecordKey.HardLevelType
  self._curLevelType = N12ToolFunctions.GetLocalDBInt(key, HardLevelType.Easy)
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._element_cfg = Cfg.cfg_pet_element({})
  self._cfgs_boss = nil
  self._selectedAffixes = {}
  self._curScore = 0
  self._levelData = {}
  self._difficultyCount = HardLevelType.Hell
  self._playItemAnimation = true
  self._globalDelayTime = 0
  self._animationInstanceIDs = {}
end

function UIN12HardlLevelInfo:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N12, ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._localProcess = self._campaign:GetLocalProcess()
  self._challengeMissionComponent = self._campaign:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  self._challengeMissionCompInfo = self._challengeMissionComponent:GetComponentInfo()
  self:_FilterLevelData()
end

function UIN12HardlLevelInfo:_FilterLevelData()
  local missionInfos = self._challengeMissionCompInfo.m_challenge_unlock_time
  local tempTable = {}
  for key, value in pairs(missionInfos) do
    local tempCfg = Cfg.cfg_component_challenge_mission({CampaignMissionId = key})
    if not table.icontains(tempTable, tempCfg[1].LeveIndex) then
      table.insert(tempTable, tempCfg[1].LeveIndex)
      self._levelData[tempCfg[1].LeveIndex] = {key, value}
    end
  end
end

function UIN12HardlLevelInfo:OnShow(uiParams)
  self._maxScore = self._challengeMissionCompInfo.m_max_score[self._curLevelIndex]
  self:_GetComponent()
  self:_OnValue()
end

function UIN12HardlLevelInfo:_GetComponent()
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end)
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._menu = self:GetGameObject("Menu")
  self._menuMask = self:GetGameObject("MenuMask")
  self._levelTypeBtn = {}
  self._levelTypeBtn[HardLevelType.Easy] = self:GetGameObject("EasyBtn")
  self._levelTypeBtn[HardLevelType.Normal] = self:GetGameObject("NormalBtn")
  self._levelTypeBtn[HardLevelType.Hard] = self:GetGameObject("HardBtn")
  self._levelTypeBtn[HardLevelType.Nightmare] = self:GetGameObject("NightmareBtn")
  self._levelTypeBtn[HardLevelType.Hell] = self:GetGameObject("HellBtn")
  self._levelTypeBtnText = {}
  self._levelTypeBtnText[HardLevelType.Easy] = self:GetUIComponent("UILocalizationText", "EasyBtnText")
  self._levelTypeBtnText[HardLevelType.Normal] = self:GetUIComponent("UILocalizationText", "NormalBtnText")
  self._levelTypeBtnText[HardLevelType.Hard] = self:GetUIComponent("UILocalizationText", "HardBtnText")
  self._levelTypeBtnText[HardLevelType.Nightmare] = self:GetUIComponent("UILocalizationText", "NightmareBtnText")
  self._levelTypeBtnText[HardLevelType.Hell] = self:GetUIComponent("UILocalizationText", "HellBtnText")
  self._levelTypeBaseScoreText = {}
  self._levelTypeBaseScoreText[HardLevelType.Easy] = self:GetUIComponent("UILocalizationText", "EasyBaseScore")
  self._levelTypeBaseScoreText[HardLevelType.Normal] = self:GetUIComponent("UILocalizationText", "NormalBaseScore")
  self._levelTypeBaseScoreText[HardLevelType.Hard] = self:GetUIComponent("UILocalizationText", "HardBaseScore")
  self._levelTypeBaseScoreText[HardLevelType.Nightmare] = self:GetUIComponent("UILocalizationText", "NightmareBaseScore")
  self._levelTypeBaseScoreText[HardLevelType.Hell] = self:GetUIComponent("UILocalizationText", "HellBaseScore")
  self._levelTypeBtnLock = {}
  self._levelTypeBtnLock[HardLevelType.Easy] = self:GetGameObject("EasyLock")
  self._levelTypeBtnLock[HardLevelType.Normal] = self:GetGameObject("NormalLock")
  self._levelTypeBtnLock[HardLevelType.Hard] = self:GetGameObject("HardLock")
  self._levelTypeBtnLock[HardLevelType.Nightmare] = self:GetGameObject("NightmareLock")
  self._levelTypeBtnLock[HardLevelType.Hell] = self:GetGameObject("HellLock")
  self._curBtnText = self:GetUIComponent("UILocalizationText", "CurBtnText")
  self._curBtnScoreText = self:GetUIComponent("UILocalizationText", "CurBtnScoreText")
  self._element = {}
  self._element[1] = self:GetUIComponent("Image", "Element1")
  self._element[2] = self:GetUIComponent("Image", "Element2")
  self._elementObj = {}
  self._elementObj[1] = self:GetGameObject("Element1")
  self._elementObj[2] = self:GetGameObject("Element2")
  self._bossName = self:GetUIComponent("UILocalizationText", "BossName")
  self._recommendInfoText = self:GetUIComponent("UILocalizationText", "RecommendInfoText")
  self._bossImg = self:GetUIComponent("RawImageLoader", "BossImg")
  self._curScoreText = self:GetUIComponent("UILocalizationText", "CurScore")
  self._maxScoreText = self:GetUIComponent("UILocalizationText", "MaxScore")
  self._menuMaskImg = self:GetUIComponent("RectTransform", "MenuMaskImg")
  
  function self._scrollView.mOnDragingAction()
    self._playItemAnimation = false
  end
end

function UIN12HardlLevelInfo:_OnValue()
  self:_RefreshUnlockInfo()
  self:_RefreshUIInfo(self._curLevelType)
  self:_InitDynamicScrollView()
  self:_CheckChallengeTaskRewards()
end

function UIN12HardlLevelInfo:_CheckChallengeTaskRewards()
  local key = N12OperationRecordKey.ShowChallengeTaskRewards .. self._curLevelIndex
  if 0 < N12ToolFunctions.GetLocalDBInt(key, 0) then
    N12ToolFunctions.SetLocalDBInt(key, 0)
    self:Lock("N12CheckChallengeTaskRewards")
    self:StartTask(function(TT)
      YIELD(TT, 500)
      self:_ShowChallengeTaskRewards()
      self:UnLock("N12CheckChallengeTaskRewards")
    end)
  end
end

function UIN12HardlLevelInfo:_ShowChallengeTaskRewards()
  local oldMaxScore = N12ToolFunctions.GetLocalDBInt(N12OperationRecordKey.OldMaxScore, 0)
  local newMaxScore = N12ToolFunctions.GetLocalDBInt(N12OperationRecordKey.NewMaxScore, 0)
  local rewards = {}
  local totalCount = 0
  if oldMaxScore < newMaxScore then
    local hardLevelIndex = N12ToolFunctions.GetLocalDBInt(N12OperationRecordKey.HardLevelIndex, 1)
    local cfg = Cfg.cfg_n12_challenges_task[hardLevelIndex]
    if cfg then
      for key, value in pairs(cfg.Score) do
        if oldMaxScore < value[1] and newMaxScore >= value[1] then
          totalCount = totalCount + cfg.Rewards[key][2]
        end
      end
    end
  end
  if 0 < totalCount then
    table.insert(rewards, totalCount)
  end
  if 0 < #rewards then
    self:ShowDialog("UIN12ChallengeTaskReward", rewards)
  end
end

function UIN12HardlLevelInfo:_RefreshUnlockInfo()
  local str = LocalDB.GetString("N12ChallengeLevelIndexes" .. self._loginModule:GetRoleShowID())
  local indexes = string.split(str, ",")
  local recorded = false
  for i = 1, #indexes do
    if indexes[i] == tostring(self._curLevelIndex) then
      recorded = true
    end
  end
  if not recorded then
    str = str .. self._curLevelIndex .. ","
  end
  LocalDB.SetString("N12ChallengeLevelIndexes" .. self._loginModule:GetRoleShowID(), str)
end

function UIN12HardlLevelInfo:_RefreshUIInfo(levelType)
  local missions = Cfg.cfg_component_challenge_mission({
    LeveIndex = self._curLevelIndex,
    HardID = levelType
  })
  if not missions then
    Log.error("cfg_component_challenge_mission dont not exist." .. self._curLevelIndex .. " " .. levelType)
    return
  end
  self:_GetDifficultyCount()
  self:_FiltrateAffix()
  self._curChallengeMissionCfg = missions[1]
  self._allAffixes = self._curChallengeMissionCfg.Affix
  local cfg_campaign_mission = Cfg.cfg_campaign_mission[self._curChallengeMissionCfg.CampaignMissionId]
  if cfg_campaign_mission then
    self._bossName:SetText(StringTable.Get(cfg_campaign_mission.Name))
  end
  self._recommendInfoText:SetText(StringTable.Get("str_n12_recommend_info", self._curChallengeMissionCfg.RecommendAwaken, self._curChallengeMissionCfg.RecommendLV))
  self._bossImg:LoadImage(self._curChallengeMissionCfg.MonsterIcon)
  self._cfgs_boss = N12ToolFunctions.GetBossCfgs(self._curChallengeMissionCfg.CampaignMissionId)
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
  self._curBtnText:SetText(StringTable.Get(HardLevelTypeText[self._curLevelType]))
  self._curBtnScoreText:SetText(self._curChallengeMissionCfg.BaseScore)
  self:_CalcAffixScore()
  self._maxScoreText:SetText(self._maxScore)
  self._menuMaskImg.sizeDelta = Vector2(506, 55 + self._difficultyCount * 75)
end

function UIN12HardlLevelInfo:_GetDifficultyCount()
  local missions = Cfg.cfg_component_challenge_mission({
    LeveIndex = self._curLevelIndex
  })
  self._difficultyCount = table.count(missions)
end

function UIN12HardlLevelInfo:_FiltrateAffix()
  self._haveRecord = false
  self._selectedAffixes = {}
  for key, value in pairs(self._challengeMissionCompInfo.m_select_affix) do
    local temps = Cfg.cfg_component_challenge_mission({
      LeveIndex = self._curLevelIndex,
      CampaignMissionId = key,
      HardID = self._curLevelType
    })
    if temps and 1 <= #temps then
      if value then
        for i = 1, #value do
          table.insert(self._selectedAffixes, value[i])
        end
      end
      self._haveRecord = #self._selectedAffixes > 0
      break
    end
  end
end

function UIN12HardlLevelInfo:_InitDynamicScrollView()
  self._scrollView:InitListView(#self._allAffixes, function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
end

function UIN12HardlLevelInfo:_OnGetItemByIndex(scrollview, index)
  local affixs = self._allAffixes[index + 1]
  local affixArrayType = #affixs <= 1
  local firstAffixCfg = Cfg.cfg_component_mission_affix[affixs[1]]
  local affixType = firstAffixCfg.UnLockScore == nil or firstAffixCfg.UnLockScore <= 0
  local itemTemplate = HardLevelInfoItemType[affixArrayType][affixType]
  local item = scrollview:NewListViewItem(itemTemplate)
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not affixArrayType then
    local count = #affixs
    if affixType then
      item.CachedRectTransform.sizeDelta = Vector2(1241, 89 * count + (count + 1) * 10)
    else
      item.CachedRectTransform.sizeDelta = Vector2(1241, 180 + 89 * (count - 1) + (count + 1) * 10)
    end
  end
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects(itemTemplate, 1)
  end
  local itemWidgets = itemPool:GetAllSpawnList()
  local itemWidget = itemWidgets[1]
  if itemWidget then
    itemWidget:SetData(function(deltaTime, instanceID)
      return self:_GlobalDelayTimeFunc(deltaTime, instanceID)
    end, affixs, function(affixId, select)
      self:_SelectAffixCallBack(affixId, select)
    end)
  end
  return item
end

function UIN12HardlLevelInfo:_GlobalDelayTimeFunc(deltaTime, instanceID)
  if not self._playItemAnimation then
    return -1
  end
  if table.icontains(self._animationInstanceIDs, instanceID) then
    return -1
  end
  table.insert(self._animationInstanceIDs, instanceID)
  local delayTime = self._globalDelayTime
  self._globalDelayTime = self._globalDelayTime + deltaTime
  return delayTime
end

function UIN12HardlLevelInfo:_SelectAffixCallBack(affixId, select)
  if select then
    table.insert(self._selectedAffixes, affixId)
  else
    table.removev(self._selectedAffixes, affixId)
  end
  if not select then
    self:_AffixAutoCancel()
  end
  self:_CalcAffixScore()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAffixScoreChange)
end

function UIN12HardlLevelInfo:_AffixAutoCancel()
  if #self._selectedAffixes <= 0 then
    return
  end
  table.sort(self._selectedAffixes, function(a, b)
    local cfga = Cfg.cfg_component_mission_affix[a]
    local cfgb = Cfg.cfg_component_mission_affix[b]
    return cfga.UnLockScore < cfgb.UnLockScore
  end)
  local tempAffixIDs = {}
  for i = 1, #self._selectedAffixes do
    local affixCfg = Cfg.cfg_component_mission_affix[self._selectedAffixes[i]]
    if 0 < affixCfg.UnLockScore then
      local tempCurScore = self:GetCurBaseScore()
      for j = 1, #self._selectedAffixes do
        if self._selectedAffixes[j] ~= self._selectedAffixes[i] then
          local cfg = Cfg.cfg_component_mission_affix[self._selectedAffixes[j]]
          if cfg and (0 >= cfg.UnLockScore or cfg.UnLockScore < affixCfg.UnLockScore and not table.icontains(tempAffixIDs, self._selectedAffixes[j])) then
            tempCurScore = tempCurScore + cfg.AffixScore
          end
        end
      end
      if tempCurScore < affixCfg.UnLockScore then
        table.insert(tempAffixIDs, self._selectedAffixes[i])
      end
    end
  end
  if 0 < #tempAffixIDs then
    for i = 1, #tempAffixIDs do
      table.removev(self._selectedAffixes, tempAffixIDs[i])
    end
  end
end

function UIN12HardlLevelInfo:_SyncSelectedAffixes(callBack)
  self:Lock("UIN12HardlLevelInfoSelectAffix")
  self:StartTask(function(TT)
    local request = AsyncRequestRes:New()
    request = self._challengeMissionComponent:HandleSelectAffix(TT, request, self._curChallengeMissionCfg.CampaignMissionId, self._selectedAffixes)
    if request:GetSucc() then
      if callBack then
        callBack()
      end
    else
      self._campaignModule:CheckErrorCode(request.m_result, self._campaign._id)
    end
    self:UnLock("UIN12HardlLevelInfoSelectAffix")
  end, self)
end

function UIN12HardlLevelInfo:_CalcAffixScore()
  self._curScore = self._curChallengeMissionCfg.BaseScore
  for i = 1, #self._selectedAffixes do
    local cfg = Cfg.cfg_component_mission_affix[self._selectedAffixes[i]]
    if cfg then
      self._curScore = self._curScore + cfg.AffixScore
    end
  end
  self._curScoreText:SetText(self._curScore)
end

function UIN12HardlLevelInfo:GetSelectedAffixes()
  return self._selectedAffixes
end

function UIN12HardlLevelInfo:GetCurScore()
  return self._curScore
end

function UIN12HardlLevelInfo:GetCurBaseScore()
  return self._curChallengeMissionCfg.BaseScore
end

function UIN12HardlLevelInfo:_Close()
  self:SwitchState(UIStateType.UIN12HardlLevel)
end

function UIN12HardlLevelInfo:OnHide()
  self:_SyncSelectedAffixes()
end

function UIN12HardlLevelInfo:ChallengeTaskBtnOnClick(go)
  self:ShowDialog("UIN12ChallengesContorl", self._levelData)
end

function UIN12HardlLevelInfo:BattleBtnOnClick(go)
  self:_SyncSelectedAffixes(function()
    self._localProcess:SetCurScore(self._curScore)
    local ctx = self._missionModule:TeamCtx()
    local param = {
      self._curChallengeMissionCfg.CampaignMissionId,
      self._challengeMissionComponent:GetCampaignMissionComponentId(),
      self._challengeMissionComponent:GetCampaignMissionParamKeyMap()
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams()
  end)
end

function UIN12HardlLevelInfo:ClearBtnOnClick(go)
  if self._haveRecord then
    self:Lock("UIN12HardlLevelInfoClearAffix")
    self:StartTask(function(TT)
      local request = AsyncRequestRes:New()
      request = self._challengeMissionComponent:HandleClearAffix(TT, request, self._curChallengeMissionCfg.CampaignMissionId)
      if request:GetSucc() then
        self:_RefreshUIInfo(self._curLevelType)
        self:_RefreshScrollView(false)
      else
        self._campaignModule:CheckErrorCode(request.m_result, self._campaign._id)
      end
      self:UnLock("UIN12HardlLevelInfoClearAffix")
    end, self)
  else
    self._selectedAffixes = {}
    self:_RefreshUIInfo(self._curLevelType)
    self:_RefreshScrollView(false)
  end
end

function UIN12HardlLevelInfo:MenuMaskOnClick(go)
  self:_SyncSelectedAffixes(function()
    self:_ShowMenu(self._curLevelType)
  end)
end

function UIN12HardlLevelInfo:CurBtnOnClick(go)
  self:_SyncSelectedAffixes(function()
    self:_ShowMenu(self._curLevelType)
  end)
end

function UIN12HardlLevelInfo:EasyBtnOnClick(go)
  self:_SelectLevelType(HardLevelType.Easy)
end

function UIN12HardlLevelInfo:NormalBtnOnClick(go)
  self:_SelectLevelType(HardLevelType.Normal)
end

function UIN12HardlLevelInfo:HardBtnOnClick(go)
  self:_SelectLevelType(HardLevelType.Hard)
end

function UIN12HardlLevelInfo:NightmareBtnOnClick(go)
  self:_SelectLevelType(HardLevelType.Nightmare)
end

function UIN12HardlLevelInfo:HellBtnOnClick(go)
  self:_SelectLevelType(HardLevelType.Hell)
end

function UIN12HardlLevelInfo:_SelectLevelType(levelType)
  local missionCfg = Cfg.cfg_component_challenge_mission({
    LeveIndex = self._curLevelIndex,
    HardID = levelType
  })
  if missionCfg[1].UnlockScore > self._maxScore then
    ToastManager.ShowToast(StringTable.Get("str_n12_hard_unlock_score", missionCfg[1].UnlockScore))
    return
  end
  self:_ShowMenu(levelType)
end

function UIN12HardlLevelInfo:_ShowMenu(levelType)
  self._menu:SetActive(not self._menu.activeSelf)
  self._menuMask:SetActive(self._menu.activeSelf)
  if self._menu.activeSelf then
    for key, value in pairs(HardLevelType) do
      local color = Color.white
      if value == self._curLevelType then
        color = Color(1.0, 0.7490196078431373, 0.0784313725490196)
      end
      local missionCfg = Cfg.cfg_component_challenge_mission({
        LeveIndex = self._curLevelIndex,
        HardID = value
      })
      local baseScore = ""
      if missionCfg[1].UnlockScore <= self._maxScore then
        baseScore = missionCfg[1].BaseScore
      end
      self._levelTypeBtnText[value].color = color
      self._levelTypeBaseScoreText[value]:SetText(baseScore)
      self._levelTypeBaseScoreText[value].color = color
      self._levelTypeBtnLock[value]:SetActive(missionCfg[1].UnlockScore > self._maxScore)
      self._levelTypeBtn[value]:SetActive(value <= self._difficultyCount)
    end
  end
  if self._curLevelType == levelType then
    return
  end
  self._curLevelType = levelType
  local key = self._curLevelIndex .. N12OperationRecordKey.HardLevelType
  N12ToolFunctions.SetLocalDBInt(key, self._curLevelType)
  self:_RefreshUIInfo(self._curLevelType)
  self:_RefreshScrollView(true)
end

function UIN12HardlLevelInfo:_RefreshScrollView(move)
  self._scrollView:SetListItemCount(#self._allAffixes)
  if move then
    self._playItemAnimation = true
    self._globalDelayTime = 0
    self._animationInstanceIDs = {}
    self._scrollView:MovePanelToItemIndex(0, 0)
  else
    self._playItemAnimation = false
    self._scrollView:RefreshAllShownItem()
  end
end

function UIN12HardlLevelInfo:RestrainBtnOnClick(go)
  self:ShowDialog("UIRestrainTips")
end

function UIN12HardlLevelInfo:BossInfoBtnOnClick(go)
  if self._cfgs_boss then
    local ids = {}
    for i = 1, #self._cfgs_boss do
      table.insert(ids, self._cfgs_boss[i].ID)
    end
    self:ShowDialog("UIEnemyTip", ids)
  end
end
