local E = require("ejoysdk_lua.ejoysdk")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local TBUtils = require("ejoysdk_lua.apm-sdk-lua.common.tb_utils")
local LOGGER = "apm_utils"
local M = {}
M.__index = M

function M.table_tostring(...)
  do return E_UTILS.log_util.table_tostring, ... end
  return E_UTILS.log_util.table_tostring, ...
end

function M.table_size(data)
  local count = 0
  for _, _ in pairs(data) do
    count = count + 1
  end
  return count
end

function M.merge_table(base, advanced, replacing)
  if nil == base then
    return advanced
  end
  local t = replacing and base or E_UTILS.deepcopy(base)
  if nil == advanced then
    return t
  end
  for k, v in pairs(advanced) do
    if nil == t[k] then
      t[k] = v
    elseif type(v) ~= type(t[k]) then
      E.LOG.error(LOGGER, string.format("table merging error: types of %s are %s and %s", k, type(v), type(t[k])))
    elseif type(v) == "table" then
      t[k] = M.merge_table(t[k], v)
    elseif t[k] ~= v then
      t[k] = v
    end
  end
  return t
end

local pack_fn = table.pack or function(...)
  return {
    ...
  }
end
local unpack_fn = table.unpack or unpack

function M.exec(func, args)
  if nil == func then
    return
  end
  local ret
  xpcall(function()
    if nil == args then
      ret = pack_fn(func())
    elseif type(args) == "table" and #args > 0 then
      ret = pack_fn(func(unpack_fn(args)))
    else
      ret = pack_fn(func(args))
    end
  end, function(err)
    E.LOG.error(LOGGER, string.format([[
Executing function error. Args: %s. Error: %s. Traceback:
%s]], M.table_tostring(args), err, TBUtils.get_traceback_info()))
  end)
  if nil ~= ret then
    do return unpack_fn end
    return unpack_fn, ret, function(err)
      E.LOG.error(LOGGER, string.format([[
Executing function error. Args: %s. Error: %s. Traceback:
%s]], M.table_tostring(args), err, TBUtils.get_traceback_info()))
    end
  end
  return nil
end

local function quick_determine(actual, expected, marginForAlmostEqual)
  if actual == expected then
    return true, true
  end
  local type_a, type_e = type(actual), type(expected)
  if type_a ~= type_e then
    return true, false
  end
  if "number" == type_a then
    if nil ~= marginForAlmostEqual and type(marginForAlmostEqual) == "number" and marginForAlmostEqual >= 0 then
      return true, marginForAlmostEqual >= math.abs(expected - actual)
    else
      return true, actual == expected
    end
  elseif "table" ~= type_a then
    return true, actual == expected
  end
  return false, false
end

function M:is_table_equals(actual, expected, cycleDetectTable, marginForAlmostEqual)
  local ok, result = quick_determine(actual, expected, marginForAlmostEqual)
  if ok then
    return result
  end
  cycleDetectTable = cycleDetectTable or {
    actual = {},
    expected = {}
  }
  if cycleDetectTable.actual[actual] then
    if cycleDetectTable.expected[expected] then
      return true
    end
    return false
  end
  if cycleDetectTable.expected[expected] then
    return false
  end
  cycleDetectTable.actual[actual] = true
  cycleDetectTable.expected[expected] = true
  local actualKeysMatched = {}
  for k, v in pairs(actual) do
    actualKeysMatched[k] = true
    if not self:is_table_equals(v, expected[k], cycleDetectTable, marginForAlmostEqual) then
      cycleDetectTable.actual[actual] = nil
      cycleDetectTable.expected[expected] = nil
      return false
    end
  end
  for k, _ in pairs(expected) do
    if not actualKeysMatched[k] then
      cycleDetectTable.actual[actual] = nil
      cycleDetectTable.expected[expected] = nil
      return false
    end
  end
  cycleDetectTable.actual[actual] = nil
  cycleDetectTable.expected[expected] = nil
  return true
end

local metric_type_regex = "^[a-zA-Z_:][a-zA-Z0-9_:]*$"

function M.is_metric_name_valid(name)
  if type(name) ~= "string" then
    return false
  end
  local ret = string.match(name, metric_type_regex)
  return nil ~= ret
end

return M
