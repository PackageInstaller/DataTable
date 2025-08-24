local Base = require("manager.fight.movement.missile_movement")
local Vec3 = require("base.vec3")
local _tinsert = table.insert
local _tremove = table.remove
local CSResLoader = CS.ResLoader
local M = Util.create_child_mt(Base)

function M:_init(missile, lineparams)
  Base._init(self, missile)
  self.v_target = self.v_missile:get_target()
  self.missile_cfg = self.v_missile.missile_cfg
  local line_param = lineparams or self.missile_cfg.lineparams
  self:set_params(line_param)
  self.v_cur_jump_num = 0
  self.v_cur_delay = 0
  self.v_cur_index = nil
  self.v_start_pos = Vec3.New()
  self:search_monster()
  self:start_jump()
end

function M:set_params(params)
  self.v_pos_transfrom = self.v_char:get_setting_point(params[1])
  self.v_attach_point_name = params[1]
  self.v_search_range = tonumber(params[2])
  self.v_max_jump_num = tonumber(params[3])
  self.v_npc_max_jump_num = tonumber(params[4])
  self.v_jump_delay = tonumber(params[5])
  self.v_connect_effect_name = params[6]
end

function M:search_monster()
  self.v_target_map = {}
  if not self.v_target then
    return
  end
  local cur_pos = self.v_target:get_pos_vec3()
  local npc_map = SceneMgr:get_all_npc()
  for _, npc in pairs(npc_map) do
    if not npc or npc:is_destroy() or not self:check_npc_search(npc) then
    else
      local pos = npc:get_pos_vec3()
      local distance = Vec3.Distance(cur_pos, pos)
      if distance <= self.v_search_range then
        local data = {
          dis = distance,
          jump_num = 0,
          npc = npc
        }
        if npc == self.v_target then
          _tinsert(self.v_target_map, 1, data)
        else
          _tinsert(self.v_target_map, data)
        end
      end
    end
  end
end

function M:check_npc_search(npc)
  if not npc:is_can_searched() then
    return false
  end
  if npc.magic_mgr:check_magic(399930) then
    return false
  end
  return true
end

function M:start_jump()
  if self.v_cur_jump_num >= self.v_max_jump_num then
    self:stop_missile()
    return
  end
  local cur_index = self.v_cur_index and self.v_cur_index + 1 or 2
  self.v_cur_index = cur_index
  local data = self.v_target_map[cur_index]
  if not data then
    self:check_last_index()
    return
  end
  if not self:check_npc_jump(data) then
    self:start_jump()
    return
  end
  self:remove_effect()
  self.v_out_dist_time = 0
  self.v_cur_jump_num = self.v_cur_jump_num + 1
  self.v_cur_delay = self.v_jump_delay
  self.v_cur_target = data.npc
  self.v_target_trans = self.v_cur_target:get_setting_point(self.v_attach_point_name)
  if not self.v_end_pos then
    local trans = self.v_target:get_setting_point(self.v_attach_point_name)
    if not trans then
      local cfg = self.v_target:get_character_cfg() or {}
      Log.Error(self.missile_cfg.Id, "【闪电链】can not found attach_point：", self.v_attach_point_name, ",in Model:", cfg.ModelId)
    end
    local x, y, z = trans:SetPositionA()
    self.v_start_pos.x = x
    self.v_start_pos.y = y
    self.v_start_pos.z = z
  else
    self.v_start_pos.x = self.v_end_pos.x
    self.v_start_pos.y = self.v_end_pos.y
    self.v_start_pos.z = self.v_end_pos.z
  end
end

function M:check_last_index()
  for i = #self.v_target_map, 1, -1 do
    local data = self.v_target_map[i]
    local target = data.npc
    if data.jump_num >= self.v_npc_max_jump_num or target:is_die() then
      _tremove(self.v_target_map, i)
    end
  end
  if #self.v_target_map <= 0 then
    self:stop_missile()
    return
  end
  self.v_cur_index = 0
  self:start_jump()
end

function M:check_npc_jump(data)
  local npc = data.npc
  local jump_num = data.jump_num
  if npc:is_destroy() then
    return
  end
  if jump_num >= self.v_npc_max_jump_num then
    return
  end
  data.jump_num = data.jump_num + 1
  return true
end

function M:update()
  if not self.v_missile or self.v_missile:is_die() then
    self:remove_effect()
    return
  end
  if self.v_cur_delay <= 0 then
    return
  end
  if not self.v_cur_target or self.v_cur_target:is_die() then
    self:remove_effect()
    self.v_cur_delay = 0
    self:start_jump()
    return
  end
  if not self.v_target_trans or self.v_target_trans:IsNull() then
    return
  end
  local x, y, z = self.v_start_pos.x, self.v_start_pos.y, self.v_start_pos.z
  local tx, ty, tz = self.v_target_trans:GetPositionA()
  local px, py, pz = (x + tx) / 2, (y + ty) / 2, (z + tz) / 2
  if not self.v_end_pos then
    self.v_end_pos = Vec3.New()
  end
  self.v_end_pos.x = tx
  self.v_end_pos.y = ty
  self.v_end_pos.z = tz
  if not self.v_effect then
    self:create_effect()
  end
  if self.v_effect then
    local distance = Vec3.Distance(self.v_start_pos, self.v_end_pos)
    local trans = self.v_missile.transform
    trans:SetPositionA(tx, ty, tz)
    self.v_effect.transform:SetPositionA(px, py, pz)
    self.v_effect.transform:LookAtA(tx, ty, tz)
    self.v_effect.transform:SetLocalScaleA(1, 1, distance + 1)
  end
  local time_mgr = self.v_missile.time_mgr
  local dt = time_mgr and time_mgr:get_dt_time() or self.v_char:get_missile_dt()
  self.v_cur_delay = self.v_cur_delay - dt
  if self.v_cur_delay <= 0 then
    self:start_jump()
  end
  if self.v_ground_destroy_height and self.v_terrain_height then
    self:check_ground_destroy()
  end
end

function M:stop_missile()
  SceneMgr:remove_missile(self.v_missile)
  self:remove_effect()
end

function M:create_effect()
  ResPoolMgr:get_spell_effect_async(self.v_connect_effect_name, self.v_char, function(go, _, need_restart)
    self.v_effect = go
    if not self.v_missile or self.v_missile:is_die() then
      self:remove_effect()
    else
      go:SetActive(true)
      go:ResetAttr()
    end
  end)
end

function M:remove_effect()
  if not self.v_effect or self.v_effect:IsNull() then
    return
  end
  ResPoolMgr:release(self.v_effect)
  self.v_effect = nil
end

return M
