local M = {}
local TAG = "ejoysdk_vm_module_manager"

local function log(msg)
  _ejoysdk.log(TAG .. "#" .. tostring(msg))
end

local function start_with(str, start)
  return str:sub(1, #start) == start
end

function M.clear()
  local cleared_modules = {}
  for m, _ in pairs(package.loaded) do
    if start_with(m, "ejoysdk_lua.") then
      package.loaded[m] = nil
      table.insert(cleared_modules, m)
    end
  end
  if #cleared_modules > 0 then
    local JSON = require("ejoysdk_lua.ejoysdk_json")
    local E = require("ejoysdk_lua.ejoysdk")
    local cache_str = JSON.encode(cleared_modules)
    local clear_temp_filename = "sdk_vm_required_modules_cache.json"
    local clear_temp_path = E.Path.join(E.File.get_ext_file_dir(), clear_temp_filename)
    local succ = pcall(E.File.writefile_fullpath, clear_temp_path, cache_str)
    log("clear_specified_modules cache save to:" .. tostring(clear_temp_path) .. ", succ:" .. tostring(succ))
  end
  log("clear cache modules end, cache modules size:" .. tostring(#cleared_modules))
end

return M
