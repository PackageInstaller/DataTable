_class("UIChapterAward", UIController)
UIChapterAward = UIChapterAward

function UIChapterAward:Constructor()
  self._module = self:GetModule(MissionModule)
  self._module:SetShowChapterPreview(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FlushChapterPreview)
  self._data = self._module:GetDiscoveryData()
end

function UIChapterAward:OnShow(uiParams)
  self._chapterId = uiParams[1]
  self._txtStarCount = self:GetUIComponent("UILocalizationText", "txtStarCount")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self:Flush()
  self:AttachEvent(GameEventType.UpdateChapterAwardData, self.Flush)
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UIChapterAward:OnHide()
  self:DetachEvent(GameEventType.UpdateChapterAwardData, self.Flush)
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UIChapterAward:Flush()
  local chapterData = self._data.chapterAwardData:GetChapterAwardChapterByChapterId(self._chapterId)
  if not chapterData then
    Log.warn("### no award in chapter:", self._chapterId)
    return
  end
  self._content:SpawnObjects("UIChapterAwardItem", table.count(chapterData.grades))
  self._grades = self._content:GetAllSpawnList()
  self._txtStarCount:SetText(StringTable.Get("str_discovery_chapter_star_count") .. StringTable.Get("str_common_colon") .. "<color=#ffad48>" .. chapterData.star_count .. "</color>")
  for i, v in ipairs(self._grades) do
    v:Flush(i, chapterData)
  end
end

function UIChapterAward:bgOnClick(go)
  self:CloseDialog()
end

function UIChapterAward:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end
