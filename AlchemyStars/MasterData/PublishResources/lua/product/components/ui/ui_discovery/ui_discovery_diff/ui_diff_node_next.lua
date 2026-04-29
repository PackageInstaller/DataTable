_class("UIDiffNodeNext", UIDiffNodeBase)
UIDiffNodeNext = UIDiffNodeNext

function UIDiffNodeNext:GetComponents()
  self._go = self:GetGameObject()
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._texName = self:GetUIComponent("UILocalizationText", "txtName")
end

function UIDiffNodeNext:SetInfo()
  local chapterID = self._node:ChapterID()
  local tips
  self._nextChapterID = self._uiModule:GetNextChapterID(chapterID)
  if self._nextChapterID then
    local cfg = Cfg.cfg_difficulty_mission_chapter_desc[self._nextChapterID]
    local cName = cfg.Name
    tips = cName
  else
    tips = "str_discovery_coming_soon"
  end
  self._texName:SetText(StringTable.Get(tips))
end

function UIDiffNodeNext:ClickItem()
  if self._nextChapterID then
    if not self:CheckNextUnLock() then
      ToastManager.ShowToast(StringTable.Get("str_discovery_next_blackbox_locktip"))
      return
    end
    if self._callback then
      self._callback(self._node)
    end
  end
end

function UIDiffNodeNext:CheckNextUnLock()
  if self._nextChapterID then
    local cfg = Cfg.cfg_difficulty_mission_chapter_desc[self._nextChapterID]
    if not cfg then
      return true
    end
    if cfg and cfg.ForceLock then
      return false
    end
    if cfg and cfg.TimeUnLock then
      local unlockTime = UITimerHelper.GetTimeFormatByString(cfg.TimeUnLock)
      local unlock = UITimerHelper.CheckTimeUnLock(unlockTime)
      return unlock
    end
    return true
  end
end
