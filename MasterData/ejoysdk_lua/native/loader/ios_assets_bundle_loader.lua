if package.searchers then
  local function loader(name, modpath)
    local src = assert(_ejoysdk.lread(modpath), "file not found " .. modpath .. "@" .. name)
    
    local ret = assert(load(src, modpath, "bt"), "source error " .. modpath)(name)
    _ejoysdk.log("ios_assets_bundle_loader name: " .. name .. ", loader ret: " .. type(ret))
    if ret then
      return ret
    end
  end
  
  table.insert(package.searchers, function(name)
    local modpath = name:gsub("%.", "/") .. ".lua"
    modpath = "ejoysdk_assets.bundle" .. "/" .. modpath
    return loader, modpath
  end)
end
_ejoysdk.register_cb("NATIVE_CALL", function(_event, params)
  local lua_adapter = require("ejoysdk_lua.ejoysdk_lua_adapter")
  lua_adapter.input(params)
end)
