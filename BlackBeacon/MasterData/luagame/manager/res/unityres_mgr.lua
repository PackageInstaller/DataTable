local Util = require("utils.util")
local AssetCache = require("manager.res.asset_cache")
local ResLoader = CS.ResLoader

local function msgh(err)
  local traceback = debug.traceback()
  local msg = err .. "\n" .. traceback
  Log.Error(msg)
end

local M = Util.create_class()

function M:_init()
  self.v_session_list = {}
end

function M:load_res_async(res_path, asset_type, session)
  asset_type = typeof(asset_type)
  if not self.v_session_list[asset_type] then
    self.v_session_list[asset_type] = {}
  end
  if self.v_session_list[asset_type][res_path] ~= nil then
    table.insert(self.v_session_list[asset_type][res_path], session)
    return
  end
  self.v_session_list[asset_type][res_path] = {}
  table.insert(self.v_session_list[asset_type][res_path], session)
  if not res_path or "" == res_path then
    assert(false, "prefab_name 不能为空")
  end
  Coroutine.start(function()
    local request = ResLoader.LoadResAsync(res_path, asset_type)
    if not request then
      Log.Error("create request failed, asset_path: " .. res_path)
      return
    end
    coroutine.yield(request)
    local asset = request.asset
    if not asset then
      Log.Error("load res failed, asset_path: " .. res_path)
      return
    end
    for _, session in ipairs(self.v_session_list[asset_type][res_path]) do
      xpcall(ResMgr.on_resource_load, msgh, ResMgr, session, asset)
    end
    self.v_session_list[asset_type][res_path] = nil
  end)
end

return M
