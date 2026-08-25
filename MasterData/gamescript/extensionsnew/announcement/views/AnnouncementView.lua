local AnnouncementView, Super = NewClass("AnnouncementView", BaseView)
AnnouncementView.uiResCls = UI_Login_Popup_TipsResource
local SdkNoticePage = CommonDefine.SdkNoticePage
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local Vector2 = CS.UnityEngine.Vector2

function AnnouncementView:ctor(annMap)
  Super.ctor(self)
  self._annMap = annMap
  self._contents = {}
  self._curContentHeights = {}
  self._noticeItemComps = {}
  self._curLoadAnnCount = 0
  self._isLoadAll = false
end

function AnnouncementView:OnBuildView()
  self:_InitNoticeTableView()
  self:_InitContentTableView()
  self:_InitMeasureNode()
end

function AnnouncementView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnAnnouncementPageChanged, self._OnPageChanged, self)
  self:RegisterNotify(NotifyId.OnAnnouncementCurUidChanged, self._OnCurUidChanged, self)
  self:RegisterNotify(NotifyId.OnAnnouncementRedDataChanged, self._OnRedDataChanged, self)
end

function AnnouncementView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self._OnClickClose))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._OnClickClose))
  self:AddButtonClickListener(self.ui.Btn_Load, System.fn(self, self._OnClickLoadAnn))
  self:AddButtonClickListener(self.ui.Btn_ReadAll, System.fn(self, self._OnClickReadAll))
  self:AddButtonClickListener(self.ui.Btn_Game, function()
    self:_OnClickPageBtn(SdkNoticePage.GameNotice)
  end)
  self:AddButtonClickListener(self.ui.Btn_Activity, function()
    self:_OnClickPageBtn(SdkNoticePage.ActivityNotice)
  end)
  self:AddButtonClickListener(self.ui.Btn_BugFixes, function()
    self:_OnClickPageBtn(SdkNoticePage.BugFixes)
  end)
  self:BindEvent(EventMgr.Instance.SelectAnnouncementEvent, function(uid, scrollToTop)
    self:_OnSelectAnnouncement(uid, scrollToTop)
  end)
end

function AnnouncementView:OnEnterView()
  Super.OnEnterView(self)
  local model = AnnouncementModel.Instance
  model:InitData(self._annMap)
  model:SetPage(SdkNoticePage.GameNotice)
  AnnouncementRedUtils.InitRed(model:GetAnnListMap())
  self:_InitPageTabRedDots()
  self:_RefreshPageTabs()
  self:_RefreshNoticeList()
  self:_RefreshSubTitle()
  self:_RefreshContentImage()
  self:_RefreshEmptyState()
  self:_RefreshReadAllBtn()
  model:InitDefaultSelection()
end

function AnnouncementView:OnExitView()
  self:_RemovePageTabRedDots()
  self:_DestroyMeasureNode()
  Super.OnExitView(self)
end

function AnnouncementView:_InitNoticeTableView()
  self._noticeItemComps = {}
  self._noticeView = self:CreateTableview(self.ui.ScrollView_Notice, function()
    local showAnns = AnnouncementModel.Instance:GetShowAnns()
    if not showAnns then
      return 0
    end
    return #showAnns
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Login_Btn_Notice)
    local gameObj = cell.gameObject
    if self._noticeItemComps[gameObj] then
      self:RemoveViewComponentOnce(gameObj, AnnouncementTitleItem)
    end
    local showAnns = AnnouncementModel.Instance:GetShowAnns()
    local data = showAnns[index]
    self._noticeItemComps[gameObj] = self:AddViewComponent(gameObj, AnnouncementTitleItem, data)
    self:_CheckLoadMoreAnn(index)
    return cell
  end, function()
    return 454, 112
  end, function()
    self._noticeItemComps = {}
  end)
  self._noticeView:ReloadData()
end

function AnnouncementView:_InitContentTableView()
  local baseGameObj = self.ui.Text_Content
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW = sizeDelta.x
  self._contentItemW = itemW
  self._contentTableView = self:CreateTableview(self.ui.ScrollView_Content, function()
    return #self._contents
  end, function(view, idx)
    local cell = self:DequeueCell(view, baseGameObj)
    local gameObj = cell.gameObject
    self:LoadAllLangFont(gameObj)
    self:SetText(gameObj, self._contents[idx], nil, function(linkText)
      local linkInfo = StrUtils.GetLinkInfo(linkText)
      if linkInfo.cfgName ~= "Url" then
        return
      end
      local url = linkInfo and linkInfo.showContent
      if not url or "" == url then
        return
      end
      ApplicationUtils.OpenURL(url)
    end)
    return cell
  end, function(view, index)
    local itemH = self._curContentHeights and self._curContentHeights[index] or 30
    return self._contentItemW, itemH
  end)
end

function AnnouncementView:_OnPageChanged()
  self._curLoadAnnCount = 0
  self._isLoadAll = false
  self:_RefreshPageTabs()
  self:_RefreshNoticeList()
  self:_RefreshSubTitle()
  self:_RefreshContentImage()
  self:_RefreshEmptyState()
  self:_RefreshReadAllBtn()
  AnnouncementModel.Instance:InitDefaultSelection()
end

function AnnouncementView:_OnCurUidChanged(uid)
  self:_RefreshSubTitle()
  self:_RefreshContentImage()
  self:_UpdateContentItems(uid)
end

function AnnouncementView:_OnRedDataChanged()
  self:_RefreshPageTabs()
  self:_RefreshReadAllBtn()
  RedDotController.Instance:RefreshAllRedDots()
end

function AnnouncementView:_OnSelectAnnouncement(uid, scrollToTop)
  local data = AnnouncementModel.Instance:GetAnnData(uid)
  if not data or not data.content then
    return
  end
  if data.new then
    AnnouncementController.Instance:MarkAnnRead(data)
  end
  if scrollToTop and data.index then
    local showAnns = AnnouncementModel.Instance:GetShowAnns()
    if showAnns and #showAnns > 0 then
      local scrollRect = self.ui.ScrollView_Notice:GetComponent(T_ScrollRect)
      if scrollRect then
        local total = #showAnns
        local idx = math.max(1, math.min(data.index, total))
        scrollRect.verticalNormalizedPosition = total > 1 and 1 - (idx - 1) / (total - 1) or 1
      end
    end
  end
end

function AnnouncementView:_RefreshPageTabs()
  local page = AnnouncementModel.Instance:GetPage()
  self:SetButtonChosen(self.ui.Btn_Game, page == SdkNoticePage.GameNotice)
  self:SetButtonChosen(self.ui.Btn_Activity, page == SdkNoticePage.ActivityNotice)
  self:SetButtonChosen(self.ui.Btn_BugFixes, page == SdkNoticePage.BugFixes)
end

function AnnouncementView:_InitPageTabRedDots()
  self:AddRedPoint(self.ui.Red_Game, RedDotDefine.DynamicRedDotID.AnnouncementPageTab, {
    page = SdkNoticePage.GameNotice
  })
  self:AddRedPoint(self.ui.Red_Activity, RedDotDefine.DynamicRedDotID.AnnouncementPageTab, {
    page = SdkNoticePage.ActivityNotice
  })
  self:AddRedPoint(self.ui.Red_BugFixes, RedDotDefine.DynamicRedDotID.AnnouncementPageTab, {
    page = SdkNoticePage.BugFixes
  })
end

function AnnouncementView:_RemovePageTabRedDots()
  if self.ui.Red_Game then
    self:RemoveRedPoint(self.ui.Red_Game)
  end
  if self.ui.Red_Activity then
    self:RemoveRedPoint(self.ui.Red_Activity)
  end
  if self.ui.Red_BugFixes then
    self:RemoveRedPoint(self.ui.Red_BugFixes)
  end
end

function AnnouncementView:_RefreshNoticeList()
  if self._noticeView then
    self._noticeView:ReloadData()
  end
end

function AnnouncementView:_RefreshSubTitle()
  local data = AnnouncementModel.Instance:GetAnnData(AnnouncementModel.Instance:GetCurrUid())
  if not data then
    self:SetText(self.ui.Text_Introduce, "")
    return
  end
  self:SetText(self.ui.Text_Introduce, LT.Text(data.subTitle))
end

function AnnouncementView:_RefreshContentImage()
  local data = AnnouncementModel.Instance:GetAnnData(AnnouncementModel.Instance:GetCurrUid())
  if not (data and data.imagePath) or data.imagePath == "" then
    self.ui.Image_Map:SetActive(false)
    return
  end
  self.ui.Image_Map:SetActive(true)
  self:SetImage(self.ui.Image_Map, data.imagePath)
end

function AnnouncementView:_RefreshEmptyState()
  local showAnns = AnnouncementModel.Instance:GetShowAnns()
  local isEmpty = not showAnns or #showAnns <= 0
  self.ui.Group_Null:SetActive(isEmpty)
  self.ui.ScrollView_Notice:SetActive(not isEmpty)
  self.ui.ScrollView_Content:SetActive(not isEmpty)
end

function AnnouncementView:_RefreshReadAllBtn()
  local showAnns = AnnouncementModel.Instance:GetShowAnns()
  local hasAnns = showAnns and #showAnns > 0
  self.ui.Btn_ReadAll:SetActive(hasAnns)
  binder:SetText(self.ui.Text_ReadAll, LT.Text("ReadAllStr"))
  local isRed = AnnouncementRedUtils.GetEntranceRed()
  if isRed then
    self:SetButtonState(self.ui.Btn_ReadAll, CommonDefine.Z1ButtonState.High)
  else
    self:SetButtonState(self.ui.Btn_ReadAll, CommonDefine.Z1ButtonState.Unclickable)
  end
end

function AnnouncementView:_UpdateContentItems(currUid)
  if not currUid then
    return
  end
  local model = AnnouncementModel.Instance
  local data = model:GetAnnData(currUid)
  if not data or not data.content then
    return
  end
  self._contents = StrUtils.SplitAnnounce(data.content)
  local heights = model:GetContentHeights(currUid)
  if not heights then
    heights = self:_ComputeContentHeights(self._contents)
    model:CacheContentHeights(currUid, heights)
  end
  self._curContentHeights = heights
  if self._contentTableView then
    self._contentTableView:SetOffset(0, false)
    self._contentTableView:ReloadData()
  end
end

function AnnouncementView:_InitMeasureNode()
  if self._measureGo then
    return
  end
  local template = self.ui.Text_Content
  local clone = Instantiate(template.gameObject, template.transform.parent)
  clone.name = "Announcement_Measure"
  clone.transform.localScale = CS.UnityEngine.Vector3.zero
  self._measureGo = clone
  self._measureTextGo = clone
  self._measureTextRect = clone.transform
  self:LoadAllLangFont(clone)
end

function AnnouncementView:_DestroyMeasureNode()
  if self._measureGo and not IsNil(self._measureGo) then
    Destroy(self._measureGo)
    self._measureGo = nil
    self._measureTextGo = nil
    self._measureTextRect = nil
  end
end

function AnnouncementView:_ComputeContentHeights(contents)
  local heights = {}
  if not contents or 0 == #contents then
    return heights
  end
  if not self._measureTextGo or IsNil(self._measureTextGo) then
    self:_InitMeasureNode()
  end
  local textGo = self._measureTextGo
  local rectTransform = self._measureTextRect
  local baseWidth = rectTransform.sizeDelta.x
  for i = 1, #contents do
    rectTransform.sizeDelta = Vector2(baseWidth, 0)
    self:SetText(textGo, contents[i])
    local h = StrUtils.SetPreferredHeight(textGo)
    heights[i] = not (0 ~= h and h) and 30 or h
  end
  return heights
end

function AnnouncementView:_OnClickPageBtn(page)
  local model = AnnouncementModel.Instance
  model:ResetLoadAnnCnt()
  model:SetPage(page)
end

function AnnouncementView:_CheckLoadMoreAnn(idx)
  local model = AnnouncementModel.Instance
  local showAnns = model:GetShowAnns()
  local showAnnCnt = showAnns and #showAnns or 0
  if showAnnCnt < 4 then
    self.ui.Btn_Load:SetActive(false)
    return
  end
  local curMinIndex = math.huge
  local curMaxIndex = -1
  local cnt = self._noticeView:GetVisibleCount()
  for i = 0, cnt - 1 do
    local cell = self._noticeView:GetCellByIndex(i)
    if curMaxIndex < cell.index then
      curMaxIndex = cell.index
    end
    if curMinIndex > cell.index then
      curMinIndex = cell.index
    end
  end
  curMaxIndex = curMaxIndex + 1
  curMinIndex = curMinIndex + 1
  self.ui.Btn_Load:SetActive(showAnnCnt > curMaxIndex)
  if self._isLoadAll then
    return
  end
  if showAnnCnt <= self._curLoadAnnCount then
    self._isLoadAll = true
    return
  end
  if idx == showAnnCnt then
    self._curLoadAnnCount = showAnnCnt
    model:AddLoadAnnCnt()
    self._noticeView:ReloadData()
  end
end

function AnnouncementView:_OnClickClose()
  self:Close()
end

function AnnouncementView:_OnClickLoadAnn()
  Alert.Show(20228)
end

function AnnouncementView:_OnClickReadAll()
  AnnouncementController.Instance:MarkAllRead()
end

return AnnouncementView
