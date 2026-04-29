_class("UIHomelandTaskGuideItem", UICustomWidget)
UIHomelandTaskGuideItem = UIHomelandTaskGuideItem

function UIHomelandTaskGuideItem:Constructor()
  self._atlas = self:GetAsset("UIHomelandTask.spriteatlas", LoadType.SpriteAtlas)
end

function UIHomelandTaskGuideItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIHomelandTaskGuideItem:_GetComponents()
  self._stateLeft = self:GetUIComponent("Image", "StateLeft")
  self._stateTag = self:GetUIComponent("Image", "StateTag")
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._value = self:GetUIComponent("UILocalizationText", "Value")
  self._stateText = self:GetGameObject("StateText")
  self._gray = self:GetGameObject("Gray")
  self._background = self:GetUIComponent("RawImageLoader", "Background")
  self._unLock = self:GetGameObject("UnLock")
  self._stateTagObj = self:GetGameObject("StateTag")
end

function UIHomelandTaskGuideItem:SetData(quest)
  self._quest = quest
  local questInfo = self._quest:QuestInfo()
  local cfg = Cfg.cfg_homeland_task[questInfo.quest_id]
  local leftSprite = "N17_task_kuang04"
  local tagSprite = "N17_task_icon06"
  local titleColor = Color(0.6196078431372549, 0.6196078431372549, 0.6196078431372549)
  local valueStr = StringTable.Get(cfg.TaskContent, questInfo.cur_progress, questInfo.total_progress)
  local background = "N17_task_di11"
  local lock = false
  if questInfo.status == QuestStatus.QUEST_NotStart then
    lock = true
  elseif questInfo.status == QuestStatus.QUEST_Accepted then
    leftSprite = "N17_task_kuang05"
    tagSprite = "N17_task_icon07"
    titleColor = Color(0.3607843137254902, 0.3607843137254902, 0.3607843137254902)
  elseif questInfo.status == QuestStatus.QUEST_Completed then
    leftSprite = "N17_task_kuang06"
    tagSprite = "N17_task_icon08"
  elseif questInfo.status == QuestStatus.QUEST_Taken then
    leftSprite = "N17_task_kuang06"
    tagSprite = "N17_task_icon08"
    background = "N17_task_di12"
  end
  self._stateLeft.sprite = self._atlas:GetSprite(leftSprite)
  self._stateTag.sprite = self._atlas:GetSprite(tagSprite)
  local titleStr = StringTable.Get(cfg.TaskTitle)
  if lock then
    titleStr = StringTable.Get("str_homeland_task_guidetask_lock")
  end
  self._title:SetText(titleStr)
  self._title.color = titleColor
  self._value:SetText(string.format("<color=#808080>%s</color>", valueStr))
  self._stateText:SetActive(questInfo.status <= QuestStatus.QUEST_Accepted)
  self._gray:SetActive(questInfo.status == QuestStatus.QUEST_Taken)
  self._background:LoadImage(background)
  self._unLock:SetActive(lock)
  self._stateTagObj:SetActive(not lock)
end
