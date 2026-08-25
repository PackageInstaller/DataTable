local type = _ENV.type
local modf = math.modf
local tonumber = _ENV.tonumber
local tostring = _ENV.tostring
local table_mt = {}

function table_mt.type_name()
  return "table"
end

function table_mt.check_type(value)
  return "table" == type(value)
end

function table_mt.value(v)
  assert("table" == type(v))
  return v
end

function table_mt.default_value()
  return {}
end

local integer_mt = {}

function integer_mt.type_name()
  return "integer"
end

function integer_mt.check_type(value)
  return "number" == type(value)
end

function integer_mt.value(v)
  local i = modf(tonumber(v))
  return i
end

function integer_mt.default_value()
  return 0
end

local number_mt = {}

function number_mt.type_name()
  return "number"
end

function number_mt.check_type(value)
  return "number" == type(value)
end

function number_mt.value(v)
  do return tonumber end
  return tonumber, v
end

function number_mt.default_value()
  return 0
end

local string_mt = {}

function string_mt.type_name()
  return "string"
end

function string_mt.check_type(value)
  return "string" == type(value)
end

function string_mt.value(v)
  do return tostring end
  return tostring, v
end

function string_mt.default_value()
  return ""
end

local bool_mt = {}

function bool_mt.type_name()
  return "boolean"
end

function bool_mt.check_type(value)
  return "boolean" == type(value)
end

function bool_mt.value(v)
  if "boolean" == type(v) then
    return v
  else
    return not not v
  end
end

function bool_mt.default_value()
  return false
end

local M = {}

function M.Table(key)
  return {
    key,
    nil,
    table_mt
  }
end

function M.Int(key, default)
  if nil == default then
    return {
      key,
      nil,
      integer_mt
    }
  else
    assert("number" == type(default))
    local d = modf(default)
    return {
      key,
      d,
      integer_mt
    }
  end
end

function M.Num(key, default)
  if nil == default then
    return {
      key,
      nil,
      number_mt
    }
  else
    assert("number" == type(default))
    return {
      key,
      default,
      number_mt
    }
  end
end

function M.Str(key, default)
  if nil == default then
    return {
      key,
      nil,
      string_mt
    }
  else
    assert("string" == type(default))
    return {
      key,
      default,
      string_mt
    }
  end
end

function M.Bool(key, default)
  if nil == default then
    return {
      key,
      nil,
      bool_mt
    }
  else
    assert("boolean" == type(default))
    return {
      key,
      default,
      bool_mt
    }
  end
end

return M
