_class("UIChapterAwardItem", UICustomWidget)
UIChapterAwardItem = UIChapterAwardItem

function UIChapterAwardItem:OnShow()
  self._txtStarAward = self:GetUIComponent("UILocalizationText", "txtStarAward")
  self._pool = self:GetUIComponent("UISelectObjectPath", "awards")
  self._btnCollect = self:GetUIComponent("Button", "btnCollect")
  self._txtCollect = self:GetUIComponent("UILocalizationText", "txtCollect")
  self._txtStarCount = self:GetUIComponent("UILocalizationText", "txtStarCount")
end

function UIChapterAwardItem:OnHide()
end

function UIChapterAwardItem:Flush(idx, chapterData)
  self._chapterData = chapterData
  self._grade = chapterData.grades[idx]
  self._txtStarAward.text = self._grade.star_count
  self._pool:SpawnObjects("UIChapterAwardEntry", table.count(self._grade.awards))
  local awardList = self._pool:GetAllSpawnList()
  for i, v in ipairs(awardList) do
    v:Flush(self._grade.awards[i])
  end
  self._txtStarCount.gameObject:SetActive(false)
  self._btnCollect.gameObject:SetActive(false)
  if self._grade:CanCollect(chapterData.star_count) then
    self._btnCollect.gameObject:SetActive(true)
    self._btnCollect.interactable = true
    self._txtCollect.text = StringTable.Get("str_discovery_chapter_collect")
    self._txtCollect.color = Color.black
  elseif self._grade.collected then
    self._btnCollect.gameObject:SetActive(true)
    self._btnCollect.interactable = false
    self._txtCollect.text = StringTable.Get("str_discovery_chapter_collected")
    local rgb = 0.3843137254901961
    self._txtCollect.color = Color(rgb, rgb, rgb)
  else
    self._txtStarCount.gameObject:SetActive(true)
    self._txtStarCount:SetText("<color=#ED3434>" .. chapterData.star_count .. "</color>/" .. self._grade.star_count)
  end
end

function UIChapterAwardItem:btnCollectOnClick(go)
  if not self._grade:CanCollect(self._chapterData.star_count) then
    return
  end
  local module = self:GetModule(MissionModule)
  self:StartTask(function(TT)
    self:Lock("UIChapterAwardItem:btnCollectOnClick")
    local ret, data = module:ReceiveChapterAward(TT, self._grade.chapter_id, self._grade.star_count)
    if ret == MISSION_RESULT_CODE.MISSION_SUCCEED then
      self._grade.collected = true
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateChapterAwardData)
      self:ShowDialog("UIGetItemController", data)
    else
      ToastManager.ShowToast(module:GetErrorMsg(ret))
    end
    self:UnLock("UIChapterAwardItem:btnCollectOnClick")
  end, self)
end
