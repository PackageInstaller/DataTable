_class("UIBookInfoController", UIController)
UIBookInfoController = UIBookInfoController

function UIBookInfoController:OnShow(uiParams)
  self._bookData = uiParams[1]
  self._chapterIndex = uiParams[2]
  self._contentScrollView = self:GetUIComponent("UIDynamicScrollView", "ContentList")
  self._bookNameLabel = self:GetUIComponent("UILocalizationText", "BookName")
  self:_InitData()
  self:_InitUI()
end

function UIBookInfoController:_InitData()
  local chapterDatas = self._bookData:GetChapters()
  self._chapterIndexs = {}
  self._chapterContents = {}
  for i = 1, #chapterDatas do
    self._chapterIndexs[i] = #self._chapterContents
    local chapterData = chapterDatas[i]
    if chapterData:IsOpen() then
      local title = StringTable.Get("str_dispatch_book_chapter" .. i) .. chapterData:GetName()
      self._chapterContents[#self._chapterContents + 1] = BookParagraphData:New(BookParagraphType.Title, title, nil, nil, nil, false)
      local contents = chapterData:GetContents()
      for j = 1, #contents do
        self._chapterContents[#self._chapterContents + 1] = contents[j]
      end
    else
      self._chapterContents[#self._chapterContents + 1] = BookParagraphData:New(BookParagraphType.UnOpen, nil, nil, nil, chapterData, true)
    end
  end
  self._chapterContentCount = #self._chapterContents
end

function UIBookInfoController:_InitUI()
  self._bookNameLabel.text = self._bookData:GetName()
  self._contentScrollView:InitListView(self._chapterContentCount, function(scrollview, index)
    return self:_OnGetChapterInfoItem(scrollview, index)
  end)
  local index = self._chapterIndexs[self._chapterIndex]
  self._contentScrollView:MovePanelToItemIndex(index, 0)
end

function UIBookInfoController:_OnGetChapterInfoItem(scrollView, index)
  local item = scrollView:NewListViewItem("UIBookInfoItem")
  local itemIndex = index + 1
  if itemIndex > self._chapterContentCount then
    item.gameObject:SetActive(false)
  else
    self:_RefreshChapterItemInfo(item.gameObject, itemIndex)
    item.gameObject:SetActive(true)
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIBookInfoController:_RefreshChapterItemInfo(itemGo, index)
  local chapterDatas = self._bookData:GetChapters()
  local paragraphData = self._chapterContents[index]
  local tran = itemGo.transform
  local unOpenGo = tran:Find("UnOpen").gameObject
  local contentGo = tran:Find("Content").gameObject
  local textureGo = tran:Find("Texture").gameObject
  local sliderGo = tran:Find("Slider").gameObject
  local paragraphType = paragraphData:GetParagraphType()
  if paragraphType == BookParagraphType.Title then
    unOpenGo:SetActive(false)
    contentGo:SetActive(true)
    textureGo:SetActive(false)
    sliderGo:SetActive(false)
    local contentTran = tran:Find("Content/Content")
    contentTran.gameObject:SetActive(false)
    local sliderTran = tran:Find("Content/Slider")
    sliderTran.gameObject:SetActive(true)
    local emptyTran = tran:Find("Content/Empty")
    emptyTran.gameObject:SetActive(true)
    local nameTran = tran:Find("Content/Name")
    nameTran.gameObject:SetActive(true)
    local nameLabel = tran:Find("Content/Name"):GetComponent("UILocalizationText")
    nameLabel.text = paragraphData:GetTitle()
  elseif paragraphType == BookParagraphType.Text then
    unOpenGo:SetActive(false)
    contentGo:SetActive(true)
    textureGo:SetActive(false)
    local nameTran = tran:Find("Content/Name")
    nameTran.gameObject:SetActive(false)
    local sliderTran = tran:Find("Content/Slider")
    sliderTran.gameObject:SetActive(false)
    local contentTran = tran:Find("Content/Content")
    contentTran.gameObject:SetActive(true)
    local contentLabel = tran:Find("Content/Content"):GetComponent("UILocalizationText")
    contentLabel.text = paragraphData:GetText()
    if paragraphData:IsEnd() then
      sliderGo:SetActive(true)
    else
      sliderGo:SetActive(false)
    end
  elseif paragraphType == BookParagraphType.Image then
    unOpenGo:SetActive(false)
    contentGo:SetActive(false)
    textureGo:SetActive(true)
    local image = tran:Find("Texture/Image"):GetComponent("RawImageLoader")
    image:LoadImage(paragraphData:GetImage())
    local rawImage = tran:Find("Texture/Image"):GetComponent("RawImage")
    local width = rawImage.material.mainTexture.width
    local height = rawImage.material.mainTexture.height
    local layoutElement = tran:Find("Texture/Image"):GetComponent("LayoutElement")
    layoutElement.preferredWidth = width
    layoutElement.preferredHeight = height
    if paragraphData:IsEnd() then
      sliderGo:SetActive(true)
    else
      sliderGo:SetActive(false)
    end
  elseif paragraphType == BookParagraphType.UnOpen then
    unOpenGo:SetActive(true)
    sliderGo:SetActive(true)
    contentGo:SetActive(false)
    textureGo:SetActive(false)
    local unOpenName = tran:Find("UnOpen/Name"):GetComponent("UILocalizationText")
    local unOpenDes = tran:Find("UnOpen/Des"):GetComponent("UILocalizationText")
    local unOpenGetDes = tran:Find("UnOpen/GetDes"):GetComponent("UILocalizationText")
    local chapterData = paragraphData:GetChapterData()
    unOpenName.text = StringTable.Get("str_dispatch_book_chapter" .. chapterData:GetChapterId()) .. chapterData:GetName()
    local des = StringTable.Get("str_dispatch_book_des_title")
    des = string.gsub(des, " ", " ")
    unOpenDes.text = des .. chapterData:GetDes()
    local getDes = StringTable.Get("str_dispatch_book_get_des_title")
    getDes = string.gsub(getDes, " ", " ")
    unOpenGetDes.text = getDes .. chapterData:GetGetDes()
  end
end

function UIBookInfoController:MaskOnClick(go)
  self:CloseDialog()
end
