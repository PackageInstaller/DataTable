_class("UITowerPassAwardEntrance", UICustomWidget)
UITowerPassAwardEntrance = UITowerPassAwardEntrance

function UITowerPassAwardEntrance:Constructor()
  self._questModule = self:GetModule(QuestModule)
end

function UITowerPassAwardEntrance:OnShow(uiParams)
  self:_GetComponents()
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
end

function UITowerPassAwardEntrance:AfterUILayerChanged()
  self:_SetUIInfo()
end

function UITowerPassAwardEntrance:_GetComponents()
  self._nameGO = self:GetGameObject("Name")
  self._lineGO = self:GetGameObject("Line")
  self._progressGO = self:GetGameObject("Progress")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._progress = self:GetUIComponent("UILocalizationText", "Progress")
  self._allGotGO = self:GetGameObject("AllGot")
  self._redPointGO = self:GetGameObject("RedPoint")
  self._Icon = self:GetUIComponent("RawImageLoader", "Icon")
end

function UITowerPassAwardEntrance:SetData()
  self._allQuests = self._questModule:GetQuestByQuestType(QuestType.QT_Tower)
  table.sort(self._allQuests, function(a, b)
    local questInfoa = a:QuestInfo()
    local questInfob = b:QuestInfo()
    return questInfoa.quest_id < questInfob.quest_id
  end)
  self:_SetUIInfo()
end

function UITowerPassAwardEntrance:EntrancsBtnOnClick(go)
  self:ShowDialog("UITowerPassAward", self._allQuests, self._topIndex)
end

function UITowerPassAwardEntrance:_SetUIInfo()
  local curQuestInfo, lastQuestInfo
  self._topIndex = nil
  for i, quest in ipairs(self._allQuests) do
    local questInfo = quest:QuestInfo()
    lastQuestInfo = questInfo
    if questInfo.status ~= QuestStatus.QUEST_Taken then
      curQuestInfo = questInfo
      self._topIndex = i - 1
      break
    end
  end
  if curQuestInfo then
    self._nameGO:SetActive(true)
    self._lineGO:SetActive(true)
    self._progressGO:SetActive(true)
    self._allGotGO:SetActive(false)
    if curQuestInfo.status == QuestStatus.QUEST_Completed then
      self._name:SetText(StringTable.Get(curQuestInfo.QuestName))
      self._progress:SetText(StringTable.Get("str_tower_pass_award_canget"))
      self._redPointGO:SetActive(true)
    elseif curQuestInfo.status == QuestStatus.QUEST_NotStart or curQuestInfo.status == QuestStatus.QUEST_Accepted then
      self._name:SetText(StringTable.Get(curQuestInfo.QuestName))
      self._progress:SetText(curQuestInfo.cur_progress .. "/" .. curQuestInfo.total_progress)
      self._redPointGO:SetActive(false)
    end
    self:_SetIcon(curQuestInfo)
  else
    self:_SetIcon(lastQuestInfo)
    self._nameGO:SetActive(false)
    self._lineGO:SetActive(false)
    self._progressGO:SetActive(false)
    self._allGotGO:SetActive(true)
    self._redPointGO:SetActive(false)
  end
end

function UITowerPassAwardEntrance:_SetIcon(questInfo)
  if questInfo then
    local reward = questInfo.rewards[1]
    if reward then
      local cfg = Cfg.cfg_item[reward.assetid]
      if cfg then
        self._Icon:LoadImage(cfg.Icon)
      end
    end
  end
end
