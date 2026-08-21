_class("UIS3TaskListBtn", UICustomWidget)
UIS3TaskListBtn = UIS3TaskListBtn

function UIS3TaskListBtn:OnShow(uiParams)
  self._seasonTaskModule = GameGlobal.GameLogic():GetModule(SeasonTaskModule)
  self._uiModule = GameGlobal.GetUIModule(SeasonModule)
  self._seasonManager = self._uiModule:SeasonManager()
  self:_Refresh()
  self:_AttachEvent()
end

function UIS3TaskListBtn:OnHide()
  self:_DetachEvent()
end

function UIS3TaskListBtn:_Refresh()
  if not self.view then
    return
  end
  local node = self._seasonTaskModule:GetCurNode()
  local isShow = self._seasonTaskModule:TaskListShow()
  self:GetGameObject():SetActive(isShow)
  local isRed = self._seasonTaskModule:TaskListRed()
  self:GetGameObject("red"):SetActive(isRed)
end

function UIS3TaskListBtn:BtnOnClick(go)
  local isShow = self._seasonTaskModule:TaskListShow()
  if not isShow then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    return
  end
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if not seasonModule:IsOpen() then
    ToastManager.ShowToast(StringTable.Get("str_activity_error_109"))
    return
  end
  self:ShowDialog("UISeasonTaskListController")
end

function UIS3TaskListBtn:_AttachEvent()
  self:AttachEvent(GameEventType.OnSeasonTaskReset, self.OnSeasonTaskReset)
  self:AttachEvent(GameEventType.OnSeasonTaskRefreshed, self.OnSeasonTaskRefreshed)
end

function UIS3TaskListBtn:_DetachEvent()
  self:DetachEvent(GameEventType.OnSeasonTaskReset, self.OnSeasonTaskReset)
  self:DetachEvent(GameEventType.OnSeasonTaskRefreshed, self.OnSeasonTaskRefreshed)
end

function UIS3TaskListBtn:OnSeasonTaskReset()
  self:_Refresh()
end

function UIS3TaskListBtn:OnSeasonTaskRefreshed()
  self:_Refresh()
end
