_class("UIChapters", UIController)
UIChapters = UIChapters

function UIChapters:Constructor()
  self._module = self:GetModule(MissionModule)
  self.data = self._module:GetDiscoveryData()
end

function UIChapters:OnShow(uiParams)
  self.chapterId = uiParams[1]
  self._openCallback = uiParams[2]
  self._closeCallback = uiParams[3]
  local curChapter = self.data:GetChapterByChapterId(self.chapterId)
  local section = self.data:GetDiscoverySectionByChapterId(self.chapterId)
  self.chapters = self.data:GetVisibleChaptersOfSection(section.id)
  local btnChapter = self:GetUIComponent("UISelectObjectPath", "btnChapter")
  self.uiDiscoveryChapterEnter = btnChapter:SpawnObject("UIDiscoveryChapterEnter")
  self.uiDiscoveryChapterEnter:Init(true)
  self.uiDiscoveryChapterEnter:Flush(self.chapterId)
  local content = self:GetUIComponent("UISelectObjectPath", "Content")
  content:SpawnObjects("UIChaptersItem", table.count(self.chapters))
  local items = content:GetAllSpawnList()
  local i = 1
  for k, v in pairs(self.chapters) do
    items[i]:Flush(v, curChapter)
    i = i + 1
  end
  if self._openCallback then
    self._openCallback()
  end
end

function UIChapters:OnHide()
  if self._closeCallback then
    self._closeCallback()
  end
end

function UIChapters:bgOnClick(go)
  self:CloseDialog()
end
