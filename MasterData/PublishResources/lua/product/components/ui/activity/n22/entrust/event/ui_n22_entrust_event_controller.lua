_class("UIN22EntrustEventController", UIController)
UIN22EntrustEventController = UIN22EntrustEventController

function UIN22EntrustEventController:OnShow(uiParams)
  self._campaign = uiParams[1]
  self._component = uiParams[2]
  self._levelId = uiParams[3]
  self._eventId = uiParams[4]
  self._eventCloseCallback = uiParams[5]
  self._setPlayerCallback = uiParams[6]
  self:SetData(self._campaign, self._component, self._levelId, self._eventId)
end

function UIN22EntrustEventController:OnHide()
  self:OnEventClose()
end

function UIN22EntrustEventController:OnEventClose()
  if self._eventCloseCallback then
    self._eventCloseCallback(self._isExit)
  end
end

function UIN22EntrustEventController:OnLevelClose(isExit)
  self._isExit = isExit
end

function UIN22EntrustEventController:SetPlayer(eventId)
  if self._setPlayerCallback then
    self._setPlayerCallback(eventId)
  end
end

function UIN22EntrustEventController:SetData(campaign, component, levelId, eventId)
  local eventType, subType = self._component:GetEventType(self._eventId)
  local tb = {
    [EntrustEventType.EntrustEventType_Start] = "",
    [EntrustEventType.EntrustEventType_End] = "UIN22EntrustEventEnd",
    [EntrustEventType.EntrustEventType_Fight] = "UIN22EntrustEventFight",
    [EntrustEventType.EntrustEventType_Story] = "UIN22EntrustEventStory",
    [EntrustEventType.EntrustEventType_MissionOccupy] = "UIN22EntrustEventQuest",
    [EntrustEventType.EntrustEventType_MissionSubmit] = "UIN22EntrustEventQuest",
    [EntrustEventType.EntrustEventType_Box] = "UIN22EntrustEventBox",
    [EntrustEventType.EntrustEventType_Transfer] = "UIN22EntrustEventTransfer"
  }
  local className = tb[eventType]
  if not className then
    Log.error("UIN22EntrustEventController:SetData() EventType Error, type = ", eventType)
  end
  if not string.isnullorempty(className) then
    local obj = UIWidgetHelper.SpawnObject(self, "_pool", className)
    obj:SetData(self, campaign, component, levelId, eventId)
  else
    self:CloseDialog()
  end
end
