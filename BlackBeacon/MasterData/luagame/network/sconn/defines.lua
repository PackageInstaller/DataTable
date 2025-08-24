local M = {}
M.STATE_IDLE = 0
M.STATE_NEWCONNECT = 1
M.STATE_LOGINING = 2
M.STATE_FORWARD = 3
M.STATE_RECONNECT = 4
M.STATE_RECOVERING = 5
M.STATE_CLOSE = 6
M.STATE_ERROR = 7
M.STATES_TEXT = {
  [M.STATE_IDLE] = "idle",
  [M.STATE_NEWCONNECT] = "newconnect",
  [M.STATE_LOGINING] = "logining",
  [M.STATE_FORWARD] = "forward",
  [M.STATE_RECONNECT] = "reconnect",
  [M.STATE_RECOVERING] = "recovering",
  [M.STATE_CLOSE] = "close",
  [M.STATE_ERROR] = "error"
}
return M
