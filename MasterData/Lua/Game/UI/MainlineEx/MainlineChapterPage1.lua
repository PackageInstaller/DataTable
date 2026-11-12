local MainlineChapterPage1 = class("MainlineChapterPage1", BaseCtrl)
local tbAllChapter = {
  1,
  2,
  3,
  4,
  5
}
local mapColor = {
  [true] = Color()
}
MainlineChapterPage1._mapNodeConfig = {
  Chapter = {
    nCount = 5,
    sCtrlName = "Game.UI.MainlineEx.MainlineChapter"
  },
  Trail_ = {nCount = 5},
  Zs = {nCount = 5}
}
MainlineChapterPage1._mapEventConfig = {
  SelectChapter = "OnEvent_SelectChapter"
}

function MainlineChapterPage1:Awake()
end

function MainlineChapterPage1:FadeOut(callback)
  if type(callback) == "function" then
    callback()
  end
end

function MainlineChapterPage1:OnEnable()
end

function MainlineChapterPage1:OnDisable()
end

function MainlineChapterPage1:OnDestroy()
end

function MainlineChapterPage1:OnRelease()
end

function MainlineChapterPage1:Init(tbChapter, curChapter)
  self.tbChapter = tbChapter
  for i, ChapterIdx in ipairs(tbAllChapter) do
    if self.tbChapter[ChapterIdx] == nil then
      self._mapNode.Chapter[i]:Init()
      self._mapNode.Zs[i]:SetActive(false)
    else
      self._mapNode.Chapter[i]:Init(self.tbChapter[ChapterIdx].nId)
      self._mapNode.Chapter[i]:SetUnlock(self.tbChapter[ChapterIdx].bUnlock)
      self._mapNode.Chapter[i]:SetCur(self.tbChapter[ChapterIdx].nId == curChapter)
      self._mapNode.Chapter[i]:SetSelect(self.tbChapter[ChapterIdx].nId == curChapter)
      self._mapNode.Chapter[i]:SetComplete(self.tbChapter[ChapterIdx].bComplete)
      self._mapNode.Zs[i]:SetActive(self.tbChapter[ChapterIdx].bUnlock)
      if self.tbChapter[ChapterIdx].nId == curChapter then
        self.curIdx = i
      end
    end
  end
end

function MainlineChapterPage1:OnEvent_SelectChapter(nChapter)
  for i, ChapterIdx in ipairs(tbAllChapter) do
    if self.tbChapter[ChapterIdx] ~= nil and self.tbChapter[ChapterIdx].nId == nChapter then
      if self.curIdx ~= 0 then
        self._mapNode.Chapter[self.curIdx]:SetSelect(false)
      end
      self._mapNode.Chapter[i]:SetSelect(true)
      self.curIdx = i
    end
  end
end

return MainlineChapterPage1
