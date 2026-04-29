_class("UIQuestStoryDetailItem", UICustomWidget)
UIQuestStoryDetailItem = UIQuestStoryDetailItem

function UIQuestStoryDetailItem:OnShow(uiParams)
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvents()
  self._Animation = self:GetUIComponent("Animation", "UIQuestStoryDetailItem")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "UIQuestStoryDetailItem")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:OnClose()
  end, nil)
  self._backBtnsGo = self:GetGameObject("backBtns")
  self._bgGo = self:GetGameObject("bg")
end

function UIQuestStoryDetailItem:OnClose()
  self:AnimatedHide()
  if self._closeCb then
    self._closeCb()
  end
end

function UIQuestStoryDetailItem:AnimatedHide()
  self._backBtnsGo:SetActive(false)
  self._bgGo:SetActive(false)
  self._Animation:Play("uieff_Quest_StoryDetailItem_Out")
  self._canvasGroup.blocksRaycasts = false
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIQuestStoryDetailClosed)
end

function UIQuestStoryDetailItem:SetData(idx, currentChapterIndex, tweenCallBack, refrenshCb, closeCb)
  self._backBtnsGo:SetActive(true)
  self._bgGo:SetActive(true)
  self._canvasGroup.blocksRaycasts = true
  self._Animation:Play("uieff_Quest_StoryDetailItem_In")
  self:_GetComponents()
  self._index = idx
  self._callback = tweenCallBack
  self._currentChapterIndex = currentChapterIndex
  self._refrenshCb = refrenshCb
  self._closeCb = closeCb
  self._questModule = GameGlobal.GetModule(QuestModule)
  if self._questModule == nil then
    Log.fatal("[quest] error --> questModule is nil !")
    return
  end
  local chapter_cfg = Cfg.cfg_chapter({})
  if chapter_cfg == nil then
    Log.fatal("[quest] error --> cfg_chapter is nil !")
    return
  end
  self._cfg_chapter = chapter_cfg[self._index]
  if self._cfg_chapter == nil then
    Log.fatal("[quest] error --> cfg_chapter is nil ! index--> " .. self._index)
    return
  end
  self._allCount = table.count(chapter_cfg)
  self:_GetCurrentQuest()
  self:_GetChaperState()
  self:_OnValue()
end

function UIQuestStoryDetailItem:QuestUpdate()
  local id = self._quest.quest_id
  self._quest = self._questModule:GetQuest(id):QuestInfo()
  self:_FlushQuestInfo()
end

function UIQuestStoryDetailItem:RefrenshInfo()
  local finish = self._questModule:GetChapterQuestsFinish(self._index)
  if finish == true then
    if self._index >= self._allCount then
      self._tweenText:SetText(StringTable.Get("str_quest_base_story_all_chapter_clean"))
      self:_ShowTextTween(true)
    else
      self._tweenText:SetText(StringTable.Get("str_quest_base_story_current_chapter_clean"))
      self:_ShowTextTween(false)
    end
    return
  end
  self:_GetCurrentQuest()
  self:_GetChaperState()
  self:_OnValue()
end

function UIQuestStoryDetailItem:_ShowTextTween(isLast)
  self:Lock("UIQusetStoryChapterFinishTween")
  self._tweenAnim:Play()
  GameGlobal.Timer():AddEvent(1267, function()
    self:UnLock("UIQusetStoryChapterFinishTween")
    if isLast == false then
      if self._callback then
        self._callback(self._index)
      end
      self:OnClose()
    else
      self._taskGotoGo:SetActive(false)
      self._finishGo:SetActive(true)
      self._getGo:SetActive(false)
    end
  end)
end

function UIQuestStoryDetailItem:_GetCurrentQuest()
  self._quest = nil
  local questList = self._questModule:GetChapterQuests(self._index)
  for i = 1, table.count(questList) do
    self._quest = questList[i]:QuestInfo()
    if self._quest == nil then
      Log.fatal("[quest] error --> quest is nil ! id --> " .. self._quest.quest_id)
      return
    end
    if self._quest.status ~= QuestStatus.QUEST_Taken then
      return
    end
  end
end

function UIQuestStoryDetailItem:_GetChaperState()
  self._chapterState = QuestStatus.QUEST_Taken
  if self._index < self._currentChapterIndex then
    self._chapterState = QuestStatus.QUEST_Taken
  else
    self._chapterState = QuestStatus.QUEST_Accepted
  end
  self._redState = 0
  do return end
  local questList = self._questModule:GetChapterQuests(self._index)
  for i = 1, table.count(questList) do
    local quest = questList[i]:QuestInfo()
    if quest == nil then
      Log.fatal("[quest] error --> quest is nil ! id --> " .. quest.quest_id)
      return
    end
    if quest.status <= QuestStatus.QUEST_Accepted then
      self._redState = 1
    end
    if quest.status <= QuestStatus.QUEST_Accepted then
      self._state = 0
    end
  end
end

function UIQuestStoryDetailItem:OnHide()
  self._detailIsOpen = false
  self:RemoveEvents()
end

function UIQuestStoryDetailItem:_GetComponents()
  self._chapterCgImg = self:GetUIComponent("RawImageLoader", "chapterCgImg")
  self._chapterNameTex = self:GetUIComponent("UILocalizationText", "chapterNameTex")
  self._taskDesTex = self:GetUIComponent("UILocalizationText", "taskDesTex")
  self._taskTargetTex = self:GetUIComponent("UILocalizationText", "taskTargetTex")
  self._taskTargetStateTex = self:GetUIComponent("UILocalizationText", "taskTargetStateTex")
  self._taskGotoGo = self:GetGameObject("taskGoto")
  self._finishGo = self:GetGameObject("taskFinish")
  self._getGo = self:GetGameObject("taskGet")
  self._tweenText = self:GetUIComponent("UILocalizationText", "tweenText")
  self._tweenGo = self:GetGameObject("tweenGo")
  self._tweenRect = self:GetUIComponent("RectTransform", "tweenGo")
  self._tweenAnim = self:GetUIComponent("Animation", "tweenGo")
  self._tweenGoAlpha = self:GetUIComponent("CanvasGroup", "tweenGo")
  self:_InitTwwenText()
  self._taskAwardListPool = self:GetUIComponent("UISelectObjectPath", "taskAwardListPool")
  self._taskAwardListPoolAlpha = self:GetUIComponent("CanvasGroup", "taskAwardListPool")
  self.taskStateImgGoto = self:GetUIComponent("Image", "taskStateImgGoto")
  self.taskStateTex = self:GetUIComponent("UILocalizationText", "taskStateTex")
  self.taskStateImgGotoIcon = self:GetUIComponent("Image", "taskStateImgGotoIcon")
end

function UIQuestStoryDetailItem:_InitTwwenText()
end

function UIQuestStoryDetailItem:_OnValue()
  self._chapterCgImg:LoadImage(self._cfg_chapter.BigBackground)
  local offset = self._cfg_chapter.DetailOffset
  if offset then
    local offsetTr = self:GetUIComponent("RectTransform", "chapterCgImg")
    offsetTr.anchoredPosition = Vector2(offset[1], offset[2])
    offsetTr.localScale = Vector3(offset[3], offset[3], offset[3])
  end
  self._chapterNameTex:SetText(StringTable.Get(self._cfg_chapter.ChapterIndex) .. "  " .. StringTable.Get(self._cfg_chapter.ChapterName))
  if self._quest.status == QuestStatus.QUEST_Taken then
    if self._index >= self._allCount then
      self._tweenText:SetText(StringTable.Get("str_quest_base_story_all_chapter_clean"))
    else
      self._tweenText:SetText(StringTable.Get("str_quest_base_story_current_chapter_clean"))
    end
    self._tweenGoAlpha.alpha = 1
    self._taskAwardListPoolAlpha.alpha = 0.5
  else
    self._tweenGoAlpha.alpha = 0
    self._taskAwardListPoolAlpha.alpha = 1
  end
  self:_FlushQuestInfo()
  self._taskAwardListPool:SpawnObjects("UIQuestSmallAwardItem", #self._quest.rewards)
  self._awards = self._taskAwardListPool:GetAllSpawnList()
  for i = 1, #self._quest.rewards do
    local awardItem = self._awards[i]
    awardItem:SetData(i, self._quest.rewards[i], function(matid, pos)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAwardItemClick, matid, pos)
    end)
  end
end

function UIQuestStoryDetailItem:_FlushQuestInfo()
  self._taskDesTex:SetText(StringTable.Get(self._quest.QuestDesc))
  local progress = ""
  if self._quest.ShowType == 1 then
    local c, d = math.modf(self._quest.cur_progress * 100 / self._quest.total_progress)
    if c < 1 and 0 < d then
      c = 1
    end
    progress = c .. "%"
  else
    progress = "(" .. self._quest.cur_progress .. "/" .. self._quest.total_progress .. ")"
  end
  self._taskTargetTex:SetText(StringTable.Get(self._quest.CondDesc))
  self._taskTargetStateTex:SetText(progress)
  self._taskGotoGo:SetActive(false)
  self._finishGo:SetActive(false)
  self._getGo:SetActive(false)
  if self._quest.status <= QuestStatus.QUEST_Accepted then
    self._taskGotoGo:SetActive(true)
  elseif self._quest.status == QuestStatus.QUEST_Completed then
    self._getGo:SetActive(true)
  elseif self._quest.status == QuestStatus.QUEST_Taken then
    self._finishGo:SetActive(true)
  end
  self:_InitTwwenText()
end

function UIQuestStoryDetailItem:PlotOnClick()
  local misModule = self:GetModule(MissionModule)
  local data = misModule:GetDiscoveryData()
  local canReviewStorys = data:GetCanReviewStorys()
  local chapter = data:GetChapterByChapterId(self._index)
  local stage = chapter.nodes[1].stages[1]
  self:ShowDialog("UIPlot", stage, canReviewStorys)
end

function UIQuestStoryDetailItem:GotoOnClick()
  local jumpModule = self._questModule.uiModule
  if jumpModule == nil then
    Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
    return
  end
  local fromParam = {}
  table.insert(fromParam, QuestType.QT_Main)
  jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
  local jumpType = self._quest.JumpID
  local jumpParams = self._quest.JumpParam
  jumpModule:SetJumpUIData(jumpType, jumpParams)
  jumpModule:Jump()
end

function UIQuestStoryDetailItem:GetOnClick()
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  self:Lock("UIQuestGet")
  GameGlobal.TaskManager():StartTask(self.GetClick, self)
end

function UIQuestStoryDetailItem:OnUIPetObtainCloseInQuest(type)
  if type == QuestType.QT_Main then
    self:ShowDialog("UIGetItemController", self._tempMsgRewards, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Main)
    end)
  end
end

function UIQuestStoryDetailItem:AttachEvents()
  self:AttachEvent(GameEventType.QuestUpdate, self.QuestUpdate)
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
end

function UIQuestStoryDetailItem:RemoveEvents()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
  self:DetachEvent(GameEventType.QuestUpdate, self.QuestUpdate)
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
end

function UIQuestStoryDetailItem:OnUIGetItemCloseInQuest(type)
  if type == QuestType.QT_Main then
    self:RefrenshInfo()
  end
end

function UIQuestStoryDetailItem:GetClick(TT)
  local res, msg = self._questModule:TakeQuestReward(TT, self._quest.quest_id)
  self:UnLock("UIQuestGet")
  if self.uiOwner == nil then
    return
  end
  local result = res:GetResult()
  if result == 0 then
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
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, QuestType.QT_Main)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Main)
      end)
    end
  end
end
