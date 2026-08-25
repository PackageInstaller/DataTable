local ejoysdk_lua_res_dir
if _ejoysdk.get_lua_res_location then
  ejoysdk_lua_res_dir = _ejoysdk.get_lua_res_location()
else
  ejoysdk_lua_res_dir = nil
end
_ejoysdk.log("base##" .. "get_lua_res_location: " .. tostring(ejoysdk_lua_res_dir))

local function fix_url_path(path)
  if nil == path or "" == path or "/" == path or "./" == path or "." == path then
    _ejoysdk.log("base##" .. "fix_url_path is empty, now return empty:" .. tostring(path))
    return nil
  end
  path = string.gsub(path, "(.-)[/]*$", "%1")
  return path
end

ejoysdk_lua_res_dir = fix_url_path(ejoysdk_lua_res_dir)
_ejoysdk.log("base##" .. "ejoysdk_lua path:" .. tostring(ejoysdk_lua_res_dir))
local DEFAULT_EJOY_RES_LUA_PATH = "ejoysdk_res"
local bundle_lua_cached_path

local function is_content_not_empty(content)
  return nil ~= content and "" ~= content
end

local function read(path)
  if _ejoysdk.os() == "ios" then
    local content = _ejoysdk.read_file(path)
    if is_content_not_empty(content) then
      return content
    end
  end
  do return _ejoysdk.lread end
  return _ejoysdk.lread, path, content
end

local function read_with_module_name(name)
  local lua_file_name_path = name:gsub("%.", "/") .. ".lua"
  local modpath = lua_file_name_path
  local content
  if ejoysdk_lua_res_dir and #ejoysdk_lua_res_dir > 0 then
    modpath = ejoysdk_lua_res_dir .. "/" .. modpath
    content = read(modpath)
    if is_content_not_empty(content) then
      return content, modpath
    end
  end
  if nil ~= bundle_lua_cached_path then
    modpath = bundle_lua_cached_path .. "/" .. lua_file_name_path
    content = read(modpath)
    if is_content_not_empty(content) then
      return content, modpath
    end
  end
  modpath = DEFAULT_EJOY_RES_LUA_PATH .. "/" .. lua_file_name_path
  content = read(modpath)
  if is_content_not_empty(content) then
    bundle_lua_cached_path = DEFAULT_EJOY_RES_LUA_PATH
    return content, modpath
  end
  modpath = lua_file_name_path
  content = read(modpath)
  if is_content_not_empty(content) then
    bundle_lua_cached_path = ""
    return content, modpath
  end
  return nil, modpath
end

if package.loaders then
  local function loader(name)
    local ret, content, modpath = pcall(read_with_module_name, name)
    
    assert(ret, "file not found " .. modpath .. "@" .. name)
    local ret2 = assert(loadstring(content))
    return ret2
  end
  
  table.insert(package.loaders, function(name)
    do return loader end
    return loader, name
  end)
elseif package.searchers then
  local function loader(name)
    local ret, content, modpath = pcall(read_with_module_name, name)
    
    assert(ret, "file not found " .. modpath .. "@" .. name)
    _ejoysdk.log("name: " .. name .. ", loader ret: " .. type(ret) .. ", ret value =" .. tostring(ret) .. ", path:" .. tostring(modpath))
    local ret2 = assert(load(content, modpath, "bt"), "source error " .. modpath)(name)
    if ret2 then
      return ret2
    end
  end
  
  table.insert(package.searchers, function(_name)
    return loader
  end)
end
_ejoysdk.register_cb("NATIVE_CALL", function(_event, params)
  local lua_adapter = require("ejoysdk_lua.ejoysdk_lua_adapter")
  lua_adapter.input(params)
end)
