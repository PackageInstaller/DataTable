local E = require("ejoysdk_lua.ejoysdk")
local pack_config = require("ejoysdk_lua.cloud_game.cloud_message.pack_config")
local pack_utils = require("ejoysdk_lua.cloud_game.cloud_message.pack_utils")
local UPD = require("ejoysdk_lua.cloud_game.cloud_message.udp_socket")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_channel"
local M = {}

function M.create(addr, port, on_connected, on_connect_error, on_error, on_message)
  E.LOG.debug(TAG, "create_msg_channel begin")
  local instance = {
    addr = addr,
    port = port,
    send_msg_ids = {},
    udp_socket = nil,
    on_message = on_message
  }
  local handlers = {
    on_connected = function()
      if on_connected then
        on_connected()
      end
      if pack_config.SEND_HEART_BEAT then
        local heartbeat_pack = pack_utils.create_heatbeat_pack()
        instance.udp_socket:send(heartbeat_pack)
        instance.udp_socket:send(heartbeat_pack)
        CSTAT.stat_event("channel create on_connected, after send udp")
      end
    end,
    on_connect_error = on_connect_error,
    on_error = on_error,
    on_message = function(data)
      instance:_receive_msg(data)
    end
  }
  instance.udp_socket = UPD.create(addr, port, handlers)
  local io_tick
  
  function io_tick()
    instance.udp_socket:tick()
    E.Timer.once(pack_config.UDP_IO_TICK, io_tick)
  end
  
  io_tick()
  local heatbeat_tick
  
  function heatbeat_tick()
    E.Timer.once(pack_config.HEART_BEAT_INTERVAL, function()
      local heatbeat_pack = pack_utils.create_heatbeat_pack()
      instance.udp_socket:send(heatbeat_pack)
      instance.udp_socket:send(heatbeat_pack)
      heatbeat_tick()
    end)
  end
  
  if pack_config.SEND_HEART_BEAT then
    heatbeat_tick()
  end
  setmetatable(instance, {__index = M})
  instance:_connect()
  return instance
end

function M:set_message_handler(on_message)
  self.on_message = on_message
end

function M:_connect()
  self.udp_socket:connect()
end

local function create_error_info(code, err_msg, msg_id)
  local body = {}
  body.error_msg = err_msg
  body.fail_data = {}
  body.fail_data.msg_id = msg_id
  return code, body
end

function M:send_msg(data, callback, id)
  local udp_data, send_id = pack_utils.create_userdata_pack(data, id)
  self.send_msg_ids[send_id] = callback
  self.udp_socket:send(udp_data)
  self.udp_socket:send(udp_data)
  E.LOG.debug(TAG, "[check time] msgid=" .. tostring(send_id) .. " send " .. " time=" .. tostring(os.time() % 1000))
  E.Timer.once(pack_config.MSG_TIME_OUT, function()
    if self.send_msg_ids[send_id] then
      self.send_msg_ids[send_id] = nil
      E.LOG.debug(TAG, "send_msg ack timeout msgid=" .. tostring(send_id) .. " time=" .. tostring(os.time() % 1000))
      local code, msg_body = create_error_info(EC.CLOUD_GAME_ERROR_CODES.MSG_TIMEOUT, "pc_send_msg_time_out", send_id)
      if callback then
        callback(false, code, msg_body, send_id)
      end
    end
  end)
end

function M:_receive_msg(receive_data, _handle_msg)
  local msg_pack = pack_utils.parse_pack(receive_data)
  if msg_pack.type ~= pack_config.TYPE.HEART_BEAT then
    E.LOG.debug(TAG, "[check time] msgid=" .. tostring(msg_pack.id) .. " receive " .. " time=" .. tostring(os.time() % 1000) .. " type=" .. tostring(msg_pack.type) .. " len=" .. tostring(#msg_pack.data))
  end
  if msg_pack.type == pack_config.TYPE.USER_DATA then
    local ack_pack = pack_utils.create_ack_pack(msg_pack.id)
    self.udp_socket:send(ack_pack)
    self.udp_socket:send(ack_pack)
    E.LOG.debug(TAG, "receive msg on lua, now receive_data:")
    E.log(msg_pack.data)
    if self.on_message then
      self.on_message(msg_pack.data)
    end
  elseif msg_pack.type == pack_config.TYPE.HEART_BEAT then
    E.LOG.debug(TAG, "[cloud game] _receive_msg heart beat id=" .. tostring(msg_pack.id) .. " msg=" .. tostring(msg_pack.data))
  elseif msg_pack.type == pack_config.TYPE.ACK then
    local cb = self.send_msg_ids[msg_pack.id]
    if cb then
      self.send_msg_ids[msg_pack.id] = nil
      E.LOG.debug(TAG, "[cloud game] send_msg succ " .. tostring(msg_pack.id))
      cb(true)
    else
      E.LOG.error(TAG, "[cloud game] _receive_msg can not find cb id " .. tostring(msg_pack.id))
    end
  end
end

return M
