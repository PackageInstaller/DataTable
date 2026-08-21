_class("UIShopSailingPlanNormalQuest", UICustomWidget)
UIShopSailingPlanNormalQuest = UIShopSailingPlanNormalQuest

function UIShopSailingPlanNormalQuest:Constructor()
  self._idx2name = {
    [1] = 5,
    [2] = 6,
    [3] = 7,
    [4] = 8,
    [5] = 9,
    [6] = 10,
    [7] = 12,
    [8] = 13
  }
  self._idx2idx = {
    [1] = 5,
    [2] = 6,
    [3] = 7,
    [4] = 8,
    [5] = 9,
    [6] = 10,
    [7] = 11,
    [8] = 12
  }
end

function UIShopSailingPlanNormalQuest:SetData(idx, quest, callback, yieldTime, allTaken)
  self:GetComponents()
  self._idx = idx
  self._quest = quest
  self._questinfo = quest:QuestInfo()
  self._rewards = self._questinfo.rewards
  self._callback = callback
  self._allTaken = allTaken
  self:OnValue()
  self:PlayAnim(yieldTime)
end

function UIShopSailingPlanNormalQuest:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIShopSailingPlanNormalQuest:PlayAnim(yieldTime)
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

function UIShopSailingPlanNormalQuest:GetComponents()
  self._pools = self:GetUIComponent("UISelectObjectPath", "pools")
  self._chapter = self:GetUIComponent("UILocalizedTMP", "chapter")
  self._idxTex = self:GetUIComponent("UILocalizationText", "idxTex")
  self._img = self:GetUIComponent("Image", "Image")
  self._root = self:GetUIComponent("CanvasGroup", "Root")
  self._rootTr = self:GetUIComponent("RectTransform", "Root")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._lock = self:GetGameObject("lock")
  self._lockImg = self:GetGameObject("lockImg")
  self._allTakenGo = self:GetGameObject("allTaken")
  self._got = self:GetGameObject("got")
end

function UIShopSailingPlanNormalQuest:OnValue()
  local count = #self._rewards
  self._pools:SpawnObjects("UIShopSailingPlanItem", count)
  local pools = self._pools:GetAllSpawnList()
  local status = self._questinfo.status
  for i = 1, count do
    local item = pools[i]
    local roleAsset = self._rewards[i]
    item:SetData(i, roleAsset, function(id, pos)
      self:ItemOnClick(id, pos)
    end, true, status, nil, nil, true, false, 0.85)
  end
  self._chapter:SetText(tostring(self._idx2idx[self._idx]))
  self._idxTex:SetText(StringTable.Get("str_chapter_idx_" .. self._idx2name[self._idx]))
  self._lock:SetActive(status ~= QuestStatus.QUEST_Completed)
  self._lockImg:SetActive(status < QuestStatus.QUEST_Completed)
  self._got:SetActive(status == QuestStatus.QUEST_Taken)
  self._allTakenGo:SetActive(self._allTaken)
end

function UIShopSailingPlanNormalQuest:ItemOnClick(id, pos)
  if self._callback then
    self._callback(self._questinfo.quest_id, id, pos)
  end
end
