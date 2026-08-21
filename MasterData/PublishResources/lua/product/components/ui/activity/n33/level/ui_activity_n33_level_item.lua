_class("UIActivityN33LevelItem", UICustomWidget)
UIActivityN33LevelItem = UIActivityN33LevelItem

function UIActivityN33LevelItem:OnShow(uiParams)
  self._build = self:GetGameObject("Build")
  self._iconLoader = self:GetUIComponent("RawImageLoader", "Icon")
  self._buildNameLabel = self:GetUIComponent("UILocalizationText", "BuildName")
  self._buildStarLabel = self:GetUIComponent("UILocalizationText", "BuildStar")
  self._buildInfo = self:GetGameObject("BuildInfo")
  self._boss = self:GetGameObject("Boss")
  self._spineTran = self:GetUIComponent("RectTransform", "Spine")
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
  self._bossNameLabel = self:GetUIComponent("UILocalizationText", "BossName")
  self._bossStarLabel = self:GetUIComponent("UILocalizationText", "BossStar")
  self._root = self:GetUIComponent("RectTransform", "Root")
  self._lockIconLoader = self:GetUIComponent("RawImageLoader", "LockIcon")
  self._lock = self:GetGameObject("LockIcon")
  self._buildPosition = self:GetGameObject("BuildPosition")
  self._bossPosition = self:GetGameObject("BossPosition")
  self._focus = self:GetGameObject("Focus")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._birth = self:GetGameObject("birth")
  self._dead = self:GetGameObject("dead")
end

function UIActivityN33LevelItem:OnHide()
end

function UIActivityN33LevelItem:SetData(data, callback)
  self._focus:SetActive(false)
  self._data = data
  self._root.anchoredPosition = data:GetPosition()
  self._callback = callback
  self._build:SetActive(true)
  self._boss:SetActive(false)
  self._lock:SetActive(false)
  self._iconLoader:LoadImage(data:GetOpenIcon())
  if data:IsOpen() == false then
    self._buildInfo:SetActive(false)
    self._lock:SetActive(true)
    self._lockIconLoader:LoadImage(data:GetLockIcon())
  else
    self._buildInfo:SetActive(true)
    self._buildNameLabel:SetText(data:GetName())
    self._buildStarLabel:SetText(data:GetStar() .. "/" .. data:TotalStar())
    local canPlayOpenAnim = self._data:GetCanPlayOpenAnim()
    if canPlayOpenAnim then
      self._lock:SetActive(true)
      self._lockIconLoader:LoadImage(self._data:GetLockIcon())
      self._buildInfo:SetActive(false)
    end
  end
  self._buildPosition:SetActive(self._data:IsCurrentBuild())
  self._bossPosition:SetActive(self._data:IsCurrentBuild())
end

function UIActivityN33LevelItem:CheckPlayAnim()
  if self._data:IsOpen() then
    self:StartTask(self.PlayAnim, self)
  end
end

function UIActivityN33LevelItem:GetData()
  return self._data
end

function UIActivityN33LevelItem:SetSelectStatus(status)
end

function UIActivityN33LevelItem:SetForcusStatus(status)
  local show = false
  if status then
    show = self._data:IsCurrentBuild()
  end
  self._focus:SetActive(show)
end

function UIActivityN33LevelItem:PlaySpine(animName)
  self._spineSke = self._spine.CurrentSkeleton
  if not self._spineSke then
    self._spineSke = self._spine.CurrentMultiSkeleton
  end
  if self._spineSke then
    self._spineSke.AnimationState:SetAnimation(0, animName, true)
  end
end

function UIActivityN33LevelItem:PlayAnim(TT)
  self:Lock("UIActivityN33LevelItem_PlayAnim" .. self._data:BuildId())
  local canPlayOpenAnim = self._data:GetCanPlayOpenAnim()
  if canPlayOpenAnim then
    self._data:PlayOpenAnim()
    self._lock:SetActive(true)
    self._lockIconLoader:LoadImage(self._data:GetLockIcon())
    self._anim:Play("uianim_UIActivityN33LevelItem_lock")
    local length = self._data:GetBuildUnlockAnimationLength()
    if length then
      YIELD(TT, length)
    end
    self._lock:SetActive(false)
    self._buildInfo:SetActive(true)
  end
  local disappearBoss = self._data:GetCanPlayDiappearAnimBoss()
  if disappearBoss then
    self._dead:SetActive(true)
    self._boss:SetActive(true)
    self._build:SetActive(false)
    local boss = disappearBoss:GetBoss()
    self._bossNameLabel:SetText(boss:GetName())
    self._bossStarLabel:SetText(self._data:GetStar() .. "/" .. self._data:TotalStar())
    self._spine:LoadSpine(boss:GetSpine())
    self:PlaySpine(boss:GetDisappearAnim())
    self._data:PlayDisappearAnim(disappearBoss:GetMissionId())
    local length = boss:GetDisappearAnimLength()
    YIELD(TT, length)
    self._build:SetActive(true)
    self._boss:SetActive(false)
  end
  local enterBoss = self._data:GetCanPlayEnterAnimBoss()
  if enterBoss then
    self._birth:SetActive(true)
    self._spineTran.anchoredPosition = Vector2(100000, 10000)
    self._boss:SetActive(true)
    self._build:SetActive(false)
    local boss = enterBoss:GetBoss()
    self._bossNameLabel:SetText(boss:GetName())
    self._bossStarLabel:SetText(self._data:GetStar() .. "/" .. self._data:TotalStar())
    self._spine:LoadSpine(boss:GetSpine())
    self:PlaySpine(boss:GetUnlockAnim())
    self._data:PlayEnterAnim(enterBoss:GetMissionId())
    YIELD(TT, 60)
    self._spineTran.anchoredPosition = Vector2(0, -94.9)
    local length = boss:GetUnlockAnimLength()
    YIELD(TT, length - 60)
    self._build:SetActive(false)
  end
  local currentLevel = self._data:GetCurrentLevel()
  if currentLevel then
    local boss = currentLevel:GetBoss()
    if boss then
      self._boss:SetActive(true)
      self._bossNameLabel:SetText(boss:GetName())
      self._bossStarLabel:SetText(self._data:GetStar() .. "/" .. self._data:TotalStar())
      self._spine:LoadSpine(boss:GetSpine())
      self:PlaySpine(boss:GetIdleAnim())
      self._build:SetActive(false)
    end
  end
  self:UnLock("UIActivityN33LevelItem_PlayAnim" .. self._data:BuildId())
end

function UIActivityN33LevelItem:RootOnClick()
  if self._data:IsOpen() == false then
    ToastManager.ShowToast(StringTable.Get("str_n33_build_lock_tips"))
    return
  end
  if self._callback then
    self._callback(self._data)
  end
end

function UIActivityN33LevelItem:SwitLevelType(playIn)
  if playIn then
    self._anim:Play("uianim_UIActivityN33LevelItem_in")
  else
    self._anim:Play("uianim_UIActivityN33LevelItem_out")
  end
end
