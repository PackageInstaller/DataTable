local UINChapterList = class("UINChapterList", UIBaseNode)
local base = UIBaseNode
local UINChapterListItem = require("Game.Sector.SectorLevelChapter.UINChapterListItem")

function UINChapterList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickSectorChapterLvConfirm)
  self.chapterItemPool = UIItemPool.New(UINChapterListItem, self.ui.obj_chapterItem)
  self.ui.obj_chapterItem:SetActive(false)
  self.__ChapterViewCallback = BindCallback(self, self.__ChapterView)
  self.ui.pageViewChapterList:onPageIndexChanged("+", self.__ChapterViewCallback)
end

function UINChapterList:InitSectorChapterList(chapterCfgList, nowIndex, callback)
  self.chapterItemPool:DeleteAll()
  self.chapterCfgList = chapterCfgList
  for i, v in pairs(chapterCfgList) do
    local item = self.chapterItemPool:GetOne()
    item:InitUINSectorChapterListItem(i)
  end
  self.callback = callback
  self.index = nowIndex
  self.ui.pageViewChapterList:InitPosList(#self.chapterCfgList)
  self:SetPageViewIndex(nowIndex)
end

function UINChapterList:SetPageViewIndex(index)
  for i, v in pairs(self.chapterItemPool.listItem) do
    if v.index == index then
      v:SetMainChapter()
    else
      v:SetSideChapter()
    end
  end
  self.ui.pageViewChapterList:SetPageIndexImmediate(index - 1, true)
end

function UINChapterList:SetRedDotStart(bool, redIndex)
  if not redIndex or redIndex == 0 then
    return
  end
  for i, v in pairs(self.chapterItemPool.listItem) do
    if v.index == redIndex then
      v:SetChapterListItemRedDotOpen(bool)
      break
    end
  end
end

function UINChapterList:OnClickSectorChapterLvConfirm()
  if self.callback ~= nil then
    self.callback(self.index)
  end
end

function UINChapterList:__ChapterView(index)
  self.index = index + 1
  for i, v in pairs(self.chapterItemPool.listItem) do
    if v.index == self.index then
      v:SetMainChapter()
    else
      v:SetSideChapter()
    end
  end
  self.ui.tex_ChapterName.text = LanguageUtil.GetLocaleText(self.chapterCfgList[self.index].chapter_name)
end

function UINChapterList:OnShow()
  UIUtil.HideTopStatus()
end

function UINChapterList:OnHide()
  UIUtil.ReShowTopStatus()
end

function UINChapterList:OnDelete()
  base.OnDelete(self)
end

return UINChapterList
