local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local Layer = require("utils.layer")
local LAND_LAYER = Layer.LayerMask.Terrain
local M = Util.create_class()

function M:_init(region, x, z, y)
  self.v_region = region
  if region:is_plat() then
    local offset = region:get_gg_offset()
    x = x - offset.x
    z = z - offset.z
  end
  self.v_x = x
  self.v_z = z
  self.v_y = y
  self.v_world_y = 0
end

function M:update_y(start_y)
  return self.v_y
end

function M:on_destroy()
  self.v_region = nil
  self.v_pos = nil
end

function M._get_pool()
  if M.v_pool then
    return M.v_pool
  end
  M.v_pool = LuaObjPoolMgr.get_pool("find_path_point_pool") or LuaObjPoolMgr.register("find_path_point_pool", 100, M)
  return M.v_pool
end

function M.create(region, x, z, y)
  return M._get_pool():new_obj(region, x, z, y)
end

function M:destroy()
  M._get_pool():destroy_obj(self)
end

function M:get_world_pos()
  local x, z = self:get_world_pos_xz()
  return x, self.v_y, z
end

function M:get_world_pos_xz()
  if not self.v_region:is_plat() then
    return self.v_x, self.v_z
  end
  local x, _, z = self.v_region:get_pos2()
  return x + self.v_x, z + self.v_z
end

return M
