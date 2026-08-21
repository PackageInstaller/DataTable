_class("UIHomeLandDiaryController", UIController)
UIHomeLandDiaryController = UIHomeLandDiaryController

function UIHomeLandDiaryController:LoadDataOnEnter(TT, res, uiParams)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._homelandEventInfo = self._homelandModule:GetHomeLandEventInfo()
  self._homelandDiaryCfg = Cfg.cfg_homeland_dairy_item({})
  self._homelandEventCfg = Cfg.cfg_homeland_event({})
  self._MAXPageIndex = #self._homelandDiaryCfg
  self._pageIndex = 0
  self._diaryId = 0
  self._firstPageIndex = 0
  self._newTipList = {}
  self._finishDairys = {}
end

function UIHomeLandDiaryController:RefreshData()
  for index, value in ipairs(self._homelandDiaryCfg) do
    local state = 1
    if self:CheckInFinish(value.ID) then
      state = 2
    end
    if self:CheckHadRead(value.ID) then
      state = 3
    end
    value.state = state
    value.time = self:GetEventTime(value.EventId)
  end
end

function UIHomeLandDiaryController:_InitWidget()
  self._dairyText = self:GetUIComponent("UILocalizationText", "Content")
  self._pageText = self:GetUIComponent("UILocalizationText", "pageText")
  self._emoMes = self:GetUIComponent("UILocalizationText", "emoMes")
  self._dataText = self:GetUIComponent("UILocalizationText", "dataText")
  self._date = self:GetUIComponent("UILocalizationText", "date")
  self._viewportRect = self:GetUIComponent("RectTransform", "Viewport")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._AniPage = self:GetUIComponent("Animation", "uianim")
  self._AniPage.enabled = true
  self._processSl = self:GetUIComponent("Slider", "processSl")
  self._lkpImgLoader = self:GetUIComponent("RawImageLoader", "lkpImg")
  self._emoImg = self:GetUIComponent("Image", "emoImg")
  self._btndownGo = self:GetGameObject("btndown")
  self._view = self:GetGameObject("view")
  self._datanew = self:GetGameObject("datanew")
  self._new = self:GetGameObject("new")
  self._emptyBg = self:GetGameObject("emptyBg")
  self._btnLiftGo = self:GetGameObject("btnlift")
  self._btnRightGo = self:GetGameObject("btnright")
  self._colloctdata = self:GetUIComponent("UILocalizationText", "colloctdata")
  self._messgaeSv = self:GetUIComponent("ScrollRect", "messgaeSv")
  self._titlebtn = self:GetGameObject("titlebtn")
  self._messgaeSv.onValueChanged:AddListener(function()
    self:_Showbtndown()
  end)
  self:GetFirstShowPage()
  self:Refresh()
end

function UIHomeLandDiaryController:OnShow(uiParams)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioOpenDiary)
  self._atlas = self:GetAsset("UIHomelandEmoji.spriteatlas", LoadType.SpriteAtlas)
  self:RefreshData()
  self:_InitWidget()
  self:_AttachEvents()
end

function UIHomeLandDiaryController:OnHide()
  self._MAXPageIndex = 0
  self._pageIndex = 0
  self:_DetachEvents()
end

function UIHomeLandDiaryController:_SpawnObject(className, widgetName)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIHomeLandDiaryController:_AttachEvents()
  self:AttachEvent(GameEventType.HomeLandEventChange, self.OnHomeLandDiaryMessage)
  self:AttachEvent(GameEventType.OnHomeLandDiaryGotoPage, self.GotoPage)
end

function UIHomeLandDiaryController:_DetachEvents()
  self:DetachEvent(GameEventType.HomeLandEventChange, self.OnHomeLandDiaryMessage)
  self:DetachEvent(GameEventType.OnHomeLandDiaryGotoPage, self.GotoPage)
end

function UIHomeLandDiaryController:GetFirstShowPage()
  self:GetFinishDairyEvent()
  self._firstPageIndex = self:_GetPageIndex(true)
end

function UIHomeLandDiaryController:GetFinishDairyEvent()
  self._finishDairys = {}
  for i, v in pairs(self._homelandEventInfo.finish_event_list) do
    table.insert(self._finishDairys, i)
  end
  table.sort(self._finishDairys, function(a, b)
    return self._homelandEventInfo.finish_event_list[a] < self._homelandEventInfo.finish_event_list[b]
  end)
  local rec = {}
  for i = 1, #self._finishDairys do
    for k, v in ipairs(self._homelandDiaryCfg) do
      if v.EventId == self._finishDairys[i] then
        table.insert(rec, v.ID)
        break
      end
    end
  end
  self._finishDairys = rec
end

function UIHomeLandDiaryController:_GetPageIndex(isFirst)
  local finishList = self._finishDairys
  if not finishList or #finishList == 0 then
    self._pageIndex = 0
    self._diaryId = 0
    return
  end
  for k = 1, #finishList do
    for i, v in ipairs(self._homelandDiaryCfg) do
      if finishList[k] == v.ID and isFirst and not self:CheckHadRead(v.ID) then
        self._pageIndex = self:_GetPageData(v.ID)
        self._diaryId = v.ID
        return
      end
    end
  end
  if 0 < #finishList and self._pageIndex == 0 then
    for i, v in ipairs(self._homelandDiaryCfg) do
      if finishList[#finishList] == v.ID then
        self._pageIndex = self:_GetPageData(v.ID)
        self._diaryId = v.ID
      end
    end
  end
end

function UIHomeLandDiaryController:_GetPageData(diaryId)
  local pagIndex, pagedata
  for i, v in ipairs(self._finishDairys) do
    if v == diaryId then
      pagIndex = i
      break
    end
  end
  for i, v in ipairs(self._homelandDiaryCfg) do
    if v.ID == diaryId then
      pagedata = v
      break
    end
  end
  return pagIndex, pagedata
end

function UIHomeLandDiaryController:Refresh()
  self:GetFinishDairyEvent()
  local index
  index, self._pageData = self:_GetPageData(self._diaryId)
  self._emptyBg:SetActive(self._pageData == nil)
  self._view:SetActive(self._pageData ~= nil)
  self._titlebtn:SetActive(true)
  self._btnLiftGo:SetActive(self._pageIndex > 1)
  self._btnRightGo:SetActive(self._pageIndex < #self._finishDairys and 1 < #self._finishDairys)
  self:_SetNew()
  if not self._pageData then
    local str = self:GetPassedEventCount() .. "/" .. self._MAXPageIndex
    self._colloctdata:SetText(str)
  else
    self._data = self._pageData
    self._dairyText:SetText(StringTable.Get(self._data.DairyContent))
    self._emoMes:SetText(StringTable.Get(self._data.DairyReply))
    local timeStr = self:GetEventTime(self._diaryId) and self:GetEventTime(self._diaryId) or ""
    self._dataText:SetText(TimeToDate4(timeStr, "day"))
    self._date:SetText(TimeToDate3(timeStr, "day"))
    local str = "- " .. self._pageIndex .. "/" .. #self._finishDairys .. " -"
    self._pageText:SetText(str)
    str = self:GetPassedEventCount() .. "/" .. self._MAXPageIndex
    self._colloctdata:SetText(str)
    self._emoImg.sprite = self._atlas:GetSprite(self._data.DairyEmo)
    self._processSl.value = self:GetPassedEventCount() / self._MAXPageIndex
    self._lkpImgLoader:LoadImage(self._data.DairyPhoto)
  end
  self:LookDiaryItem()
end

function UIHomeLandDiaryController:_ChangePage(bNext)
  local nextIndex = bNext and self._pageIndex + 1 or self._pageIndex - 1
  local eventId = self._finishDairys[nextIndex]
  self:StartTask(function(TT)
    local lockName = "UIHomeLandDiaryController:_ChangePage"
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.HomelandAudioPageTurnning)
    self:Lock(lockName)
    if eventId then
      if bNext then
        self._pageIndex = self._pageIndex + 1
        self._AniPage.enabled = true
        self._AniPage:Play("UIHomeLandDiaryController_ui_page_01")
      else
        self._pageIndex = self._pageIndex - 1
        self._AniPage.enabled = true
        self._AniPage:Play("UIHomeLandDiaryController_ui_page_02")
      end
      YIELD(TT, 500)
      self._diaryId = eventId
    end
    self:CheckPage()
    self:Refresh()
    if eventId then
      YIELD(TT, 500)
    end
    self:UnLock(lockName)
  end)
end

function UIHomeLandDiaryController:CheckPage()
  self._pageIndex = self._pageIndex < 0 and 0 or self._pageIndex
  self._pageIndex = self._pageIndex > self._MAXPageIndex and self._MAXPageIndex or self._pageIndex
end

function UIHomeLandDiaryController:GotoPage(diaryId)
  self._diaryId = diaryId
  self._pageIndex = self:_GetPageData(diaryId)
  self:CheckPage()
  self:Refresh()
end

function UIHomeLandDiaryController:GetCfgByIndex(index)
  return self._homelandDiaryCfg[index]
end

function UIHomeLandDiaryController:OnHomeLandDiaryMessage()
  self:_SetNew()
  self:Refresh()
end

function UIHomeLandDiaryController:titlebtnOnClick()
  self:ShowDialog("UIHomeLandDiaryContentsController")
end

function UIHomeLandDiaryController:closebtnOnClick()
  self:CloseDialog()
end

function UIHomeLandDiaryController:btnliftOnClick()
  self:_ChangePage(false)
end

function UIHomeLandDiaryController:btnrightOnClick()
  self:_ChangePage(true)
end

function UIHomeLandDiaryController:_Showbtndown()
  local viewHeight = self._viewportRect.rect.height
  local contentHeight = self._contentRect.rect.height
  local pos = self._contentRect.anchoredPosition.y
  self._btndownGo:SetActive(math.abs(pos - (viewHeight - contentHeight)) <= 0.2)
end

function UIHomeLandDiaryController:_SetNew()
  if not self._pageData then
    return
  end
  self._datanew:SetActive(not self:CheckHadRead(self._pageData.ID))
  self._new:SetActive(self:HaveNoRead())
end

function UIHomeLandDiaryController:GetPassedEventCount()
  local count = 0
  for i, v in pairs(self._finishDairys) do
    count = count + 1
  end
  return count
end

function UIHomeLandDiaryController:HaveNoRead()
  local info = self._homelandModule:GetHomelandDairyInfo()
  return #self._finishDairys - #info.is_readed_dairy > 0
end

function UIHomeLandDiaryController:CheckInFinish(diaryId)
  local list = self._finishDairys
  for key, value in pairs(list) do
    if diaryId == value then
      return true
    end
  end
  return false
end

function UIHomeLandDiaryController:CheckHadRead(diaryId)
  local readlist = self._homelandModule:GetHomelandDairyInfo().is_readed_dairy
  for key, value in pairs(readlist) do
    if diaryId == value then
      return true
    end
  end
  return false
end

function UIHomeLandDiaryController:GetEventID(diaryId)
  if self._homelandDiaryCfg[diaryId] and self._homelandDiaryCfg[diaryId].EventId then
    return self._homelandDiaryCfg[diaryId].EventId
  end
end

function UIHomeLandDiaryController:GetEventTime(diaryId)
  local list = self._homelandEventInfo.finish_event_list
  if not list then
    return
  end
  local eventId = self:GetEventID(diaryId)
  for key, value in pairs(list) do
    if eventId == key then
      return value
    end
  end
  return nil
end

function UIHomeLandDiaryController:LookDiaryItem()
  GameGlobal.UIStateManager():Lock("UIHomeLandDiaryController:LookDiaryItem")
  self:StartTask(function(TT)
    local homelandModule = GameGlobal.GetModule(HomelandModule)
    local res = homelandModule:HandleHomelandReadedDairyReq(TT, self._diaryId)
    if res:GetSucc() then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeStoryFinish, "")
    end
    GameGlobal.UIStateManager():UnLock("UIHomeLandDiaryController:LookDiaryItem")
  end, self)
end
