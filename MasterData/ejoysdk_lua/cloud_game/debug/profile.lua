local E = require("ejoysdk_lua.ejoysdk")
local profile = LuaProfile
local M = {}
local TAG = "cloud_profile"
local debug = require("debug")
debug.sethook(nil)

function M.lua_profile_start()
  E.LOG.debug(TAG, "lua_profile_start")
  local permission = "android.permission.WRITE_EXTERNAL_STORAGE"
  E.Permission.check_permission_v2(permission, function(succ, ...)
    if succ then
      _ejoysdk.log("profile_start begin")
      local path = E.Path.join(E.File.get_ext_file_dir(), "log")
      E.File.make_dirs(path)
      profile.init("log_path=" .. path .. "&bool_profile_dmtrace=false&bool_profile_record_item=false&bool_profile_optick=false&int_flamegraph_sample_per_sec=50")
      profile.start()
      _ejoysdk.log("profile_start end")
    else
      _ejoysdk.log("没有存储权限 profile_start fail")
    end
  end)
end

local function dump(records)
  local ret = {
    "------- dump profile -------"
  }
  if not records then
    _ejoysdk.log("dump failed not records")
    return
  end
  for i, v in ipairs(records) do
    local s = string.format("[%d] %s name:%s file:[%s]%s:%d count:%d total:%fs ave:%fs percent:%.4g%%", i, v.point, v.name, v.flag, v.source, v.line, v.count, v.all_cost, v.ave_cost, v.percent * 100)
    ret[#ret + 1] = s
  end
  do return table.concat, ret end
  return table.concat, ret, "\n", ipairs(records)
end

local function file_exists(path)
  local file = io.open(path, "rb")
  if file then
    file:close()
  end
  return nil ~= file
end

function M.lua_profile_stop()
  E.LOG.debug(TAG, "profile_stop begin")
  
  function profile.dstop(count)
    local records = profile.stop(count)
    local s = dump(records)
    _ejoysdk.log(s)
  end
  
  profile.dstop(20)
  profile.destory()
  local log_dir = E.Path.join(E.File.get_ext_file_dir(), "log")
  if file_exists(log_dir) then
    _ejoysdk.log(log_dir .. " exist")
    local file_prefix = tostring(os.time()) .. "."
    local rename_ret = os.rename(log_dir .. "luaprofile_digraph_data.txt", log_dir .. file_prefix .. "luaprofile_digraph_data.txt")
    if rename_ret then
      _ejoysdk.log("output => " .. file_prefix .. "luaprofile_digraph_data.txt")
    end
    rename_ret = os.rename(log_dir .. "luaprofile_flame_graph_data.txt", log_dir .. file_prefix .. "luaprofile_flame_graph_data.txt")
    if rename_ret then
      _ejoysdk.log("output => " .. file_prefix .. "luaprofile_flame_graph_data.txt")
    end
  end
  _ejoysdk.log("profile_stop end")
end

return M
