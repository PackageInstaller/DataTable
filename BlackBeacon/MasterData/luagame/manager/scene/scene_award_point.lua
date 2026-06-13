local M = Util.create_class()
local ccd = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local FX_AWARD_POINT = ccd.WORLD_EFFECT_NAME.FX_BAOSHI
local CSFollower = CS.Game.MoveFollower

local function get_random_dir_and_index(get_count)
  local param = ShareRes.get_comm_string_value("RandomDropSplineParam")
  local max_random_count = #param
  local result_dir_list = {}
  local result_index_list = {}
  if 1 == get_count then
    result_dir_list[1] = math.random(0, 360)
    result_index_list[1] = math.random(1, max_random_count)
  elseif 2 == get_count then
    result_dir_list[1] = math.random(1, 180)
    result_dir_list[2] = math.random(181, 360)
    result_index_list[1] = math.random(1, max_random_count)
    result_index_list[2] = math.random(1, max_random_count)
  else
    local get_suc_count = 0
    local temp = {}
    local index
    local interval_count = 5
    local interval_dir = 120 / interval_count
    local use_dir_temp = {
      [1] = {count = interval_count},
      [2] = {count = interval_count},
      [3] = {count = interval_count}
    }
    local cur_count, remainder, dir
    while get_count > get_suc_count do
      cur_count = get_suc_count + 1
      remainder = cur_count % 3
      if 0 == remainder then
        remainder = 3
      end
      local consult
      local while_count = 5
      for i = 1, while_count do
        dir = math.random(120 * (remainder - 1) + 1, 120 * remainder)
        consult = math.floor(dir % 120 / interval_dir)
        local dir_temp = use_dir_temp[remainder]
        if dir_temp.count <= 0 then
          dir_temp = {count = interval_count}
        end
        if not dir_temp[consult] or i == while_count then
          result_dir_list[#result_dir_list + 1] = dir
          dir_temp[consult] = true
          dir_temp.count = dir_temp.count - 1
          break
        end
      end
      if max_random_count <= get_suc_count then
        temp = {}
      end
      for i = 1, while_count do
        index = math.random(1, max_random_count)
        if not temp[index] or i == while_count then
          result_index_list[#result_index_list + 1] = index
          temp[index] = true
          get_suc_count = get_suc_count + 1
          break
        end
      end
    end
  end
  return result_dir_list, result_index_list
end

local function get_rota_offset(param, dir)
  local magnitude
  Util.QuatTemp:SetEuler(0, dir, 0)
  Util.VEC3_TEMP:Set(param[1], param[2], param[3])
  magnitude = Util.VEC3_TEMP:Magnitude()
  Util.VEC3_TEMP:SetNormalize()
  Util.QuatTemp:MulVec3_NoneAlloc(Util.VEC3_TEMP, Util.VEC3_TEMP)
  Util.VEC3_TEMP:SetNormalize():Mul(magnitude)
  local offset_x1, offset_y1, offset_z1 = Util.VEC3_TEMP:Get()
  Util.VEC3_TEMP:Set(param[4], param[5], param[6])
  magnitude = Util.VEC3_TEMP:Magnitude()
  Util.VEC3_TEMP:SetNormalize()
  Util.QuatTemp:MulVec3_NoneAlloc(Util.VEC3_TEMP, Util.VEC3_TEMP)
  Util.VEC3_TEMP:SetNormalize():Mul(magnitude)
  local offset_x2, offset_y2, offset_z2 = Util.VEC3_TEMP:Get()
  Util.VEC3_TEMP:Set(param[7], param[8], param[9])
  magnitude = Util.VEC3_TEMP:Magnitude()
  Util.VEC3_TEMP:SetNormalize()
  Util.QuatTemp:MulVec3_NoneAlloc(Util.VEC3_TEMP, Util.VEC3_TEMP)
  Util.VEC3_TEMP:SetNormalize():Mul(magnitude)
  local offset_x3, offset_y3, offset_z3 = Util.VEC3_TEMP:Get()
  return offset_x1, offset_y1, offset_z1, offset_x2, offset_y2, offset_z2, offset_x3, offset_y3, offset_z3
end

local mathx = require("base.mathx")
local Vec3 = require("base.vec3")
local Quat = require("base.quat")
local _drop_curvey = mathx.item_drop_curvey
local _lerp = mathx.lerp_number
local _distance = mathx.distance
local _distance2 = mathx.distance2
local _distance3 = mathx.dist_vec3A
local _min = math.min
local AREA_TYPE = require("cs_share.scene_define").AREA_TYPE
local EQUIP_CUBE_SCALE = 0.35
local TYPE_EFFECT_STATUS = TypeEffectStatus
local START_SCALE = 0.5 * EQUIP_CUBE_SCALE
local DROP_R = 3
local STATUS = {
  CREATED = 1,
  BURSTING = 2,
  BURSETED = 3
}
local RANDOM_DIS = {
  [1] = -1,
  [2] = 0,
  [3] = 1,
  [4] = -1.25,
  [5] = -0.75,
  [6] = 1.25,
  [7] = 0.75
}
local SCENE_ITEM_DROP_TYPE = Config.SCENE_ITEM_DROP_TYPE
local AUTO_GET_DIST = 4
local AUTO_GET_MAX_TIME = 5
local ITEM_STATE = require("manager.scene.scene_item_mgr").ITEM_STATE

function M:_init(px, py, pz, room_id, item_data_list, not_show, param)
  self.room_id = room_id
  self.room_center = nil
  self.v_award_type = SCENE_ITEM_DROP_TYPE.BATTLE
  if param then
    self.v_effect_name = param.effect_name
    self.v_award_type = param.award_type
    self.breakable_id = param.breakable_id
  end
  self.v_obj = ResPoolMgr:get_world_model(self.v_effect_name or FX_AWARD_POINT)
  self.v_obj_transform = self.v_obj.transform
  self.v_obj_transform.localRotation = Quat.Euler(0, 0, 0)
  if not py then
    local ret
    ret, py = Util.raycast_by_role(Global.hero, px, pz)
    if not ret then
      py = Global.hero:get_pos_height()
    end
  end
  self.v_obj_transform:SetPositionA(px, py, pz)
  self.px = px
  self.py = py
  self.pz = pz
  self.burst_y = py
  self.item_data_list = item_data_list
  self.status = STATUS.CREATED
  self.can_update = true
  Util.bind_msg(self, Const.MSG_ON_OPEN_DROP_UI, self.on_open_drop_ui, self)
  Util.bind_msg(self, Const.MSG_ON_CLOSE_DROP_UI, self.on_close_drop_ui, self)
  Util.bind_msg(self, Const.MSG_ON_REMOVE_DROP_ITEM, self.response_remove_drop_item, self)
  self.v_pick_distance = ShareRes.get_comm_value("PickDistance")
  CSFollower.FollowOnce(self.v_obj.gameObject)
  if not_show then
    self.v_obj_transform:SetActive(false)
  else
    self.v_obj:SetActive(true)
  end
  if Global.sound_mgr then
    Global.sound_mgr:play_award_drop_init_sound(self.v_obj_transform)
  end
end

function M:on_open_drop_ui()
  local ui = UIMgr:try_get_visible_ui("ui_battle_item")
  if ui then
    ui:ui_hide()
  end
end

function M:on_close_drop_ui()
  local ui = UIMgr:get_ui("ui_battle_item")
  if self.showing_item then
    ui:ui_show(self.showing_item)
  end
end

function M:not_all_item_picked()
  for _, item_data in pairs(self.item_data_list) do
    if item_data.state ~= ITEM_STATE.END then
      return true
    end
  end
  return false
end

function M:on_enter_room(room_id)
  self.can_update = room_id == self.room_id
  if self.status == STATUS.BURSETED then
    for _, data in pairs(self.item_data_list) do
      for index, item_obj in ipairs(data.item_obj_list) do
        if not item_obj.gameObject:IsNull() and data.state ~= ITEM_STATE.END then
          item_obj.gameObject:SetActive(self.can_update)
        end
      end
    end
  elseif self.v_obj and not self.v_obj:IsNull() then
    self.v_obj:SetActive(self.can_update)
  end
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

local BUEST_TIME = 1

function M:_calc_move_dir(x, z, tx, tz)
  return (tx - x) / BUEST_TIME, (tz - z) / BUEST_TIME
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

function M:_get_closet_no_collider_pos_from_hero(x, y, z, dis_x, dis_z)
  local drop_pos = Vec3.New(x + dis_x, y, z + dis_z)
  local hero_pos = Global.hero:get_pos_vec3()
  local dir_tb = {
    Vec3.right,
    Vec3.left,
    Vec3.forward,
    Vec3.back
  }
  local min_dist = 999999
  local dist_tb = {1, 3}
  local ret_pos = drop_pos
  for _, dis in ipairs(dist_tb) do
    for _, dir in ipairs(dir_tb) do
      local is_hit, hit_pos = Util.raycast2_block_vec3(drop_pos + dir * dis, -dir, dis)
      if is_hit then
        local dist = Vec3.Distance(hit_pos, hero_pos)
        if min_dist > dist then
          min_dist = dist
          ret_pos = hit_pos
        end
      end
    end
  end
  return ret_pos
end

function M:get_random_point_list(count, drop_point_list)
  local suc_count = 0
  local list_len = #drop_point_list
  if count <= 0 or list_len <= 0 then
    return
  end
  local temp = {}
  while count ~= suc_count and list_len > 0 do
    local i = math.random(1, list_len)
    table.insert(temp, drop_point_list[i])
    table.remove(drop_point_list, i)
    list_len = list_len - 1
    suc_count = suc_count + 1
  end
  return temp
end

function M:burst(drop_point_list)
  if self.status ~= STATUS.CREATED then
    return
  end
  local px, py, pz = self.px, self.py, self.pz
  local scene_logic = SceneMgr:get_scene_logic()
  local use_original_pos, random_point_list
  if drop_point_list then
    if 1 == #drop_point_list and 0 == tonumber(drop_point_list[1]) then
      use_original_pos = true
    else
      random_point_list = self:get_random_point_list(UtilTable.hash_lenth(self.item_data_list), drop_point_list)
    end
  end
  local have_drop_key, pos_x, pos_y, pos_z
  local target_pos = Util.VEC3_TEMP
  local pos_index = 0
  for i, data in pairs(self.item_data_list) do
    have_drop_key = false
    local item_obj_list = data.item_obj_list
    if random_point_list and random_point_list[i] then
      pos_x, pos_y, pos_z = scene_logic:get_pos_key_position(random_point_list[i])
      have_drop_key = true
      data.droped_px, data.droped_py, data.droped_pz = pos_x, pos_y, pos_z
    end
    if not data.droped_px then
      data.droped_px, data.droped_py, data.droped_pz = px, py, pz
    end
    data.state = ITEM_STATE.DROPING
    data.drop_t = 0
    data.move_state = 1
    data.use_offset = not use_original_pos and not have_drop_key
    local dir_list, index_list = get_random_dir_and_index(#item_obj_list)
    local param_table = ShareRes.get_comm_string_value("RandomDropSplineParam")
    local offset_x1, offset_y1, offset_z1, offset_x2, offset_y2, offset_z2, offset_x3, offset_y3, offset_z3
    for index, item_obj in ipairs(item_obj_list) do
      local trans = item_obj.transform
      trans:SetLocalScaleA(START_SCALE, START_SCALE, START_SCALE)
      trans:SetPositionA(px, self.burst_y, pz)
      if data.use_offset then
        if not data.obj_info then
          data.obj_info = {}
        end
        if not data.obj_info[index] then
          data.obj_info[index] = {}
        end
        local obj_info = data.obj_info[index]
        pos_index = pos_index + 1
        local param = param_table[index_list[index]]
        offset_x1, offset_y1, offset_z1, offset_x2, offset_y2, offset_z2, offset_x3, offset_y3, offset_z3 = get_rota_offset(param, dir_list[index])
        target_pos:Set(data.droped_px + offset_x3, data.droped_py, data.droped_pz + offset_z3)
        local _, result_pos = SceneMgr:get_nearest_walkable_pos(Global.hero:get_pos_vec3(), target_pos, 0.2)
        obj_info.sx = px + offset_x1
        obj_info.sy = py + offset_y1
        obj_info.sz = pz + offset_z1
        obj_info.cx = px + offset_x2
        obj_info.cy = py + offset_y2
        obj_info.cz = pz + offset_z2
        obj_info.ex = result_pos.x
        obj_info.ey = data.droped_py + offset_y3
        obj_info.ez = result_pos.z
      end
      local CSgo = item_obj.gameObject
      CSFollower.Follow(CSgo)
    end
  end
  self.status = STATUS.BURSTING
  if self.v_effect_name == FX_AWARD_POINT then
    self.v_obj:GetComponent(TYPE_EFFECT_STATUS):PlayEndEffect()
  end
  self:clear_timer()
  self.v_burset_timer = Timer:add_timer("FX_BURST", 3, function()
    if self.v_obj and not self.v_obj:IsNull() then
      ResPoolMgr:release(self.v_obj)
    end
  end)
  if Global.sound_mgr then
    Global.sound_mgr:play_award_drop_touch_sound()
  end
  if not next(self.item_data_list) then
    local scene_item_mgr = SceneMgr:get_scene_item_mgr()
    scene_item_mgr:on_item_obj_all_fly_end()
  end
end

function M:update()
  if not self.v_obj then
    return
  end
  if not self.can_update then
    return
  end
  if self.status == STATUS.CREATED then
    local px, _, pz = self.v_obj_transform:GetPositionA()
    local hero = Global.hero
    local pos = hero:get_pos_vec3()
    if _distance(pos.x, pos.y, pos.z, px, self.py, pz) < 1 then
      if ChallengeRingPlusMgr:check_drop_func() then
        return
      else
        self:burst()
      end
    end
  elseif self.status == STATUS.BURSTING then
    local dt = GlobalTimeMgr:get_dt_time()
    for _, data in pairs(self.item_data_list) do
      if data.state == ITEM_STATE.DROPING then
        if data.use_offset and data.obj_info then
          self:on_item_rebound_droping(data, dt)
        else
          self:on_item_normal_droping(data, dt)
        end
      end
    end
  elseif self.status == STATUS.BURSETED and not Util.get_auto_pick() then
    local px, py, pz = Global.hero:get_pos()
    local min_dist = AUTO_GET_DIST
    local min_dist_data
    local scaled_time = GlobalTimeMgr:get_time()
    for _, data in pairs(self.item_data_list) do
      if data.state == ITEM_STATE.DROPED then
        for index, item_obj in ipairs(data.item_obj_list) do
          local item_trans = item_obj.transform
          if item_trans then
            local x, y, z = item_trans:GetPositionA()
            local dist = _distance3(x, y, z, px, py, pz)
            if data.state == ITEM_STATE.DROPED and (min_dist > dist or data.is_auto_pick_item and data.burseted_time - scaled_time <= 0) then
              min_dist = dist
              min_dist_data = data
            end
          end
        end
      end
    end
    self:change_showing_item(min_dist_data)
  end
end

function M:on_item_rebound_droping(data, dt)
  local is_drop_end = false
  data.drop_t = data.drop_t + dt
  if data.drop_t > BUEST_TIME then
    data.drop_t = 0
    is_drop_end = true
    self:on_item_drop_end(data)
  end
  local p = data.drop_t / BUEST_TIME
  for index, item_obj in ipairs(data.item_obj_list) do
    local obj_info = data.obj_info[index]
    if is_drop_end then
      local scene_item_mgr = SceneMgr:get_scene_item_mgr()
      scene_item_mgr:set_default_effect_show(data, index)
    else
      local x, y, z = self:get_obj_target_pos(obj_info, p)
      self:update_obj_pos(item_obj, x, y, z, p)
    end
  end
end

function M:on_item_normal_droping(data, dt)
  local is_drop_end = false
  data.drop_t = data.drop_t + dt
  if data.drop_t > BUEST_TIME then
    data.drop_t = BUEST_TIME
    self:on_item_drop_end(data)
    is_drop_end = true
  else
    local p = data.drop_t / BUEST_TIME
    for index, item_obj in ipairs(data.item_obj_list) do
      local sx, sy, sz = self.px, self.burst_y, self.pz
      local ex, ey, ez = data.droped_px, data.droped_py, data.droped_pz
      local x, y, z = _drop_curvey(sx, sy, sz, ex, ey, ez, p)
      self:update_obj_pos(item_obj, x, y, z, p)
    end
  end
  return is_drop_end
end

function M:update_obj_pos(item_obj, x, y, z, p)
  local trans = item_obj.transform
  trans:SetPositionA(x, y, z)
  local cur_scale = _lerp(START_SCALE, 1, p) * EQUIP_CUBE_SCALE
  trans:SetLocalScaleA(cur_scale, cur_scale, cur_scale)
end

function M:on_item_drop_end(data)
  if data then
    self:set_item_drop_end(data)
  end
  local scene_item_mgr = SceneMgr:get_scene_item_mgr()
  self.status = STATUS.BURSETED
  if self.v_award_type == SCENE_ITEM_DROP_TYPE.BREAKABLE then
    scene_item_mgr:breakable_item_fly_to_hero(self.breakable_id)
  end
  if Util.get_auto_pick() then
    scene_item_mgr:fly_to_hero_animation()
  end
  if Global.sound_mgr then
    Global.sound_mgr:play_award_show_sound()
  end
  if not next(self.item_data_list) then
    scene_item_mgr:on_item_obj_all_fly_end()
  end
end

function M:set_item_drop_end(data)
  for index, item_obj in ipairs(data.item_obj_list) do
    local obj_info = data.obj_info[index]
    local ex, ey, ez
    if obj_info and data.use_offset then
      ex, ey, ez = obj_info.ex, obj_info.ey, obj_info.ez
    else
      ex, ey, ez = data.droped_px, data.droped_py, data.droped_pz
    end
    local trans = item_obj.transform
    trans:SetPositionA(ex, ey, ez)
    trans:SetLocalScaleA(EQUIP_CUBE_SCALE, EQUIP_CUBE_SCALE, EQUIP_CUBE_SCALE)
  end
  self.v_obj:SetActive(false)
  data.state = ITEM_STATE.DROPED
  data.burseted_time = GlobalTimeMgr:get_time() + AUTO_GET_MAX_TIME
  local msg = MsgGame:mq_publish2(Const.MSG_ITEM_DROPED)
  msg.mm_obj = data
  msg.mm_x = self.room_id
end

function M:get_obj_target_pos(obj_info, p)
  local sx, sy, sz = obj_info.sx, obj_info.sy, obj_info.sz
  local cx, cy, cz = obj_info.cx, obj_info.cy, obj_info.cz
  local ex, ey, ez = obj_info.ex, obj_info.ey, obj_info.ez
  local x, y, z = mathx.bezier_3d_2o(sx, sy, sz, cx, cy, cz, ex, ey, ez, p)
  return x, y, z
end

function M:change_showing_item(min_dist_data)
  if self.showing_item == min_dist_data then
    return
  end
  self.showing_item = min_dist_data
  local msg = MsgGame:mq_publish2(Const.MSG_TOG_SPECIAL_AREA)
  msg.mm_x = AREA_TYPE.near_item
  msg.mm_y = nil ~= min_dist_data
  msg.mm_obj = min_dist_data
end

function M:on_destroy()
  Util.unbind_all_msg(self)
  self:clear_timer()
  if self.v_obj and not self.v_obj:IsNull() then
    ResPoolMgr:release(self.v_obj)
  end
  self.v_obj = nil
  self.v_effect_name = nil
end

function M:clear_timer()
  if self.v_burset_timer then
    Timer:remove_timer(self.v_burset_timer)
    self.v_burset_timer = nil
  end
end

function M:remove_item(remove_uuid)
  for idx, data in pairs(self.item_data_list) do
    local drop_uuid = data.drop_uuid
    if remove_uuid == drop_uuid then
      self.item_data_list[idx] = nil
      break
    end
  end
end

function M:response_remove_drop_item(msg)
  if nil == msg then
    return
  end
  local drop_uuid = msg.mm_x
  self:remove_item(drop_uuid)
end

return M
