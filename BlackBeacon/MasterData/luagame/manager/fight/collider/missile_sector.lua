local Base = require("manager.fight.collider.collider")
local vec3 = require("base.vec3")
local Debug = UnityEngine.Debug
local Color = UnityEngine.Color
local M = Util.create_child_mt(Base)
local CHECK_STEP = 5
local _deg2rad = math.rad(1)
local _sin = math.sin
local _cos = math.cos

function M:_init(char, missile_cid, radius, height, deg)
  Base._init(self, char)
  self.v_radius = radius
  self.v_half_deg = deg / 2
  self.v_height = height
  self.v_missile_cid = missile_cid
  self.v_now_frame = 0
  self.v_check_vec = vec3.New()
  self.v_self_cur_heigh_pos = vec3.New()
  self.v_hit_temp = {
    content = CompExtensions.GetRaycastHitArray(10),
    size = 0
  }
  self.v_hit_cache = {}
end

function M:_add_to_cache()
  local hit_infos = self.v_hit_temp.content
  local inst_id
  for i = 0, self.v_hit_temp.size - 1 do
    inst_id = hit_infos[i].collider.gameObject:GetInstanceID()
    if not self.v_hit_cache[inst_id] then
      self.v_hit_cache[inst_id] = self.v_now_frame
    end
  end
end

function M:check_collider()
  if self.v_char:is_destroy() then
    return
  end
  UtilTable.clear_map(self.v_hit_cache)
  local dir
  self.v_now_frame = self.v_now_frame + 1
  local self_cur_pos = self.v_char:get_pos_vec3()
  self.v_self_cur_heigh_pos.x = self_cur_pos.x
  self.v_self_cur_heigh_pos.y = self_cur_pos.y + self.v_height
  self.v_self_cur_heigh_pos.z = self_cur_pos.z
  for diff = -self.v_half_deg, self.v_half_deg, CHECK_STEP do
    dir = self.v_char:get_dir() + diff
    self.v_check_vec.x = _sin(_deg2rad * dir)
    self.v_check_vec.z = _cos(_deg2rad * dir)
    self.v_hit_temp.size = UnityPhysics.RaycastNonAlloc(self_cur_pos, self.v_check_vec, self.v_hit_temp.content, self.v_radius)
    self:_add_to_cache()
    self.v_hit_temp.size = UnityPhysics.RaycastNonAlloc(self.v_self_cur_heigh_pos, self.v_check_vec, self.v_hit_temp.content, self.v_radius)
    self:_add_to_cache()
  end
  for cid, enter_frame in pairs(self.v_hit_cache) do
    if enter_frame == self.v_now_frame then
      SceneMgr:on_collide(self.v_missile_cid, cid)
    end
  end
  local all_char = SceneMgr:get_all_char()
  for _, char in pairs(all_char) do
    if char.collider and char.collider:check_point(0, self_cur_pos.x, self_cur_pos.z) and char ~= self.v_char then
      SceneMgr:on_collide(self.v_missile_cid, char.cid)
    end
  end
end

function M:is_missile_sector()
  return true
end

return M
