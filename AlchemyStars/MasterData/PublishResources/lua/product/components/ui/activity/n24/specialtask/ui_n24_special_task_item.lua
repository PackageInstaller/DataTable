_class("UIN24SpecialTaskItem", UICustomWidget)
UIN24SpecialTaskItem = UIN24SpecialTaskItem

function UIN24SpecialTaskItem:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
end

function UIN24SpecialTaskItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIN24.spriteatlas", LoadType.SpriteAtlas)
  self:_GetComponents()
end

function UIN24SpecialTaskItem:_GetComponents()
  self._descRollText = self:GetUIComponent("RollingText", "Desc")
  self._progress = self:GetUIComponent("UILocalizationText", "Progress")
  self._stateImg = self:GetUIComponent("Image", "State")
  self._stateGo = self:GetGameObject("State")
  self._redPoint = self:GetGameObject("RedPoint")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._lockGo = self:GetGameObject("Lock")
  self._lockText = self:GetUIComponent("UILocalizationText", "LockText")
  self._selectedGo = self:GetGameObject("Selected")
  self._gotGo = self:GetGameObject("Got")
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
end

function UIN24SpecialTaskItem:SetData(component, quest, callback, showTips)
  self._questComponent = component
  self._questComponentInfo = self._questComponent:GetComponentInfo()
  self._quest = quest
  self._callback = callback
  self._showTips = showTips
  self._questInfo = self._quest:QuestInfo()
  self._state = self._quest:Status()
  self._campaignQuestState = self._questComponent:CheckCampaignQuestStatus(self._questInfo)
  self._lockGo:SetActive(self._campaignQuestState == CampaignQuestStatus.CQS_NotStart)
  self._stateGo:SetActive(self._state ~= QuestStatus.QUEST_NotStart)
  local descStr = StringTable.Get(self._questInfo.QuestDesc)
  local progressStr = self._questInfo.cur_progress
  if self._campaignQuestState == CampaignQuestStatus.CQS_NotStart then
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local timeInfo = self._questComponentInfo.m_quest_time_param_map[self._questInfo.quest_id]
    local remainTime = timeInfo.m_open_time - curTime
    local unlockTime = UIN24SpecialTaskToolFunctions.GetRemainTime(remainTime)
    self._lockText:SetText(StringTable.Get("str_n24_specialtask_unlock", unlockTime))
  end
  if self._state == QuestStatus.QUEST_Accepted then
    self._stateImg.sprite = self._atlas:GetSprite("n24_tasksp_icon03")
    descStr = "<color=#DCC9B3>" .. descStr .. "</color>"
    progressStr = "<color=#FF7676>" .. self._questInfo.cur_progress .. "</color>"
  elseif self._state == QuestStatus.QUEST_Completed then
    self._stateImg.sprite = self._atlas:GetSprite("n24_tasksp_icon02")
    descStr = "<color=#FEF2E0>" .. descStr .. "</color>"
    progressStr = "<color=#FF9000>" .. self._questInfo.cur_progress .. "</color>"
  elseif self._state == QuestStatus.QUEST_Taken then
    self._stateImg.sprite = self._atlas:GetSprite("n24_tasksp_icon01")
  end
  self._descRollText:RefreshText(descStr)
  self._progress:SetText(StringTable.Get("str_n24_specialtask_progress", progressStr .. "/" .. self._questInfo.total_progress))
  self._redPoint:SetActive(self._state == QuestStatus.QUEST_Completed)
  self._gotGo:SetActive(self._state == QuestStatus.QUEST_Taken)
  local count = #self._questInfo.rewards
  if count <= 0 then
    return
  end
  if count <= 2 then
    self._scrollRect.horizontal = false
  else
    self._scrollRect.horizontal = true
  end
  self._content:SpawnObjects("UIN24SpecialTaskAwardItem", count)
  local items = self._content:GetAllSpawnList()
  for i = 1, count do
    local cfg = Cfg.cfg_item[self._questInfo.rewards[i].assetid]
    if cfg then
      items[i]:SetData(self._questInfo.rewards[i], self._showTips, self._campaignQuestState == CampaignQuestStatus.CQS_NotStart)
    end
  end
end

function UIN24SpecialTaskItem:BackgroundOnClick(go)
  if self._state == QuestStatus.QUEST_Completed then
    GameGlobal.TaskManager():StartTask(self.GetAwards, self)
  end
  self:OnSelect(true)
  self._callback(self)
end

function UIN24SpecialTaskItem:OnSelect(select)
  self._selectedGo:SetActive(select)
end

function UIN24SpecialTaskItem:GetAwards(TT)
  self:Lock("UIN24SpecialTaskItemGetAwards")
  local res = AsyncRequestRes:New()
  local retCode, rewards = self._questComponent:HandleQuestTake(TT, res, self._quest:ID())
  if retCode == QuestErrorCode.QuestEC_Succ then
    self:ShowRewards(rewards)
    local questModule = GameGlobal.GetModule(QuestModule)
    self._quest = questModule:GetQuest(self._quest:ID())
    self:SetData(self._questComponent, self._quest, self._callback)
  else
    self.uiOwner:CloseDialog()
  end
  self:UnLock("UIN24SpecialTaskItemGetAwards")
end

function UIN24SpecialTaskItem:ShowRewards(rewards)
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
