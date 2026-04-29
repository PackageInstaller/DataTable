_class("UIShopSailingPlanSpecialQuest", UICustomWidget)
UIShopSailingPlanSpecialQuest = UIShopSailingPlanSpecialQuest

function UIShopSailingPlanSpecialQuest:Constructor()
end

function UIShopSailingPlanSpecialQuest:SetData(idx, quest, callback, buyState, yieldTime)
  self:GetComponents()
  self._quest = quest
  self._questinfo = quest:QuestInfo()
  self._rewards = self._questinfo.rewards
  self._callback = callback
  self._buyState = buyState
  self:OnValue()
  self:PlayAnim(yieldTime)
end

function UIShopSailingPlanSpecialQuest:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIShopSailingPlanSpecialQuest:PlayAnim(yieldTime)
  if yieldTime then
    self._root.alpha = 0
    if yieldTime == 0 then
      self._anim:Play()
    else
      if self._event then
        GameGlobal.Timer():CancelEvent(self._event)
        self._event = nil
      end
      self._event = GameGlobal.Timer():AddEvent(yieldTime, function()
        self._anim:Play()
      end)
    end
  else
    self._rootTr.anchoredPosition = Vector2(0, 0)
    self._root.alpha = 1
  end
end

function UIShopSailingPlanSpecialQuest:GetComponents()
  self._pools = self:GetUIComponent("UISelectObjectPath", "pools")
  self._root = self:GetUIComponent("CanvasGroup", "Root")
  self._rootTr = self:GetUIComponent("RectTransform", "Root")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._lock = self:GetGameObject("lock")
  self._lockImg = self:GetGameObject("lockImg")
  self._got = self:GetGameObject("got")
end

function UIShopSailingPlanSpecialQuest:OnValue()
  local count = #self._rewards
  self._pools:SpawnObjects("UIShopSailingPlanItem", count)
  local pools = self._pools:GetAllSpawnList()
  local status = self._questinfo.status
  for i = 1, count do
    local item = pools[i]
    local roleAsset = self._rewards[i]
    item:SetData(i, roleAsset, function(id, pos)
      self:ItemOnClick(id, pos)
    end, true, status, self._buyState, nil, true, false, 0.85)
  end
  local lock = true
  local lockImg = true
  if self._buyState and self._buyState ~= BuyGiftStateType.EBGST_INIT then
    lock = status ~= QuestStatus.QUEST_Completed
    lockImg = status < QuestStatus.QUEST_Completed
  end
  self._lock:SetActive(lock)
  self._lockImg:SetActive(lockImg)
  self._got:SetActive(status == QuestStatus.QUEST_Taken)
end

function UIShopSailingPlanSpecialQuest:ItemOnClick(id, pos)
  if self._callback then
    self._callback(self._questinfo.quest_id, id, pos)
  end
end
