local M = {}
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local msg_status = {
  server_received = 0,
  user_received = 1,
  reject = 4,
  recall = 5,
  sending = 6,
  failed = 7,
  only_self_visible = 19,
  delete = 20
}
local msg_status_msg = {
  block_by_blacklist = "block_by_blacklist",
  recall_by_user = "recall_by_user",
  recall_by_admin = "recall_by_admin",
  recall_by_youdun = "recall_by_youdun",
  recall_by_platform = "recall_by_platform",
  recall_by_game = "recall_by_game"
}

function M.msg_status()
  return msg_status
end

function M.msg_status_msg()
  return msg_status_msg
end

local _msg_src = {
  info_msg = "info_msg",
  get_session_msg = "get_session_msg",
  mock = "mock",
  get_session_msg_in_special = "get_session_msg_in_special"
}

function M.msg_sdk_src()
  return _msg_src
end

function M.smaller(msg1, msg2)
  local res = M._cmp(msg1, msg2)
  if res < 0 then
    return true
  else
    return false
  end
end

function M.greater(msg1, msg2)
  local res = M._cmp(msg1, msg2)
  if res > 0 then
    return true
  else
    return false
  end
end

function M.is_the_same(msg1, msg2)
  if 0 == M._cmp(msg1, msg2) then
    return true
  else
    return false
  end
end

function M._cmp(msg1, msg2)
  local msg_id1 = msg1.msg_id
  local msg_id2 = msg2.msg_id
  if nil ~= msg_id1 and nil ~= msg_id2 then
    do return M._cmp_to_int, msg_id1 end
    return M._cmp_to_int, msg_id1, msg_id2
  elseif nil == msg_id1 and nil == msg_id2 then
    do return M._cmp_to_int, msg1.send_id end
    return M._cmp_to_int, msg1.send_id, msg2.send_id
  elseif nil == msg_id1 then
    if msg1.is_local_msg then
      do return M._cmp_to_int, msg1.ts end
      return M._cmp_to_int, msg1.ts, msg2.ts
    end
    return 1
  else
    if msg2.is_local_msg then
      do return M._cmp_to_int, msg1.ts end
      return M._cmp_to_int, msg1.ts, msg2.ts
    end
    return -1
  end
end

function M._cmp_to_int(val1, val2)
  if val1 == val2 then
    return 0
  elseif val1 < val2 then
    return -1
  else
    return 1
  end
end

E_UTILS.do_export_wrapping(M, "chat")
return M
