require("singleton")
_class("AchievementManager", Singleton)
AchievementManager = AchievementManager

function AchievementManager:Init(uiroot)
  self._go = uiroot.transform:Find("UICameras/depth_high/UI/UIQuestAchievementFinish").gameObject
  self._maxCount = 2
  self._closeTime = Cfg.cfg_global.ui_achievement_finish_controller_close_time.IntValue or 1000
  self._gapsTime = Cfg.cfg_global.ui_achievement_finish_controller_gaps_time.IntValue or 500
  self._moveY = 450
  self._tweenTimeUp = 0.5
  self._tweenTimeDown = 0.25
  self._waitTime = 0
  self._hasNextOne = false
  self.popType = PopType.Achieve
  self.medalID = nil
  self.waitTime = 100
  self:_OnValue()
  self._msgQueue = {}
  self._medalMsgQueue = {}
end

function AchievementManager:FnishAchievement(msgss)
  self:_GetMsg(msgss)
end

function AchievementManager:FnishMedal(msgss)
  self:_GetMedalMsg(msgss)
end

function AchievementManager:_OnValue()
  local item1go = self._go.transform:Find("SafeArea/Down/pools/item1").gameObject
  local item2go = self._go.transform:Find("SafeArea/Down/pools/item2").gameObject
  local medal1go = self._go.transform:Find("SafeArea/Down/pools/medalItem1").gameObject
  local medal2go = self._go.transform:Find("SafeArea/Down/pools/medalItem2").gameObject
  self._item1 = AchievementManagerItem:New()
  self._item1:SetGameObject(item1go)
  self._item2 = AchievementManagerItem:New()
  self._item2:SetGameObject(item2go)
  self._medalItem1 = MedalManagerItem:New()
  self._medalItem1:SetGameObject(medal1go)
  self._medalItem2 = MedalManagerItem:New()
  self._medalItem2:SetGameObject(medal2go)
  self._item1rect = self._item1:GetRectTransform()
  self._item2rect = self._item2:GetRectTransform()
  self._medalitem1rect = self._medalItem1:GetRectTransform()
  self._medalitem2rect = self._medalItem2:GetRectTransform()
  self._state = PopState.Close
end

function AchievementManager:_GetMsg(msgss)
  if msgss == nil or table.count(msgss) <= 0 then
    return
  end
  Log.debug("###[AchievementManager]消息数量", #msgss)
  for i = 1, #msgss do
    table.insert(self._msgQueue, msgss[i])
  end
  Log.debug("###[AchievementManager]当前队列数量", #self._msgQueue)
  GameGlobal.Timer():AddEvent(self.waitTime, function()
    if self.popType == PopType.Achieve and self._state == PopState.Close then
      self._state = PopState.Open
      self.popType = PopType.Achieve
      self:_OpenMsg()
    end
  end)
end

function AchievementManager:_GetMedalMsg(msgss)
  if msgss == nil then
    return
  end
  Log.debug("###[AchievementManager]获得勋章消息ID", msgss)
  table.insert(self._medalMsgQueue, msgss)
  Log.debug("###[AchievementManager]当前队列数量", #self._medalMsgQueue)
  if self._state == PopState.Close then
    self._state = PopState.Open
    self.popType = PopType.Medal
    self:_OpenMsg()
  end
end

function AchievementManager:_OpenMsg()
  Log.debug("###[AchievementManager]打开消息")
  local item = self._item2
  local rect = self._item2rect
  local questModule = GameGlobal.GetModule(QuestModule)
  local quest = questModule:GetQuest(self._msgQueue[1])
  local queue = self._msgQueue
  if self.popType == PopType.Medal then
    item = self._medalItem2
    rect = self._medalitem2rect
    quest = self._medalMsgQueue[1]
    queue = self._medalMsgQueue
    item:SetData(quest)
  else
    item:SetData(quest:QuestInfo())
  end
  table.remove(queue, 1)
  item:ReplyTween()
  self._tweener2 = rect:DOAnchorPosY(self._moveY, self._tweenTimeUp):OnComplete(function()
    Log.debug("###[AchievementManager]检查了消息数量", #queue)
    item:DoTween()
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundPopWindow)
    if 0 < #queue then
      self._hasNextOne = true
      self._waitTime = self._gapsTime
    else
      self._hasNextOne = false
      self._waitTime = self._closeTime
    end
    if self._event then
      GameGlobal.Timer():CancelEvent(self._event)
    end
    self._event = GameGlobal.Timer():AddEvent(self._waitTime, function()
      self:_ClosePanel()
    end)
  end)
end

function AchievementManager:Dispose()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  self._item2rect = nil
  self._item1rect = nil
  self._medalitem2rect = nil
  self._medalitem1rect = nil
  self._item1 = nil
  self._item2 = nil
  self._medalItem1 = nil
  self._medalItem2 = nil
  table.clear(self._msgQueue)
  table.clear(self._medalMsgQueue)
  self._msgQueue = nil
  self._medalMsgQueue = nil
  self._hasNextOne = nil
  self._waitTime = nil
  self.medalID = nil
  self._go = nil
  self._maxCount = nil
  self._closeTime = nil
  self._gapsTime = nil
  self._moveY = nil
  self._tweenTimeUp = nil
  self._tweenTimeDown = nil
end

function AchievementManager:_ClosePanel()
  if self._hasNextOne then
    self:_CloseAndPop()
  else
    self:_CloseMsg()
  end
end

function AchievementManager:_CloseAndPop()
  self:_ChangeIndex(isAchievement)
  local questModule = GameGlobal.GetModule(QuestModule)
  local quest = questModule:GetQuest(self._msgQueue[1])
  local queue = self._msgQueue
  local item = self._item2
  local rect1 = self._item1rect
  local rect2 = self._item2rect
  if self.popType == PopType.Medal then
    queue = self._medalMsgQueue
    item = self._medalItem2
    rect1 = self._medalitem1rect
    rect2 = self._medalitem2rect
    quest = self._medalMsgQueue[1]
    if not quest then
      Log.fatal("###[AchievementManager] 掉线，清空弹出数据")
      table.clear(self._medalMsgQueue)
      self._hasNextOne = false
      self:_ClosePanel()
      return
    end
    item:SetData(quest)
  else
    if not quest then
      Log.fatal("###[AchievementManager] 掉线，清空弹出数据")
      table.clear(self._msgQueue)
      self._hasNextOne = false
      self:_ClosePanel()
      return
    end
    item:SetData(quest:QuestInfo())
  end
  table.remove(queue, 1)
  item:ReplyTween()
  rect1:DOAnchorPosY(0, self._tweenTimeDown)
  rect2:DOAnchorPosY(self._moveY, self._tweenTimeUp):OnComplete(function()
    item:DoTween()
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundPopWindow)
    if 0 < #queue then
      self._hasNextOne = true
      self._waitTime = self._gapsTime
    else
      self._hasNextOne = false
      self._waitTime = self._closeTime
    end
    if self._event then
      GameGlobal.Timer():CancelEvent(self._event)
    end
    self._event = GameGlobal.Timer():AddEvent(self._waitTime, function()
      self:_ClosePanel()
    end)
  end)
end

function AchievementManager:_CloseMsg()
  self:_ChangeIndex()
  local rect = self._item1rect
  local queue = self._msgQueue
  if self.popType == PopType.Medal then
    rect = self._medalitem1rect
    queue = self._medalMsgQueue
  end
  rect:DOAnchorPosY(0, self._tweenTimeDown):OnComplete(function()
    if 0 < #queue then
      self:_OpenMsg()
    else
      Log.debug("###[AchievementManager]关闭")
      self:_CloseDialog()
      if self.popType == PopType.Medal and 0 < #self._msgQueue then
        self.popType = PopType.Achieve
        self:_OpenMsg()
      end
    end
  end)
end

function AchievementManager:_CloseDialog()
  self._hasNextOne = false
  self._state = PopState.Close
  local item1 = self._item1
  local item2 = self._item2
  if self.popType == PopType.Medal then
    item1 = self._medalItem1
    item2 = self._medalItem2
  end
  item1:OnHide()
  item2:OnHide()
end

function AchievementManager:_ChangeIndex()
  if self.popType == PopType.Medal then
    self._medalitem2rect:SetAsFirstSibling()
    local item = self._medalItem1
    self._medalItem1 = self._medalItem2
    self._medalItem2 = item
    local rt = self._medalitem1rect
    self._medalitem1rect = self._medalitem2rect
    self._medalitem2rect = rt
  else
    self._item2rect:SetAsFirstSibling()
    local item = self._item1
    self._item1 = self._item2
    self._item2 = item
    local rt = self._item1rect
    self._item1rect = self._item2rect
    self._item2rect = rt
  end
end

local PopState = {Close = 1, Open = 2}
_enum("PopState", PopState)
local PopType = {Achieve = 1, Medal = 2}
_enum("PopType", PopType)
