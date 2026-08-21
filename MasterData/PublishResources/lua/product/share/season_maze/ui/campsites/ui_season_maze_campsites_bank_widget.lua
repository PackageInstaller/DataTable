_class("UISeasonMaze_Campsites_BankWidget", UICustomWidget)
UISeasonMaze_Campsites_BankWidget = UISeasonMaze_Campsites_BankWidget

function UISeasonMaze_Campsites_BankWidget:InitWidget()
  self._OpenAreaGo = self:GetGameObject("OpenArea")
  self._LockAreaGo = self:GetGameObject("LockArea")
  self._SaveCountGo = self:GetGameObject("SaveCount")
  self._SaveCountText = self:GetUIComponent("UILocalizationText", "SaveCount")
  self._DescText = self:GetUIComponent("UILocalizationText", "DescText")
  self._anim = self:GetGameObject():GetComponent("Animation")
  self._rootGo = self:GetGameObject("root")
end

function UISeasonMaze_Campsites_BankWidget:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMaze_Campsites_BankWidget:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  if self._timerUnlock then
    GameGlobal.Timer():CancelEvent(self._timerUnlock)
  end
end

function UISeasonMaze_Campsites_BankWidget:SetData(idx, save, currentSave)
  self._idx = idx
  self._save = save
  self._currentSave = currentSave
  self:SetQuestInfo()
end

function UISeasonMaze_Campsites_BankWidget:SetQuestInfo()
  local target = self._save.NeedNum
  local formatStr = "%s<color=#8f1010>/%s</color>"
  local saveStr = string.format(formatStr, tostring(self._currentSave), tostring(target))
  self._SaveCountText:SetText(saveStr)
  local desc = self._save.Desc
  if desc then
    self._DescText:SetText(StringTable.Get(desc))
  end
  if target <= 0 then
    target = 1
    Log.error("###[UISeasonMaze_Campsites_BankWidget] target == 0 ! self._idx:", self._idx)
  end
  local isLock = target > self._currentSave
  self._OpenAreaGo:SetActive(not isLock)
  self._LockAreaGo:SetActive(isLock)
  self._SaveCountGo:SetActive(isLock)
end

function UISeasonMaze_Campsites_BankWidget:PlayShowInAnim(delay)
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._rootGo:SetActive(true)
  end
  if delay and 0 < delay then
    self._rootGo:SetActive(false)
    self._timer = GameGlobal.Timer():AddEvent(delay, function()
      self._rootGo:SetActive(true)
      if self._anim then
        self._anim:Play("uieffanim_UISeasonMaze_Campsites_BankWidget_in")
      end
    end)
  else
    self._rootGo:SetActive(true)
    if self._anim then
      self._anim:Play("uieffanim_UISeasonMaze_Campsites_BankWidget_in")
    end
  end
end

function UISeasonMaze_Campsites_BankWidget:PlayUnlockAnim()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._rootGo:SetActive(true)
  end
  if self._timerUnlock then
    GameGlobal.Timer():CancelEvent(self._timerUnlock)
  end
  if self._anim then
    self._LockAreaGo:SetActive(true)
    self._anim:Play("uieffanim_UISeasonMaze_Campsites_BankWidget_unlock")
    self._timerUnlock = GameGlobal.Timer():AddEvent(867, function()
      self._LockAreaGo:SetActive(false)
    end)
  end
end
