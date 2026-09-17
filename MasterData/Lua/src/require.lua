package.pageLoaded = setmetatable({}, {__mode = "kv"})
local baseRequire = require

local function requireWrap(name)
  if name:match("^ui[/.]pages[/.]") then
    local res = package.pageLoaded[name]
    if res ~= nil then
      return res
    end
    res = baseRequire(name)
    package.pageLoaded[name] = res
    package.loaded[name] = nil
    return res
  else
    return baseRequire(name)
  end
end

if not IS_EDITOR and not IS_DEV_BUILD then
  return requireWrap
end
local statistics = CS.XLua.LuaStatistics
local requireStack = {}
local requireLevel = 0
return function(moduleName)
  requireLevel = requireLevel + 1
  local shouldCheck = statistics.ShouldCheck(moduleName)
  local ok, res
  if shouldCheck then
    collectgarbage("collect")
    local count1 = collectgarbage("count")
    ok, res = xpcall(requireWrap, debug.traceback, moduleName)
    collectgarbage("collect")
    local count2 = collectgarbage("count")
    local diff = count2 - count1
    statistics.SetRequireSize(moduleName, diff - (requireStack[requireLevel + 1] or 0))
    local lastDiff = requireStack[requireLevel] or 0
    requireStack[requireLevel] = lastDiff + diff
  else
    ok, res = xpcall(requireWrap, debug.traceback, moduleName)
  end
  requireStack[requireLevel + 1] = nil
  requireLevel = requireLevel - 1
  assert(ok, res)
  return res
end
