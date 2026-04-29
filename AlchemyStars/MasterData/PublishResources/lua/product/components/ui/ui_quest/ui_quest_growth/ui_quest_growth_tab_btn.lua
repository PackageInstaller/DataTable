_class("UIQuestGrowthTabBtn", UICustomWidget)
UIQuestGrowthTabBtn = UIQuestGrowthTabBtn

function UIQuestGrowthTabBtn:OnShow(uiParams)
  self._unLockDay = self:GetUIComponent("Text", "unlockDay")
  self._lockDay = self:GetUIComponent("Text", "lockDay")
  self._doneGO = self:GetGameObject("done")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIQuestGrowthTabBtn:SetData(index, lock, done, clickCallback, lockClickCallback)
  if lock then
    self._lockDay.text = index
    self._unLockDay.text = ""
  else
    self._unLockDay.text = index
    self._lockDay.text = ""
  end
  self._index = index
  self._lock = lock
  self._done = done
  self._clickCallback = clickCallback
  self._lockClickCallback = lockClickCallback
  self._doneGO:SetActive(done)
end

function UIQuestGrowthTabBtn:IsLock()
  return self._lock
end

function UIQuestGrowthTabBtn:Unlock()
  self._lock = false
  self._unLockDay.text = self._index
  self._lockDay.text = ""
end

function UIQuestGrowthTabBtn:IsDone()
  return self._done
end

function UIQuestGrowthTabBtn:Done()
  self._done = true
  self._doneGO:SetActive(true)
end

function UIQuestGrowthTabBtn:UnSelect()
  if self._anim then
    self._anim:Play("uianim_UIQuestGrowthTabBtn2_up")
  end
end

function UIQuestGrowthTabBtn:BtnOnClick()
  if self._lock then
    self._lockClickCallback(self._index)
  else
    self._clickCallback(self._index)
  end
end
