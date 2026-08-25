local PushMsgComp, Super = System.NewClass("PushMsgComp", Component, IUpdater)

function PushMsgComp:ctor()
  Super.ctor(self)
end

function PushMsgComp:Awake(binder)
  self.binder = binder
  self:InitSdk()
end

function PushMsgComp:InitSdk()
  local ejoysdk_init = require("ejoysdk_lua.ejoysdk_init")
  ejoysdk_init.subscribe(ejoysdk_init.SUBSCRIBE_PUSH_INITED, function(succ, ...)
    if succ then
      Logger.Info("推送模块 初始化成功")
    else
      Logger.Info("推送模块 初始化失败")
    end
  end)
end

function PushMsgComp:GetPushHandlers()
  local push_handlers = {
    on_server_notification = System.fn(self, self.OnServerNotify),
    on_local_notification = System.fn(self, self.OnLocalNotify),
    on_server_notification_in_app = System.fn(self, self.OnServerNotifyInApp),
    on_local_notification_in_app = System.fn(self, self.OnLocalNotifyInApp)
  }
  return push_handlers
end

function PushMsgComp:OnServerNotify(title, content, ext)
  Logger.Info("OnServerNotify", title, content, table.tostring(ext))
end

function PushMsgComp:OnLocalNotify(title, content, ext)
  Logger.Info("OnLocalNotify", title, content, table.tostring(ext))
end

function PushMsgComp:OnServerNotifyInApp(title, content, ext)
  Logger.Info("OnServerNotifyInApp", title, content, table.tostring(ext))
end

function PushMsgComp:OnLocalNotifyInApp(title, content, ext)
  Logger.Info("OnLocalNotifyInApp", title, content, table.tostring(ext))
end

function PushMsgComp:CreateLocalPush(title, content, calendar, ext, config)
  local ejoysdk_push = require("ejoysdk_lua.push.ejoysdk_push")
  local notify_id = ejoysdk_push.add_local_notification(title, content, calendar, ext, config)
  return notify_id
end

function PushMsgComp:RemoveLocalPush(notifyId)
  local ejoysdk_push = require("ejoysdk_lua.push.ejoysdk_push")
  ejoysdk_push.remove_local_notification(notifyId)
end

return PushMsgComp
