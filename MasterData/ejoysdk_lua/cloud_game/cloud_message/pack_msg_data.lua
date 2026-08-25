local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local compat_string = compat.string
local E = require("ejoysdk_lua.ejoysdk")
local LZ = _ejoysdk_crypt.zlib
local pack_config = require("ejoysdk_lua.cloud_game.cloud_message.pack_config")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.CLOUD_GAME .. "cloud_message"
if not LZ then
  E.LOG.error(TAG, "[cloud game] is_support_deflate false")
end
local M = {}

function M.pack_data(version, id, type, data)
  local data_tb = {}
  table.insert(data_tb, compat_string.pack(">i2", version))
  table.insert(data_tb, compat_string.pack(">I2", id))
  table.insert(data_tb, compat_string.pack(">i2", type))
  data = data or ""
  table.insert(data_tb, compat_string.pack(">s2", data))
  data = table.concat(data_tb)
  if pack_config.IS_USE_ZIP then
    data = LZ.deflate(5, 31)(data, "finish")
  end
  if pack_config.IS_USE_BASE64 then
    data = _ejoysdk_crypt.base64encode(data)
  end
  return data
end

function M.unpack_data(receive_data)
  if pack_config.IS_USE_BASE64 then
    receive_data = _ejoysdk_crypt.base64decode(receive_data)
  end
  if pack_config.IS_USE_ZIP then
    receive_data = LZ.inflate(31)(receive_data)
  end
  local tb = {}
  local pos = 1
  tb.version, pos = compat_string.unpack(">i2", receive_data, pos)
  tb.id, pos = compat_string.unpack(">I2", receive_data, pos)
  tb.type, pos = compat_string.unpack(">i2", receive_data, pos)
  tb.data = compat_string.unpack(">s2", receive_data, pos)
  return tb
end

return M
