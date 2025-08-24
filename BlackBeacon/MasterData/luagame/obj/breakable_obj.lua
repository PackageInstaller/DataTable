local Base = require("obj.baseobj")
local M = Util.create_child_mt(Base)
local Layer = require("utils.layer")
local NoMagic = 0
local BLOOD_ATTACH = "Bip001 Chest"
local mathx = require("base.mathx")
local _drop_curvey = mathx.item_drop_curvey
local _fly_curvey = mathx.item_fly_curvey
local _lerp = mathx.lerp_number
local EQUIP_CUBE_SCALE = 0.35
local START_SCALE = 0.5 * EQUIP_CUBE_SCALE
local _min = math.min
local DROP_STATE = {
  INIT = 0,
  DROPING = 1,
  FLYING = 2,
  END = 3
}
local RANDOM_DIS = {
  [1] = -0.5,
  [2] = 0,
  [3] = 0.5
}
local drop_quality_light = {
  [1] = "Fx_UI_battle_treasure_light_wh",
  [2] = "Fx_UI_battle_treasure_light_gn",
  [3] = "Fx_UI_battle_treasure_light_bu",
  [4] = "Fx_UI_battle_treasure_light_vt",
  [5] = "Fx_UI_battle_treasure_light_gld"
}

function M:_init(pos, cfg, breakable_id)
  Base._init(self)
  self.v_cfg = cfg
  local is_breakable = cfg.IsBreakalbe
  self.v_position:Set(pos.x, pos.y, pos.z)
  self.v_breakable_id = breakable_id
  self.v_is_breakable = is_breakable or false
  self.v_is_break = TowerMgr.breaked_item_map[self.v_breakable_id]
end

function M:show_state()
  local is_can_crush = self:is_can_crush()
  self.gameobj:SetActive(is_can_crush)
end

function M:born_ok()
  Base.born_ok(self)
  self:show_state()
end

function M:is_can_crush()
  return self.v_is_breakable and not self.v_is_break
end

function M:on_init_gameobj(...)
  Base.on_init_gameobj(self, ...)
  self:set_layer(Layer.Layer.NPC)
end

function M:set_to_state(item, state, force)
  if item.state + 1 == state or force then
    item.state = state
  end
  if state == DROP_STATE.END then
    local hero = Global.hero
    local magic_list = self.v_cfg.MagicArray
    if hero and magic_list then
      for _, magic_id in pairs(magic_list) do
        if hero and magic_id ~= NoMagic then
          hero.magic_mgr:add_magic(hero, magic_id)
        end
      end
    end
    local go = item.go
    if go and not go:IsNull() then
      go:SetActive(false)
    end
  end
end

function M:update()
  local drop_obj = self.v_drop_effect_obj
  if drop_obj then
    if drop_obj.state == DROP_STATE.INIT then
      self:set_to_state(drop_obj, DROP_STATE.DROPING)
    end
    self:droping_update()
    self:flying_update()
  end
end

function M:droping_update()
  if self.v_drop_effect_obj.state == DROP_STATE.DROPING then
    local data = self.v_drop_effect_obj
    local go = data.go
    local trans = go.transform
    trans:SetLocalScaleA(EQUIP_CUBE_SCALE, EQUIP_CUBE_SCALE, EQUIP_CUBE_SCALE)
    local p = data.drop_t
    if p <= 0 then
      self:set_to_state(self.v_drop_effect_obj, DROP_STATE.FLYING)
      return
    end
    local x, y, z = _drop_curvey(data.droped_px, data.droped_py, data.droped_pz, self.v_position.x, self.v_position.y, self.v_position.z, p)
    trans:SetPositionA(x, y, z)
    local cur_scale = _lerp(START_SCALE, 1, p) * EQUIP_CUBE_SCALE
    trans:SetLocalScaleA(cur_scale, cur_scale, cur_scale)
    data.drop_t = data.drop_t - Global.delta_time
  end
end

function M:flying_update()
  if self.v_drop_effect_obj.state == DROP_STATE.FLYING then
    local data = self.v_drop_effect_obj
    local go = data.go
    local trans = go.transform
    local fly_t = data.fly_t
    if not Util.almost_zero(fly_t - 1) then
      local hero = Global.hero
      local attach_point = Global.hero:get_setting_point(BLOOD_ATTACH)
      if not attach_point then
        Log.Error("attach point is not exist! hero = ", hero.buddy_cfg.Id)
        return
      end
      local target_x, target_y, target_z = attach_point:GetPositionA()
      local px, py, pz = _fly_curvey(data.droped_px, data.droped_py, data.droped_pz, target_x, target_y, target_z, fly_t)
      trans:SetPositionA(px, py, pz)
      local new_fly_t = fly_t + Global.delta_time
      data.fly_t = _min(new_fly_t, 1)
    else
      self:set_to_state(self.v_drop_effect_obj, DROP_STATE.END)
    end
  end
end

function M:be_crush()
  if self.gameobj and self:is_can_crush() then
    local scene_item_mgr = SceneMgr:get_scene_item_mgr()
    local breakable_item_map = TowerMgr.breakable_map[self.v_breakable_id]
    if breakable_item_map then
      scene_item_mgr:breakable_drop(self.v_position, breakable_item_map, self.v_breakable_id)
    end
    self.v_is_break = true
    local disable_time = self.v_cfg.DisableTime or 0
    local effect_name = self.v_cfg.BreakEffect
    if effect_name and "" ~= effect_name then
      local prefab_path = Path.get_res_path(effect_name)
      local go = ResMgr:load_gameobj(prefab_path, nil, true)
      go:SetActive(true)
      local x = self.v_position.x
      local y = self.v_position.y
      local z = self.v_position.z
      go.transform:SetPositionA(x, y, z)
      self.v_effect_go = go
    end
    self:use_magic()
    self:show_state()
    self:clear_disable_timer()
    self.v_disable_timer = Timer:add_timer("disable_obj", disable_time, function()
      self:disable_effect()
    end)
  end
end

function M:on_destroy_luaobj()
  self:clear_drop_effect_obj()
  self.v_cfg = nil
  self.v_position = nil
  self.v_breakable_id = nil
  self.v_is_breakable = nil
  self.v_is_break = nil
  if self.v_effect_go then
    ResMgr:destroy_gameobj(self.v_effect_go)
    self.v_effect_go = nil
  end
  self:clear_disable_timer()
end

function M:clear_drop_effect_obj()
  if self.v_drop_effect_obj then
    self:set_to_state(self.v_drop_effect_obj, DROP_STATE.END, true)
    local go = self.v_drop_effect_obj.go
    ResMgr:destroy_gameobj(go)
    self.v_drop_effect_obj = nil
  end
end

function M:clear_disable_timer()
  if self.v_disable_timer then
    Timer:remove_timer(self.v_disable_timer)
    self.v_disable_timer = nil
  end
end

function M:disable_effect()
  if self.v_effect_go then
    self.v_effect_go:SetActive(false)
  end
end

function M:is_break_obj()
  return true
end

function M:use_magic()
  local magic_list = self.v_cfg.MagicArray
  if magic_list then
    local quality = self.v_cfg.Quality
    self:create_magic_drop(quality)
  end
end

function M:create_magic_drop(quality)
  local prefab_name = drop_quality_light[quality]
  if prefab_name then
    local prefab_path = Path.get_res_path(prefab_name)
    local go = ResMgr:load_gameobj(prefab_path, nil, true)
    go:SetActive(true)
    local px = self.v_position.x
    local py = self.v_position.y
    local pz = self.v_position.z
    go.transform:SetPositionA(px, py, pz)
    local map = SceneMgr:get_scene_map()
    local has_platforms = map:has_platforms()
    local cur_retion = map:get_region_at_pos(px, pz)
    local point_list = map:get_drop_areas(px, py, pz)
    point_list = self:_filter_point_by_retion(cur_retion, point_list, has_platforms)
    local droped_px, droped_pz = self:_get_one_drop_point(point_list, px, pz, has_platforms)
    local drop_t = 1
    local drop_data = {
      droped_px = droped_px,
      droped_pz = droped_pz,
      droped_py = self.v_position.y,
      drop_t = drop_t,
      go = go,
      state = DROP_STATE.INIT,
      fly_t = 0
    }
    self.v_drop_effect_obj = drop_data
  end
end

function M:_filter_point_by_retion(target_region, point_list, has_platforms)
  if not has_platforms then
    return point_list
  end
  local map = SceneMgr:get_scene_map()
  local rlt = {}
  for i = 1, #point_list do
    local tx = point_list[i].x
    local tz = point_list[i].y
    local region = map:get_region_at_pos(tx, tz)
    if region == target_region then
      table.insert(rlt, point_list[i])
    end
  end
  return rlt
end

function M:_get_one_drop_point(point_list, px, pz, has_platforms)
  local length = #point_list
  local end_x, end_z
  local dis_x_idx = math.random(1, 3)
  local dis_z_idx = math.random(1, 3)
  local offset_x = RANDOM_DIS[dis_x_idx]
  local offset_z = RANDOM_DIS[dis_z_idx]
  if length > 0 then
    local choose_idx = math.random(1, length)
    end_x = point_list[choose_idx].x
    end_z = point_list[choose_idx].y
  else
    end_x = px
    end_z = pz
  end
  if has_platforms then
    return end_x, end_z
  end
  return end_x + offset_x, end_z + offset_z
end

return M
