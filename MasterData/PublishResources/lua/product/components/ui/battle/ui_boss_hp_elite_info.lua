_class("UIBossHPEliteInfo", UICustomWidget)
UIBossHPEliteInfo = UIBossHPEliteInfo

function UIBossHPEliteInfo:Constructor()
  self._eliteIDs = {}
  self._interval = 8
  self._edgeWidth = 10
  self._curRootWidth = BattleConst.UIBossHPEliteInfoDefaultWidth
  self._tweeners = {}
  self._moveSpeed = 20
end

function UIBossHPEliteInfo:OnShow()
  self._root = self:GetGameObject("Root")
  self._rootRectTransform = self._root:GetComponent("RectTransform")
  self._rootPath = self:GetUIComponent("UISelectObjectPath", "Root")
end

function UIBossHPEliteInfo:OnHide()
  if self._root then
    self._root.gameObject:SetActive(false)
  end
end

function UIBossHPEliteInfo:OnSetData(eliteIDs)
  if not eliteIDs or table.count(eliteIDs) == 0 then
    return
  end
  for _, tweener in ipairs(self._tweeners) do
    tweener:Kill(false)
  end
  self._tweeners = {}
  self._root.gameObject:SetActive(true)
  self._eliteIDs = eliteIDs
  local eliteCount = table.count(self._eliteIDs)
  self._rootPath:SpawnObjects("UIBossHPEliteItem", eliteCount)
  self._itemList = self._rootPath:GetAllSpawnList()
  local startPosition = 0
  local endPosition = 0
  for i = 1, #self._itemList do
    local go = self._itemList[i]:GetGameObject()
    go:SetActive(i <= eliteCount)
    if i <= eliteCount then
      local cfgElite = Cfg.cfg_monster_elite[self._eliteIDs[i]]
      if not cfgElite then
        Log.fatal("[UIBossHPEliteInfo] error --> cfg_monster_elite is nil ! id --> " .. self._eliteIDs[i])
        return
      end
      local eliteKey = cfgElite.Name
      self._itemList[i]:OnSetData(eliteKey)
      local rect = go:GetComponent("RectTransform")
      rect.anchoredPosition = Vector2(startPosition, 0)
      local width = self._itemList[i]:OnGetTextWidth()
      endPosition = startPosition + width + self._edgeWidth
      startPosition = startPosition + width + self._edgeWidth + self._interval
    end
  end
  if endPosition > self._curRootWidth then
    self._rootPath:SpawnObjects("UIBossHPEliteItem", eliteCount * 2)
    self._itemList = self._rootPath:GetAllSpawnList()
    for i = eliteCount + 1, #self._itemList do
      local go = self._itemList[i]:GetGameObject()
      go:SetActive(i <= eliteCount * 2)
      if i <= eliteCount * 2 then
        local cfgElite = Cfg.cfg_monster_elite[self._eliteIDs[i - eliteCount]]
        local eliteKey = cfgElite.Name
        self._itemList[i]:OnSetData(eliteKey)
        local rect = go:GetComponent("RectTransform")
        rect.anchoredPosition = Vector2(startPosition, 0)
        local width = self._itemList[i]:OnGetTextWidth()
        endPosition = startPosition + width + self._edgeWidth
        startPosition = startPosition + width + self._edgeWidth + self._interval
      end
    end
    for i = 1, #self._itemList do
      local go = self._itemList[i]:GetGameObject()
      local rect = go:GetComponent("RectTransform")
      local width = self._itemList[i]:OnGetTextWidth()
      local targetPos = 0 - width - self._edgeWidth
      local moveTime = (rect.anchoredPosition.x + width + self._edgeWidth + self._interval) / self._moveSpeed
      local doTween = go.transform:DOLocalMoveX(targetPos, moveTime):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
        local turnPos = targetPos + endPosition
        rect.anchoredPosition = Vector2(turnPos, 0)
        go.transform:DOLocalMoveX(targetPos, (turnPos - targetPos) / self._moveSpeed):SetEase(DG.Tweening.Ease.Linear):SetLoops(-1)
      end)
      if doTween then
        table.insert(self._tweeners, doTween)
      end
    end
  end
end

function UIBossHPEliteInfo:SetWidth(width, doRefresh)
  self._curRootWidth = width
  if doRefresh then
    self:OnSetData(self._eliteIDs)
  end
end
