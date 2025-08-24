local M = Global.util.create_class()

function M:load_default_res()
  self.v_pure_box_collider_obj = self:load_res(Path.get_res_path("PureBoxCollider"), UnityGameObject)
  self.v_box_collider_obj = self:load_res(Path.get_res_path("BoxCollider"), UnityGameObject)
  self.v_capsule_collider_obj = self:load_res(Path.get_res_path("CapsuleCollider"), UnityGameObject)
  self.v_sphere_collider_obj = self:load_res(Path.get_res_path("SphereCollider"), UnityGameObject)
  self.v_box_collider_obj2 = self:load_res(Path.get_res_path("BoxCollider_2"), UnityGameObject)
  self.v_capsule_collider_obj2 = self:load_res(Path.get_res_path("CapsuleCollider_2"), UnityGameObject)
  self.v_sphere_collider_obj2 = self:load_res(Path.get_res_path("SphereCollider_2"), UnityGameObject)
  self.v_skill_area = self:load_res(Path.get_res_path("SkillArea"), UnityGameObject)
  self.v_sector_collider_obj_map = {}
  self.v_sector_collider_obj_map2 = {}
  for _, degree in ipairs(Config.SECTOR_COLLIDER_DEGREE) do
    local path = string.format("SectorCollider%d", degree)
    self.v_sector_collider_obj_map[degree] = self:load_res(Path.get_res_path(path), UnityGameObject)
    path = string.format("SectorCollider%d_2", degree)
    self.v_sector_collider_obj_map2[degree] = self:load_res(Path.get_res_path(path), UnityGameObject)
  end
end

function M:create_pure_box_collider_obj(name, need_multi_collide, dont_destroy)
  local obj = self.v_pure_box_collider_obj
  local gameobj = self:raw_instantiate(obj, dont_destroy)
  if UNITY_EDITOR and name then
    gameobj.name = name
  end
  return gameobj
end

function M:create_box_collider_obj(name, need_multi_collide, dont_destroy)
  local obj = need_multi_collide and self.v_box_collider_obj2 or self.v_box_collider_obj
  local gameobj = self:raw_instantiate(obj, dont_destroy)
  if UNITY_EDITOR and name then
    if need_multi_collide then
      name = name .. "2"
    end
    gameobj.name = name
  end
  return gameobj
end

function M:create_sphere_collider_obj(name, need_multi_collide, dont_destroy)
  local obj = need_multi_collide and self.v_sphere_collider_obj2 or self.v_sphere_collider_obj
  local gameobj = self:raw_instantiate(obj, dont_destroy)
  if UNITY_EDITOR and name then
    if need_multi_collide then
      name = name .. "2"
    end
    gameobj.name = name
  end
  return gameobj
end

function M:create_capsule_collider_obj(name, need_multi_collide, dont_destroy)
  local obj = need_multi_collide and self.v_capsule_collider_obj2 or self.v_capsule_collider_obj
  local gameobj = self:raw_instantiate(obj, dont_destroy)
  if UNITY_EDITOR and name then
    if need_multi_collide then
      name = name .. "2"
    end
    gameobj.name = name
  end
  return gameobj
end

function M:creates_sector_collider_obj(name, need_multi_collide, dont_destroy, degree)
  local map = need_multi_collide and self.v_sector_collider_obj_map2 or self.v_sector_collider_obj_map
  local res = map[degree]
  Util.assert(res, "sector_collider res is nil. degree is: ", degree)
  local gameobj = self:raw_instantiate(res, dont_destroy)
  if UNITY_EDITOR and name then
    gameobj.name = name .. degree
  end
  return gameobj
end

function M:create_item_obj(dont_destroy)
  return self:raw_instantiate(self.v_item_obj, dont_destroy)
end

function M:create_skill_area_obj()
  local gameobj = self:raw_instantiate(self.v_skill_area, false)
  return gameobj
end

function M:create_emptygameobj(name, dont_destroy)
  local gameobj = UnityGameObject()
  if dont_destroy then
    self:dont_destroy_on_load(gameobj)
  end
  if name then
    gameobj.name = name
  end
  return Util.wrap_gameobj(gameobj)
end

function M:instantiate(obj, ...)
  return self:raw_instantiate(obj.gameObject, ...)
end

return M
