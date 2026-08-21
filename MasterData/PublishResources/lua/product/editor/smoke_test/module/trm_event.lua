require("test_robot_module")

function TestRobotModule:SubscribeGameEvent()
  if self.__autoBinder then
    self.__autoBinder:Dispose()
  end
  self.__autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
  self.__autoBinder:BindEvent(GameEventType.ConnectReset, self, self._OnConnectReset)
end

function TestRobotModule:_OnConnectReset(reason)
  local t = {
    StringTable.Get("str_login_ask_login_connect_timeout_text"),
    tostring(reason)
  }
  WorkWXPoster.SendError(table.concat(t, "："))
end
