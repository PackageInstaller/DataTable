local M = {}
local Behavior = require("manager.fight.behavior")
local index_func
local behavior_config = require("common.lua_behavior_const")
if UNITY_EDITOR and GAME_DEBUG then
  local BehaviorDesc = require("manager.fight.behaviordesc")
  local BEHAVIOR_FUNC_INFO = {}
  
  local function get_func_info(func)
    local info = BEHAVIOR_FUNC_INFO[func]
    if not info then
      info = debug.getinfo(func, "nu")
      BEHAVIOR_FUNC_INFO[func] = info
    end
    return info
  end
  
  local function behavior_func_wrapper(key, func)
    return function(...)
      local info = get_func_info(func)
      local args = {
        ...
      }
      local desc = BehaviorDesc[key]
      for i = 1, info.nparams do
        if nil == args[i] and (nil == desc or not desc[i]) then
          Log.Error(Util.format_str("错误，第:{1}个参数为空", i), debug.traceback())
          break
        end
      end
      return func(...)
    end
  end
  
  function index_func(tbl, key)
    local behavior_func = Behavior[key]
    if behavior_func then
      return behavior_func_wrapper(key, behavior_func)
    elseif BehaviorMgr.SCOPE_GLOBAL[key] then
      return BehaviorMgr.SCOPE_GLOBAL[key]
    else
      local value = _G[key]
      if nil == value then
        local file = rawget(tbl, "__file__")
        assert(nil, file .. " 没有找到：" .. key)
      else
        return value
      end
    end
  end
else
  function index_func(tbl, key)
    local behavior_func = Behavior[key]
    
    if behavior_func then
      return behavior_func
    elseif BehaviorMgr.SCOPE_GLOBAL[key] then
      return BehaviorMgr.SCOPE_GLOBAL[key]
    else
      local value = _G[key]
      if nil == value then
        local file = rawget(tbl, "__file__")
        assert(nil, file .. " 没有找到：" .. key)
      else
        return value
      end
    end
  end
end
local behavior_importer, behevior_injector

local function get_behavior_env(file)
  return setmetatable({
    __file__ = file,
    import = behavior_importer,
    inject = behevior_injector,
    Const = behavior_config
  }, {__index = index_func})
end

local CSLuaService = CS.Game.LuaService

function M.load_behavior_file(file)
  local ret, err
  if UNITY_EDITOR and GAME_DEBUG and not Game_AssetBundle then
    local file_path = CSLuaService.GetLuaFilePath(file)
    ret, err = loadfile(file_path, "bt", get_behavior_env(file))
  else
    local data = CSLuaService.loadBehavior(file)
    if not data or "" == data then
      Log.Error("找不到行为文件：", file)
      assert(nil)
    end
    ret, err = load(data, file, "bt", get_behavior_env(file))
  end
  if ret then
    return ret
  else
    Log.Error("加载: " .. file .. " 出错", err, debug.traceback())
  end
end

local BEHAVIOR_IMPORTED_FILES = {}

function behavior_importer(file_name)
  local module_map = BehaviorMgr:get_module_map()
  local data = module_map[file_name]
  if data then
    return data
  end
  data = M.load_behavior_file(file_name)
  if data then
    data = data()
    module_map[file_name] = data
    BEHAVIOR_IMPORTED_FILES[file_name] = data
  end
  return data
end

local CANT_INJECT_KEYS = {"__index", "__newindex"}

local function try_inject(meta, k, v)
  if UtilTable.contains(CANT_INJECT_KEYS, k) then
    return
  end
  if meta[k] then
    Log.Info("重复注入将覆盖: " .. k, debug.traceback())
  end
  if not v then
    Log.Error("需要注入的API不存在: " .. k, debug.traceback())
  end
  meta[k] = v
end

function behevior_injector(meta, api_tbl, api_names)
  if api_names then
    for k, _ in pairs(api_names) do
      try_inject(meta, k, api_tbl[k])
    end
  else
    for k, v in pairs(api_tbl) do
      try_inject(meta, k, v)
    end
  end
end

function M.on_enter_battle_scene()
  for _, file in pairs(BEHAVIOR_IMPORTED_FILES) do
    local func = file.reset_on_enter_scene
    if func then
      func()
    end
  end
end

function M.on_enter_room()
  for _, file in pairs(BEHAVIOR_IMPORTED_FILES) do
    local func = file.reset_on_enter_room
    if func then
      func()
    end
  end
end

function M.reload_all()
  BEHAVIOR_IMPORTED_FILES = {}
end

function M.clear_all()
  UtilTable.clear_map(BEHAVIOR_IMPORTED_FILES)
end

return M
