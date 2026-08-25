local COMPAT = require("ejoysdk_lua.compat.ejoysdk_compat")
local BitUtil = COMPAT.bitutil
local core = setmetatable({}, {
  __index = _ejoysdk_crypt.md5
})

function core.sumhexa(k)
  k = core.sum(k)
  return (string.gsub(k, ".", function(c)
    do return string.format, "%02x", string.byte(c) end
    return string.format, "%02x", string.byte(c)
  end))
end

local function get_ipad(c)
  do return string.char, BitUtil.bxor(c:byte(), 54) end
  return string.char, BitUtil.bxor(c:byte(), 54)
end

local function get_opad(c)
  do return string.char, BitUtil.bxor(c:byte(), 92) end
  return string.char, BitUtil.bxor(c:byte(), 92)
end

function core.hmacmd5(data, key)
  if #key > 64 then
    key = core.sum(key)
    key = key:sub(1, 16)
  end
  local ipad_s = key:gsub(".", get_ipad) .. string.rep("6", 64 - #key)
  local opad_s = key:gsub(".", get_opad) .. string.rep("\\", 64 - #key)
  local istr = core.sum(ipad_s .. data)
  local ostr = core.sumhexa(opad_s .. istr)
  return ostr
end

local meta = {
  update_md5 = function(self, data)
    core.update_md5c(self.ud, data)
  end,
  finish_md5 = function(self)
    local ret = core.finish_md5c(self.ud)
    self.ud = nil
    return ret
  end,
  finishhexa = function(self)
    local k = self:finish_md5()
    if k then
      return (string.gsub(k, ".", function(c)
        do return string.format, "%02x", string.byte(c) end
        return string.format, "%02x", string.byte(c)
      end))
    end
    return ""
  end
}

function core.new_inc_md5()
  local inc_md5 = setmetatable({}, {__index = meta})
  inc_md5.ud = core.start_md5c()
  return inc_md5
end

return core
