_class("UIMapNodeItemNextChapter", UIMapNodeItemBase)
UIMapNodeItemNextChapter = UIMapNodeItemNextChapter

function UIMapNodeItemNextChapter:Constructor()
  UIMapNodeItemNextChapter.super.Constructor(self)
  self._module = self:GetModule(MissionModule)
  self._data = self._module:GetDiscoveryData()
  self._nextChapter = nil
end

function UIMapNodeItemNextChapter:OnHide()
  self._nextChapter = nil
end

function UIMapNodeItemNextChapter:GetUIComponentStar()
end

function UIMapNodeItemNextChapter:Init(nextChapterData, notPlayAnimation)
  self._nextChapter = nextChapterData
  self._notPlayAnimation = notPlayAnimation
  self._rectTransform.anchorMax = self._vec0_5
  self._rectTransform.anchorMin = self._vec0_5
  self._rectTransform.sizeDelta = Vector2(100, 100)
  self._rectTransform.anchoredPosition = self._nextChapter.pos
  self.eff:SetActive(false)
  local chapter = self._data:GetChapterByChapterId(self._nextChapter.chapterId)
  if chapter and chapter:State() then
    self.txtTip.text = chapter.name or ""
  else
    self.txtTip.text = StringTable.Get("str_discovery_coming_soon")
  end
end

function UIMapNodeItemNextChapter:Flush()
  self:FlushState()
  self:Animation()
end

function UIMapNodeItemNextChapter:FlushState()
  local curChapter = self._data:GetCurPosChapter()
  local isComplete = curChapter:IsComplete()
  self._root:SetActive(isComplete)
end

function UIMapNodeItemNextChapter:FlushStar()
end

function UIMapNodeItemNextChapter:ClickItem()
  local chapter = self._data:GetChapterByChapterId(self._nextChapter.chapterId)
  if chapter and chapter:State() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryFlushChapter, self._nextChapter.chapterId)
  else
    ToastManager.ShowToast(StringTable.Get("str_discovery_coming_soon_hint"))
  end
end

function UIMapNodeItemNextChapter:Animation()
  if self:IsFirstShow() then
    self:SaveIsFirstShow()
  end
  self:PlayTipAnim()
end

function UIMapNodeItemNextChapter:Highlight(isHighlight, chapterId)
end

function UIMapNodeItemNextChapter:GetTipAnimName()
  return "uieff_UINormNodeNext_in"
end

function UIMapNodeItemNextChapter:GetTip()
  if self._nextChapter then
    return self._tipRoot
  end
end

function UIMapNodeItemNextChapter:IsFirstShow()
  local playerPrefsKey = self:GetPstId() .. "DiscoveryNextChapterIsFirstShow" .. self._nextChapter.chapterId
  local isFirst = UnityEngine.PlayerPrefs.GetInt(playerPrefsKey, 0)
  return isFirst == 0
end

function UIMapNodeItemNextChapter:SaveIsFirstShow()
  local playerPrefsKey = self:GetPstId() .. "DiscoveryNextChapterIsFirstShow" .. self._nextChapter.chapterId
  UnityEngine.PlayerPrefs.SetInt(playerPrefsKey, 1)
end

function UIMapNodeItemNextChapter:GetPstId()
  local roleModule = GameGlobal.GetModule(RoleModule)
  return roleModule:GetPstId()
end
