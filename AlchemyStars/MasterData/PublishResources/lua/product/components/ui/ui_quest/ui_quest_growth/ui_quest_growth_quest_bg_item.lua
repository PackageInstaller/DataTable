_class("UIQuestGrowthQuestBGItem", UICustomWidget)
UIQuestGrowthQuestBGItem = UIQuestGrowthQuestBGItem

function UIQuestGrowthQuestBGItem:OnShow()
  self._questList = self:GetUIComponent("UISelectObjectPath", "item")
  self._awardFinishTex = self:GetUIComponent("UILocalizationText", "awardFinishTex")
  self._closeTex = self:GetUIComponent("UILocalizationText", "closeTex")
  self._awardImgNotFinish = self:GetGameObject("imgAwardNotFinish")
  self._awardImgAcceptable = self:GetGameObject("imgAwardAcceptable")
  self._awardImgAccepted = self:GetGameObject("imgAwardAccepted")
  self._questModule = GameGlobal.GetModule(QuestModule)
end

function UIQuestGrowthQuestBGItem:OnHide()
end

function UIQuestGrowthQuestBGItem:Flush(TT, idx, datas, RefrenshList, anim)
  self.view:GetGameObject().name = idx - 1
  self._questList:AsyncSpawnObjects(TT, "UIQuestGrowthQuestItem", 3)
  local quests = self._questList:GetAllSpawnList()
  for index, quest in ipairs(quests) do
    local i = (idx - 1) * 3 + index
    local data = datas[i]
    if data then
      quest:SetData(i, data, nil, anim)
    else
      Log.fatal("### no data in datas. i=", i)
    end
  end
  local gridCount = 9
  local i = idx + gridCount
  local data = datas[i]
  if data then
    self._awardQuest = data:QuestInfo()
    self._getState = self._awardQuest.status
    local progress = ""
    if self._awardQuest.ShowType == 1 then
      local c, d = math.modf(self._awardQuest.cur_progress * 100 / self._awardQuest.total_progress)
      if c < 1 and 0 < d then
        c = 1
      end
      progress = c .. "%"
    else
      progress = self._awardQuest.cur_progress .. "/" .. self._awardQuest.total_progress
    end
    self._awardFinishTex:SetText(progress)
    self._awardImgNotFinish:SetActive(false)
    self._awardImgAcceptable:SetActive(false)
    self._awardImgAccepted:SetActive(false)
    if self._getState <= QuestStatus.QUEST_Accepted then
      self._closeTex:SetText(StringTable.Get("str_quest_base_un_open"))
      self._awardImgNotFinish:SetActive(true)
    elseif self._getState == QuestStatus.QUEST_Completed then
      self._closeTex:SetText(StringTable.Get("str_quest_base_can_get"))
      self._awardImgAcceptable:SetActive(true)
    elseif self._getState == QuestStatus.QUEST_Taken then
      self._closeTex:SetText(StringTable.Get("str_quest_base_got"))
      self._awardImgAccepted:SetActive(true)
    else
      Log.fatal("### UIQuestGrowthAwardItem")
    end
  end
end

function UIQuestGrowthQuestBGItem:BtnAwardOnClick()
  if self._getState <= QuestStatus.QUEST_Accepted then
    self:ShowDialog("UIQuestAwardsInfoController", self._awardQuest.rewards)
  elseif self._getState == QuestStatus.QUEST_Completed then
    GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
    self:Lock("UIQuestGet")
    GameGlobal.TaskManager():StartTask(self._OnbgOnClick, self)
  elseif self._getState == QuestStatus.QUEST_Taken then
    self:ShowDialog("UIQuestAwardsInfoController", self._awardQuest.rewards)
  end
end

function UIQuestGrowthQuestBGItem:_OnbgOnClick(TT)
  if self._questModule == nil then
    Log.fatal("[quest] error --> questModule is nil !")
    return
  end
  local res, msg = self._questModule:TakeQuestReward(TT, self._awardQuest.quest_id)
  self:UnLock("UIQuestGet")
  if self.uiOwner == nil then
    return
  end
  if res:GetSucc() then
    local tempPets = {}
    local pets = msg.rewards
    self._tempMsgRewards = msg.rewards
    if 0 < #pets then
      for i = 1, #pets do
        local ispet = GameGlobal.GetModule(PetModule):IsPetID(pets[i].assetid)
        if ispet then
          table.insert(tempPets, pets[i])
        end
      end
    end
    if 0 < #tempPets then
      self:ShowDialog("UIPetObtain", tempPets, function()
        GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, QuestType.QT_Growth + 10000)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Growth + 10000)
      end)
    end
  end
end
