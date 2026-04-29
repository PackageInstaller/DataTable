_class("UIActivityN21CCLevelDetail", UIController)
UIActivityN21CCLevelDetail = UIActivityN21CCLevelDetail

function UIActivityN21CCLevelDetail:LoadDataOnEnter(TT, res, uiParams)
  if uiParams[1] == true then
    self._levelGroupData = uiParams[2]
    self._activityConst = uiParams[3]
    self._isNormalUI = true
  else
    self._isNormalUI = false
    self._activityConst = UIActivityN21CCConst:New()
    self._activityConst:LoadData(TT, res)
    local challengeComponent, challengeCompInfo = self._activityConst:GetChallengeComponent()
    local levelGroupsData = UIActivityN21CCLevelGroupsData:New(challengeComponent:GetComponentCfgId(), challengeCompInfo)
    local index = UIActivityN21CCConst.GetEnterBattleLevelId()
    self._levelGroupData = levelGroupsData:GetLevelGroupDataByIndex(index)
  end
  self._hardIndex = 1
  local hardIndex = UIActivityN21CCConst.GetHistoryLevelHard(self._levelGroupData:GetIndex())
  if hardIndex and 0 <= hardIndex and self._levelGroupData:IsHardOpen(hardIndex) then
    self._hardIndex = hardIndex
  end
end

function UIActivityN21CCLevelDetail:OnShow(uiParams)
  self:AttachEvent(GameEventType.N21CCRefreshRedAndNew, self.RefreshRedAndNew)
  self:AttachEvent(GameEventType.N21CCRefreshItemList, self.RefreshItemList)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    self:Close()
  end, nil, nil, false)
  self._bossIconLoader = self:GetUIComponent("RawImageLoader", "BossIcon")
  self._element1Loader = self:GetUIComponent("RawImageLoader", "Element1")
  self._element2Loader = self:GetUIComponent("RawImageLoader", "Element2")
  self._element1Go = self:GetGameObject("Element1")
  self._element2Go = self:GetGameObject("Element2")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._bossNameLabel = self:GetUIComponent("UILocalizationText", "BossName")
  self._eventRed = self:GetGameObject("EventRed")
  self._levelSelectPanel = self:GetGameObject("LevelSelectPanel")
  self._levelSelectPanel:SetActive(false)
  self._hardItemList = self:GetUIComponent("UISelectObjectPath", "HardItemList")
  self._hardTitleLabel = self:GetUIComponent("UILocalizationText", "HardTitle")
  self._baseScoreLabel = self:GetUIComponent("UILocalizationText", "BaseScore")
  self._recommendLV = self:GetUIComponent("UILocalizationText", "recommendLV")
  self._recommendLV2 = self:GetUIComponent("UILocalizationText", "recommendLV2")
  self._selectedScoreLabel = self:GetUIComponent("UILocalizationText", "SelectedScore")
  self._affixGroups = self:GetUIComponent("UISelectObjectPath", "AffixGroups")
  self._unOpenGroups = self:GetUIComponent("UISelectObjectPath", "UnOpenGroups")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._anim:Play("UIActivityN21CCLevelDetail_in")
  self:RefreshUI(true)
  self:PlayListEnterAnim()
end

function UIActivityN21CCLevelDetail:OnUpdate(deltaTimeMS)
  if not self._playAnim then
    return
  end
  self._currentVaue = self._currentVaue + deltaTimeMS * self._speed
  self._currentVaue = math.floor(self._currentVaue)
  if self._currentVaue >= self._targetValue then
    self._playAnim = false
    self._currentVaue = self._targetValue
  end
  self._scoreLabel:SetText(self._currentVaue)
end

function UIActivityN21CCLevelDetail:OnHide()
  self:DetachEvent(GameEventType.N21CCRefreshItemList, self.RefreshItemList)
  self:DetachEvent(GameEventType.N21CCRefreshRedAndNew, self.RefreshRedAndNew)
end

function UIActivityN21CCLevelDetail:Close()
  GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
end

function UIActivityN21CCLevelDetail:CloseCoro(TT)
  self:Lock("UIActivityN21CCLevelDetail_CloseCoro")
  if self._isNormalUI then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.N21CCPlayMainFocusAnim)
    self._anim:Play("UIActivityN21CCLevelDetail_out")
    YIELD(TT, 500)
    self:CloseDialog()
  else
    self:SwitchState(UIStateType.UIActivityN21CCMainController)
  end
  self:UnLock("UIActivityN21CCLevelDetail_CloseCoro")
end

function UIActivityN21CCLevelDetail:GetCurrentLevel()
  local levels = self._levelGroupData:GetLevels()
  if not levels then
    return nil
  end
  local levelData
  for i = 1, #levels do
    local level = levels[i]
    if level:GetHardId() == self._hardIndex then
      levelData = level
      break
    end
  end
  return levelData
end

function UIActivityN21CCLevelDetail:RefreshUI(playAnim)
  local levelData = self:GetCurrentLevel()
  if not levelData then
    return
  end
  self._bossIconLoader:LoadImage(levelData:GetMonsterBigIcon())
  local elementIcon1 = levelData:GetElementIcon1()
  if string.isnullorempty(elementIcon1) then
    self._element1Go:SetActive(false)
  else
    self._element1Go:SetActive(true)
    self._element1Loader:LoadImage(elementIcon1)
  end
  local elementIcon2 = levelData:GetElementIcon2()
  if string.isnullorempty(elementIcon2) then
    self._element2Go:SetActive(false)
  else
    self._element2Go:SetActive(true)
    self._element2Loader:LoadImage(elementIcon2)
  end
  self._bossNameLabel:SetText(levelData:GetMonsterName())
  self:RefreshRedAndNew()
  self._hardTitleLabel:SetText(StringTable.Get("str_n20_crisis_contract_hard_title" .. self._hardIndex))
  self._baseScoreLabel:SetText(levelData:GetBaseScore())
  local recommendAwaken = levelData:GetRecommendAwaken()
  local recommendLV = levelData:GetRecommendLV()
  if recommendAwaken == nil or recommendAwaken == 0 then
    self._recommendLV.gameObject:SetActive(false)
  else
    self._recommendLV.gameObject:SetActive(true)
    self._recommendLV:SetText(StringTable.Get("str_pet_config_common_advance") .. recommendAwaken)
  end
  if recommendLV then
    self._recommendLV2:SetText("LV." .. recommendLV)
  else
    self._recommendLV2.gameObject:SetActive(false)
  end
  self:RefreshSelectedScore()
  local commonGroups = levelData:GetCommonAffixGroups()
  self._affixGroups:SpawnObjects("UIActivityN21CCLevelAffixGroupItem", #commonGroups)
  self._commonItems = self._affixGroups:GetAllSpawnList()
  for i = 1, #self._commonItems do
    local item = self._commonItems[i]
    item:Refresh(commonGroups[i], true, playAnim, function()
      self:RefreshSelectedScore()
    end)
  end
  local scoreUnlockGroups = levelData:GetScoreUnLockAffixGroups()
  self._unOpenGroups:SpawnObjects("UIActivityN21CCLevelAffixUnOpenItem", #scoreUnlockGroups)
  self._unOpenItems = self._unOpenGroups:GetAllSpawnList()
  for i = 1, #self._unOpenItems do
    local item = self._unOpenItems[i]
    local isOpen = false
    if scoreUnlockGroups[i] and 0 < table.count(scoreUnlockGroups[i]) then
      isOpen = self._selectedScore >= scoreUnlockGroups[i][1]:GetUnLockScore()
    end
    item:Refresh(scoreUnlockGroups[i], isOpen, playAnim, function()
      self:RefreshSelectedScore()
    end)
  end
end

function UIActivityN21CCLevelDetail:PlayListEnterAnim()
  self._scoreLabel:SetText(0)
  self._playAnim = true
  self._length = 500
  self._targetValue = self._levelGroupData:GetMaxScore()
  self._speed = self._targetValue / self._length
  self._currentVaue = 0
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIActivityN21CCLevelDetail:PlayEnterAnimCoro(TT)
  self:Lock("UIActivityN21CCLevelDetail_PlayEnterAnimCoro")
  for i = 1, #self._commonItems do
    self._commonItems[i]:PlayAnim(TT)
  end
  for i = 1, #self._unOpenItems do
    self._unOpenItems[i]:PlayAnim(TT)
  end
  self:UnLock("UIActivityN21CCLevelDetail_PlayEnterAnimCoro")
end

function UIActivityN21CCLevelDetail:RefreshItemList()
  if self._commonItems then
    for i = 1, #self._commonItems do
      local item = self._commonItems[i]
      item:RefreshData(self._selectedScore)
    end
  end
  for i = 1, #self._unOpenItems do
    local item = self._unOpenItems[i]
    item:RefreshData(self._selectedScore)
  end
end

function UIActivityN21CCLevelDetail:RefreshSelectedScore()
  local levelData = self:GetCurrentLevel()
  local score = levelData:GetBaseScore()
  local commonGroups = levelData:GetCommonAffixGroups()
  for i = 1, #commonGroups do
    local affixDatas = commonGroups[i]:GetAffixDatas()
    for j = 1, #affixDatas do
      local affixData = affixDatas[j]
      if affixData:IsSelected() then
        score = score + affixData:GetScroe()
      end
    end
  end
  local scoreUnlockGroups = levelData:GetScoreUnLockAffixGroups()
  for i = 1, #scoreUnlockGroups do
    for j = 1, #scoreUnlockGroups[i] do
      local affixGroupData = scoreUnlockGroups[i][j]
      local unlockScore = affixGroupData:GetUnLockScore()
      local affixDatas = affixGroupData:GetAffixDatas()
      for j = 1, #affixDatas do
        local affixData = affixDatas[j]
        if affixData:IsSelected() then
          if score >= unlockScore then
            score = score + affixData:GetScroe()
          else
            affixData:SetSelectStatus(false)
          end
        end
      end
    end
  end
  self._selectedScore = score
  self._selectedScoreLabel:SetText(score)
end

function UIActivityN21CCLevelDetail:RefreshRedAndNew()
  self._eventRed:SetActive(self._activityConst:IsShowEventnRed())
end

function UIActivityN21CCLevelDetail:BtnRestrainOnClick()
  self:ShowDialog("UIRestrainTips")
end

function UIActivityN21CCLevelDetail:BtnEnemyOnClick()
  local ids = {}
  local levelData = self:GetCurrentLevel()
  if not levelData then
    return
  end
  local monsterIDs = UICommonHelper:GetInstance():GetOptimalEnemys(levelData:GetFightId())
  if monsterIDs == nil or #monsterIDs == 0 then
    Log.fatal("[Enemy] 怪物id列表为空")
  else
    local count = table.count(monsterIDs)
    for i = 1, count do
      table.insert(ids, monsterIDs[i])
    end
  end
  if #ids <= 0 then
    Log.debug("monster list is empty")
    return
  end
  self:ShowDialog("UIEnemyTip", ids, 1)
end

function UIActivityN21CCLevelDetail:BtnEventOnClick()
  if self._activityConst:IsActivityEnd() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  if not self._activityConst:IsProgressEnable() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  local levelData = self:GetCurrentLevel()
  self:ShowDialog("UIActivityN21CCShop", levelData:GetMissionId())
end

function UIActivityN21CCLevelDetail:LevelPanelOnClick()
  self._levelSelectPanel:SetActive(true)
  local levels = self._levelGroupData:GetLevels()
  if levels == nil or #levels <= 0 then
    return
  end
  self._hardItemList:SpawnObjects("UIActivityN21CCLevelHardItem", #levels)
  local items = self._hardItemList:GetAllSpawnList()
  for i = 1, #items do
    local item = items[i]
    item:Refresh(levels[i], levels[i]:GetHardId() == self._hardIndex, function(success, hardId)
      if success and hardId ~= self._hardIndex then
        UIActivityN21CCConst.SetHistoryLevelHard(self._levelGroupData:GetIndex(), hardId)
        self._hardIndex = hardId
        self:RefreshUI(false)
      end
      self:LevelSelectPanelOnClick()
    end)
  end
end

function UIActivityN21CCLevelDetail:LevelSelectPanelOnClick()
  self._levelSelectPanel:SetActive(false)
end

function UIActivityN21CCLevelDetail:BtnStartBattleOnClick()
  if self._activityConst:IsActivityEnd() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  GameGlobal.TaskManager():StartTask(self.StartBattleBtnCoro, self)
end

function UIActivityN21CCLevelDetail:StartBattleBtnCoro(TT)
  UIActivityN21CCConst.SetEnterBattleHardIndex(self._hardIndex)
  UIActivityN21CCConst.SetEnterBattleLeveId(self._levelGroupData:GetIndex())
  local challengeComponent, challengeComponentInfo = self._activityConst:GetChallengeComponent()
  local levelData = self:GetCurrentLevel()
  local affixList = {}
  if levelData then
    local affixGroupDatas = levelData:GetAffixGroups()
    for i = 1, #affixGroupDatas do
      local affixGroupData = affixGroupDatas[i]
      local affixDatas = affixGroupData:GetAffixDatas()
      for j = 1, #affixDatas do
        local affixData = affixDatas[j]
        if affixData:IsSelected() then
          affixList[#affixList + 1] = affixData:GetMissionAffixId()
        end
      end
    end
  end
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  if #affixList <= 0 then
    res = challengeComponent:HandleClearAffix(TT, res, levelData:GetMissionId())
  else
    res = challengeComponent:HandleSelectAffix(TT, res, levelData:GetMissionId(), affixList)
  end
  if res:GetSucc() then
    self._activityConst:LoadData(TT, res)
    local missiontModule = GameGlobal.GetModule(MissionModule)
    local ctx = missiontModule:TeamCtx()
    local formationList = challengeComponentInfo.formation_list
    local team
    for i = 1, #formationList do
      local formation = formationList[i]
      if formation.id == levelData:GetIndex() then
        team = formation
        break
      end
    end
    ctx:InitN21CCTeams(team, levelData:GetIndex())
    local level = levelData:GetRecommendLV()
    local awake = levelData:GetRecommendAwaken()
    local param = {
      levelData:GetMissionId(),
      challengeComponent:GetCampaignMissionComponentId(),
      challengeComponent:GetCampaignMissionParamKeyMap(),
      {
        true,
        level,
        awake
      }
    }
    ctx:Init(TeamOpenerType.N21CC, param)
    UIActivityN21CCConst.SaveHistoryScore(levelData:GetMissionId())
    ctx:ShowDialogUITeams(false)
  else
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CheckErrorCode(res.m_result)
  end
end

function UIActivityN21CCLevelDetail:BtnClearOnClick()
  local levelData = self:GetCurrentLevel()
  if levelData then
    local affixGroupDatas = levelData:GetAffixGroups()
    for i = 1, #affixGroupDatas do
      local affixGroupData = affixGroupDatas[i]
      local affixDatas = affixGroupData:GetAffixDatas()
      for j = 1, #affixDatas do
        local affixData = affixDatas[j]
        affixData:SetSelectStatus(false)
      end
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.N21CCClearAllSelectAffix)
  self:RefreshSelectedScore()
  self:RefreshItemList()
end
