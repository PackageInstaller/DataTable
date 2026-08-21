_class("UIActivityN33LevelListItem", UICustomWidget)
UIActivityN33LevelListItem = UIActivityN33LevelListItem

function UIActivityN33LevelListItem:OnShow(uiParams)
  self._plot = self:GetGameObject("Plot")
  self._plotName = self:GetUIComponent("UILocalizationText", "PlotName")
  self._normal = self:GetGameObject("Normal")
  self._normalName = self:GetUIComponent("UILocalizationText", "NormalName")
  self._normalStarLock = {}
  self._normalStarLock[#self._normalStarLock + 1] = self:GetGameObject("NormalStarLock1")
  self._normalStarLock[#self._normalStarLock + 1] = self:GetGameObject("NormalStarLock2")
  self._normalStarLock[#self._normalStarLock + 1] = self:GetGameObject("NormalStarLock3")
  self._normalStar = {}
  self._normalStar[#self._normalStar + 1] = self:GetGameObject("NormalStar1")
  self._normalStar[#self._normalStar + 1] = self:GetGameObject("NormalStar2")
  self._normalStar[#self._normalStar + 1] = self:GetGameObject("NormalStar3")
  self._boss = self:GetGameObject("Boss")
  self._bossName = self:GetUIComponent("UILocalizationText", "BossName")
  self._bossStarLock = {}
  self._bossStarLock[#self._bossStarLock + 1] = self:GetGameObject("BossStarLock1")
  self._bossStarLock[#self._bossStarLock + 1] = self:GetGameObject("BossStarLock2")
  self._bossStarLock[#self._bossStarLock + 1] = self:GetGameObject("BossStarLock3")
  self._bossStar = {}
  self._bossStar[#self._bossStar + 1] = self:GetGameObject("BossStar1")
  self._bossStar[#self._bossStar + 1] = self:GetGameObject("BossStar2")
  self._bossStar[#self._bossStar + 1] = self:GetGameObject("BossStar3")
  self._position = self:GetGameObject("Position")
  self._lock = self:GetGameObject("Lock")
  self._normalStarPanel = self:GetGameObject("NormalStar")
  self._hardNormalStarPanel = self:GetGameObject("HardNormalStar")
  self._bossStarPanel = self:GetGameObject("BossStar")
  self._hardBossStarPanel = self:GetGameObject("HardBossStar")
end

function UIActivityN33LevelListItem:SetData(currentLevel, data, callback)
  self._data = data
  self._callback = callback
  self._lock:SetActive(not self._data:IsOpen())
  self._position:SetActive(self._data == currentLevel)
  local levelType = self._data:GetLevelType()
  self._plot:SetActive(false)
  self._normal:SetActive(false)
  self._boss:SetActive(false)
  if levelType == DiscoveryStageType.Plot then
    self._plot:SetActive(true)
    self._plotName:SetText(data:GetName())
  elseif levelType == DiscoveryStageType.FightBoss then
    self._boss:SetActive(true)
    self._bossName:SetText(data:GetName())
    if self._data:IsHard() then
      self._bossStarPanel:SetActive(false)
      self._hardBossStarPanel:SetActive(data:IsComplete())
    else
      local star = self._data:GetStar()
      for i = 1, #self._bossStar do
        self._bossStar[i]:SetActive(i <= star)
        self._bossStarLock[i]:SetActive(i > star)
      end
      self._bossStarPanel:SetActive(true)
      self._hardBossStarPanel:SetActive(false)
    end
  else
    self._normal:SetActive(true)
    self._normalName:SetText(data:GetName())
    if self._data:IsHard() then
      self._normalStarPanel:SetActive(false)
      self._hardNormalStarPanel:SetActive(data:IsComplete())
    else
      local star = self._data:GetStar()
      for i = 1, #self._normalStar do
        self._normalStar[i]:SetActive(i <= star)
        self._normalStarLock[i]:SetActive(i > star)
      end
      self._normalStarPanel:SetActive(true)
      self._hardNormalStarPanel:SetActive(false)
    end
  end
end

function UIActivityN33LevelListItem:RootOnClick()
  if self._data:IsOpen() == false then
    ToastManager.ShowToast(self._data:GetTips())
    return
  end
  if self._callback then
    self._callback(self._data)
  end
end
