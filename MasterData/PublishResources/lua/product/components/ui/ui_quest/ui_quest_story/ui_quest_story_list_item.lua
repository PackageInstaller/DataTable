_class("UIQuestStoryListItem", UICustomWidget)
UIQuestStoryListItem = UIQuestStoryListItem

function UIQuestStoryListItem:OnShow(uiParams)
  self._state = 0
  self._atlas = self:RootUIOwner():GetAsset("UIQuest.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.QuestUpdate, self.CheckQuestRedPoint)
  self:AttachEvent(GameEventType.RolePropertyChanged, self.CheckQuestRedPoint)
  self:AttachEvent(GameEventType.ItemCountChanged, self.CheckQuestRedPoint)
  self:AttachEvent(GameEventType.UIQuestStoryDetailClosed, self.AnimatedNormal)
  self:AttachEvent(GameEventType.OnNewStoryQuestUnLock, self.OnNewStoryQuestUnLock)
  self:AttachEvent(GameEventType.StoryQuestLock, self.LockQuest)
  self._animation = self:GetUIComponent("Animation", "UIQuestStoryListItem")
end

function UIQuestStoryListItem:AnimatedNormal()
  self._animation:Play("uieff_Quest_StoryListItem_Back")
end

function UIQuestStoryListItem:SetData(index, currentChapterIndex, callback)
  self._animation:Play("uieff_Quest_StoryListItem_In")
  self:_GetComponents()
  self._index = index
  self._callback = callback
  self._currentChapterIndex = currentChapterIndex
  self._cfg_chapter = Cfg.cfg_chapter[self._index]
  if self._cfg_chapter == nil then
    Log.fatal("[quest] error --> cfg_chapter is nil !index--> " .. self._index)
    return
  end
  self._questModule = GameGlobal.GetModule(QuestModule)
  if self._questModule == nil then
    Log.fatal("[quest] error --> questModule is nil !")
    return
  end
  self:_GetChaperState()
  self:_OnValue()
end

function UIQuestStoryListItem:_GetChaperState()
  self._state = QuestStatus.QUEST_Taken
  if self._index < self._currentChapterIndex then
    self._state = QuestStatus.QUEST_Taken
  elseif self._index == self._currentChapterIndex then
    self._state = QuestStatus.QUEST_Accepted
  else
    self._state = QuestStatus.QUEST_NotStart
  end
end

function UIQuestStoryListItem:OnHide()
  self._state = 0
  self._index = 0
  self._id = 0
  self._callback = nil
  self._atlas = nil
  self._cg = nil
  self._name = nil
  self._state = nil
  self._redState = nil
  self._cgImg = nil
  self._nameTex = nil
  self._redGo = nil
end

function UIQuestStoryListItem:_GetComponents()
  self._nameTex = self:GetUIComponent("UILocalizationText", "nameTex")
  self._doingGo = self:GetGameObject("doingGo")
  self._finishGo = self:GetGameObject("finishGo")
  self._lockGo = self:GetGameObject("lockGo")
  self._cgImg = self:GetUIComponent("RawImageLoader", "cg")
  self._redGo = self:GetGameObject("red")
  self._bg = self:GetGameObject("bg")
  self._select = self:GetGameObject("select")
  self._select:SetActive(false)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._bg), UIEvent.Press, function(go)
    self._select:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._bg), UIEvent.Release, function(go)
    self._select:SetActive(false)
  end)
end

function UIQuestStoryListItem:_OnValue()
  self._nameTex:SetText(StringTable.Get(self._cfg_chapter.QuestShowName))
  self._redGo:SetActive(self:CheckRed(self._index))
  self._doingGo:SetActive(false)
  self._finishGo:SetActive(false)
  self._lockGo:SetActive(false)
  if self._state == QuestStatus.QUEST_Accepted then
    self._nameTex.color = Color(1, 1, 1)
    self._doingGo:SetActive(true)
  elseif self._state < QuestStatus.QUEST_Accepted then
    self._lockGo:SetActive(true)
  else
    self._nameTex.color = Color(1, 1, 1)
    self._finishGo:SetActive(true)
  end
  if self._state == QuestStatus.QUEST_NotStart then
    self._cgImg:LoadImage(self._cfg_chapter.BackgroundLock)
  else
    self._cgImg:LoadImage(self._cfg_chapter.Background)
  end
end

function UIQuestStoryListItem:CheckQuestRedPoint()
  self._redGo:SetActive(self:CheckRed(self._index))
end

function UIQuestStoryListItem:LockQuest(idx)
  if idx == self._index then
    self._state = QuestStatus.QUEST_NotStart
    self:_OnValue()
  end
end

function UIQuestStoryListItem:OnNewStoryQuestUnLock(idx)
  if idx == self._index then
    self._animation:Play("uieff_Quest_StoryListItem_Unlock")
  end
end

function UIQuestStoryListItem:bgOnClick()
  if self._callback then
    self._callback(self._index, self._state)
  end
  if self._state == QuestStatus.QUEST_NotStart then
    self._animation:Play("uieff_Quest_StoryListItem_Lock")
  else
    self._animation:Play("uieff_Quest_StoryListItem_Click")
  end
end

function UIQuestStoryListItem:CheckRed(enum)
  local redInfo = self._questModule:GetRedPoint()
  if table.count(redInfo[QuestType.QT_Main]) > 0 then
    for i = 1, table.count(redInfo[QuestType.QT_Main]) do
      if redInfo[QuestType.QT_Main][i] == enum then
        return true
      end
    end
  end
  return false
end
