_class("UISeasonTalentLineMissionGroupItem", UICustomWidget)
UISeasonTalentLineMissionGroupItem = UISeasonTalentLineMissionGroupItem

function UISeasonTalentLineMissionGroupItem:OnShow()
  self._selectGo = self:GetGameObject("select")
  self._lockTimerGo = self:GetGameObject("lockTimer")
  self._lockGo = self:GetGameObject("lock")
  self._maskGo = self:GetGameObject("mask")
  self._red = self:GetGameObject("red")
  self._anim = self:GetUIComponent("Animation", "UISeasonTalentLineMission_GroupItem")
  self._timerTexPool = self:GetUIComponent("UISelectObjectPath", "lockTimerTexPool")
  self._starNumTex = self:GetUIComponent("UILocalizationText", "starNum")
  self._nameTex = self:GetUIComponent("UILocalizationText", "name")
  self._alpha = self:GetUIComponent("CanvasGroup", "root")
end

function UISeasonTalentLineMissionGroupItem:SetData(idx, data, starNum, red, isLock, lockTime, callback, loadSeasonCb)
  self.idx = idx
  self.data = data
  self.isLock = isLock
  self.lockTime = lockTime
  self.callback = callback
  self.starNum = starNum
  self.red = red
  self.loadSeasonCb = loadSeasonCb
  self._starNumTex:SetText(self.starNum)
  self._nameTex:SetText(StringTable.Get(self.data.nameStr))
  self._maskGo:SetActive(self.isLock)
  self._lockGo:SetActive(self.isLock and self.lockTime == nil)
  self._lockTimerGo:SetActive(self.lockTime ~= nil)
  if self.lockTime then
    self:SetLockTime()
  end
  self:SetRed()
end

function UISeasonTalentLineMissionGroupItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UISeasonTalentLineMissionGroupItem:PlayAnim(yieldTime)
  if yieldTime and 0 < yieldTime then
    self._alpha.alpha = 0
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
    end
    self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
      self._alpha.alpha = 1
      self._anim:Play()
    end)
  else
    self._alpha.alpha = 1
    self._anim:Play()
  end
end

function UISeasonTalentLineMissionGroupItem:SetRed()
  self._red:SetActive(self.red)
end

function UISeasonTalentLineMissionGroupItem:SetLockTime()
  self._timerTexItem = self._timerTexPool:SpawnObject("UISeasonTalentTimeBase")
  self._timerTexItem:Set_Time_Tex("str_season_talent_tree_line_group_time_tex")
  self._timerTexItem:SetData(self.lockTime, function()
    self:LoadSeasonInfo()
  end)
end

function UISeasonTalentLineMissionGroupItem:LoadSeasonInfo()
  if self.loadSeasonCb then
    self.loadSeasonCb()
  end
end

function UISeasonTalentLineMissionGroupItem:BtnOnClick(go)
  if self.isLock then
    local tips
    if self.lockTime then
      tips = StringTable.Get("str_season_talent_tree_line_lock_tips1")
    else
      tips = StringTable.Get("str_season_talent_tree_line_lock_tips2")
    end
    ToastManager.ShowToast(tips)
  else
    if self._isSelected then
      return
    end
    if self.callback then
      self.callback(self.idx)
    end
  end
end

function UISeasonTalentLineMissionGroupItem:Select(select)
  self._isSelected = select
  self._selectGo:SetActive(select)
end
