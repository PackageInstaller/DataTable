_class("UIHomeLandDiaryContentsController", UIController)
UIHomeLandDiaryContentsController = UIHomeLandDiaryContentsController

function UIHomeLandDiaryContentsController:LoadDataOnEnter(TT, res, uiParams)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._petModule = GameGlobal.GetModule(PetModule)
  self._homelandEventInfo = self._homelandModule:GetHomeLandEventInfo()
  self._homelandDiaryCfg = Cfg.cfg_homeland_dairy_item({})
  self._homelandEventCfg = Cfg.cfg_homeland_event({})
  self._rowpPerCount = 3
  self._diaryItems = {}
  self._finishDairys = {}
end

function UIHomeLandDiaryContentsController:_InitWidget()
  self._messgaeSvList = self:GetUIComponent("UIDynamicScrollView", "messgaeSv")
  self:Refresh()
end

function UIHomeLandDiaryContentsController:OnShow(uiParams)
  self:GetFinishDairyEvent()
  self:RefreshData()
  self:_InitWidget()
  self:_AttachEvents()
end

function UIHomeLandDiaryContentsController:OnHide()
  self:_DetachEvents()
end

function UIHomeLandDiaryContentsController:GetFinishDairyEvent()
  self._finishDairys = {}
  for i, v in pairs(self._homelandEventInfo.finish_event_list) do
    table.insert(self._finishDairys, i)
  end
end

function UIHomeLandDiaryContentsController:RefreshData()
  for index, value in pairs(self._homelandDiaryCfg) do
    local state = 1
    if self:CheckInFinish(value.EventId) then
      state = 2
    end
    if self:CheckHadRead(value.ID) then
      state = 3
    end
    value.state = state
    value.time = self:GetEventTime(value.EventId) or 0
    local info = self:GetPetInfoByEventId(value.EventId)
    if info then
      value.petId = info.ID
      value.petStar = info.Star
    end
  end
end

function UIHomeLandDiaryContentsController:Refresh()
  self._showListInfo = self:GetSortData()
  self._itemGroupCount = #self._showListInfo
  local count = math.ceil(self._itemGroupCount / self._rowpPerCount)
  self._messgaeSvList:InitListView(count, function(scrollview, index)
    return self:_OnGetDiaryItemGroupCell(scrollview, index)
  end)
  self._messgaeSvList:RefreshAllShownItem()
end

function UIHomeLandDiaryContentsController:_OnGetDiaryItemGroupCell(scrollview, index)
  local item = scrollview:NewListViewItem("cellItem")
  local cellPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    cellPool:SpawnObjects("UIHomeLandDiaryItem", self._rowpPerCount)
  end
  local rowList = cellPool:GetAllSpawnList()
  for i = 1, self._rowpPerCount do
    local diaryItem = rowList[i]
    local itemIndex = index * self._rowpPerCount + i
    if itemIndex > #self._showListInfo then
      diaryItem:GetGameObject():SetActive(false)
    else
      self:ShowDiaryItem(diaryItem, itemIndex)
      self._diaryItems[itemIndex] = diaryItem
    end
  end
  return item
end

function UIHomeLandDiaryContentsController:ShowDiaryItem(diaryItem, index)
  local config = self._showListInfo[index]
  local isnew, islock = self:CheckIsNewOrIsLock(config)
  diaryItem:GetGameObject():SetActive(true)
  if config ~= nil then
    diaryItem:InitData(config, function(id)
    end, index, isnew, islock, self._homelandEventCfg, #self._homelandDiaryCfg)
  end
end

function UIHomeLandDiaryContentsController:GetCellItemState()
end

function UIHomeLandDiaryContentsController:_GetEventData(eventId)
  for i, v in pairs(self._homelandDiaryCfg) do
    if v.EventId == eventId then
      return i, v
    end
  end
end

function UIHomeLandDiaryContentsController:_SpawnObject(className, widgetName, count)
  local spCount = count == nil and 1 or count
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className, spCount)
  return obj
end

function UIHomeLandDiaryContentsController:_AttachEvents()
  self:AttachEvent(GameEventType.OnHomeLandDiaryGotoPage, self.OnHomeLandDiaryGotoPage)
end

function UIHomeLandDiaryContentsController:_DetachEvents()
  self:DetachEvent(GameEventType.OnHomeLandDiaryGotoPage, self.OnHomeLandDiaryGotoPage)
end

function UIHomeLandDiaryContentsController:_SetFunction()
end

function UIHomeLandDiaryContentsController:closebtnOnClick()
  self:CloseDialog()
end

function UIHomeLandDiaryContentsController:OnHomeLandDiaryGotoPage()
  self:CloseDialog()
end

function UIHomeLandDiaryContentsController:CheckIsNewOrIsLock(data)
  local isNew, isLock = true, true
  for i, v in pairs(self._homelandModule:GetHomelandDairyInfo().is_readed_dairy) do
    if data.ID == v then
      isNew = false
      break
    end
  end
  for k = 1, #self._finishDairys do
    if self._finishDairys[k] == data.EventId then
      isLock = false
      break
    end
  end
  return isNew and not isLock, isLock
end

function UIHomeLandDiaryContentsController:GetSortData()
  local gotIdList = {}
  local ungetIdList = {}
  local finishied = self._finishDairys
  for i = 1, #self._homelandDiaryCfg do
    local hadGot = false
    for k = #finishied, 1, -1 do
      if finishied[k] == self._homelandDiaryCfg[i].EventId then
        hadGot = true
        table.insert(gotIdList, self._homelandDiaryCfg[i])
        break
      end
    end
    if not hadGot then
      table.insert(ungetIdList, self._homelandDiaryCfg[i])
    end
  end
  
  local function sortfun(x, y)
    if not x.petStar then
      x.petStar = 0
    end
    if not y.petStar then
      y.petStar = 0
    end
    if x.petStar == y.petStar then
      if x.petId == y.petId then
        return x.ID < y.ID
      else
        return x.petId < y.petId
      end
    end
    return x.petStar > y.petStar
  end
  
  local function sortfungot(x, y)
    return x.time < y.time
  end
  
  local sortedCfgList = gotIdList
  table.sort(sortedCfgList, sortfungot)
  table.sort(ungetIdList, sortfun)
  for i = 1, #ungetIdList do
    table.insert(sortedCfgList, ungetIdList[i])
  end
  return sortedCfgList
end

function UIHomeLandDiaryContentsController:GetPetInfoByEventId(eventId)
  local petInfo = {}
  for key, value in pairs(self._homelandEventCfg) do
    if eventId == value.ID then
      petInfo = Cfg.cfg_pet[value.PetID]
    end
  end
  return petInfo
end

function UIHomeLandDiaryContentsController:CheckInFinish(eventId)
  local eventlist = self._finishDairys
  for key, value in pairs(eventlist) do
    if eventId == value then
      return true
    end
  end
  return false
end

function UIHomeLandDiaryContentsController:CheckHadRead(Id)
  local readlist = self._homelandModule:GetHomelandDairyInfo().is_readed_dairy
  for key, value in pairs(readlist) do
    if Id == value then
      return true
    end
  end
  return false
end

function UIHomeLandDiaryContentsController:GetEventTime(eventId)
  local list = self._homelandEventInfo.finish_event_list
  if not list then
    return
  end
  for key, value in pairs(list) do
    if eventId == key then
      return value
    end
  end
  return nil
end
