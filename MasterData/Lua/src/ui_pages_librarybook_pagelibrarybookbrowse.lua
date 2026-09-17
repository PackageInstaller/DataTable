local this = class("pageLibraryBookBrowse", G_UIPageBase)
local _libraryReadingsTpl = L_GameTpl:getLibraryReadingsTpl()
local _librarySeriesTpl = L_GameTpl:getLibrarySeriesTpl()
local DESCTYPE = {
  img = 1,
  desc = 2,
  centerdesc = 3
}
local BG_TYPE = {
  charlulu = 1,
  fleece = 2,
  jinghua = 3,
  paper = 4,
  s_charlulu = 5,
  s_fleece = 6,
  s_jinghua = 7
}

function this.bind()
  return {
    listTab = {
      moduleName = "pages/libraryBook/cellLibraryBrowseTabItem"
    },
    txtBookName = "",
    txtAuthor = "",
    listTabRoot = false,
    imgOri = nil,
    txtDescOri = nil,
    tfmSubBookName = false,
    txtSubBookName = "",
    tfmScrollView = false,
    tfmEmpty = false,
    tfmLeftBtn = false,
    tfmRightBtn = false,
    imgBookBg = "",
    tfmCharlulu = false,
    tfmFleece = false,
    tfmJinghua = false,
    tfmPaper = false,
    tfmSCharlulu = false,
    tfmSFleece = false,
    tfmSJinghua = false,
    imgPaperOutSide2 = "",
    imgPaperOutSide3 = "",
    imgPaperOutSide4 = "",
    imgSjinghuaOutSideBack = "",
    imgCharlulu = "",
    imgFleece = "",
    imgJinghua = "",
    imgPaper = "",
    imgSCharlulu = "",
    imgSFleece = "",
    imgSJinghua = "",
    go_subBookName = false
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.cacheDescObj = {}
  self.cacheImgObj = {}
  L_LibraryBookStore:listenCallFunc(L_LibraryBookStore.event.libraryBookChange, self.refreshAll, self)
  self:initData(options)
  self:initSubTab()
  self:refresh()
  self:refreshScrollView()
  self:refreshTabCellSelected()
end

function this:close()
  this.super.close(self)
  if self.closeCB then
    self.closeCB()
    self.closeCB = nil
  end
  L_LibraryBookStore:unListenCallFunc(L_LibraryBookStore.event.libraryBookChange, self.refreshAll)
end

function this.methods()
  return {
    onClickClose = function(self)
      L_UI:close(self.pageName)
    end,
    onClickLeft = function(self)
      local preId = -1
      local seriesTpl = _librarySeriesTpl:getTplById(self.seriesId)
      for k, v in pairs(seriesTpl.subId) do
        if v == self.selectedBookBrowseId then
          break
        end
        preId = v
      end
      if preId ~= -1 then
        self.selectedBookBrowseId = preId
        self:refreshAll()
      end
    end,
    onClickRight = function(self)
      local nextId = -1
      local findSign = false
      local seriesTpl = _librarySeriesTpl:getTplById(self.seriesId)
      for k, v in pairs(seriesTpl.subId) do
        if findSign then
          nextId = v
          break
        end
        if v == self.selectedBookBrowseId then
          findSign = true
        end
      end
      if nextId ~= -1 then
        self.selectedBookBrowseId = nextId
        self:refreshAll()
      end
    end
  }
end

function this:refresh()
  local seriesTpl = _librarySeriesTpl:getTplById(self.seriesId)
  local bookReadingTpl = _libraryReadingsTpl:getTplById(self.selectedBookBrowseId)
  if seriesTpl == nil or bookReadingTpl == nil then
    return
  end
  self.bind.txtBookName = L_Config:provider(seriesTpl.name)
  self.bind.txtAuthor = _libraryReadingsTpl:getAuthor(bookReadingTpl)
  self.bind.tfmSubBookName = bookReadingTpl.subTitle ~= nil and bookReadingTpl.subTitle ~= ""
  self.bind.txtSubBookName = _libraryReadingsTpl:getSubTitle(bookReadingTpl)
  self.bind.go_subBookName = true
  if self.bind.txtSubBookName == "" then
    self.bind.go_subBookName = false
  end
  local isBookCollected = L_LibraryBookStore:isLibraryBookCollect(self.selectedBookBrowseId) or self.forceShow
  if self.forceShowBookId and self.forceShowBookId == self.selectedBookBrowseId then
    isBookCollected = true
  end
  self.bind.tfmScrollView = isBookCollected
  self.bind.tfmEmpty = not isBookCollected
  L_LibraryBookStore:req_bookReadBySeriesId(self.seriesId)
  self.bind.tfmLeftBtn = self.selectedBookBrowseId ~= seriesTpl.subId[1]
  self.bind.tfmRightBtn = self.selectedBookBrowseId ~= seriesTpl.subId[#seriesTpl.subId]
  self.bind.imgBookBg = seriesTpl.icon
  self:setBgByType()
end

function this:initData(options)
  if options.forceShow then
    self.forceShow = options.forceShow
  else
    self.forceShow = false
  end
  if options.closeCB then
    self.closeCB = options.closeCB
  end
  if options.seriesId then
    self.seriesId = options.seriesId
  end
  self.forceShowBookId = options.forceShowBookId
  if options.bookBrowseId then
    self.selectedBookBrowseId = options.bookBrowseId
    self.seriesId = _librarySeriesTpl:getIdBySubId(options.bookBrowseId).id
  else
    self.selectedBookBrowseId = self:getDefaultSelectedId()
  end
end

function this:initSubTab()
  local seriesTpl = _librarySeriesTpl:getTplById(self.seriesId)
  if #seriesTpl.subId <= 1 then
    self.bind.listTabRoot = false
  else
    self.bind.listTabRoot = true
    local tag = {}
    for i, v in ipairs(seriesTpl.subId) do
      table.insert(tag, {
        id = v,
        index = i * 2 - 1,
        callback = function(tab)
          self:tabClicked(tab)
        end
      })
      if i == #seriesTpl.subId then
        break
      end
      table.insert(tag, {
        id = 0,
        index = i * 2
      })
    end
    self.bind.listTab:clear()
    self.bind.listTab:insert_array(tag)
  end
end

function this:getDefaultSelectedId()
  local seriesTpl = _librarySeriesTpl:getTplById(self.seriesId)
  if #seriesTpl.subId == 1 then
    return seriesTpl.subId[1]
  else
    for k, v in pairs(seriesTpl.subId) do
      if L_LibraryBookStore:isLibraryBookCollect(v) then
        return v
      end
    end
    return seriesTpl.subId[1]
  end
end

function this:refreshAll()
  self:refresh()
  self:refreshScrollView()
  self:refreshTabCellSelected()
end

function this:tabClicked(tab)
  self.selectedBookBrowseId = tab.id
  self:refreshAll()
end

function this:refreshTabCellSelected()
  for i, v in pairs(self.modules.listTab) do
    local cell = v
    cell:setSelected(self.selectedBookBrowseId == v.bind.id)
  end
end

function this:refreshScrollView()
  self.bindComponents.rtfImgOri.gameObject:SetActive(false)
  self.bindComponents.rtfDescOri.gameObject:SetActive(false)
  self.curDescCount = 0
  self.curImgCount = 0
  if self.cacheDescObj ~= nil then
    for k, v in pairs(self.cacheDescObj) do
      v:SetActive(false)
    end
  end
  if self.cacheImgObj ~= nil then
    for k, v in pairs(self.cacheImgObj) do
      v:SetActive(false)
    end
  end
  local tempLibraryReading = _libraryReadingsTpl:getTplById(self.selectedBookBrowseId)
  local analysizedDescList = self:analysizeDesc(_libraryReadingsTpl:getDetail(tempLibraryReading))
  for k, v in pairs(analysizedDescList) do
    if v.type == DESCTYPE.desc or v.type == DESCTYPE.centerdesc then
      local tmpDesc
      self.curDescCount = self.curDescCount + 1
      if #self.cacheDescObj >= self.curDescCount then
        tmpDesc = self.cacheDescObj[self.curDescCount]
      else
        tmpDesc = CS.Lens.Framework.AzurAssets.Instantiate(self.bindComponents.rtfDescOri.gameObject, false, self.bindComponents.scrollViewContent).Result
        table.insert(self.cacheDescObj, tmpDesc)
      end
      local tmpRtfDesc = tmpDesc:GetComponent(typeof(C_RectTransform))
      tmpRtfDesc:SetAsLastSibling()
      tmpDesc:SetActive(true)
      local text = tmpDesc.transform:GetComponent(typeof(C_LTextMeshProUGUI))
      text.text = v.value
      text.horizontalAlignment = v.type == DESCTYPE.centerdesc and 2 or 1
    else
      local tmpImg
      self.curImgCount = self.curImgCount + 1
      if #self.cacheImgObj >= self.curImgCount then
        tmpImg = self.cacheImgObj[self.curImgCount]
      else
        tmpImg = CS.Lens.Framework.AzurAssets.Instantiate(self.bindComponents.rtfImgOri.gameObject, false, self.bindComponents.scrollViewContent).Result
        table.insert(self.cacheImgObj, tmpImg)
      end
      local tmpRtfImg = tmpImg:GetComponent(typeof(C_RectTransform))
      tmpRtfImg:SetAsLastSibling()
      tmpImg:SetActive(true)
      local icon = tmpImg.transform:GetComponent(typeof(C_LImage))
      icon:LoadSprite(v.value, false)
    end
  end
  self.bindComponents.bookScrollView.verticalNormalizedPosition = 1
  FrameScheduler.add(function()
    local isCanVertical = self.bindComponents.tfmViewport.rect.height < self.bindComponents.scrollViewContent.rect.height
    self.bindComponents.bookScrollView.vertical = isCanVertical
  end)
end

function this:analysizeDesc(text)
  local result = {}
  local patterns = {
    {
      tag = "lbimg",
      type = DESCTYPE.img
    },
    {
      tag = "lbcenterDesc",
      type = DESCTYPE.centerdesc
    }
  }
  local last_end = 1
  while last_end <= #text do
    local earliest
    for _, patternInfo in ipairs(patterns) do
      local tag = patternInfo.tag
      local pattern = "<" .. tag .. ">(.-)</" .. tag .. ">"
      local start_pos, end_pos, inside = string.find(text, pattern, last_end)
      if start_pos and (not earliest or start_pos < earliest.start_pos) then
        earliest = {
          start_pos = start_pos,
          end_pos = end_pos,
          inside = inside,
          type = patternInfo.type
        }
      end
    end
    if not earliest then
      break
    end
    if last_end < earliest.start_pos then
      local before = string.sub(text, last_end, earliest.start_pos - 1)
      if before ~= "" then
        table.insert(result, {
          type = DESCTYPE.desc,
          value = before
        })
      end
    end
    table.insert(result, {
      type = earliest.type,
      value = earliest.inside
    })
    last_end = earliest.end_pos + 1
  end
  if last_end <= #text then
    local rest = string.sub(text, last_end)
    if rest ~= "" then
      table.insert(result, {
        type = DESCTYPE.desc,
        value = rest
      })
    end
  end
  return result
end

function this:setBgByType()
  local seriesTpl = _librarySeriesTpl:getTplById(self.seriesId)
  local type = seriesTpl.bg
  local bgList = {
    self.bind.tfmCharlulu,
    self.bind.tfmFleece,
    self.bind.tfmJinghua,
    self.bind.tfmPaper,
    self.bind.tfmSCharlulu,
    self.bind.tfmSFleece,
    self.bind.tfmSJinghua
  }
  for k, v in pairs(bgList) do
    v = false
  end
  if type == BG_TYPE.charlulu then
    self.bind.tfmCharlulu = true
    self.bind.imgCharlulu = "UI/Texture/IllustrationBook/tex_library_bg_charlulu.png"
  elseif type == BG_TYPE.fleece then
    self.bind.tfmFleece = true
    self.bind.imgFleece = "UI/Texture/IllustrationBook/tex_library_bg_fleece.png"
  elseif type == BG_TYPE.jinghua then
    self.bind.tfmJinghua = true
    self.bind.imgJinghua = "UI/Texture/IllustrationBook/tex_library_bg_jinghua.png"
  elseif type == BG_TYPE.paper then
    self.bind.tfmPaper = true
    self.bind.imgPaper = "UI/Texture/IllustrationBook/tex_library_bg_paper_4.png"
    self.bind.imgPaperOutSide2 = "UI/Texture/IllustrationBook/tex_library_bg_paper_3.png"
    self.bind.imgPaperOutSide3 = "UI/Texture/IllustrationBook/tex_library_bg_paper_2.png"
    self.bind.imgPaperOutSide4 = "UI/Texture/IllustrationBook/tex_library_bg_paper_1.png"
  elseif type == BG_TYPE.s_charlulu then
    self.bind.tfmSCharlulu = true
    self.bind.imgSCharlulu = "UI/Texture/IllustrationBook/tex_library_bg_s_charlulu.png"
  elseif type == BG_TYPE.s_fleece then
    self.bind.tfmSFleece = true
    self.bind.imgSFleece = "UI/Texture/IllustrationBook/tex_library_bg_s_fleece_4.png"
  elseif type == BG_TYPE.s_jinghua then
    self.bind.tfmSJinghua = true
    self.bind.imgSJinghua = "UI/Texture/IllustrationBook/tex_library_bg_s_jinghua.png"
    self.bind.imgSjinghuaOutSideBack = "UI/Texture/IllustrationBook/tex_library_bg_s_jinghua.png"
  end
end

return this
