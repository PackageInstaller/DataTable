_class("UISpecialTaskV3Cell", UICustomWidget)
UISpecialTaskV3Cell = UISpecialTaskV3Cell

function UISpecialTaskV3Cell:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UISpecialTaskV3Cell:OnShow(uiParams)
  self:_GetComponents()
end

function UISpecialTaskV3Cell:OnHide()
  if self._cdTask then
    GameGlobal.TaskManager():KillTask(self._cdTask)
    self._cdTask = nil
  end
end

function UISpecialTaskV3Cell:_GetComponents()
  self._descRollText = self:GetUIComponent("UILocalizationText", "Desc")
  self._progress = self:GetUIComponent("UILocalizationText", "Progress")
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._lockGo = self:GetGameObject("Lock")
  self._lockText = self:GetUIComponent("UILocalizationText", "LockText")
  self._selectedGo = self:GetGameObject("Selected")
  self._gotGo = self:GetGameObject("Got")
  self._doingBtn = self:GetGameObject("DoingBtn")
  self._getBtn = self:GetGameObject("GetBtn")
  self._gotBtn = self:GetGameObject("GotBtn")
  self._daily = self:GetGameObject("daily")
  self._notdaily = self:GetGameObject("notdaily")
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
end

function UISpecialTaskV3Cell:SetDaily()
  local cfg = Cfg.cfg_component_quest({
    QuestID = self._questInfo.quest_id
  })
  if cfg and next(cfg) then
    local daily = cfg[1].NeedReset or false
    local finish = self._state == QuestStatus.QUEST_Taken
    self._daily:SetActive(daily and not finish)
    self._notdaily:SetActive(not daily and not finish)
  end
end

function UISpecialTaskV3Cell:SetData(component, quest, callback, showTips, refreshUI, errorCheck)
  self._questComponent = component
  self._questComponentInfo = self._questComponent:GetComponentInfo()
  self._quest = quest
  self._callback = callback
  self._showTips = showTips
  self._refreshUI = refreshUI
  self._errorCheck = errorCheck
  self._questInfo = self._quest:QuestInfo()
  self._state = self._quest:Status()
  self._campaignQuestState = self._questComponent:CheckCampaignQuestStatus(self._questInfo)
  self:_SetLock(self._campaignQuestState == CampaignQuestStatus.CQS_NotStart)
  local descStr = StringTable.Get(self._questInfo.QuestDesc)
  local progressStr = self._questInfo.cur_progress
  if self._cdTask then
    GameGlobal.TaskManager():KillTask(self._cdTask)
    self._cdTask = nil
  end
  if self._campaignQuestState == CampaignQuestStatus.CQS_NotStart then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local timeInfo = self._questComponentInfo.m_quest_time_param_map[self._questInfo.quest_id]
    local remainTime = timeInfo.m_open_time - curTime
    local unlockTime = UISpecialTaskToolFunctions.GetRemainTime(remainTime)
    self._lockText:SetText(StringTable.Get("str_n24_specialtask_unlock", unlockTime))
    self._cdTask = self:StartTask(function(TT)
      YIELD(TT, (remainTime + 1) * 1000)
      if self._refreshUI then
        self._refreshUI()
      end
    end, self)
  end
  if self._state == QuestStatus.QUEST_Accepted then
    progressStr = StringTable.Get("str_sakura_specialtask_progress", progressStr .. "/" .. self._questInfo.total_progress)
    self._doingBtn:SetActive(true)
    self._getBtn:SetActive(false)
    self._gotBtn:SetActive(false)
  elseif self._state == QuestStatus.QUEST_Completed then
    progressStr = StringTable.Get("str_sakura_specialtask_progress", progressStr .. "/" .. self._questInfo.total_progress)
    self._doingBtn:SetActive(false)
    self._getBtn:SetActive(true)
    self._gotBtn:SetActive(false)
  elseif self._state == QuestStatus.QUEST_Taken then
    progressStr = StringTable.Get("str_sakura_specialtask_progress", self._questInfo.cur_progress .. "/" .. self._questInfo.total_progress)
    self._doingBtn:SetActive(false)
    self._getBtn:SetActive(false)
    self._gotBtn:SetActive(true)
  end
  self._descRollText:SetText(descStr)
  self._progress:SetText(progressStr)
  self._gotGo:SetActive(self._state == QuestStatus.QUEST_Taken)
  self._questID = self._questInfo.quest_id
  local cfg_vice_awards = Cfg.cfg_activity_vice_quest_rewards_view[self._questID]
  local item = cfg_vice_awards.AwardsView
  local count = #item
  if count <= 0 then
    return
  end
  if count <= 2 then
    self._scrollRect.horizontal = false
  else
    self._scrollRect.horizontal = true
  end
  self._content:SpawnObjects("UISpecialTaskV3Award", count)
  local items = self._content:GetAllSpawnList()
  for i = 1, count do
    items[i]:SetData(item[i], self._showTips, self._campaignQuestState == CampaignQuestStatus.CQS_NotStart)
  end
  self:SetDaily()
end

function UISpecialTaskV3Cell:_SetLock(isLock)
  self._lockGo:SetActive(isLock)
  self:GetGameObject("ScrollView"):SetActive(not isLock)
  self:GetGameObject("Desc"):SetActive(not isLock)
end

function UISpecialTaskV3Cell:GetOnClick(go)
  if self._state == QuestStatus.QUEST_Completed then
    GameGlobal.TaskManager():StartTask(self.GetAwards, self)
  end
  self:OnSelect(true)
  self._callback(self)
end

function UISpecialTaskV3Cell:OnSelect(select)
end

function UISpecialTaskV3Cell:GetAwards(TT)
  self:Lock("UISpecialTaskV3CellGetAwards")
  local res = AsyncRequestRes:New()
  local retCode, rewards = self._questComponent:HandleQuestTake(TT, res, self._quest:ID())
  if retCode == QuestErrorCode.QuestEC_Succ then
    self:ShowRewards(rewards)
  elseif self._errorCheck then
    self._errorCheck(res.m_result)
  end
  self:UnLock("UISpecialTaskV3CellGetAwards")
end

function UISpecialTaskV3Cell:ShowRewards(rewards)
  local petIdList = {}
  local petModule = GameGlobal.GetModule(PetModule)
  for _, reward in pairs(rewards) do
    if petModule:IsPetID(reward.assetid) then
      table.insert(petIdList, reward)
    end
  end
  if table.count(petIdList) > 0 then
    self:ShowDialog("UIPetObtain", petIdList, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      self:ShowDialog("UIGetItemController", rewards)
    end)
    return
  end
  self:ShowDialog("UIGetItemController", rewards)
end

function UISpecialTaskV3Cell:PlayAnimationInSequence(index)
  local delay = 0 + (index - 1) * 50
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", "uieff_UISpecialTaskCell_in", delay)
end
