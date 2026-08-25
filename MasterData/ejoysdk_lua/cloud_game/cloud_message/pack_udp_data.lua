local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local compat_string = compat.string
local pack_config = require("ejoysdk_lua.cloud_game.cloud_message.pack_config")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.CLOUD_GAME .. "pack_udp_data"
local M = {}

function M.pack_data(version, id, type, pkg_name, data)
  if pack_config.IS_USE_BASE64 then
    data = _ejoysdk_crypt.base64encode(data)
  end
  local data_tb = {}
  table.insert(data_tb, compat_string.pack(">i2", version))
  table.insert(data_tb, compat_string.pack(">I2", id))
  table.insert(data_tb, compat_string.pack(">i2", type))
  table.insert(data_tb, compat_string.pack("c64", pkg_name))
  table.insert(data_tb, compat_string.pack(">s2", data))
  do return table.concat end
  return table.concat, data_tb, compat_string.pack(">s2", data)
end

function M._pack_cn(len, str)
  if len < #str then
    print("_pack_cn too long", str)
    str = string.sub(str, 1, len)
  end
  local tb = {str}
  for _ = #str + 1, len do
    table.insert(tb, "\000")
  end
  do return table.concat end
  return table.concat, tb, 1, nil, table.insert, tb, "\000"
end

function M.unpack_data(receive_data)
  local tb = {}
  local pos = 1
  tb.version, pos = compat_string.unpack(">i2", receive_data, pos)
  tb.id, pos = compat_string.unpack(">I2", receive_data, pos)
  tb.type, pos = compat_string.unpack(">i2", receive_data, pos)
  tb.pkg_name, pos = compat_string.unpack("c64", receive_data, pos)
  tb.data = compat_string.unpack(">s2", receive_data, pos)
  if pack_config.IS_USE_BASE64 then
    tb.data = _ejoysdk_crypt.base64decode(tb.data)
  end
  return tb
end

return M
