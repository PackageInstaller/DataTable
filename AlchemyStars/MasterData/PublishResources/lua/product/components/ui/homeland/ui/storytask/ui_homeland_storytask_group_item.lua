_class("UIHomelandStoryTaskGroupItem", UICustomWidget)
UIHomelandStoryTaskGroupItem = UIHomelandStoryTaskGroupItem

function UIHomelandStoryTaskGroupItem:Constructor()
end

function UIHomelandStoryTaskGroupItem:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomelandStoryTaskGroupItem:OnShow()
  self._height = {
    24.3,
    60.4,
    22.4,
    60.4,
    10,
    46.2
  }
  self:_GetComponents()
  self:SetCustomTimeStr_Common()
end

function UIHomelandStoryTaskGroupItem:OnHide()
end

function UIHomelandStoryTaskGroupItem:_GetComponents()
  self._bgImage = self:GetGameObject("bgImage")
  self._lockImage = self:GetGameObject("lockImage")
  self._selectImage = self:GetGameObject("select")
  self._bottomImage = self:GetGameObject("bottom")
  self._bottomImage1 = self:GetGameObject("bottom1")
  self._txt = self:GetUIComponent("UILocalizationText", "txt")
  self._locktxt = self:GetUIComponent("UILocalizationText", "locktxt")
  self._tran = self:GetUIComponent("RectTransform", "tra")
  self._ani = self:GetUIComponent("Animation", "root")
end

function UIHomelandStoryTaskGroupItem:Refresh()
  self._unlock = true
  if self._lastGroup then
    self._unlock = self._controller:CheckTaskGroupFinish(self._hodeTaskId, self._lastGroup)
  else
    self._unlock = true
  end
  self._tran.anchoredPosition = Vector2(0, self._height[self._index])
  local isInTime = self._controller:CheckTaskGroupInTime(self._taskGroupId)
  self._lockImage:SetActive(not self._unlock or not isInTime)
  self._txt:SetText(self._index)
  self._locktxt:SetText(self._index)
  self._selectImage:SetActive(self._select and isInTime)
  self._bottomImage:SetActive(true)
  self._bgImage:SetActive(self._unlock and isInTime)
  self._bottomImage1:SetActive(self._select)
end

function UIHomelandStoryTaskGroupItem:Flush(index, taskGroup, controller, taskID, lastGroup, select, cfg)
  self._index = index
  self._controller = controller
  self._hodeTaskId = taskID
  self._taskGroupId = taskGroup
  self._lastGroup = lastGroup
  self._select = self._taskGroupId == select
  self._cfg = cfg
  self:Refresh()
end

function UIHomelandStoryTaskGroupItem:BtnOnClick(go)
  local svrTimeModule = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local servertime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local time = loginModule:GetTimeStampByTimeStr(self._cfg[self._taskGroupId].StartTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if 0 <= time - servertime then
    local timeStr = UIActivityHelper.GetFormatTimerStr(time - servertime, self._customStr)
    local str = string.format(StringTable.Get("str_homeland_storytask_time_unlock", timeStr))
    ToastManager.ShowHomeToast(str)
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandStoryTaskGroupSelect, self._taskGroupId)
end

function UIHomelandStoryTaskGroupItem:ShowAnim()
  self._ani:Play("uieff_N19_UIHomelandStory01_in")
end

function UIHomelandStoryTaskGroupItem:SetCustomTimeStr_Common()
  self:SetCustomTimeStr({
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_common_less_minute"
  })
end

function UIHomelandStoryTaskGroupItem:SetCustomTimeStr(customStr)
  self._customStr = customStr
end
