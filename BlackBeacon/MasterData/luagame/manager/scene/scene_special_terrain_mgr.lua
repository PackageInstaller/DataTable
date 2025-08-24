local M = Util.create_class()
local TypeCollider = typeof(UnityEngine.Collider)
local Vec3 = require("base.vec3")

function M:_init()
  self.v_special_terrain_map = {}
end

function M:load_scene_special_terrain(container)
  for tag, cfg in pairs(Config.SPECIAL_TERRAIN) do
    local objs = container and container[cfg.container_objs_name]
    if objs then
      for i = 0, objs.Length - 1 do
        local go = objs[i]
        if go and not go:IsNull() and go:CompareTag(tag) then
          self:load_single_scene_special_terrain(go, cfg)
        end
      end
    end
  end
end

function M:load_single_scene_special_terrain(go, cfg)
  local comp = go:GetComponent(TypeCollider)
  if not Util.is_nil(comp) then
    self.v_special_terrain_map[comp:GetInstanceID()] = cfg
  else
    Log.Error("特殊地形缺少Collider", cfg.tag, go.gameObject.name)
  end
end

function M:get_cfg(cid)
  local map = self.v_special_terrain_map
  return map and map[cid]
end

local Layer = require("utils.layer")
local TERRAIN_LAYER = Layer.LayerMask.Terrain
local tags = Config.TERRAIN_TAG
local WATER_INTERACTION = {
  Ice = function(missile, x, y, z)
    SceneMgr:create_scene_effect("Fx_scene_waterfreeze", Vec3.New(x, y, z))
  end,
  Electric = function(missile, x, y, z)
    SceneMgr:create_missile(missile:get_owner(), nil, 10010121206, nil, nil, nil, math.floor(1.0010121206E8), Vec3.New(x, y, z))
  end
}

function M:try_interact(missile)
  local x, y, z = missile:get_pos()
  local hit, height, cid = CSHelper.GetSpecialTerrainHeight(x, z, TERRAIN_LAYER, y + 1, 3)
  local terrain_cfg = self:get_cfg(cid)
  if terrain_cfg and terrain_cfg.tag == tags.WATER then
    local func = WATER_INTERACTION[missile.interact_type]
    if func then
      func(missile, x, height, z)
    end
  end
end

function M:on_clear_scene()
  self.v_special_terrain_map = nil
end

return M
