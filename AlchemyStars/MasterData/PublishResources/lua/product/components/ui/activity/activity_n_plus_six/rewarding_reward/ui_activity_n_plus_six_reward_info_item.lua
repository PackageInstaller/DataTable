_class("UIActivityNPlusSixRewardInfoItem", UICustomWidget)
UIActivityNPlusSixRewardInfoItem = UIActivityNPlusSixRewardInfoItem

function UIActivityNPlusSixRewardInfoItem:OnShow()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._go = self:GetGameObject("Go")
  self._getBtn = self:GetGameObject("GetBtn")
  self._hasGet = self:GetGameObject("HasGet")
  self._unComplete = self:GetGameObject("UnComplete")
  self._contents = self:GetUIComponent("UISelectObjectPath", "Content")
  self._des = self:GetUIComponent("UILocalizationText", "Des")
  self._desRollingText = self:GetUIComponent("RollingText", "Des")
  self._selectBtGo = self:GetGameObject("SelectedBtn")
  self._selectedGo = self:GetGameObject("Selected")
end

function UIActivityNPlusSixRewardInfoItem:Refresh(quest, questComponent, rewardController)
  self._rewardController = rewardController
  self._questComponent = questComponent
  self._quest = quest
  self._go:SetActive(true)
  local questInfo = self._quest:QuestInfo()
  local status = self._quest:Status()
  self._name:SetText(StringTable.Get(questInfo.QuestName))
  self._des:SetText(StringTable.Get(questInfo.QuestDesc))
  self._desRollingText:RefreshText(StringTable.Get(questInfo.QuestDesc))
  if status == QuestStatus.QUEST_NotStart or status == QuestStatus.QUEST_Accepted then
    self._getBtn:SetActive(false)
    self._hasGet:SetActive(false)
    self._unComplete:SetActive(true)
    self._selectBtGo:SetActive(true)
  elseif status == QuestStatus.QUEST_Completed then
    self._getBtn:SetActive(true)
    self._hasGet:SetActive(false)
    self._unComplete:SetActive(false)
    self._selectBtGo:SetActive(false)
  elseif status == QuestStatus.QUEST_Taken then
    self._getBtn:SetActive(false)
    self._hasGet:SetActive(true)
    self._unComplete:SetActive(false)
    self._selectBtGo:SetActive(true)
  end
  self._rewards = questInfo.rewards
  self._contents:SpawnObjects("UIActivityNPlusSixRewardItem", #self._rewards)
  local items = self._contents:GetAllSpawnList()
  for i = 1, #self._rewards do
    items[i]:Refresh(self._rewards[i], status == QuestStatus.QUEST_Taken)
  end
  self._selectedGo:SetActive(false)
end

function UIActivityNPlusSixRewardInfoItem:GetQuest()
  return self._quest
end

function UIActivityNPlusSixRewardInfoItem:SetSelectStatus(selected)
  self._selectedGo:SetActive(false)
end

function UIActivityNPlusSixRewardInfoItem:SelectedBtnOnClick()
  self._rewardController:SelectRewardItem(self._quest)
end

function UIActivityNPlusSixRewardInfoItem:GetBtnOnClick()
  GameGlobal.TaskManager():StartTask(self.GetRewards, self)
end

function UIActivityNPlusSixRewardInfoItem:GetRewards(TT)
  self:Lock("UIActivityNPlusSixRewardInfoItem_GetRewards")
  local res = AsyncRequestRes:New()
  local ret, rewards = self._questComponent:HandleQuestTake(TT, res, self._quest:ID())
  if ret == 0 then
    self:ShowRewards(rewards)
  else
    Log.error("GetRewards error")
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.NPlusSixBuildingRewardGet)
  self:UnLock("UIActivityNPlusSixRewardInfoItem_GetRewards")
end

function UIActivityNPlusSixRewardInfoItem:ShowRewards(rewards)
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
