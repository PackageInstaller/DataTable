_class("UIN12ChallengesContorl", UIController)
UIN12ChallengesContorl = UIN12ChallengesContorl

function UIN12ChallengesContorl:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N12, ECampaignN12ComponentID.ECAMPAIGN_N12_QUEST_MISSION, ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
  end
  self._challengeMissionComponent = self._campaign:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  self._challengeMissionInfo = self._campaign:GetComponentInfo(ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  self._quest_component = self._campaign:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_QUEST_MISSION)
  self._questInfo = self._campaign:GetComponentInfo(ECampaignN12ComponentID.ECAMPAIGN_N12_QUEST_MISSION)
end

function UIN12ChallengesContorl:OnShow(uiParams)
  self:_SetValue(uiParams)
  self:_GetComponents()
  self:_SetShow()
  self:_InitSrollView()
  self:_SetItemDate()
end

function UIN12ChallengesContorl:_SetValue(uiParams)
  self._levelData = uiParams[1]
  self._challenges_task_cfg = Cfg.cfg_n12_challenges_task()
  self._questlist = self._quest_component:GetQuestInfo()
  self._taskCfg = nil
  self._bossCfg = nil
  self._commonTopBtn = nil
  self._btns = {}
  self._items = {}
  self._quest_date_list = {}
  self._curidx = 1
  self._cur_mission = self._challenges_task_cfg[self._curidx].LevelIndex
  self._taskcount = 0
  self._globalDelayTime = 0
  self._firstIn = true
  self._playItemAnimation = true
  self:_SetDate()
end

function UIN12ChallengesContorl:_GetComponents()
  self._bg = self:GetUIComponent("RawImageLoader", "_bg")
  self._cg = self:GetUIComponent("RawImageLoader", "_cg")
  self._cgRaw = self:GetUIComponent("RawImage", "_cg")
  self._scrollview = self:GetUIComponent("UIDynamicScrollView", "_scrollview")
  self._score = self:GetUIComponent("UILocalizationText", "_score")
  self._score_shade = self:GetUIComponent("UILocalizationText", "_score_shade")
  self._animation = self:GetUIComponent("Animation", "UIN12ChallengesContorl")
end

function UIN12ChallengesContorl:_SetDate()
  local indextab = {}
  local index = 0
  for _, task_cfg in pairs(self._challenges_task_cfg) do
    local idtab = {}
    for _, quest_id in pairs(task_cfg.QuestIDs) do
      local quest = self:_CheckTask(quest_id[1])
      if quest then
        table.insert(idtab, quest)
      end
    end
    self._quest_component:SortQuestInfoByCampaignQuestStatus(idtab)
    local dates = {}
    for _, quest in pairs(idtab) do
      local questinfo = quest:QuestInfo()
      local date = {}
      date.quest_id = questinfo.quest_id
      date.score = quest:ParseParams(questinfo.Cond)[2]
      date.rewards = questinfo.rewards
      date.status = quest:Status()
      table.insert(dates, date)
    end
    self._quest_date_list[task_cfg.LevelIndex] = dates
  end
end

function UIN12ChallengesContorl:_CheckTask(quest_id)
  for _, quest in pairs(self._questlist) do
    if quest:ID() == quest_id then
      return quest
    end
  end
end

function UIN12ChallengesContorl:_SetShow()
  self._cg:LoadImage(self._challenges_task_cfg[self._curidx].BoosPicture)
  local cfg_task = Cfg.cfg_n12_challenges_task()[self._curidx]
  self._cgRaw.transform.localPosition = Vector3(cfg_task.Tranceform[1], cfg_task.Tranceform[2], 0)
  self._cgRaw.transform.localScale = Vector3(cfg_task.Tranceform[3], cfg_task.Tranceform[3], 1)
  self:_SetScore(self._challengeMissionInfo.m_max_score[self._curidx])
  local backBtn = self:GetUIComponent("UISelectObjectPath", "_backBtn")
  self._commonTopBtn = backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:CloseDialog()
  end)
  local btns = self:GetUIComponent("UISelectObjectPath", "_btns")
  btns:SpawnObjects("UIN12ChallengesbtnItem", #self._challenges_task_cfg)
  self._btns = btns:GetAllSpawnList()
end

function UIN12ChallengesContorl:_SetItemDate()
  for idx, value in ipairs(self._btns) do
    value:SetData(self._challengeMissionInfo.m_max_score[idx], idx, function(idx)
      self._cgRaw.color = Color(1, 1, 1, 0)
      local cfg_task = Cfg.cfg_n12_challenges_task()[idx]
      self._cgRaw.transform.localPosition = Vector3(cfg_task.Tranceform[1], cfg_task.Tranceform[2], 0)
      self._cgRaw.transform.localScale = Vector3(cfg_task.Tranceform[3], cfg_task.Tranceform[3], 1)
      self._animation:Stop()
      self._animation:Play("uieff_N12_Hard_Challenges_Switch")
      self._curidx = idx
      self._cur_mission = self._challenges_task_cfg[idx].LevelIndex
      self:_RefTask()
      self:_SetScore(self._challengeMissionInfo.m_max_score[idx])
      for _, v in ipairs(self._btns) do
        v:SetSelect(false)
      end
      self._btns[idx]:SetSelect(true)
      self._cg:LoadImage(self._challenges_task_cfg[self._curidx].BoosPicture)
    end, self._levelData[idx], self._curidx)
  end
end

function UIN12ChallengesContorl:_InitSrollView()
  self:_GetTaskNum(self._curidx)
  self._scrollview:InitListView(self._taskcount, function(scrollView, idx)
    return self:_InitSpritListInfo(scrollView, idx)
  end, self:_GetScrollViewParam())
  self._firstIn = false
end

function UIN12ChallengesContorl:_GetScrollViewParam()
  local param = UIDynamicScrollViewInitParam:New()
  param.mItemDefaultWithPaddingSize = 150
  return param
end

function UIN12ChallengesContorl:_InitSpritListInfo(scrollView, idx)
  if idx < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIN12ChallengsTaskItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local taskItem = rowList[1]
  local itemidx = idx
  if itemidx > self._taskcount then
    taskItem:GetGameObject():SetActive(false)
  else
    self:_ShowTaskItem(taskItem, itemidx)
    self._items[itemidx] = taskItem
  end
  return item
end

function UIN12ChallengesContorl:_ShowTaskItem(taskItem, idx)
  local date = self._quest_date_list[self._cur_mission][idx + 1]
  taskItem:GetGameObject():SetActive(true)
  if date ~= nil then
    taskItem:SetData(self._campaign, date, self._levelData[self._curidx], idx, function(deltaTime)
      return self:_GlobalDelayTimeFunc(deltaTime)
    end)
  end
end

function UIN12ChallengesContorl:_GlobalDelayTimeFunc(deltaTime)
  if not self._playItemAnimation then
    return -1
  end
  local delayTime = self._globalDelayTime
  self._globalDelayTime = self._globalDelayTime + deltaTime
  return delayTime
end

function UIN12ChallengesContorl:_SetScore(score)
  self._score:SetText(score)
  self._score_shade:SetText(score)
end

function UIN12ChallengesContorl:_GetTaskNum(idx)
  self._taskcount = #self._quest_date_list[self._cur_mission]
end

function UIN12ChallengesContorl:_RefTask()
  self._globalDelayTime = 0
  local idx = self._curidx
  self._items = {}
  self:_GetTaskNum(idx)
  self._scrollview:SetListItemCount(self._taskcount)
  self._scrollview:MovePanelToItemIndex(0, 0)
end

function UIN12ChallengesContorl.SetIconGrey(objs, gray)
  if not objs then
    return
  end
  for _, obj in pairs(objs) do
    local rawimg = obj.gameObject:GetComponent("RawImage")
    local emiMat = UnityEngine.Material:New(rawimg.material)
    local texture = rawimg.material.mainTexture
    rawimg.material = emiMat
    rawimg.material.mainTexture = texture
    rawimg.material:SetFloat("_LuminosityAmount", gray)
  end
end
