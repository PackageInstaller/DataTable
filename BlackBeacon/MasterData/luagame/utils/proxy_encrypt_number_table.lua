local M = {}
local _mfloor = math.floor

local function calibrationValue(value, valueDecimalPlaces)
  local mult = 10 ^ (valueDecimalPlaces or 0)
  return _mfloor(value * mult + 0.5) / mult
end

function M.create_encrypted_table()
  local t = {}
  local attr_proxy_table = {}
  math.randomseed(os.time())
  local dynamic_key = math.random(0, 4294967295)
  
  local function encrypt_value(value)
    if nil == value or value == math.huge then
      return value
    end
    local int_value = calibrationValue(value * 100, 2)
    local encrypted = int_value ~ dynamic_key
    return encrypted
  end
  
  local function decrypt_value(value)
    if nil == value or value == math.huge then
      return value
    end
    local decrypted = (value ~ dynamic_key) / 100
    return decrypted
  end
  
  local mt = {
    __index = function(tbl, key)
      local value = rawget(attr_proxy_table, key)
      local decrypted_val = decrypt_value(value)
      return decrypted_val
    end,
    __newindex = function(tbl, key, value)
      local encrypted_val = encrypt_value(value)
      rawset(attr_proxy_table, key, encrypted_val)
    end,
    __pairs = function(tbl)
      local function iterator(t_internal, k)
        local key, encrypted_value = next(t_internal, k)
        
        if nil ~= key then
          local decrypted_value = decrypt_value(encrypted_value)
          return key, decrypted_value
        end
        return nil
      end
      
      return iterator, attr_proxy_table, nil
    end,
    __ipairs = function(tbl)
      local i = 0
      
      local function iterator(t_internal, index)
        i = i + 1
        local encrypted_value = t_internal[i]
        if nil ~= encrypted_value then
          local decrypted_value = decrypt_value(encrypted_value)
          return i, decrypted_value
        else
          return nil
        end
      end
      
      return iterator, attr_proxy_table, 0
    end
  }
  setmetatable(t, mt)
  return t
end

return M
