_class("UILostLandStageController", UIController)
UILostLandStageController = UILostLandStageController

function UILostLandStageController:Constructor()
  self._itemCountPerRow = 3
  self._missionCount = 0
  self._missionTable = {}
  self._missionid2activityrewards = {}
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._module = GameGlobal.GetModule(LostAreaModule)
  self._uiModule = GameGlobal.GetUIModule(LostAreaModule)
end

function UILostLandStageController:OnShow(uiParams)
  self._enterData = self._uiModule:GetCurrentEnterData()
  self._missionid = uiParams[1] or nil
  if not self._missionid then
    self._missionid = self:GetFirstNotPassMission()
  end
  self:GetCurrentGroupAndStageIdx()
  self._stageData = self._uiModule:GetMissionDataByMissionID(self._missionid)
  self:GetComponents()
  self:OnValue()
end

function UILostLandStageController:GetFirstNotPassMission()
  local missionid = self._uiModule:GetCurrentStageID()
  return missionid
end

function UILostLandStageController:GetCurrentGroupAndStageIdx()
  local missionTab = self._enterData:GetMissionTable()
  for i = 1, #missionTab do
    local group = missionTab[i]
    for j = 1, #group do
      local missionid = group[j]
      if missionid == self._missionid then
        self._groupIdx = i
        self._stageIdx = j
        break
      end
    end
  end
end

function UILostLandStageController:GetComponents()
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._uiHeartItemAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  local itemTips = self:GetUIComponent("UISelectObjectPath", "MatTip")
  self._selectInfo = itemTips:SpawnObject("UISelectInfo")
  local ltBtns = self:GetUIComponent("UISelectObjectPath", "TopButtons")
  self._backBtn = ltBtns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseController()
  end)
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._stageName = self:GetUIComponent("UILocalizationText", "stageName")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._timer = self:GetUIComponent("UILocalizationText", "timer")
  self._word = self:GetUIComponent("UILocalizationText", "word")
  self._wordParent = self:GetGameObject("wordParent")
  self._recommendPools = self:GetUIComponent("UISelectObjectPath", "recommendPools")
  self._weekAwardPool = self:GetUIComponent("UISelectObjectPath", "weekAwardPool")
  self._enemyMsg = self:GetUIComponent("UISelectObjectPath", "enemyMsg")
  self._recommendLV = self:GetUIComponent("UILocalizationText", "recommendLV")
  self._recommendLV2 = self:GetUIComponent("UILocalizationText", "recommendLV2")
  self._awardContent = self:GetUIComponent("UISelectObjectPath", "AwardContent")
  self._awardGot = self:GetGameObject("awardGot")
  self._stagePools = self:GetUIComponent("UISelectObjectPath", "stagePools")
end

function UILostLandStageController:CloseController()
  self:SwitchState(UIStateType.UIDiscovery)
end

function UILostLandStageController:OnValue()
  self:InitTimer()
  self:InitEnterInfo()
  self:ClickSucc()
end

function UILostLandStageController:OnHide()
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
end

function UILostLandStageController:InitEnterInfo()
  self:InitWeekInfo()
  self:InitStagePool()
  self._name:SetText(StringTable.Get(self._enterData:GetName()))
  self._bg:LoadImage(self._enterData:GetCg())
end

function UILostLandStageController:InitTimer()
  self._resetTime = self._uiModule:GetResetTime()
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
  self._timerEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:SetTimerTex()
  end)
  self:SetTimerTex()
end

function UILostLandStageController:SetTimerTex()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sec = self._resetTime - svrTime
  if sec < 0 then
    self:TimeReset()
  else
    local timeTex = self._uiModule:Time2Tex(sec)
    self._timer:SetText(StringTable.Get("str_lost_land_reset_time_tips", timeTex))
  end
end

function UILostLandStageController:TimeReset()
  if self._timerEvent then
    GameGlobal.Timer():CancelEvent(self._timerEvent)
    self._timerEvent = nil
  end
  self._uiModule:ResetTime(UILostLandResetTimeDialog.Stage)
end

function UILostLandStageController:InitEnemyInfo()
  if self._enemies == nil then
    self._enemies = self._enemyMsg:SpawnObject("UIEnemyMsg")
  end
  self._enemies:SetData(self._stageData:GetLevelID())
end

function UILostLandStageController:InitWeekAwardInfo()
  local petAwardCount = self._uiModule:GetPetAwardCount()
  local award_count = self._stageData:GetPetAward()
  self._weekAwardPool:SpawnObjects("UILostLandMissionInfoItem", petAwardCount)
  local pools = self._weekAwardPool:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    item:SetData(i, award_count, function(id, pos)
      self:ItemInfo(id, pos)
    end)
  end
end

function UILostLandStageController:InitWeekInfo()
  local recommendList = self._uiModule:GetRecommendConditionList()
  self._recommendPools:SpawnObjects("UILostLandStageFilterItem", #recommendList)
  local pools = self._recommendPools:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    item:SetData(recommendList[i])
  end
end

function UILostLandStageController:InitStagePool()
  self._missionTable = self._enterData:GetMissionTable()
  self._idx2tableIdx = {}
  local count = 0
  for i = 1, #self._missionTable do
    local group = self._missionTable[i]
    for j = 1, #group do
      count = count + 1
      local tableIdx = {}
      tableIdx.group = i
      tableIdx.stage = j
      self._idx2tableIdx[count] = tableIdx
    end
  end
  self._stagePools:SpawnObjects("UILostLandStageItem", count)
  local pools = self._stagePools:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local groupIdx = self._idx2tableIdx[i].group
    local stageIdx = self._idx2tableIdx[i].stage
    local groupCount = table.count(self._missionTable)
    local stageCount = table.count(self._missionTable[groupIdx])
    local missionid = self._missionTable[groupIdx][stageIdx]
    local upOrDown = groupIdx % 2
    local width = self._enterData:GetItemShowWidth()
    item:SetData(groupIdx, stageIdx, groupCount, stageCount, missionid, function(groupIdx, stageIdx)
      self:OnStageItemClick(groupIdx, stageIdx)
    end, upOrDown, width)
  end
end

function UILostLandStageController:OnStageItemClick(groupIdx, stageIdx)
  if self._groupIdx == groupIdx and self._stageIdx == stageIdx then
    return
  end
  self._groupIdx = groupIdx
  self._stageIdx = stageIdx
  self:ClickSucc()
end

function UILostLandStageController:ClickSucc()
  local missionId = self._missionTable[self._groupIdx][self._stageIdx]
  ToastManager.ShowToast("missionid --> " .. missionId)
  self._missionid = missionId
  self._stageData = self._uiModule:GetMissionDataByMissionID(self._missionid)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUILostLandStageItemClick, self._groupIdx, self._stageIdx)
  self:InitStageInfo()
end

function UILostLandStageController:InitStageInfo()
  self:InitEnemyInfo()
  self:InitWeekAwardInfo()
  self:InitRecommendLv()
  self:InitStageAwardTT()
  self:InitWord()
  self:InitStageName()
end

function UILostLandStageController:InitRecommendLv()
  local recommendGrade = self._stageData:GetRecommendGrade()
  local recommendLv = self._stageData:GetRecommendLv()
  if recommendGrade and 0 < recommendGrade then
    self._recommendLV.gameObject:SetActive(true)
    self._recommendLV:SetText(recommendGrade)
  else
    self._recommendLV.gameObject:SetActive(false)
  end
  if recommendLv and 0 < recommendLv then
    self._recommendLV2.gameObject:SetActive(true)
    self._recommendLV2:SetText(recommendLv)
  else
    self._recommendLV2.gameObject:SetActive(false)
  end
end

function UILostLandStageController:InitStageAwardTT()
  local passTimes = self._stageData:GetPassTimes()
  if passTimes <= 0 then
    self._awardGot:SetActive(false)
  else
    self._awardGot:SetActive(true)
  end
  if self._missionid2activityrewards[self._missionid] then
    self._activity_rewards = {}
    for i = 1, #self._missionid2activityrewards[self._missionid] do
      local _data = self._missionid2activityrewards[self._missionid][i]
      table.insert(self._activity_rewards, _data)
    end
    self:InitStageAward()
  else
    self:Lock("UILostLandStageController:InitStageAwardTT")
    GameGlobal.TaskManager():StartTask(self._OnInitStageAwardTT, self)
  end
end

function UILostLandStageController:_OnInitStageAwardTT(TT)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local res, rewards = campaignModule:HandleCampaignGetMatchMissionExReward(TT, MatchType.MT_LostArea, self._missionid)
  self:UnLock("UILostLandStageController:InitStageAwardTT")
  local items = {}
  if res:GetSucc() then
    for i = 1, table.count(rewards) do
      local _data = {}
      _data.item = rewards[i]
      _data.type = StageAwardType.Activity
      table.insert(items, _data)
    end
  else
    Log.error("###[UILostLandStageController] HandleCampaignGetMatchMissionExReward fail ! mission id --> ", self._missionid)
  end
  if not self._missionid2activityrewards then
    self._missionid2activityrewards = {}
  end
  if not self._missionid2activityrewards[self._missionid] then
    self._missionid2activityrewards[self._missionid] = items
  end
  self._activity_rewards = {}
  for i = 1, #items do
    local _data = items[i]
    table.insert(self._activity_rewards, _data)
  end
  self:InitStageAward()
end

function UILostLandStageController:InitStageAward()
  local dropItems = self._stageData:GetAward()
  local items = {}
  for i = 1, #dropItems do
    local _data = {}
    _data.type = StageAwardType.First
    _data.item = dropItems[i]
    table.insert(items, _data)
  end
  table.appendArray(self._activity_rewards, items)
  self._awardContent:SpawnObjects("UIItem", #self._activity_rewards)
  local items = self._awardContent:GetAllSpawnList()
  for i, data in ipairs(self._activity_rewards) do
    local item = data.item
    items[i]:SetForm(UIItemForm.Tower, UIItemScale.Level3)
    local cfgItem = Cfg.cfg_item[item.assetid]
    if not cfgItem then
      Log.error("###[UILostLandStageController] cfgItem is nil ! id --> ", item.assetid)
    end
    local strKey = ""
    local activityText = ""
    local awardType = data.type
    if awardType == StageAwardType.First then
      strKey = "str_discovery_first_award"
    elseif awardType == StageAwardType.Star then
      strKey = "str_discovery_3star_award"
    elseif awardType == StageAwardType.Activity then
      strKey = "str_discovery_activity_award"
      activityText = "str_item_xianshi"
    elseif awardType == StageAwardType.HasGen then
      strKey = "str_discovery_already_collect"
    else
      strKey = "str_discovery_normal_award"
    end
    items[i]:SetData({
      text1 = item.count,
      awardText = StringTable.Get(strKey),
      icon = cfgItem.Icon,
      itemId = item.assetid,
      quality = cfgItem.Color,
      activityText = StringTable.Get(activityText)
    })
    items[i]:SetClickCallBack(function(go)
      self:ItemInfo(item.assetid, go.transform.position)
    end)
  end
end

function UILostLandStageController:InitWord()
  local word = self._stageData:GetWord()
  self._wordParent:SetActive(word ~= nil)
  if word then
    self._word:SetText(word)
  end
end

function UILostLandStageController:InitStageName()
  local name = self._stageData:GetMissionName()
  self._stageName:SetText(name)
end

function UILostLandStageController:BattleButtonOnClick(go)
  local missionID = self._missionTable[self._groupIdx][self._stageIdx]
  local missionData = self._uiModule:GetMissionDataByMissionID(missionID)
  local lock = missionData:GetLockType()
  if lock == UILostLandMissionLockType.LOCK then
    local tips = StringTable.Get("str_lost_land_stage_lock_tips")
    ToastManager.ShowToast(tips)
    return
  end
  local ctx = GameGlobal.GetModule(MissionModule):TeamCtx()
  ctx:Init(TeamOpenerType.LostLand, self._missionid)
  self:Lock("DoEnterTeam")
  ctx:ShowDialogUITeams()
end

function UILostLandStageController:ItemInfo(id, pos)
  self._selectInfo:SetData(id, pos)
end
