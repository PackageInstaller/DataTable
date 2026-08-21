_class("UINoticeController", UIController)
UINoticeController = UINoticeController

function UINoticeController:OnShow(uiParams)
  self._tag2type = {
    [1] = NoticeType.System,
    [2] = NoticeType.Active
  }
  self:_GetComponents()
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self._isFirst = true
  self._noticeType = uiParams[1] or NoticeType.System
  self._showNoticeID = uiParams[2] or nil
  self:_LoadData(true)
  self:SelectNoticeType()
end

function UINoticeController:_GetNoticeIndexByID(showNoticeID)
  local idx = 1
  if self._noticeList and #self._noticeList > 0 then
    for i = 1, #self._noticeList do
      if self._noticeList[i].UniqID == showNoticeID then
        return i
      end
    end
  end
  Log.fatal("###配置的跳转公告UniqId没找到！id-->", showNoticeID)
  return idx
end

function UINoticeController:OnHide()
  if self._showEvent then
    GameGlobal.Timer():CancelEvent(self._showEvent)
    self._showEvent = nil
  end
  if self._selectTween then
    self._selectTween:Kill()
    self._selectTween = nil
  end
  self._noticeType = nil
  self._noticeIndex = nil
  self._loginModule = nil
end

function UINoticeController:_LoadData(isInit)
  local noticeData = self._loginModule:GetNoticeData()
  if noticeData == nil then
    Log.fatal("###[UINoticeController:_LoadData] the noticeData is nil !")
    return
  end
  self._noticeList = noticeData:GetNoticeDataWithGroup(self._noticeType)
  if #self._noticeList > 0 then
    if self._showNoticeID then
      self._noticeIndex = self:_GetNoticeIndexByID(self._showNoticeID)
    else
      self._noticeIndex = 1
    end
  else
    self._noticeIndex = 0
  end
  self:_ShowHideUIPanel()
  self:_OnValue(isInit)
end

function UINoticeController:_GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, nil, true)
  self._noticePool = self:GetUIComponent("UIDynamicScrollView", "noticeActivePool")
  self._info_img = self:GetUIComponent("UISelectObjectPath", "info_img")
  self._info_imgtex = self:GetUIComponent("UISelectObjectPath", "info_imgtex")
  self._info_tex = self:GetUIComponent("UISelectObjectPath", "info_tex")
  self._info_img_go = self:GetGameObject("info_img")
  self._info_imgtex_go = self:GetGameObject("info_imgtex")
  self._info_tex_go = self:GetGameObject("info_tex")
  self._systemPanel = self:GetGameObject("systemPanel")
  self._activePanel = self:GetGameObject("activePanel")
  self._systemSelect = self:GetGameObject("systemSelect")
  self._activeSelect = self:GetGameObject("activeSelect")
  self._systemNoticeBg = self:GetGameObject("systemNoticeBg")
  self._activeNoticeBg = self:GetGameObject("activeNoticeBg")
  self._commonSelectRect = self:GetUIComponent("RectTransform", "commonSelect")
  self._commonSelectGo = self:GetGameObject("commonSelect")
  self._typeAnim = self:GetUIComponent("Animation", "typeBtn")
end

function UINoticeController:SelectNoticeType()
  if self._noticeType == NoticeType.Active then
    self._systemSelect:SetActive(false)
    self._activeSelect:SetActive(true)
  elseif self._noticeType == NoticeType.System then
    self._systemSelect:SetActive(true)
    self._activeSelect:SetActive(false)
  end
end

function UINoticeController:_OnValue(isInit)
  self._infoImg = self._info_img:SpawnObject("UINoticeDetailImg")
  self._infoImgTex = self._info_imgtex:SpawnObject("UINoticeDetailImgTex")
  self._infoTex = self._info_tex:SpawnObject("UINoticeDetailTex")
  if self._isFirst then
    self:InitNoticeList()
    self._isFirst = false
  else
    self:RefreshNoticeList()
  end
  local needTween = not isInit
  if self._noticeIndex > 0 then
    self:_NoticeItemClick(self._noticeIndex, needTween)
  else
    self._commonSelectGo:SetActive(false)
    self:HideInfoGo()
  end
end

function UINoticeController:_ShowHideUIPanel()
  self._systemNoticeBg:SetActive(self._noticeType == NoticeType.System)
  self._activeNoticeBg:SetActive(self._noticeType == NoticeType.Active)
end

function UINoticeController:RefreshNoticeList()
  self._noticePool:SetListItemCount(#self._noticeList)
  self._noticePool:MovePanelToItemIndex(0, 0)
end

function UINoticeController:InitNoticeList()
  self._noticePool:InitListView(#self._noticeList, function(scrollView, index)
    return self:InitNoticeListInfo(scrollView, index)
  end)
end

function UINoticeController:InitNoticeListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  item.IsInitHandlerCalled = true
  local btn = rowPool:SpawnObject("UINoticeBtnItem")
  local idx = index + 1
  btn:SetData(idx, self._noticeList[idx], function(idx)
    self:_NoticeItemClick(idx, true)
  end)
  return item
end

function UINoticeController:systemBtnOnClick(go)
  if self._noticeType ~= NoticeType.System then
    self._noticeType = NoticeType.System
    self._typeAnim:Play("uieff_Notice_ToSystem")
    self:Lock("UINoticeController:systemBtnOnClick")
    GameGlobal.Timer():AddEvent(270, function()
      self:UnLock("UINoticeController:systemBtnOnClick")
    end)
    self:SelectNoticeType()
    self._noticeIndex = 1
    self:_LoadData()
  end
end

function UINoticeController:activeBtnOnClick(go)
  if self._noticeType ~= NoticeType.Active then
    self._noticeType = NoticeType.Active
    self._typeAnim:Play("uieff_Notice_ToActive")
    self:Lock("UINoticeController:activeBtnOnClick")
    GameGlobal.Timer():AddEvent(270, function()
      self:UnLock("UINoticeController:activeBtnOnClick")
    end)
    self:SelectNoticeType()
    self._noticeIndex = 1
    self:_LoadData()
  end
end

function UINoticeController:_NoticeItemClick(idx, needTween)
  self._noticeIndex = idx
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UINoticeItemClick, self._noticeIndex, self._noticeType)
  local has = false
  local noticeInfo
  if self._noticeList[idx] then
    has = true
    noticeInfo = self._noticeList[idx]
  end
  if has then
    self:_ShowDetailData(noticeInfo, needTween)
  else
    self:HideInfoGo()
  end
  self._commonSelectGo:SetActive(has)
  if has then
    if needTween then
      if self._selectTween then
        self._selectTween:Kill()
      end
      self._selectTween = self._commonSelectRect:DOAnchorPos(Vector2(0, -118 * (idx - 1)), 0.17)
    else
      self._commonSelectRect.anchoredPosition = Vector2(0, -118 * (idx - 1))
    end
  end
end

function UINoticeController:_ShowDetailData(noticeInfo, needTween)
  self._showNoticeInfo = noticeInfo
  if needTween then
    if self._LayoutType then
      if self._LayoutType == NoticeLayout.TextureText then
        self._infoImgTex:AnimFade()
      elseif self._LayoutType == NoticeLayout.Texture then
        self._infoImg:AnimFade()
      elseif self._LayoutType == NoticeLayout.Text then
        self._infoTex:AnimFade()
      end
    end
    if self._showEvent then
      GameGlobal.Timer():CancelEvent(self._showEvent)
      self._showEvent = nil
    end
    self:Lock("UINoticeController:_ShowDetailData")
    self._showEvent = GameGlobal.Timer():AddEvent(167, function()
      self:UnLock("UINoticeController:_ShowDetailData")
      self:_OnShowDetailData(true)
    end)
  else
    self:_OnShowDetailData(false)
  end
end

function UINoticeController:_OnShowDetailData(needTween)
  if self._showNoticeInfo.NoticeType == NoticeType.System then
    self._LayoutType = NoticeLayout.Text
    self:ShowHideInfoGo(NoticeLayout.Text)
    self._infoTex:SetData(self._showNoticeInfo)
    if needTween then
      self._infoTex:AnimShow()
    end
  else
    local tab = cjson.decode(self._showNoticeInfo.Text_NoticeContent)
    if tab then
      self:ShowHideInfoGo(tab.layout)
      if tab.layout == NoticeLayout.TextureText then
        self._LayoutType = NoticeLayout.TextureText
        self._infoImgTex:SetData(self._showNoticeInfo)
        if needTween then
          self._infoImgTex:AnimShow()
        end
      elseif tab.layout == NoticeLayout.Texture then
        self._LayoutType = NoticeLayout.Texture
        self._infoImg:SetData(self._showNoticeInfo)
        if needTween then
          self._infoImg:AnimShow()
        end
      end
    else
      Log.fatal("###notice json decode fail ! content --> ", self._showNoticeInfo.Text_NoticeContent)
    end
  end
end

function UINoticeController:ShowHideInfoGo(layout)
  self._info_img_go:SetActive(layout == NoticeLayout.Texture)
  self._info_imgtex_go:SetActive(layout == NoticeLayout.TextureText)
  self._info_tex_go:SetActive(layout == NoticeLayout.Text)
end

function UINoticeController:HideInfoGo()
  self._info_img_go:SetActive(false)
  self._info_imgtex_go:SetActive(false)
  self._info_tex_go:SetActive(false)
end

function UINoticeController:backBtnOnClick()
  self:CloseDialog()
end
