_class("UIQuestGrowthFeatherItem", UICustomWidget)
UIQuestGrowthFeatherItem = UIQuestGrowthFeatherItem

function UIQuestGrowthFeatherItem:OnShow(uiParams)
  self._questModule = self:GetModule(QuestModule)
  self._anim = self:GetUIComponent("Animation", "UIQuestGrowthFeatherItem")
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "award")
  self:AttachEvents()
end

function UIQuestGrowthFeatherItem:SetData(tabIndex, index, posx, lastPos, iconID, iconCount, featherCount, currCount, showAnimDelay, anim)
  self:_GetComponents()
  self._posX = posx
  self._lastPos = lastPos
  self._tabIndex = tabIndex
  self._index = index
  self._id = iconID
  self._iconCount = iconCount
  self._count = featherCount
  self._currCount = currCount
  self._state = QuestStatus.QUEST_Accepted
  self:_OnValue()
  if anim then
    if self._animTaskID then
      GameGlobal.TaskManager():KillTask(self._animTaskID)
    end
    self._anim:Stop()
    self._canvasGroup.alpha = 0
    self._animTaskID = self:StartTask(function(TT)
      if 0 < showAnimDelay then
        YIELD(TT, showAnimDelay * 1000)
      end
      self._canvasGroup.alpha = 1
      self._anim:Play("uieffanim_UIItemForQuest_in")
    end)
  end
end

function UIQuestGrowthFeatherItem:_OnValue()
  self:_GetState()
  self:_ShowInfo()
  self:_ShowState()
  self:_CalcWidthAndPos()
end

function UIQuestGrowthFeatherItem:_GetState()
  local isGot = {
    self._questModule:CheckGrowthFeatherState(self._index),
    self._questModule:CheckStage2GrowthFeatherState(self._index)
  }
  if isGot[self._tabIndex] then
    self._state = QuestStatus.QUEST_Taken
  elseif self._currCount >= self._count then
    self._state = QuestStatus.QUEST_Completed
  else
    self._state = QuestStatus.QUEST_Accepted
  end
end

function UIQuestGrowthFeatherItem:_ShowState()
  if self._state <= QuestStatus.QUEST_Accepted then
    self._eff:SetActive(false)
    self._imgGot:SetActive(false)
    self._complete:SetActive(false)
    self._unComplete:SetActive(true)
  elseif self._state == QuestStatus.QUEST_Completed then
    self._eff:SetActive(true)
    self._imgGot:SetActive(false)
    self._complete:SetActive(true)
    self._unComplete:SetActive(false)
  elseif self._state == QuestStatus.QUEST_Taken then
    self._eff:SetActive(false)
    self._imgGot:SetActive(true)
    self._complete:SetActive(true)
    self._unComplete:SetActive(false)
  end
end

function UIQuestGrowthFeatherItem:_ShowInfo()
  local cfg_item = Cfg.cfg_item[self._id]
  if not cfg_item then
    Log.fatal("###cfg_item is nil ! id --> ", self._id)
  end
  self._countTex:SetText(self._count)
  local icon = cfg_item.Icon
  local quality = cfg_item.Color
  local text1 = UIActivityHelper.GetRichText({size = 42}, self._iconCount)
  local itemId = self._id
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = self._id
  })
end

function UIQuestGrowthFeatherItem:_GetComponents()
  self._imgGot = self:GetGameObject("imgGot")
  self._countTex = self:GetUIComponent("UILocalizationText", "countTex")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._complete = self:GetGameObject("complete")
  self._unComplete = self:GetGameObject("unComplete")
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItemForQuest")
  self.uiItem:SetForm(UIItemForm.Base, UIItemScale.Level3)
  self.uiItem:SetClickCallBack(function(go)
    self:bgOnClick(go)
  end)
  self._eff = self:GetGameObject("eff")
end

function UIQuestGrowthFeatherItem:_CalcWidthAndPos()
  self._rect.anchoredPosition = Vector2(self._posX, 0)
  local width = 0
  local awardWidthHalf = 70
  local awardWidthPadding = 12
  local startOffset = 25
  if self._index > 1 then
    width = self._posX - self._lastPos - 2 * awardWidthHalf - 2 * awardWidthPadding
  else
    width = self._posX - awardWidthHalf - awardWidthPadding - startOffset
  end
end

function UIQuestGrowthFeatherItem:bgOnClick(go)
  if self._state <= QuestStatus.QUEST_Accepted then
    local pos = go.transform.position
    GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAwardItemClick, self._id, pos)
  elseif self._state == QuestStatus.QUEST_Completed then
    self:_GetAward()
  elseif self._state == QuestStatus.QUEST_Taken then
    local pos = go.transform.position
    GameGlobal.EventDispatcher():Dispatch(GameEventType.QuestAwardItemClick, self._id, pos)
  end
end

function UIQuestGrowthFeatherItem:_GetAward()
  self:Lock(self:GetName())
  GameGlobal.TaskManager():StartTask(self._OnGetAward, self)
end

function UIQuestGrowthFeatherItem:OnUIGetItemCloseInQuest(type)
  if type == QuestType.QT_Growth + 1000 then
    self:_GetState()
    self:_ShowState()
  end
end

function UIQuestGrowthFeatherItem:OnUIPetObtainCloseInQuest(type)
  if type == QuestType.QT_Growth + 1000 * self._index then
    self:ShowDialog("UIGetItemController", self._tempMsgRewards, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Growth + 1000)
    end)
  end
end

function UIQuestGrowthFeatherItem:AttachEvents()
  self:AttachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:AttachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
end

function UIQuestGrowthFeatherItem:RemoveEvents()
  self:DetachEvent(GameEventType.OnUIGetItemCloseInQuest, self.OnUIGetItemCloseInQuest)
  self:DetachEvent(GameEventType.OnUIPetObtainCloseInQuest, self.OnUIPetObtainCloseInQuest)
end

function UIQuestGrowthFeatherItem:_OnGetAward(TT)
  local res, msg = self._questModule:RequestGetGrowthFeatherAward(TT, self._index)
  self:UnLock(self:GetName())
  if self.uiOwner == nil then
    return
  end
  if res:GetSucc() then
    local tempPets = {}
    local pets = msg.rewards
    self._tempMsgRewards = pets
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
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIPetObtainCloseInQuest, QuestType.QT_Growth + 1000 * self._index)
      end)
    else
      self:ShowDialog("UIGetItemController", msg.rewards, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIGetItemCloseInQuest, QuestType.QT_Growth + 1000)
      end)
    end
  else
    local result = res:GetResult()
    Log.fatal("### RequestGetGrowthFeatherAward fail , result -> ", result)
  end
end

function UIQuestGrowthFeatherItem:OnHide()
  self:RemoveEvents()
  GameGlobal.TaskManager():KillTask(self._animTaskID)
end
