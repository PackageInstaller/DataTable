_class("UIHomelandStoryTaskBtn", UICustomWidget)
UIHomelandStoryTaskBtn = UIHomelandStoryTaskBtn

function UIHomelandStoryTaskBtn:SetData(data, controller, selectId)
  self._controller = controller
  self._data = data
  self._taskId = data.ID
  self._selectId = selectId
  self._isUnLock = controller:CheckTaskUnLock(self._taskId)
  self._isNew = not controller:CheckNewPoint(self._taskId)
  self._isFinished = controller:CheckStoryTaskFinish(self._taskId)
  self._isTrace = controller:CheckIsTrace(self._taskId)
  if self._isFinished then
    self._isTrace = false
  end
  self:Refresh()
end

function UIHomelandStoryTaskBtn:Refresh()
  local state = self:_CheckState()
  self:_SetState(state)
  self:_SetText(state)
  self:_SetWidgetShow("new", self._isNew)
  self:_SetWidgetShow("tracePoint", self._isTrace)
end

function UIHomelandStoryTaskBtn:_CheckState()
  local state = 2
  if self._selectId == self._taskId then
    state = 1
  end
  if self._isFinished then
    state = 4
  end
  if not self._isUnLock then
    state = 3
  end
  return state
end

function UIHomelandStoryTaskBtn:_SetState(state)
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"bg_select"},
    {"bg_normal"},
    {"bg_lock", "icon_lock"},
    {
      "bg_finish",
      "icon_finish"
    }
  }, self._stateObj)
  UIWidgetHelper.SetObjGroupShow(self._stateObj, state)
  self:GetGameObject("bg_selectlock"):SetActive(state == 3 and self._selectId == self._taskId)
end

function UIHomelandStoryTaskBtn:_SetText(state)
  local tb = {
    "#ffffff",
    "#6b6b6b",
    "#6a6969",
    "#848484"
  }
  local text = UIActivityHelper.GetColorText(tb[state], StringTable.Get(self._data.GroupsListTitle))
  UIWidgetHelper.SetLocalizationText(self, "text", text)
end

function UIHomelandStoryTaskBtn:_SetWidgetShow(widgetName, isShow)
  isShow = isShow and self._isUnLock
  self:GetGameObject(widgetName):SetActive(isShow)
end

function UIHomelandStoryTaskBtn:BtnOnClick(go)
  self._controller:SetNewPoint(self._taskId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandStoryTaskBtnSelect, self._data.ID)
end
