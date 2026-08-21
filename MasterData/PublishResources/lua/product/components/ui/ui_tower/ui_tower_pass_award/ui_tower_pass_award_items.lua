_class("UITowerPassAwardItems", UICustomWidget)
UITowerPassAwardItems = UITowerPassAwardItems

function UITowerPassAwardItems:OnShow(uiParams)
  self._atlas = self:GetAsset("UITowerPassAward.spriteatlas", LoadType.SpriteAtlas)
  self._questModule = self:GetModule(QuestModule)
  self:_GetComponents()
end

function UITowerPassAwardItems:_GetComponents()
  self._condition = self:GetUIComponent("UILocalizationText", "Condition")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._getBtnGO = self:GetGameObject("GetBtn")
  self._getBtn = self:GetUIComponent("Image", "GetBtn")
  self._getButton = self:GetUIComponent("Button", "GetBtn")
  self._getBtnImg = self:GetUIComponent("Image", "GetBtnImg")
  self._getBtnText = self:GetUIComponent("UILocalizationText", "GetBtnText")
  self._progressGO = self:GetGameObject("Progress")
  self._progressText = self:GetUIComponent("UILocalizationText", "ProgressText")
  self._progressValue = self:GetUIComponent("Image", "ProgressValue")
end

function UITowerPassAwardItems:SetData(quest, index, callBack)
  self._questInfo = quest:QuestInfo()
  self._index = index
  self._tipsCallBack = callBack
  self._rewards = self._questInfo.rewards
  self._content:SpawnObjects("UITowerPassAwardItem", #self._rewards)
  local widgets = self._content:GetAllSpawnList()
  for i, widget in ipairs(widgets) do
    widget:SetData(self._rewards[i], function(id, pos)
      self:ShowTips(id, pos)
    end)
  end
  self._condition:SetText(StringTable.Get(self._questInfo.CondDesc))
  self:_SetUIInfo()
end

function UITowerPassAwardItems:_SetUIInfo()
  if self._questInfo.status == QuestStatus.QUEST_NotStart or self._questInfo.status == QuestStatus.QUEST_Accepted then
    self._getBtnGO:SetActive(false)
    self._progressGO:SetActive(true)
    self._progressText:SetText(self._questInfo.cur_progress .. "/" .. self._questInfo.total_progress)
    self._progressValue.fillAmount = self._questInfo.cur_progress / self._questInfo.total_progress
  elseif self._questInfo.status == QuestStatus.QUEST_Completed then
    self._getBtnGO:SetActive(true)
    self._getBtnText:SetText(StringTable.Get("str_tower_pass_award_get"))
    self._getBtnText.color = Color(0.1803921568627451, 0.1803921568627451, 0.1803921568627451)
    self._getBtnImg.sprite = self._atlas:GetSprite("tower_jl_btn2")
    self._getButton.interactable = true
    self._progressGO:SetActive(false)
  elseif self._questInfo.status == QuestStatus.QUEST_Taken then
    self._getBtnGO:SetActive(true)
    self._getBtnText:SetText(StringTable.Get("str_tower_pass_award_got"))
    self._getBtnText.color = Color.white
    self._getBtnImg.sprite = self._atlas:GetSprite("tower_jl_btn3")
    self._getButton.interactable = false
    self._progressGO:SetActive(false)
  end
end

function UITowerPassAwardItems:GetBtnOnClick(go)
  self:Lock("UITowerPassAwardItems_GetQuestRewards")
  self:StartTask(self._GetQuestRewards, self)
end

function UITowerPassAwardItems:ShowTips(id, pos)
  self._tipsCallBack(id, pos)
end

function UITowerPassAwardItems:_GetQuestRewards(TT)
  local res, msg = self._questModule:TakeQuestReward(TT, self._questInfo.quest_id)
  self:UnLock("UITowerPassAwardItems_GetQuestRewards")
  if res:GetSucc() and msg.rewards then
    self:ShowDialog("UIGetItemController", msg.rewards, function()
      local quest = self._questModule:GetQuest(self._questInfo.quest_id)
      self._questInfo = quest:QuestInfo()
      self:_SetUIInfo()
    end)
  end
end
