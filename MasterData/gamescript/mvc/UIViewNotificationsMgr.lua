local UIViewNotificationsMgr = NewClass("UIViewNotificationsMgr")
local ExtensionMgr = _ENV.ExtensionMgr
local GlobalDispatcher = _ENV.GlobalDispatcher
local NotifyEntry = _ENV.NotifyEntry

function UIViewNotificationsMgr:ctor(view)
  self.view = view
  self.globalNotificationEntries = nil
  self.localNotificationsEntries = nil
end

function UIViewNotificationsMgr:Clear()
  self:_UnbindNotifications()
end

function UIViewNotificationsMgr:RegisterNotify(name, handler, handlerObj, priority)
  GlobalDispatcher:AddListener(name, handler, handlerObj, priority)
  self.globalNotificationEntries = self.globalNotificationEntries or {}
  self:_AddNotificationEntry(self.globalNotificationEntries, name, handler, handlerObj, priority)
end

function UIViewNotificationsMgr:UnregisterNotify(name, handler, handlerObj)
  GlobalDispatcher:RemoveListener(name, handler, handlerObj)
  self:_RemoveNotificationEntry(self.globalNotificationEntries, name, handler, handlerObj)
end

function UIViewNotificationsMgr:Notify(name, ...)
  GlobalDispatcher:Dispatch(name, ...)
end

function UIViewNotificationsMgr:RegisterLocalNotify(name, handler, handlerObj, priority)
  ExtensionMgr.Instance:RegisterLocalNotify(self.view.__name, name, handler, handlerObj, priority)
  self.localNotificationsEntries = self.localNotificationsEntries or {}
  self:_AddNotificationEntry(self.localNotificationsEntries, name, handler, handlerObj, priority)
end

function UIViewNotificationsMgr:UnregisterLocalNotify(name, handler, handlerObj)
  ExtensionMgr.Instance:UnregisterLocalNotify(self.view.__name, name, handler, handlerObj)
  self:_RemoveNotificationEntry(self.localNotificationsEntries, name, handler, handlerObj)
end

function UIViewNotificationsMgr:LocalNotify(name, ...)
  ExtensionMgr.Instance:LocalNotify(self.view.__name, name, ...)
end

function UIViewNotificationsMgr:_AddNotificationEntry(entries, notifyName, handler, handlerObj, priority)
  local entry = NotifyEntry.GetPool():FetchObject()
  entry.name = notifyName
  entry.handlerObj = handlerObj
  entry.handler = handler
  entry.priority = priority or NotifyPriority.Normal
  table.insert(entries, entry)
end

function UIViewNotificationsMgr:_RemoveNotificationEntry(entries, name, handler, handlerObj)
  if not entries then
    return
  end
  for i = 1, #entries do
    if entries[i].name == name and entries[i].handler == handler and entries[i].handlerObj == handlerObj then
      NotifyEntry.GetPool():ReturnObject(entries[i])
      table.remove(entries, i)
      return
    end
  end
end

function UIViewNotificationsMgr:_UnbindNotifications()
  if self.globalNotificationEntries then
    for i = 1, #self.globalNotificationEntries do
      local entry = self.globalNotificationEntries[i]
      GlobalDispatcher:RemoveListener(entry.name, entry.handler, entry.handlerObj)
      NotifyEntry.GetPool():ReturnObject(entry)
    end
    self.globalNotificationEntries = nil
  end
  if self.localNotificationsEntries then
    for i = 1, #self.localNotificationsEntries do
      local entry = self.localNotificationsEntries[i]
      ExtensionMgr.Instance:UnregisterLocalNotify(self.view.__name, entry.name, entry.handler, entry.handlerObj)
      NotifyEntry.GetPool():ReturnObject(entry)
    end
    self.localNotificationsEntries = nil
  end
end

return UIViewNotificationsMgr
