local E = require("ejoysdk_lua.ejoysdk")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
local protocol = require("ejoysdk_lua.chat.ejoysdk_chat_protocol")
local LZ = _ejoysdk_crypt.zlib
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local string_pack, string_unpack, xpcall = compat.string.pack, compat.string.unpack, compat.xpcall
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local chat_token = require("ejoysdk_lua.chat.ejoysdk_chat_token_util")
local chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
local Class = require("ejoysdk_lua.ejoysdk_class")
local TAG = EM.MODULE.CHAT .. "data_pack"
local M = Class:Inherit("ejoy.class.chat.data_pack")
M.DATA_PARTS = {
  RPC_HEADER = "rpc_header",
  CONTENT_HEADER = "content_header",
  CONTENT_BODY = "content_body"
}
M.ENCODING_TYPES = {DEFLATE = "deflate"}

function M:_init(options)
  self._data = {
    curr_login_version = chat_token.LOGIN_V1,
    rc4_send_key = nil,
    rc4_recv_key = nil,
    pack_options = options or {},
    inflate_stream = nil,
    deflate_stream = nil,
    is_first_rpc_request = true,
    server_deflate_support = false
  }
  local rc4_init_key = ""
  if chat_token.is_chat_token_valid() then
    self._data.curr_login_version = chat_token.LOGIN_V2
    rc4_init_key = chat_token.get_chat_token_info_key()
    E.LOG.debug(TAG, "聊天登录协议V2:使用chat_token_key加密连接")
  end
  if not rc4_init_key or 0 == #rc4_init_key then
    self._data.curr_login_version = chat_token.LOGIN_V1
    if EH.get_player_token_body() then
      rc4_init_key = EH.get_player_token_body().key
      E.LOG.debug(TAG, "聊天登录协议V1:使用moment_token加密连接")
    else
      E.LOG.debug(TAG, "ejoy_chat_data_pack_init, " .. "token_is_nil")
      ESTAT.stat_error_with_limit(TAG, "ejoy_chat_data_pack_init_token_is_nil", "ejoy_chat_data_pack_init_token_is_nil", "ejoy_chat_token_is_nil")
    end
  end
  chat_token.curr_login_version = self._data.curr_login_version
  self._data.rc4_send_key = _ejoysdk_crypt.rc4_key(rc4_init_key)
  self._data.rc4_recv_key = _ejoysdk_crypt.rc4_key(rc4_init_key)
end

function M:_prepare_content_header(content_header)
  if self._data.server_deflate_support then
    content_header.content_encoding = M.ENCODING_TYPES.DEFLATE
  end
  local header_chunk = protocol.encode_header(content_header)
  return header_chunk
end

function M:_get_deflate_stream()
  if self._data.deflate_stream == nil then
    self._data.deflate_stream = LZ.deflate(LZ.DEFAULT_COMPRESSION, LZ.DEFAULT_WINDOWBITS)
  end
  return self._data.deflate_stream
end

function M:_prepare_content_body(content_body, options)
  local encode_content = JSON.encode_with_option(content_body, options)
  local result_body = encode_content
  if self._data.server_deflate_support and self._data.pack_options.deflate then
    local deflated_content, _shrink_eof = self:_get_deflate_stream()(encode_content, "sync")
    result_body = deflated_content
  end
  return result_body
end

function M:_append_first_rpc_header(encrypt_pack, rpc_header)
  local pack
  if self._data.is_first_rpc_request and self._data.pack_options.type == "tcp" then
    self._data.is_first_rpc_request = false
    pack = rpc_header .. encrypt_pack
  else
    pack = encrypt_pack
  end
  return pack
end

function M.is_support_deflate()
  if _ejoysdk_crypt.zlib then
    return true
  else
    return false
  end
end

function M:pack_data(data, options)
  local rpc_header = data[M.DATA_PARTS.RPC_HEADER] or ""
  local content_header = data[M.DATA_PARTS.CONTENT_HEADER] or {}
  local content_body = data[M.DATA_PARTS.CONTENT_BODY] or {}
  local header_chunk = self:_prepare_content_header(content_header)
  local prepared_content_body = self:_prepare_content_body(content_body, options)
  local pack_list = {}
  table.insert(pack_list, string_pack(">I2", #header_chunk))
  table.insert(pack_list, header_chunk)
  table.insert(pack_list, prepared_content_body)
  local pack_body = table.concat(pack_list)
  if self._data.pack_options.encrypt then
    pack_body = _ejoysdk_crypt.rc4_encrypt(pack_body, self._data.rc4_send_key)
  end
  local pack_result = self:_append_first_rpc_header(pack_body, rpc_header)
  return pack_result
end

function M:_get_inflate_stream()
  if self._data.inflate_stream == nil then
    self._data.inflate_stream = LZ.inflate(LZ.DEFAULT_WINDOWBITS)
  end
  return self._data.inflate_stream
end

function M:_get_decode_json()
  if self._data.pack_options and self._data.pack_options.enable_cjson then
    return CJSON
  end
  return JSON
end

function M:_decrypt_messge(pack)
  if self._data.pack_options.encrypt then
    pack = _ejoysdk_crypt.rc4_decrypt(pack, self._data.rc4_recv_key)
  end
  local header_length = string_unpack(">I2", pack:sub(1, 2))
  pack = pack:sub(3)
  local header_chunk = pack:sub(1, header_length)
  local header = protocol.decode_header(header_chunk)
  pack = pack:sub(header_length + 1)
  local content_encoding = header.content_encoding
  if content_encoding == M.ENCODING_TYPES.DEFLATE then
    self._data.server_deflate_support = true
    pack = self:_get_inflate_stream()(pack)
  end
  local msg = self:_get_decode_json().decode(pack)
  return header, msg
end

function M:unpack_data(pack)
  local ok, header, msg = xpcall(M._decrypt_messge, function(x)
    chat_log.warn(chat_log_util.header(), TAG, "decrypt_messge_has_error", {
      lua_error_msg = tostring(x)
    }, {})
  end, self, pack)
  return ok, header, msg
end

function M:reset()
  if self._data.deflate_stream then
    self._data.deflate_stream(nil, "finish")
  end
  if self._data.inflate_stream then
    self._data.inflate_stream(nil, "finish")
  end
  self._data.deflate_stream = nil
  self._data.inflate_stream = nil
  self._data.is_first_rpc_request = true
  self._data.server_deflate_support = false
end

function M:get_curr_login_version()
  return self._data.curr_login_version
end

return M
