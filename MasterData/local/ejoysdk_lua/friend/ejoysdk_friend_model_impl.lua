local Class = require("ejoysdk_lua.ejoysdk_class")
local FRIEND = require("ejoysdk_lua.friend.ejoysdk_friend")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CALLBACK = require("ejoysdk_lua.chat.ejoysdk_chat_callback_manager")
local M = Class:Inherit("friend_model")
local TAG = EM.MODULE.FRIEND .. "friend_model_impl"

function M:_init(handler, init_param)
  self.user_type = init_param.user_type or "player"
  self.handler = handler
  if self.user_type == "player" then
    self:_try_friend_sync()
  end
  self:_register_handler()
end

function M:_try_friend_sync()
  FRIEND.init()
  local EH = require("ejoysdk_lua.ejoysdk_holo")
  if EH.get_player_token() and #EH.get_player_token() > 0 then
    FRIEND._sync_friend_scene()
  end
end

function M:_info_friend_apply(_msg_type, _msgs)
  self.handler:info_friend_changes(_msg_type, _msgs)
end

function M:_info_friend_apply_refuse(_msg_type, _msgs)
  self.handler:info_friend_changes(_msg_type, _msgs)
end

function M:_info_friend_apply_delete(_msg_type, _msgs)
  self.handler:info_friend_changes(_msg_type, _msgs)
end

function M:_info_friend_add(_msg_type, _msgs)
  self.handler:info_friend_changes(_msg_type, _msgs)
end

function M:_info_friend_del(_msg_type, _msgs)
  self.handler:info_friend_changes(_msg_type, _msgs)
end

function M:_info_friend_info_change(_msg_type, _msgs)
  self.handler:info_friend_changes(_msg_type, _msgs)
end

function M:_info_favor_change(_msg_type, _msgs)
  self.handler:info_favor_changes(_msg_type, _msgs)
end

function M:_info_follow_add(_msg_type, _msgs)
  self.handler:info_follow_changes(_msg_type, _msgs)
end

function M:_info_follow_be_add(_msg_type, _msgs)
  self.handler:info_follow_changes(_msg_type, _msgs)
end

function M:_info_follow_del(_msg_type, _msgs)
  self.handler:info_follow_changes(_msg_type, _msgs)
end

function M:_info_follow_be_del(_msg_type, _msgs)
  self.handler:info_follow_changes(_msg_type, _msgs)
end

function M:_info_follow_info_change(_msg_type, _msgs)
  self.handler:info_follow_changes(_msg_type, _msgs)
end

function M:_info_customer_friend_add(_msg_type, _msgs)
  if self.handler.info_channel_friend_changes then
    self.handler:info_channel_friend_changes(_msg_type, _msgs)
  end
end

function M:_info_customer_friend_del(_msg_type, _msgs)
  if self.handler.info_channel_friend_changes then
    self.handler:info_channel_friend_changes(_msg_type, _msgs)
  end
end

function M:_info_customer_friend_info_change(_msg_type, _msgs)
  if self.handler.info_channel_friend_changes then
    self.handler:info_channel_friend_changes(_msg_type, _msgs)
  end
end

function M:_get_handlers()
  return {
    info_friend_apply = function(_msgs)
      self:HANDLERS("info_friend_apply", _msgs)
    end,
    info_friend_apply_refuse = function(_msgs)
      self:HANDLERS("info_friend_apply_refuse", _msgs)
    end,
    info_friend_apply_delete = function(_msgs)
      self:HANDLERS("info_friend_apply_delete", _msgs)
    end,
    info_friend_add = function(_msgs)
      self:HANDLERS("info_friend_add", _msgs)
    end,
    info_friend_del = function(_msgs)
      self:HANDLERS("info_friend_del", _msgs)
    end,
    info_friend_info_change = function(_msgs)
      self:HANDLERS("info_friend_info_change", _msgs)
    end,
    info_favor_change = function(_msgs)
      self:HANDLERS("info_favor_change", _msgs)
    end,
    info_follow_add = function(_msgs)
      self:HANDLERS("info_follow_add", _msgs)
    end,
    info_follow_be_add = function(_msgs)
      self:HANDLERS("info_follow_be_add", _msgs)
    end,
    info_follow_del = function(_msgs)
      self:HANDLERS("info_follow_del", _msgs)
    end,
    info_follow_be_del = function(_msgs)
      self:HANDLERS("info_follow_be_del", _msgs)
    end,
    info_follow_info_change = function(_msgs)
      self:HANDLERS("info_follow_info_change", _msgs)
    end
  }
end

function M:_get_channel_handlers()
  return {
    info_customer_friend_add = function(_msgs)
      self:HANDLERS("info_customer_friend_add", _msgs)
    end,
    info_customer_friend_del = function(_msgs)
      self:HANDLERS("info_customer_friend_del", _msgs)
    end,
    info_customer_friend_info_change = function(_msgs)
      self:HANDLERS("info_customer_friend_info_change", _msgs)
    end
  }
end

function M:_register_handler()
  local _friend_handlers = self:_get_handlers()
  if self.user_type == "account" then
    local _channel_friend_handlers = self:_get_channel_handlers()
    CALLBACK.register_callback("client_friend_chat_account", _channel_friend_handlers)
  else
    CALLBACK.register_callback("client_friend_chat", _friend_handlers)
  end
end

function M:_unregister_handler()
  if self.user_type == "account" then
    CALLBACK.unregister_callback("client_friend_chat_account")
  else
    CALLBACK.unregister_callback("client_friend_chat")
  end
end

function M:destroy()
  if not self.destroy_flag then
    self.destroy_flag = true
    self:_unregister_handler()
  end
end

function M:HANDLERS(cmd, _msgs)
  local fun_cmd = "_" .. (cmd or "")
  local func = M[fun_cmd]
  if nil ~= func and type(func) == "function" then
    func(self, cmd, _msgs)
  else
    self:_default_handler(cmd)
  end
end

function M:_default_handler(_cmd)
  E.LOG.d(TAG, "_default_handler:" .. tostring(_cmd))
end

return M
