local BookParagraphType = {
  Title = 1,
  Text = 2,
  Image = 3,
  UnOpen = 4
}
_enum("BookParagraphType", BookParagraphType)
_class("BookParagraphData", Object)
BookParagraphData = BookParagraphData

function BookParagraphData:Constructor(paragraphType, title, text, image, chapterData, isEnd)
  self._paragraphType = paragraphType
  self._title = title
  self._text = text
  self._image = image
  self._chapterData = chapterData
  self._isEnd = isEnd
end

function BookParagraphData:GetParagraphType()
  return self._paragraphType
end

function BookParagraphData:GetTitle()
  return self._title
end

function BookParagraphData:GetText()
  return self._text
end

function BookParagraphData:GetImage()
  return self._image
end

function BookParagraphData:GetChapterData()
  return self._chapterData
end

function BookParagraphData:IsEnd()
  return self._isEnd
end

_class("BookChapterData", Object)
BookChapterData = BookChapterData

function BookChapterData:Constructor(cfg)
  self._index = cfg.ID
  self._chapterId = cfg.ChapterId
  self._bookId = cfg.BookId
  self._itemId = cfg.ItemId
  self._name = StringTable.Get(cfg.Name)
  self._des = StringTable.Get(cfg.Des)
  self._getDes = StringTable.Get(cfg.GetDes)
  self:_ParseContent(StringTable.Get(cfg.Content))
  self._isOpen = false
  self.itemModule = GameGlobal.GetModule(ItemModule)
  if self._itemId == nil or self._itemId <= 0 or 0 < self.itemModule:GetItemCount(self._itemId) then
    self._isOpen = true
  end
end

function BookChapterData:_ParseContent(content)
  self._contentCount = 0
  self._contents = {}
  local startIndex, endIndex = string.find(content, "<image>")
  if startIndex then
    local tempContent = content
    while startIndex do
      local desContent = string.sub(tempContent, 1, startIndex - 1)
      self._contentCount = self._contentCount + 1
      self._contents[#self._contents + 1] = BookParagraphData:New(BookParagraphType.Text, nil, desContent, nil, nil, false)
      local _, imageStartIndex = string.find(tempContent, "<image>")
      local imageEndIndex, endIndex = string.find(tempContent, "</image>")
      local imageName = string.sub(tempContent, imageStartIndex + 1, imageEndIndex - 1)
      local len = string.len(tempContent)
      tempContent = string.sub(tempContent, endIndex + 1, len)
      startIndex, _ = string.find(tempContent, "<image>")
      local isEnd = false
      if string.isnullorempty(tempContent) then
        isEnd = true
      end
      self._contentCount = self._contentCount + 1
      self._contents[#self._contents + 1] = BookParagraphData:New(BookParagraphType.Image, nil, nil, imageName, nil, isEnd)
    end
    if not string.isnullorempty(tempContent) then
      self._contentCount = self._contentCount + 1
      self._contents[#self._contents + 1] = BookParagraphData:New(BookParagraphType.Text, nil, tempContent, nil, nil, true)
    end
  else
    self._contentCount = self._contentCount + 1
    self._contents[1] = BookParagraphData:New(BookParagraphType.Text, nil, content, nil, nil, true)
  end
end

function BookChapterData:GetIndex()
  return self._index
end

function BookChapterData:GetChapterId()
  return self._chapterId
end

function BookChapterData:GetBookId()
  return self._bookId
end

function BookChapterData:GetItemId()
  return self._itemId
end

function BookChapterData:GetName()
  return self._name
end

function BookChapterData:GetDes()
  return self._des
end

function BookChapterData:GetGetDes()
  return self._getDes
end

function BookChapterData:IsOpen()
  return self._isOpen
end

function BookChapterData:GetContents()
  return self._contents
end

function BookChapterData:IsNew()
  return self.itemModule:IsNewBookChapter(self._itemId)
end

function BookChapterData:SetNewStatus(TT, status)
  self.itemModule:SetBookChapterStatus(TT, self._itemId)
end

_class("BookData", Object)
BookData = BookData

function BookData:Constructor(bookCfg)
  self._index = bookCfg.ID
  self._id = bookCfg.BookId
  self._name = StringTable.Get(bookCfg.Name)
  self._des = StringTable.Get(bookCfg.Desc)
  self._icon = bookCfg.Icon
  self._chapters = {}
  self._openCount = 0
  local chapterCfgs = Cfg.cfg_book_chapter({
    BookId = self._id
  })
  if chapterCfgs then
    for k, v in pairs(chapterCfgs) do
      local bookChapter = BookChapterData:New(v)
      self._chapters[#self._chapters + 1] = bookChapter
      if bookChapter:IsOpen() then
        self._openCount = self._openCount + 1
      end
    end
    table.sort(self._chapters, function(a, b)
      local aChapterId = a:GetChapterId()
      local bChapterId = b:GetChapterId()
      if aChapterId == bChapterId then
        return a:GetIndex() < b:GetIndex()
      end
      return aChapterId < bChapterId
    end)
  end
  self._chapterCount = table.count(self._chapters)
  self._isSelected = false
end

function BookData:GetIndex()
  return self._index
end

function BookData:GetId()
  return self._id
end

function BookData:GetName()
  return self._name
end

function BookData:GetDes()
  return self._des
end

function BookData:GetIcon()
  return self._icon
end

function BookData:IsSelected()
  return self._isSelected
end

function BookData:SetSelectedStatus(isSelected)
  self._isSelected = isSelected
end

function BookData:GetChapters()
  return self._chapters
end

function BookData:GetChapterCount()
  return self._chapterCount
end

function BookData:GetOpenChapterCount()
  return self._openCount
end

function BookData:IsNew()
  if not self._chapters then
    return false
  end
  for k, chapter in pairs(self._chapters) do
    if chapter:IsNew() then
      return true
    end
  end
  return false
end
