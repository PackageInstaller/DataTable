local AnnouncementPanel, Super = System.NewClass("AnnouncementPanel", UIBasePanel)
AnnouncementPanel.uiResCls = UI_Login_Popup_TipsResource

function AnnouncementPanel:ctor(annMap)
  Super.ctor(self)
  self.annMap = annMap
  self.contents = {}
  self.realTextHeightMap = {}
  self.contentItems = {}
  self.curLoadAnnCount = 0
  self.isLoadAll = false
end

function AnnouncementPanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(AnnouncementModel, self.annMap)
  self.model:SetPage("GameNotice")
  AnnouncementRedUtils.InitRed(self.model.annListMap)
  self:InitContentTableView()
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.OnClickClose))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnClickClose))
  binder:BindButtonClick(self.ui.Btn_Load, System.fn(self, self.OnClickLoadAnn))
  local noticeItemComps = {}
  self.noticeView = self:CreateTableview(self.ui.ScrollView_Notice, function()
    if not self.model.showAnns then
      return 0
    end
    return #self.model.showAnns
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Login_Btn_Notice)
    local gameObj = cell.gameObject
    if noticeItemComps[gameObj] then
      noticeItemComps[gameObj].binder:teardown()
    end
    local data = self.model.showAnns[index]
    noticeItemComps[gameObj] = self.binder:BindComponent(AnnouncementTitleComponent(gameObj, data, self.model))
    self:CheckLoadMoreAnn(index)
    return cell
  end, function()
    return 454, 112
  end, function()
    noticeItemComps = nil
  end)
  self.noticeView:ReloadData()
  binder:BindToText(self.ui.Text_Introduce, System.fn(self, self._SetSubTitle))
  binder:BindToImage(self.ui.Image_Map, System.fn(self, self._SetContentImage))
  binder:BindToVisible(self.ui.Image_Map, System.fn(self, self._SetContentImageVisible))
  binder:BindZ1Button(self.ui.Btn_Game, function()
    self:_OnClickPageBtn(CommonDefine.SdkNoticePage.GameNotice)
  end, nil, nil, function()
    local page = CommonDefine.SdkNoticePage.GameNotice
    local data = AnnouncementRedUtils.GetNoticePageRedData(page)
    local state = RedPointDataUtils.ShowRedPointState(data)
    return state
  end, function()
    return self.model.page == CommonDefine.SdkNoticePage.GameNotice
  end)
  binder:BindZ1Button(self.ui.Btn_Activity, function()
    self:_OnClickPageBtn(CommonDefine.SdkNoticePage.ActivityNotice)
  end, nil, nil, function()
    local page = CommonDefine.SdkNoticePage.ActivityNotice
    local data = AnnouncementRedUtils.GetNoticePageRedData(page)
    local state = RedPointDataUtils.ShowRedPointState(data)
    return state
  end, function()
    return self.model.page == CommonDefine.SdkNoticePage.ActivityNotice
  end)
  binder:BindZ1Button(self.ui.Btn_BugFixes, function()
    self:_OnClickPageBtn(CommonDefine.SdkNoticePage.BugFixes)
  end, nil, nil, function()
    local page = CommonDefine.SdkNoticePage.BugFixes
    local data = AnnouncementRedUtils.GetNoticePageRedData(page)
    local state = RedPointDataUtils.ShowRedPointState(data)
    return state
  end, function()
    return self.model.page == CommonDefine.SdkNoticePage.BugFixes
  end)
  binder:BindToVisible(self.ui.Group_Null, System.fn(self, self._EmptyStateVisible))
  binder:BindToVisible(self.ui.ScrollView_Notice, function()
    local isEmpty = self:_EmptyStateVisible()
    return not isEmpty
  end)
  binder:BindToVisible(self.ui.ScrollView_Content, function()
    local isEmpty = self:_EmptyStateVisible()
    return not isEmpty
  end)
  binder:BindToRaw(System.fn(self, self._UpdateContentItems), function()
    return self.model.currUid
  end)
  binder:BindEvent(EventMgr.Instance.SelectAnnouncementEvent, function(uid, scrollToTop)
    local data = self.model:GetAnnData(uid)
    if not data or not data.content then
      return
    end
    if data.new then
      SdkMgr.Instance:RemoveNoticeRed(data.annType, data.uid, function()
        AnnouncementRedUtils.RemoveRedData(data)
      end)
    end
    if scrollToTop and data.index and data.index <= #self.model.showAnns then
      binder:CircularScrollTo(self.ui.ScrollView_Notice, data.index)
    end
  end)
  binder:BindButtonClick(self.ui.Btn_ReadAll, System.fn(self, self.OnClickReadAll))
  binder:SetText(self.ui.Text_ReadAll, LT.Text("ReadAllStr"))
  binder:BindToVisible(self.ui.Btn_ReadAll, function()
    return self.model.showAnns and #self.model.showAnns > 0
  end)
end

function AnnouncementPanel:_FillCell(cell, index)
  self:AddViewComponentOnce(cell.gameObject, AnnouncementTitleComponent, index, self.awardsData, self.maxCellsNum)
end

function AnnouncementPanel:_EmptyStateVisible()
  local noticeNum = self.model.showAnns and #self.model.showAnns or 0
  return noticeNum <= 0
end

function AnnouncementPanel:_OnClickPageBtn(page)
  self.model:ResetLoadAnnCnt()
  self.model:SetPage(page)
  self.noticeView:ReloadData()
end

function AnnouncementPanel:_SetTitle()
  local data = self.model:GetAnnData(self.model.currUid)
  if not data then
    return ""
  end
  do return LT.Text end
  return LT.Text, data.title
end

function AnnouncementPanel:_SetSubTitle()
  local data = self.model:GetAnnData(self.model.currUid)
  if not data then
    return ""
  end
  do return LT.Text end
  return LT.Text, data.subTitle
end

function AnnouncementPanel:_SetContent()
  local data = self.model:GetAnnData(self.model.currUid)
  if not data then
    return ""
  end
  do return LT.Text end
  return LT.Text, data.content
end

function AnnouncementPanel:_SetContentImage()
  local data = self.model:GetAnnData(self.model.currUid)
  if not data then
    return ""
  end
  return data.imagePath
end

function AnnouncementPanel:_SetContentImageVisible()
  local data = self.model:GetAnnData(self.model.currUid)
  if not data then
    return false
  end
  return data.imagePath and data.imagePath ~= ""
end

function AnnouncementPanel:_UpdateContentItems(_, currUid)
  if not currUid then
    return
  end
  local data = self.model:GetAnnData(currUid)
  if not data or not data.content then
    return
  end
  local contents = StrUtils.SplitAnnounce(data.content)
  self.contents = contents
  self.realTextHeightMap = {}
  self.contentTableView:SetOffset(0, false)
  self.contentTableView:ReloadData()
end

function AnnouncementPanel:InitContentTableView()
  local baseGameObj = self.ui.Text_Content
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW = sizeDelta.x
  local itemComps = {}
  self.contentTableView = self:CreateTableview(self.ui.ScrollView_Content, function()
    return #self.contents
  end, function(view, idx)
    local cell = self:DequeueCell(view, baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    self.binder:LoadAllLangFont(gameObj)
    self.binder:SetText(gameObj, self.contents[idx], nil, function(linkText)
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
    local itemH = self:CalTMPFontSizeHeight(index)
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

function AnnouncementPanel:CalTMPFontSizeHeight(index)
  local desc = self.contents[index]
  self.binder:SetText(self.ui.Text_Content.gameObject, desc)
  local textHeight = StrUtils.SetPreferredHeight(self.ui.Text_Content)
  return 0 == textHeight and 30 or textHeight
end

function AnnouncementPanel:EstimateHeight(text, index)
  return #text * 2
end

function AnnouncementPanel:CheckLoadMoreAnn(idx)
  local showAnnCnt = #self.model.showAnns
  if showAnnCnt < 4 then
    self.ui.Btn_Load:SetActive(false)
    return
  end
  local curMinIndex = math.huge
  local curMaxIndex = -1
  local cnt = self.noticeView:GetVisibleCount()
  for i = 0, cnt - 1 do
    local cell = self.noticeView:GetCellByIndex(i)
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
  if self.isLoadAll then
    return
  end
  if showAnnCnt <= self.curLoadAnnCount then
    self.isLoadAll = true
  end
  if idx == showAnnCnt and showAnnCnt > self.curLoadAnnCount then
    self.curLoadAnnCount = showAnnCnt
    self.model:AddLoadAnnCnt()
    self.noticeView:ReloadData()
  end
end

function AnnouncementPanel:OnClickLoadAnn()
  Alert.Show(20228)
end

function AnnouncementPanel:OnClickClose()
  self:Close()
end

function AnnouncementPanel:_ClearContentItems()
  if self.contentItems then
    for i = 1, #self.contentItems do
      if self.contentItems[i] then
        local ui = self.contentItems[i].ui
        if ui and ui.uiNode then
          UIRootMgr.DestroyGameObject(ui.uiNode)
        end
        if self.contentItems[i].binder then
          self.contentItems[i].binder:teardown()
        end
        self.contentItems[i] = nil
      end
    end
  end
end

function AnnouncementPanel:OnClickReadAll()
  if not self.model then
    return
  end
  for _, data in ipairs(self.model.curAnns) do
    if data.new then
      SdkMgr.Instance:RemoveNoticeRed(data.annType, data.uid, function()
        AnnouncementRedUtils.RemoveRedData(data)
      end)
    end
  end
end

function AnnouncementPanel:GetBtnReadAllState()
  local isRed = AnnouncementRedUtils.GetEntranceRed()
  if isRed then
    return CommonDefine.Z1ButtonState.High
  end
  return CommonDefine.Z1ButtonState.Unclickable
end

function AnnouncementPanel:GetBtnReadAllText()
  do return LT.Text end
  return LT.Text, "ReadAllStr"
end

function AnnouncementPanel:OnUnbind()
  self:_ClearContentItems()
end

return AnnouncementPanel
