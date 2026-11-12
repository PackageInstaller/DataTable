local EventReminderPanel = class("EventReminderPanel", BasePanel)
EventReminderPanel._tbDefine = {
  {
    sPrefabPath = "EventReminder/EventReminderPanel.prefab",
    sCtrlName = "Game.UI.EventReminder.EventReminderCtrl"
  }
}

function EventReminderPanel:Awake()
end

function EventReminderPanel:OnEnable()
end

function EventReminderPanel:OnAfterEnter()
end

function EventReminderPanel:OnDisable()
end

function EventReminderPanel:OnDestroy()
end

function EventReminderPanel:OnRelease()
end

return EventReminderPanel
