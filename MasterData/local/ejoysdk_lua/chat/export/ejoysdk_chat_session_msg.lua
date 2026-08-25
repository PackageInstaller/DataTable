local Class = require("ejoysdk_lua.ejoysdk_class")
local E = require("ejoysdk_lua.ejoysdk")
local msg_util = require("ejoysdk_lua.chat.export.ejoysdk_chat_msg_util")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local table_move = compat.table_move
local TAG = "chat_msg_model"
local M = Class:Inherit("session_msg_model")

function M:_init(session_id)
  self.mapped_msg = {}
  self.sorted_msg = {}
  self.session_id = session_id
end

function M:get_session_id()
  return self.session_id
end

function M:merge_msgs(new_msgs)
  local changed_msgs = {}
  local insert_msgs = {}
  for _, v in ipairs(new_msgs) do
    local msg_id = v.msg_id
    local update_key = msg_id
    local msg
    if nil ~= msg_id then
      msg = self.mapped_msg[msg_id]
      if nil == msg and nil ~= v.send_id then
        self.mapped_msg[msg_id] = self.mapped_msg[v.send_id]
        self.mapped_msg[v.send_id] = nil
        msg = self.mapped_msg[msg_id]
      end
    elseif nil ~= v.send_id then
      update_key = v.send_id
      msg = self.mapped_msg[v.send_id]
    else
      E.LOG.e(TAG, "should_not_be_here msg_id and send_id both nil")
    end
    if nil ~= msg then
      msg = self:_update_old_msg(msg, v)
    else
      table.insert(insert_msgs, v)
      msg = v
    end
    table.insert(changed_msgs, msg)
    self.mapped_msg[update_key] = msg
  end
  local idx1 = #self.sorted_msg
  local idx2 = #insert_msgs
  local idx_right = idx1 + idx2
  while idx2 > 0 do
    if idx1 <= 0 or msg_util.smaller(self.sorted_msg[idx1], insert_msgs[idx2]) then
      self.sorted_msg[idx_right] = insert_msgs[idx2]
      idx2 = idx2 - 1
    else
      self.sorted_msg[idx_right] = self.sorted_msg[idx1]
      idx1 = idx1 - 1
    end
    idx_right = idx_right - 1
  end
  return changed_msgs
end

function M:count()
  return #self.sorted_msg
end

function M:get_sorted_msg()
  return self.sorted_msg
end

function M:get_mapped_msg()
  return self.mapped_msg
end

function M:query_msg_idx(msg)
  do return self._find_idx_binary, self end
  return self._find_idx_binary, self, function(msg2)
    do return msg_util._cmp, msg end
    return msg_util._cmp, msg, msg2
  end
end

function M:get_msg_by_range(start_idx, end_idx)
  local using_start_idx = math.max(1, start_idx or 1)
  local using_end_idx = math.min(#self.sorted_msg, end_idx or #self.sorted_msg)
  local ret = {}
  table_move(self.sorted_msg, using_start_idx, using_end_idx, 1, ret)
  return ret
end

function M:delete_msg_by_range(start_idx, end_idx)
  local using_start_idx = math.max(1, start_idx or 1)
  local using_end_idx = math.min(#self.sorted_msg, end_idx or #self.sorted_msg)
  local ret = {}
  for idx = using_start_idx, using_end_idx do
    table.insert(ret, self.sorted_msg[idx])
  end
  table_move(self.sorted_msg, using_end_idx + 1, #self.sorted_msg, using_start_idx)
  for idx = #self.sorted_msg - (using_end_idx - using_start_idx), #self.sorted_msg do
    self.sorted_msg[idx] = nil
  end
  for _, v in ipairs(ret) do
    local key = v.msg_id or v.send_id
    self.mapped_msg[key] = nil
  end
  return ret
end

function M:_find_idx_binary(compare_func)
  local left, right = 1, #self.sorted_msg
  local mid
  while left <= right do
    mid = math.floor((left + right) / 2)
    local cmp_result = compare_func(self.sorted_msg[mid])
    if 0 == cmp_result then
      return mid
    elseif cmp_result < 0 then
      right = mid - 1
    else
      left = mid + 1
    end
  end
  return nil
end

function M:_find_insert_idx(v)
  return self:_find_idx_from_back(function(msg1)
    local msg2 = v
    do return msg_util.greater, msg2 end
    return msg_util.greater, msg2, msg1
  end) + 1
end

function M:_find_idx_from_back(func)
  for idx = #self.sorted_msg, 1, -1 do
    local msg1 = self.sorted_msg[idx]
    if func(msg1) then
      return idx
    end
  end
  return 0
end

function M:_update_old_msg(old_msg, new_msg)
  local is_need_bubble = false
  if old_msg.msg_id == nil and new_msg.msg_id ~= nil then
    is_need_bubble = true
  end
  for k, v in pairs(new_msg) do
    old_msg[k] = v
  end
  if is_need_bubble then
    local idx = self:_find_idx_from_back(function(msg1)
      local msg2 = old_msg
      return msg1.msg_id == msg2.msg_id
    end)
    for idx2 = idx - 1, 1, -1 do
      local msg1 = old_msg
      local msg2 = self.sorted_msg[idx2]
      if msg_util.smaller(msg1, msg2) then
        self.sorted_msg[idx], self.sorted_msg[idx2] = self.sorted_msg[idx2], self.sorted_msg[idx]
        idx = idx2
      else
        break
      end
    end
  end
  return old_msg
end

E_UTILS.do_export_wrapping(M, "chat")
return M
