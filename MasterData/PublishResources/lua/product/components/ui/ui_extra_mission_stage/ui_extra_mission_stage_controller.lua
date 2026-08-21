_class("UIExtraMissionStageController", UIController)
UIExtraMissionStageController = UIExtraMissionStageController

function UIExtraMissionStageController:LoadDataOnEnter(TT, res, uiParams)
  self._module = self:GetModule(ExtMissionModule)
  self._extraMissionID = uiParams[1]
  local idx = 0
  for i, v in HelperProxy:GetInstance():pairsByKeys(Cfg.cfg_extra_mission({})) do
    local cfg_ext = v
    idx = idx + 1
    if v.ExtMissionID == self._extraMissionID then
      self._extraMissionIdx = idx
      break
    end
  end
  if not self._extraMissionIdx then
    Log.fatal("### calc self._extraMissionIdx is nil ! id --> ", self._extraMissionID)
  end
  self._cfg_extra_mission = Cfg.cfg_extra_mission[self._extraMissionID]
  if self._cfg_extra_mission == nil then
    Log.fatal("###[error] extraMissionStage --> self._cfg_extra_misiso is nil! extid --> ", self._extraMissionID)
  end
  self._stageID = uiParams[2]
  if self._stageID == nil then
    self._stageID, self._stageIdx = self:GetStageID()
  else
    self._stageIdx = self:GetStageIdx(self._stageID)
  end
  self._cfg_extra_mission_task = Cfg.cfg_extra_mission_task[self._stageID]
  if self._cfg_extra_mission_task == nil then
    Log.fatal("###[error] extraMissionStage --> self._cfg_extra_mission_task is nil! stageid --> ", self._stageID)
  end
  local resT = self._module:Request_GetDetail_ExtMission(TT, self._extraMissionID)
  if resT:GetSucc() then
    res:SetSucc(true)
  else
    res:SetSucc(false)
  end
end

function UIExtraMissionStageController:OnShow(uiParams)
  self._atlas = self:GetAsset("UIExtraMissionStage.spriteatlas", LoadType.SpriteAtlas)
  if self._stageID == nil then
    Log.fatal("###ext stage -- stageid is nil !")
    return
  end
  self:GetComponents()
  if self._cfg_extra_mission.ImgThemeLow then
    self._imgThemeLow:LoadImage(self._cfg_extra_mission.ImgThemeLow)
  end
  self:FlushStage()
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._bg:LoadImage(self._cfg_extra_mission.ExtMissionBigImgBlur)
  self:OnValue()
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowItemTips)
  self:AttachEvent(GameEventType.CancelRedPoint, self.CancelRedPoint)
end

function UIExtraMissionStageController:FlushStage()
  local c = self._cfg_extra_mission.ExtTaskList
  if #c ~= 6 then
    Log.fatal("###taskList count ~= 6 ! extid --> ", self._extraMissionID)
    return
  end
  self._puzzle:SpawnObjects("UIExtPuzzleItem", #c)
  self._puzzles = self._puzzle:GetAllSpawnList()
  for i = 1, #c do
    self._puzzles[i]:SetData(i, self._extraMissionID, self._extraMissionIdx, self._cfg_extra_mission.ExtTaskList[i], self._stageIdx, function(idx)
      self:OnPuzzleItemClick(idx)
    end)
  end
end

function UIExtraMissionStageController:OnPuzzleItemClick(idx)
  self._puzzles[self._stageIdx]:Select(false)
  self:RefreshInfo(idx)
  self._puzzles[self._stageIdx]:Select(true)
end

function UIExtraMissionStageController:OnValue()
  self._info = self._module:UI_GetExtTaskDetail(self._extraMissionID, self._stageID)
  self._cfg_extra_mission_task = Cfg.cfg_extra_mission_task[self._stageID]
  if self._cfg_extra_mission_task == nil then
    Log.fatal("###[error] extraMissionStage --> self._cfg_extra_mission_task is nil! stageid --> ", self._stageID)
  end
  self:StageIsDown()
  self:SetInfo()
  self:EnemyInfo()
  self:RecommendLV()
  self:Conditions()
  self:_InitAllAwards()
  self:AwardRed()
end

function UIExtraMissionStageController:StageIsDown()
  local star = self._module:UI_GetExtTaskState(self._extraMissionID, self._stageID)
  self._tongguan:SetActive(0 < star)
end

function UIExtraMissionStageController:AwardRed()
  local red = self._module:UI_GetExtAwardRed(self._extraMissionID)
  self._red:SetActive(red)
end

function UIExtraMissionStageController:SetInfo()
  self._txtDesc:SetText(self._info.m_stDesc)
  self._txtDescRect.anchoredPosition = Vector2(self._txtDescRect.anchoredPosition.x, 0)
  self._txtTitle:SetText(self._info.m_stName)
  self._txtTitleIdx:SetText(self._extraMissionIdx .. "-" .. self._stageIdx)
end

function UIExtraMissionStageController:EnemyInfo()
  local enemy = self._enemyMsg:SpawnObject("UIEnemyMsg")
  enemy:SetData(self._cfg_extra_mission_task.FightLevel)
end

function UIExtraMissionStageController:Conditions()
  if table.count(self._info.m_vecCondition) > 0 then
    self._conditionsGo:SetActive(true)
    self._conditionNo:SetActive(false)
    self._sop:SpawnObjects("UIConditionItem", table.count(self._info.m_vecCondition))
    self._conditions = self._sop:GetAllSpawnList()
    for i, v in ipairs(self._conditions) do
      local condition = StageCondition:New()
      condition:FlushSatisfy(self._info.m_vecCondition[i].m_bPass)
      condition:Init(i, self._info.m_vecCondition[i].m_nID)
      v:Flush(condition, i)
    end
  else
    self._conditionsGo:SetActive(false)
    self._conditionNo:SetActive(true)
  end
end

function UIExtraMissionStageController:RecommendLV()
  local reLV = self._cfg_extra_mission_task.RecommendLV
  local needLV = self._cfg_extra_mission_task.NeedLevel
  local reAwaken = self._cfg_extra_mission_task.RecommendAwaken
  if reAwaken == 0 then
    self._recommendLV.gameObject:SetActive(false)
  else
    self._recommendLV.gameObject:SetActive(true)
    self._recommendLV:SetText(StringTable.Get("str_pet_config_common_advance") .. "<size=29>" .. reAwaken .. "</size>")
  end
  if reLV then
    self._recommendLV2:SetText("LV." .. reLV)
  end
  local lv = self:GetModule(RoleModule):GetLevel()
  if needLV > lv then
    self._reach = false
  else
    self._reach = true
  end
  self._reachGo:SetActive(not self._reach)
  local needPower = self._info.m_nExpendPower
  self._txtCost:SetText(needPower)
end

function UIExtraMissionStageController:RefreshInfo(idx)
  local stagelist = self._cfg_extra_mission.ExtTaskList
  self._stageID = stagelist[idx]
  self._stageIdx = idx
  self:OnValue()
end

function UIExtraMissionStageController:GetStageID()
  local stageid
  local idx = 0
  local extState = self._module:UI_GetExtMissionState(self._extraMissionID)
  local stagelist = self._cfg_extra_mission.ExtTaskList
  if extState == EnumExtMissionState.Down then
    stageid = stagelist[1]
    idx = 1
  else
    for i = 1, #stagelist do
      stageid = stagelist[i]
      idx = i
      local star = self._module:UI_GetExtTaskState(self._extraMissionID, stageid)
      if star <= 0 then
        break
      end
    end
  end
  return stageid, idx
end

function UIExtraMissionStageController:GetStageIdx(stageid)
  local stagelist = self._cfg_extra_mission.ExtTaskList
  for i = 1, #stagelist do
    local stageidT = stagelist[i]
    if stageidT == stageid then
      return i
    end
  end
  return 1
end

function UIExtraMissionStageController:ShowItemTips(itemID, pos)
  self._selectInfo:SetData(itemID, pos)
end

function UIExtraMissionStageController:CancelRedPoint(extid)
  self:AwardRed()
end

function UIExtraMissionStageController:GetComponents()
  self._txtTitleIdx = self:GetUIComponent("UILocalizationText", "txtTitleIdx")
  self._txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._txtDescRect = self:GetUIComponent("RectTransform", "txtDesc")
  self._txtCost = self:GetUIComponent("UILocalizationText", "txtCost")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self._imgThemeLow = self:GetUIComponent("RawImageLoader", "imgThemeLow")
  self._power = self:GetUIComponent("Transform", "power")
  self._powerPool = self:GetUIComponent("UISelectObjectPath", "powerpool")
  local powerPool = self._powerPool:SpawnObject("UIPowerInfo")
  powerPool:SetData(self._power)
  self._recommendLV = self:GetUIComponent("UILocalizationText", "recommendLV")
  self._recommendLV2 = self:GetUIComponent("UILocalizationText", "recommendLV2")
  self._enemyMsg = self:GetUIComponent("UISelectObjectPath", "enemyMsg")
  self._reachGo = self:GetGameObject("reachGo")
  self._puzzle = self:GetUIComponent("UISelectObjectPath", "puzzle")
  self._red = self:GetGameObject("red")
  self._conditionsGo = self:GetGameObject("conditions")
  self._conditionNo = self:GetGameObject("conditionNo")
  self._sop = self:GetUIComponent("UISelectObjectPath", "conditions")
  local itemTips = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._selectInfo = itemTips:SpawnObject("UISelectInfo")
  self._tongguan = self:GetGameObject("tongguan")
  local ltBtns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtn = ltBtns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseController()
  end)
end

function UIExtraMissionStageController:CloseController()
  self:SwitchState(UIStateType.UIExtraMission, self._extraMissionID)
end

function UIExtraMissionStageController:OnHide()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowItemTips)
  self:DetachEvent(GameEventType.CancelRedPoint, self.CancelRedPoint)
end

function UIExtraMissionStageController:InitAwards()
  local awards = self:FormatAwards()
  local count = table.count(awards)
  if count <= 0 then
  end
  local grid = self:GetUIComponent("GridLayoutGroup", "Content")
  local contentSizeFilter = self:GetUIComponent("ContentSizeFitter", "Content")
  local contentRect = self:GetUIComponent("RectTransform", "Content")
  if 6 < count then
    grid.childAlignment = UnityEngine.TextAnchor.MiddleLeft
    contentSizeFilter.enabled = true
  else
    grid.childAlignment = UnityEngine.TextAnchor.MiddleCenter
    contentSizeFilter.enabled = false
  end
  contentRect.localPosition = Vector3(0, 0, 0)
  local sop = self:GetUIComponent("UISelectObjectPath", "Content")
  sop:SpawnObjects("UIAwardItem", count)
  local list = sop:GetAllSpawnList()
  for i, v in ipairs(list) do
    v:Flush(awards[i])
  end
end

function UIExtraMissionStageController:_InitAllAwards()
  return self:InitAwards()
end

function UIExtraMissionStageController:_GetActivityAwardsAndInit()
  self:StartTask(function(TT)
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    local res, rewards = campaignModule:HandleCampaignGetMatchMissionExReward(TT, MatchType.MT_ExtMission, self._stageID)
    if res:GetSucc() then
      local items = {}
      local itemconfig = Cfg.cfg_item
      for i = 1, table.count(rewards) do
        local _data = {}
        _data.id = rewards[i].assetid
        local config = itemconfig[_data.id]
        if config ~= nil then
          _data.icon = config.Icon
          _data.color = config.Color
        end
        _data.type = StageAwardType.Activity
        _data.count = rewards[i].count
        table.insert(items, _data)
      end
      self._activity_rewards = items
    end
    self:InitAwards()
  end, self)
end

function UIExtraMissionStageController:_InsertActivityReward(rewards)
  local count = table.count(self._activity_rewards)
  if count <= 0 then
    return rewards
  end
  table.appendArray(self._activity_rewards, rewards)
  return self._activity_rewards
end

function UIExtraMissionStageController:fightBtnOnClick(go)
  if self._reach == false then
    return
  end
  if not self:IsPowerEnough() then
    self:ShowDialog("UIGetPhyPointController")
    return
  end
  local missionModule = self:GetModule(MissionModule)
  local extMissionData = {
    [1] = self._extraMissionID,
    [2] = self._stageID
  }
  local ctx = missionModule:TeamCtx()
  ctx:Init(TeamOpenerType.ExtMission, extMissionData)
  if DiscoveryStage.IsGuideStageId(self._stageID) then
    self:ShowDialog("UITeamsGuide")
  else
    self:ShowDialog("UITeams")
  end
end

function UIExtraMissionStageController:IsPowerEnough()
  local roleModule = self:GetModule(RoleModule)
  local leftPower = roleModule:GetAssetCount(RoleAssetID.RoleAssetPhyPoint)
  return leftPower >= self._info.m_nExpendPower
end

function UIExtraMissionStageController:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIExtraMissionStageController:bgOnClick()
  self:CloseController()
end

function UIExtraMissionStageController:btnChapterAwardOnClick()
  self:ShowDialog("UIExtraMissionAwardController", self._extraMissionID)
end

function UIExtraMissionStageController:btnPlotOnClick()
  local canReviewStages = {}
  local stages = self:GetAllPassStage()
  for i = 1, #stages do
    local cfg_task = Cfg.cfg_extra_mission_task[stages[i]]
    if cfg_task then
      local curStage = DiscoveryStage:New()
      curStage.id = cfg_task.ExtTaskID
      curStage.longDesc = StringTable.Get(cfg_task.TaskDesc .. "_long")
      curStage.name = StringTable.Get(cfg_task.TaskName)
      curStage.stageIdx = self._extraMissionIdx .. "-" .. i
      local storyList = DiscoveryStoryList:New()
      local slist = {}
      storyList.stageId = cfg_task.ExtTaskID
      local wayPoint = cfg_task.WayPointID
      local cfg_way_point = Cfg.cfg_extra_mission_story[wayPoint]
      for i = 1, #cfg_way_point.StoryID do
        local story = DiscoveryStory:New()
        story:Init(cfg_way_point.StoryID[i], cfg_way_point.StoryActiveType[i])
        table.insert(slist, story)
      end
      storyList.list = slist
      curStage.story = storyList
      table.insert(canReviewStages, curStage)
    end
  end
  if table.count(canReviewStages) <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_extra_mission_public_no_story_review"))
    return
  end
  local tempStage = canReviewStages[1]
  self:ShowDialog("UIPlot", tempStage, canReviewStages, true)
end

function UIExtraMissionStageController:GetAllPassStage()
  local stages = {}
  local tempStages = self._module:UI_GetPassExtTask(self._extraMissionID)
  for i = 1, #tempStages do
    table.insert(stages, tempStages[i])
  end
  return stages
end

function UIExtraMissionStageController:FormatAwards()
  local cfg = Cfg.cfg_extra_mission_task[self._stageID]
  local awards = {}
  if not self:HasPassThreeStar() then
    local awardsStar = self:GetSortedArr(AwardType.ThreeStar, cfg, StageAwardType.Star)
    if awardsStar then
      for i, v in ipairs(awardsStar) do
        awards[#awards + 1] = v
      end
    end
  end
  if not self:HasPassFirst() then
    local awardsFirst = self:GetSortedArr(AwardType.First, cfg, StageAwardType.First)
    if awardsFirst then
      for i, v in ipairs(awardsFirst) do
        awards[#awards + 1] = v
      end
    end
  end
  local normalArr = self:GetSortedArr(AwardType.Pass, cfg, StageAwardType.Normal)
  if normalArr then
    for i, v in ipairs(normalArr) do
      awards[#awards + 1] = v
    end
  end
  return awards
end

function UIExtraMissionStageController:HasPassFirst()
  local star = self._module:UI_GetExtTaskState(self._extraMissionID, self._stageID)
  if star and 0 < star then
    return true
  end
  return false
end

function UIExtraMissionStageController:HasPassThreeStar()
  for index, value in ipairs(self._info.m_vecCondition) do
    if not value.m_bPass then
      return false
    end
  end
  return true
end

function UIExtraMissionStageController:GetSortedArr(awardType, cfg, stageAwardType)
  local list = UICommonHelper:GetInstance():GetDropByAwardType(awardType, cfg)
  local vecSort = SortedArray:New(Algorithm.COMPARE_CUSTOM, UIExtraMissionStageController._LessComparer)
  if list then
    for i, v in ipairs(list) do
      local award = Award:New()
      award:InitWithCount(v.ItemID, v.Count, v.Type)
      award:FlushType(stageAwardType)
      vecSort:Insert(award)
    end
  end
  return vecSort.elements
end

function UIExtraMissionStageController._LessComparer(nItemIDA, nItemIDB)
  return -1
end

function UIExtraMissionStageController:threeStarTipsBtnOnClick(go)
  self:ShowDialog("UIThreeStarTips")
end

function UIExtraMissionStageController:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end
