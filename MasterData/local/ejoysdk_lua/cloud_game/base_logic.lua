local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.CLOUD_GAME .. "base_logic"
local lua_files = {}

local function get_lua_file(path)
  local lua_f = lua_files[path]
  if not lua_f then
    lua_f = require(path)
    lua_files[path] = lua_f
  end
  return lua_f
end

function M.inject_methods(hook_config)
  E.LOG.debug(TAG, "start inject_methods")
  for lua_path, hook_map in pairs(hook_config) do
    local lua_f = get_lua_file(lua_path)
    E.LOG.debug(TAG, "start inject_methods hook: " .. tostring(lua_path))
    for key, value in pairs(hook_map) do
      E.LOG.debug(TAG, "hook method, path:" .. tostring(lua_path) .. ", method:" .. tostring(key))
      local type = type(value)
      if "function" == type then
        local method_name = key
        local method = value
        local origin_method = lua_f[method_name]
        lua_f[method_name] = function(...)
          do return method, origin_method, ... end
          return method, origin_method, ...
        end
      elseif "table" == type then
        local table_name = key
        local hook_table = value
        for method_name, method in pairs(hook_table) do
          local origin_method = lua_f[table_name][method_name]
          lua_f[table_name][method_name] = function(...)
            do return method, origin_method, ... end
            return method, origin_method, ...
          end
        end
      end
    end
  end
end

return M
