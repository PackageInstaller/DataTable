local ResMgr = Global.res_mgr
local Timer = Global.timer
local Util = require("utils.util")
local ResourcePool = require("manager.res.resource_pool")
local SimpleResourcePool = require("manager.res.simple_resource_pool")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local SpellResFifo = require("manager.res.spell_res_fifo")
local Lru = require("manager.res.res_lru_new")
local UnityMaterial = UnityEngine.Material
local TypeUnityAnimatorOverrideController = typeof(UnityEngine.AnimatorOverrideController)
local UnityAnimationClip = UnityEngine.AnimationClip
local UnityResourceFind = UnityEngine.Resources.FindObjectsOfTypeAll
local TypeEffectStage = _ENV.TypeEffectStage
local MAX_LOADING_EFFECT_COUNT = 20
local _insert, _remove = table.insert, table.remove
local LuaResPoolClass = Util.create_class()

function LuaResPoolClass:_init(res, session)
  self.res = res
  self.session = session
end

function LuaResPoolClass:_on_destroy()
  self.res = nil
  self.session = nil
end

local M = Util.create_class()
local OBJ_CALLBACK = {}
local MAIN_SCENE_CHECK_TIMER = 10
local BATTLE_CHECK_TIMER = 300
local EffectStatus = CSEffectStatus
local EMPTY_OBJECT_PATH = "empty_object"
local BOX_COLLIDER_PATH = "box_collider"
local CAPSURE_COLLIDER_PATH = "capsule_collider"
local SECTOR_COLLIDER_PATH = "sector_collider"
local EQUIP_ITEM_OBJECT = "equip_item_obj"
local LUA_OBJ_POOL_NAME = "RESOURCE_POOL_KEY"
local MAX_FREE_LUA_OBJ_COUNT = 20
local MAX_VISIBLE_SCENE_EFFECT = 15
local POOL_TYPE = {
  model = "MODEL",
  effect_model = "EFFECT_MODEL",
  material = "MATERIAL",
  animator = "ANIMATOR",
  player_skill_effect = "PLAYER_SKILL_EFFECT",
  weapon = "WEAPON",
  weapon_no_char = "WEAPON_NO_CHAR",
  attach_model = "ATTACH_MODEL",
  empty = "EMPTY",
  pure_box_collider = "PURE_BOX_COLLIDER",
  empty_box_collider = "EMPTY_BOX_COLLIDER",
  empty_capsule_collider = "EMPTY_CAPSURE_COLLIDER",
  empty_sector_collider = "EMPTY_SECTOR_COLLIDER",
  empty_sphere_collider = "EMPTY_SPHERE_COLLIDER",
  empty_box_collider2 = "EMPTY_BOX_COLLIDER2",
  empty_capsule_collider2 = "EMPTY_CAPSURE_COLLIDER2",
  empty_sector_collider2 = "EMPTY_SECTOR_COLLIDER2",
  empty_sphere_collider2 = "EMPTY_SPHERE_COLLIDER2",
  equip_item_obj = "EQUIP_ITEM_OBJ",
  ui_effect = "UI_EFFECT",
  world_model = "WORLD_MODEL",
  ui_font = "UI_FONT",
  monster_shadow = "MONSTER_SHADOW",
  sound = "SOUND_RES",
  ui_res = "UI_RES",
  spine = "SPINE_RES",
  navigator_effect = "NAVIGATOR_EFFECT",
  npc_reload_pool = "PRELOAD_NPC",
  timeline = "TIMELINE"
}
local IGNORE_CLEAR_POOL = {
  [POOL_TYPE.player_skill_effect] = true,
  [POOL_TYPE.model] = true,
  [POOL_TYPE.navigator_effect] = true
}
M.POOL_TYPE = POOL_TYPE

function M:_init()
  self.v_pools = {}
  self.v_effect_pools = {}
  self:_clear_tbl()
  self.v_used_gameobj_pools = {}
  self.v_last_release_times = {}
  self.v_used_gameobjs = {}
  self.v_session = 0
  self.v_root = ResMgr:create_emptygameobj("ResourcePool", true)
  self.v_effect_status = {}
  self.v_effect_lengths = {}
  self.v_effect_stage_data = {}
  self.v_obj_binds = {}
  self.v_inverse_obj_binds = {}
  self.v_fog_disables = {}
  self.v_free_objs = {}
  self.v_loading_spell_effects = {}
  self.v_preload_gameobj_root = ResMgr:create_emptygameobj("PRELOAD", true, true)
  self.v_preload_gameobj_root.transform:SetParent(self.v_root.transform, true)
  self.v_loading_effect_count = 0
  self.v_spell_res_fifo_first = SpellResFifo:new()
  self.v_res_obj_lua_pool = LuaObjPoolMgr.register(LUA_OBJ_POOL_NAME, MAX_FREE_LUA_OBJ_COUNT, LuaResPoolClass)
  self.v_preload_gameobjs_lru = Lru:new(300, 600)
  self:create_pool(POOL_TYPE.player_skill_effect, 300, 500, true)
  self:create_pool(POOL_TYPE.model, 15, 30)
  local effect_model_pool = self:create_pool(POOL_TYPE.effect_model, 10, 15)
  effect_model_pool:set_release_obj_callback(function(obj)
    Global.effect_model_mgr:on_release_obj(obj)
  end)
  self:create_pool(POOL_TYPE.empty, 50, 50)
  self:create_simple_pool(POOL_TYPE.empty_box_collider, 50)
  self:create_simple_pool(POOL_TYPE.empty_capsule_collider, 50)
  self:create_pool(POOL_TYPE.empty_sector_collider, 50, 50)
  self:create_simple_pool(POOL_TYPE.empty_sphere_collider, 50, 50)
  self:create_simple_pool(POOL_TYPE.pure_box_collider, 50)
  self:create_simple_pool(POOL_TYPE.empty_box_collider2, 50)
  self:create_simple_pool(POOL_TYPE.empty_capsule_collider2, 50)
  self:create_pool(POOL_TYPE.empty_sector_collider2, 50, 50)
  self:create_simple_pool(POOL_TYPE.empty_sphere_collider2, 50, 50)
  self:create_pool(POOL_TYPE.equip_item_obj, 50, 50)
  self:create_pool(POOL_TYPE.animator, 5, 30, nil, true, UnityAnimatorOverrideController)
  self:create_pool(POOL_TYPE.weapon, 10, 10)
  self:create_pool(POOL_TYPE.weapon_no_char, 10, 10)
  self:create_pool(POOL_TYPE.ui_effect, 110, 150, true)
  self:create_pool(POOL_TYPE.world_model, 10, 10)
  self:create_pool(POOL_TYPE.timeline, 5, 10)
  self:create_pool(POOL_TYPE.ui_font, 40, 40)
  self:create_pool(POOL_TYPE.monster_shadow, 10, 10)
  self:create_pool(POOL_TYPE.sound, 50, 50, nil, true)
  self:create_pool(POOL_TYPE.spine, 5, 5)
  self:create_pool(POOL_TYPE.ui_res, 50, 50)
  self:create_pool(POOL_TYPE.navigator_effect, 50, 50)
  self.v_last_check_time = 0
end

function M:on_destroy()
  ResMgr:destroy_gameobj(self.v_root)
  self.v_root = nil
end

function M:update()
  self:check_timer()
  if self.v_loading_effect_count >= MAX_LOADING_EFFECT_COUNT then
    return
  end
  local pool, res_name, owner, callback, id = self.v_spell_res_fifo_first:pop()
  while pool do
    local obj = self:_pop_from_free_list(pool, res_name, owner)
    if obj then
      if not pool:is_effect_pool() then
        obj:SetActive(true)
      end
      callback(obj, id, true)
    else
      local path = Path.get_res_path(res_name)
      if Global.debug_res then
        Log.Error("资源未预加载: ", path)
      end
      local session = self:_new_session()
      self.v_loading_effect_count = self.v_loading_effect_count + 1
      self.v_loading_spell_effects[session] = true
      self.v_callbacks[session] = callback
      if Global.memory_debug then
        OBJ_CALLBACK[session] = debug.traceback()
      end
      ResMgr:load_gameobj_async(path, nil, true, self._on_gameobj_load, {
        session,
        pool,
        res_name,
        self,
        id
      })
    end
    pool, res_name, owner, callback, id = self.v_spell_res_fifo_first:pop()
  end
end

function M:create_pool(pool_name, long_keep_count, max_count, is_effect, is_res, res_type)
  local pool = ResourcePool:new(pool_name, long_keep_count, max_count, is_effect, is_res, self.v_root, res_type)
  if is_effect then
    _insert(self.v_effect_pools, pool)
  end
  self.v_pools[pool_name] = pool
  return pool
end

function M:create_simple_pool(pool_name, long_free_count)
  local pool = SimpleResourcePool:new(pool_name, long_free_count, self.v_root)
  self.v_pools[pool_name] = pool
  return pool
end

function M:bind_obj(parent, child)
  local parent_cid = parent:GetInstanceID()
  local child_cid = child:GetInstanceID()
  if not self.v_obj_binds[parent_cid] then
    self.v_obj_binds[parent_cid] = {}
  end
  self.v_obj_binds[parent_cid][child_cid] = child
  self.v_inverse_obj_binds[child_cid] = parent_cid
end

function M:get_obj_from_pool(pool, res_name, callback, args)
  local obj = self:_pop_from_free_list(pool, res_name)
  if obj then
    obj:SetActive(true)
    callback(obj, args, true)
    return
  end
  local session = self:_new_session()
  self.v_callbacks[session] = callback
  if Global.memory_debug then
    OBJ_CALLBACK[session] = debug.traceback()
  end
  local path = Path.get_res_path(res_name)
  ResMgr:load_gameobj_async(path, nil, true, self._on_gameobj_load, {
    session,
    pool,
    res_name,
    self,
    args
  })
end

function M:get_model_async(res_name, callback)
  self:get_obj_from_pool(self.v_pools[POOL_TYPE.model], res_name, callback)
end

function M:get_model(res_name)
  local obj = self:get_gameobj(self.v_pools[POOL_TYPE.model], res_name)
  return obj
end

function M:get_shadow_async(res_name, callback)
  self:get_obj_from_pool(self.v_pools[POOL_TYPE.monster_shadow], res_name, callback)
end

function M:get_animator(res_name)
  local animator_path = Path.get_res_path(res_name)
  local pool = self.v_pools[POOL_TYPE.animator]
  local res = self:get_res(pool, UnityAnimatorOverrideController, animator_path)
  return res
end

function M:get_animator_async(res_name, callback)
  local animator_path = Path.get_res_path(res_name)
  local pool = self.v_pools[POOL_TYPE.animator]
  self:get_res_async(pool, UnityAnimatorOverrideController, animator_path, callback)
end

function M:get_spine_async(res_name, callback)
  local pool_type = POOL_TYPE.spine
  self:get_obj_from_pool(self.v_pools[pool_type], res_name, callback)
end

function M:get_spine(res_name)
  local obj = self:get_gameobj(self.v_pools[POOL_TYPE.spine], res_name)
  return obj
end

function M:get_weapon(res_name)
  local pool_type = POOL_TYPE.weapon
  local obj = self:get_gameobj(self.v_pools[pool_type], res_name)
  return obj
end

function M:get_weapon_async(res_name, callback)
  local pool_type = POOL_TYPE.weapon
  self:get_obj_from_pool(self.v_pools[pool_type], res_name, callback)
end

function M:get_weapon_no_char_async(res_name, callback)
  local pool_type = POOL_TYPE.weapon_no_char
  self:get_obj_from_pool(self.v_pools[pool_type], res_name, callback)
end

function M:_get_spell_res_async(pool, res_name, owner, callback, id)
  self.v_spell_res_fifo_first:push(pool, res_name, owner, callback, id)
  return true
end

function M:get_spell_effect_async(res_name, owner, callback, id)
  if owner and not owner:is_real_finish_init() then
    return
  end
  local pool_type = POOL_TYPE.player_skill_effect
  local pool = self.v_pools[pool_type]
  return self:_get_spell_res_async(pool, res_name, owner, callback, id)
end

function M:get_effect_res(res_name)
  local pool_type = POOL_TYPE.player_skill_effect
  local pool = self.v_pools[pool_type]
  local obj = self:_pop_from_free_list(pool, res_name, nil)
  if obj then
    local cid = obj:GetInstanceID()
    return obj, self.v_effect_lengths[cid], self.v_effect_status[cid], false
  end
  local path = Path.get_res_path(res_name)
  obj = ResMgr:load_gameobj(path, nil, true)
  if not obj then
    return
  end
  if Global.memory_debug then
    OBJ_CALLBACK[obj:GetInstanceID()] = debug.traceback()
  end
  self._on_gameobj_load({
    nil,
    pool,
    res_name,
    self
  }, obj)
  local cid = obj:GetInstanceID()
  return obj, self.v_effect_lengths[cid], self.v_effect_status[cid], true
end

function M:get_effect_data(cid)
  return self.v_effect_lengths[cid], self.v_effect_status[cid], self.v_effect_stage_data[cid]
end

function M:get_ui_effect(res_name)
  local pool = self.v_pools[POOL_TYPE.ui_effect]
  local obj = self:_pop_from_free_list(pool, res_name)
  if obj then
    return obj
  end
  local path = Path.get_res_path(res_name)
  obj = ResMgr:load_gameobj(path, nil, true)
  if Global.memory_debug then
    OBJ_CALLBACK[obj:GetInstanceID()] = debug.traceback()
  end
  self._on_gameobj_load({
    nil,
    pool,
    res_name,
    self
  }, obj)
  return obj
end

function M:get_ui_effect_async(res_name, callback, args)
  local pool_type = POOL_TYPE.ui_effect
  self:get_obj_from_pool(self.v_pools[pool_type], res_name, callback, args)
end

function M:get_world_model_async(res_name, callback)
  local pool_type = POOL_TYPE.world_model
  self:get_obj_from_pool(self.v_pools[pool_type], res_name, callback)
end

function M:get_ui_font_async(res_name, callback)
  local pool_type = POOL_TYPE.ui_font
  self:get_obj_from_pool(self.v_pools[pool_type], res_name, callback)
end

function M:get_ui_font(res_name)
  local pool_type = POOL_TYPE.ui_font
  local pool = self.v_pools[pool_type]
  local obj = self:_pop_from_free_list(pool, res_name)
  if obj then
    obj:SetActive(true)
    return obj
  end
  local path = Path.get_res_path(res_name)
  obj = ResMgr:load_gameobj(path, nil, true)
  if Global.memory_debug then
    OBJ_CALLBACK[obj:GetInstanceID()] = debug.traceback()
  end
  self._on_gameobj_load({
    nil,
    pool,
    res_name,
    self
  }, obj)
  return obj
end

function M:get_navigator_effect_res(res_name, callback)
  local pool_type = POOL_TYPE.navigator_effect
  self:get_obj_from_pool(self.v_pools[pool_type], res_name, callback)
end

function M:get_empty()
  local pool = self.v_pools[POOL_TYPE.empty]
  local obj = self:_pop_from_free_list(pool, EMPTY_OBJECT_PATH)
  if obj then
    obj:SetActive(true)
    return obj
  end
  obj = ResMgr:create_empty_role_obj("empty", true)
  if Global.memory_debug then
    OBJ_CALLBACK[obj:GetInstanceID()] = debug.traceback()
  end
  self._on_gameobj_load({
    nil,
    pool,
    EMPTY_OBJECT_PATH,
    self
  }, obj)
  return obj
end

local function get_collider(self, func, pool_name, need_multi_collide, param, path)
  local pool = self.v_pools[pool_name]
  local obj = self:_pop_from_free_list(pool, path)
  if obj then
    obj:SetActive(true)
    return obj
  end
  obj = func(ResMgr, pool_name, need_multi_collide, true, param)
  if Global.memory_debug then
    OBJ_CALLBACK[obj:GetInstanceID()] = debug.traceback()
  end
  self._on_gameobj_load({
    nil,
    pool,
    path,
    self
  }, obj)
  return obj
end

function M:get_pure_box_collider()
  return get_collider(self, ResMgr.create_pure_box_collider_obj, POOL_TYPE.pure_box_collider)
end

function M:get_box_collider(need_multi_collide)
  local pool_type = need_multi_collide and POOL_TYPE.empty_box_collider2 or POOL_TYPE.empty_box_collider
  return get_collider(self, ResMgr.create_box_collider_obj, pool_type, need_multi_collide)
end

function M:get_capsule_collider(need_multi_collide)
  local pool_type = need_multi_collide and POOL_TYPE.empty_capsule_collider2 or POOL_TYPE.empty_capsule_collider
  return get_collider(self, ResMgr.create_capsule_collider_obj, pool_type, need_multi_collide)
end

function M:get_sector_collider(degree, need_multi_collide)
  local pool_type = need_multi_collide and POOL_TYPE.empty_sector_collider2 or POOL_TYPE.empty_sector_collider
  return get_collider(self, ResMgr.creates_sector_collider_obj, pool_type, need_multi_collide, degree, SECTOR_COLLIDER_PATH .. degree)
end

function M:get_sphere_collider(need_multi_collide)
  local pool_type = need_multi_collide and POOL_TYPE.empty_sphere_collider2 or POOL_TYPE.empty_sphere_collider
  return get_collider(self, ResMgr.create_sphere_collider_obj, pool_type, need_multi_collide)
end

function M:get_drop_item_obj(res_name)
  local pool_type = POOL_TYPE.equip_item_obj
  local pool = self.v_pools[pool_type]
  local obj = self:_pop_from_free_list(pool, res_name)
  if obj then
    obj:SetActive(true)
    return obj
  end
  local path = Path.get_res_path(res_name)
  obj = ResMgr:load_gameobj(path, nil, true)
  if Global.memory_debug then
    OBJ_CALLBACK[obj:GetInstanceID()] = debug.traceback()
  end
  self._on_gameobj_load({
    nil,
    pool,
    res_name,
    self
  }, obj)
  return obj
end

function M:get_res_async(pool, res_type, res_path, callback, cbdata)
  local res = pool:get_from_free_list(res_path)
  local session = self:_new_session()
  local traceback = Global.memory_debug and debug.traceback()
  if res then
    pool:on_used_res(res_path, session, traceback)
    callback(cbdata, self.v_res_obj_lua_pool:new_obj(res, session))
    return
  end
  self.v_callbacks[session] = callback
  local path = Path.get_res_path(res_path)
  ResMgr:load_res_async(path, res_type, self._on_res_loaded, {
    session,
    pool,
    path,
    self,
    cbdata,
    traceback
  })
end

function M:get_res(pool, res_type, res_name)
  local res = pool:get_from_free_list(res_name)
  local session = self:_new_session()
  local traceback = Global.memory_debug and debug.traceback()
  if res then
    pool:on_used_res(res_name, session, traceback)
    return self.v_res_obj_lua_pool:new_obj(res, session)
  end
  local path = Path.get_res_path(res_name)
  res = ResMgr:load_res(path, res_type)
  assert(res, res_name)
  local cid = res:GetInstanceID()
  self.v_used_gameobj_pools[cid] = pool
  self.v_used_gameobjs[cid] = res_name
  self.v_last_release_times[cid] = nil
  pool:on_load_res(path, res, session, traceback)
  return self.v_res_obj_lua_pool:new_obj(res, session)
end

function M:get_gameobj(pool, res_name)
  local obj = self:_pop_from_free_list(pool, res_name)
  if not obj then
    local path = Path.get_res_path(res_name)
    obj = ResMgr:load_gameobj(path, typeof(UnityGameObject), true)
  end
  if Global.memory_debug then
    OBJ_CALLBACK[obj:GetInstanceID()] = debug.traceback()
  end
  self._on_gameobj_load({
    nil,
    pool,
    res_name,
    self
  }, obj)
  obj:SetActive(true)
  return obj
end

function M:release_from_lru(obj)
  if obj:IsNull() then
    return
  end
  local cid = obj:GetInstanceID()
  self:_destroy_obj_helper(cid, obj)
end

function M:release_res(res_info)
  if not res_info then
    return
  end
  local res = res_info.res
  local session = res_info.session
  local cid = res:GetInstanceID()
  local pool = self.v_used_gameobj_pools[cid]
  self.v_res_obj_lua_pool:destroy_obj(res_info)
  if pool then
    pool:on_release_res(self.v_used_gameobjs[cid], session)
  end
end

function M:release(obj, owner_cid)
  if obj:IsNull() then
    return
  end
  local cid = obj:GetInstanceID()
  local pool = self.v_used_gameobj_pools[cid]
  if pool and pool:is_res_pool() then
    assert(nil, "请调用release_res接口释放res相关资源")
    return
  end
  if not pool then
    if UNITY_EDITOR then
      Log.Error("释放一个没有pooled的 " .. obj.name, " ", cid, " ", debug.traceback())
    end
    if not self.v_free_objs[cid] then
      self:_destroy_obj_helper(cid, obj)
    elseif UNITY_EDITOR then
      Log.Error("重复释放资源 " .. obj.name, debug.traceback())
    end
  else
    local path = self.v_used_gameobjs[cid]
    if pool:is_effect_pool() then
      local effect_status = self.v_effect_status[cid]
      if effect_status then
        obj:SetActive(false)
      end
      obj.transform:SetParent(pool.root, false)
    else
      obj:SetActive(false)
      obj.transform:SetParent(pool.root, false)
    end
    pool:release_obj(obj, path)
    self.v_used_gameobj_pools[cid] = nil
    self.v_used_gameobjs[cid] = nil
    self.v_last_release_times[cid] = Global.real_time
    self.v_free_objs[cid] = true
  end
end

local ENTER_ROOM_CLEAR_POOL = {
  [POOL_TYPE.model] = false,
  [POOL_TYPE.timeline] = true,
  [POOL_TYPE.navigator_effect] = true
}

function M:clear_room_pool()
  for pool_type, is_clear in pairs(ENTER_ROOM_CLEAR_POOL) do
    local pool = self.v_pools[pool_type]
    pool:clear()
  end
end

function M:clear_specific_pool(pool_type)
  local pool = self.v_pools[pool_type]
  if pool then
    pool:clear()
  end
end

function M:clear()
  for pool_name, pool in pairs(self.v_pools) do
    pool:clear()
  end
  if SceneMgr:check_main_scene() then
    self:clear_preload_gameobj()
  end
  self.v_loading_effect_count = 0
  self.v_loading_spell_effects = {}
  self.v_spell_res_fifo_first:clear()
end

function M:clear_preload_gameobj()
  self.v_preload_gameobjs_lru:clear()
end

function M:_clear_tbl()
  self.v_used_gameobjs = {}
  self.v_effect_status = {}
  self.v_effect_lengths = {}
  self.v_effect_stage_data = {}
  self.v_callbacks = {}
  self.v_obj_binds = {}
  self.v_inverse_obj_binds = {}
  self.v_fog_disables = {}
  self.v_free_objs = {}
end

function M:check_timer(force)
  local interval = SceneMgr:check_main_scene() and MAIN_SCENE_CHECK_TIMER or BATTLE_CHECK_TIMER
  if force or interval < Global.real_time - self.v_last_check_time then
    self.v_last_check_time = Global.real_time
  else
    return
  end
  for _, pool in pairs(self.v_pools) do
    if not pool:is_simple() then
      pool:iterate_and_reset_lru(force)
    end
  end
  return true
end

function M:recursive_find_memory_tag_obj(obj, tbl)
  local transform = obj.transform
  local child_count = transform.childCount
  for i = 1, child_count do
    local child = transform:GetChild(i - 1)
    local gameobj = child.gameObject
    if not gameobj.activeSelf then
      if gameobj:CompareTag(Config.memory_tag) then
        tbl[gameobj:GetInstanceID()] = true
      else
        self:recursive_find_memory_tag_obj(gameobj, tbl)
      end
    end
  end
end

function M:check_gameobj_memory_leak()
  local dont_destroy_on_load = Global.res_mgr:get_dont_destroy_on_load()
  local tmp_tbl = {}
  local objs = UnityResourceFind(UnityTransform)
  for _, obj in ipairs(objs) do
    local gameobj = obj.gameObject
    if gameobj:CompareTag(Config.memory_tag) then
      tmp_tbl[gameobj:GetInstanceID()] = gameobj
    end
  end
  for cid, obj in pairs(dont_destroy_on_load) do
    if not tmp_tbl[cid] then
      if OBJ_CALLBACK[cid] then
        Global.log.Error("----- memory leak --- ", cid, " ", OBJ_CALLBACK[cid])
      else
        Global.log.Error("----- memory leak --- ", cid, " ", obj)
      end
    end
  end
  local all_res = self:_get_all_res()
  local all_res_traceback = self:_get_all_res_traceback()
  local current_used_res = {}
  for _, obj in pairs(tmp_tbl) do
    local animator = obj:GetComponentInChildren(TypeUnityAnimator)
    local animator_override = animator and animator:GetAnimatorOverrideController()
    self:_add_current_used_res(current_used_res, animator)
    self:_add_current_used_res(current_used_res, animator_override)
    local renderers = obj:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
    for _, renderer in ipairs(renderers) do
      self:_add_current_used_res(current_used_res, renderer.sharedMesh)
      self:_add_current_used_res(current_used_res, renderer.sharedMaterial)
    end
  end
  for _, res_info in ipairs(all_res) do
    local key = res_info[1]
    local obj = res_info[2]
    if not current_used_res[obj:GetInstanceID()] then
      local flag = false
      for _, tracebacks in ipairs(all_res_traceback) do
        if tracebacks[key] then
          for _, traceback in pairs(tracebacks[key]) do
            Global.log.Error("----- memory leak --- ", key, " ", traceback)
            flag = true
          end
          break
        end
      end
      if not flag then
        Global.log.Error("----- memory leak --- ", key)
      end
    end
  end
end

function M:_add_current_used_res(tbl, res)
  if res and not res:IsNull() then
    tbl[res:GetInstanceID()] = true
  end
end

function M:_get_all_res()
  local ret = {}
  for _, pool in pairs(self.v_pools) do
    if pool:is_res_pool() then
      pool:get_lru():get_all(ret)
    end
  end
  return ret
end

function M:_get_all_res_traceback()
  local ret = {}
  for _, pool in pairs(self.v_pools) do
    if pool:is_res_pool() then
      table.insert(ret, pool.res_traceback)
    end
  end
  return ret
end

function M:_use_obj(gameobj, res_name, pool)
  local cid = gameobj:GetInstanceID()
  self.v_used_gameobj_pools[cid] = pool
  self.v_used_gameobjs[cid] = res_name
  self.v_last_release_times[cid] = nil
  self.v_free_objs[cid] = nil
  pool:on_use_obj(gameobj, cid)
end

function M:_new_session()
  self.v_session = self.v_session + 1
  return self.v_session
end

function M:_init_effect_datas(gameobj, res_name)
  local cid = gameobj:GetInstanceID()
  local status, length = EffectStatus.Bind(gameobj.gameObject)
  assert(status, res_name)
  self.v_effect_status[cid] = status
  self.v_effect_lengths[cid] = length
  local effect_stage = Util.get_component(nil, gameobj, TypeEffectStage)
  if effect_stage then
    self.v_effect_stage_data[cid] = effect_stage
  end
end

function M._on_gameobj_load(cbdata, gameobj)
  local session = cbdata[1]
  local pool = cbdata[2]
  local res_name = cbdata[3]
  local self = cbdata[4]
  local arg = cbdata[5]
  if not gameobj then
    if session then
      local callback = self.v_callbacks[session]
      self.v_callbacks[session] = nil
      if self.v_loading_spell_effects[session] then
        self.v_loading_spell_effects[session] = nil
        self.v_loading_effect_count = self.v_loading_effect_count - 1
      end
    end
    return
  end
  if pool:is_effect_pool() then
    self:_init_effect_datas(gameobj, res_name)
    local pool_name = pool:get_name()
    if pool_name == POOL_TYPE.player_skill_effect and not self.v_preload_gameobjs_lru:try_get(res_name) then
      local path = Path.get_res_path(res_name)
      local obj = ResMgr:instantiate(gameobj, true, path, true)
      obj:SetActive(false)
      obj.transform:SetParent(self.v_preload_gameobj_root.transform, true)
      self.v_preload_gameobjs_lru:push(res_name, obj)
    end
  end
  self:_use_obj(gameobj, res_name, pool)
  if session then
    local callback = self.v_callbacks[session]
    self.v_callbacks[session] = nil
    callback(gameobj, arg)
    if Global.memory_debug then
      OBJ_CALLBACK[gameobj:GetInstanceID()] = OBJ_CALLBACK[session]
      OBJ_CALLBACK[session] = nil
    end
    if self.v_loading_spell_effects[session] then
      self.v_loading_spell_effects[session] = nil
      self.v_loading_effect_count = self.v_loading_effect_count - 1
    end
  end
  if Global.memory_debug then
    gameobj.tag = Config.memory_tag
  end
end

function M._on_res_loaded(cbdata, res)
  local session = cbdata[1]
  local pool = cbdata[2]
  local path = cbdata[3]
  local self = cbdata[4]
  local arg = cbdata[5]
  local traceback = cbdata[6]
  local cid = res:GetInstanceID()
  self.v_used_gameobj_pools[cid] = pool
  self.v_used_gameobjs[cid] = path
  self.v_last_release_times[cid] = nil
  pool:on_load_res(path, res, session, traceback)
  if session then
    local callback = self.v_callbacks[session]
    self.v_callbacks[session] = nil
    callback(arg, self.v_res_obj_lua_pool:new_obj(res, session))
  end
end

function M:clear_cid_cache(cid)
  self.v_used_gameobjs[cid] = nil
  self.v_used_gameobj_pools[cid] = nil
  self.v_fog_disables[cid] = nil
  self.v_effect_status[cid] = nil
  self.v_effect_lengths[cid] = nil
  self.v_effect_stage_data[cid] = nil
  self.v_last_release_times[cid] = nil
end

function M:on_destroy_gameobj(obj)
  self:clear_cid_cache(obj:GetInstanceID())
end

function M:on_destroy_logicobj(cid)
  for _, pool in pairs(self.v_effect_pools) do
    pool:on_destroy_logicobj(cid)
  end
end

function M:on_res_unload(res)
  self:clear_cid_cache(res:GetInstanceID())
end

function M:_pop_from_free_list(pool, res_name, owner)
  local obj = pool:pop_from_free_list(res_name, owner)
  if not obj and res_name then
    obj = self.v_preload_gameobjs_lru:try_get(res_name)
    if obj then
      local path = Path.get_res_path(res_name)
      obj = ResMgr:instantiate(obj, true, path, true)
      if pool:is_effect_pool() then
        self:_init_effect_datas(obj, res_name)
      end
    end
  end
  if obj then
    self:_use_obj(obj, res_name, pool)
  end
  if pool:is_effect_pool() then
    self:_debug_uesless_fx(res_name)
  end
  return obj
end

function M:_destroy_obj_helper(cid, obj)
  self.v_effect_status[cid] = nil
  self.v_effect_lengths[cid] = nil
  self.v_effect_stage_data[cid] = nil
  self.v_fog_disables[cid] = nil
  self.v_free_objs[cid] = nil
  obj.transform:SetParent(nil)
  obj:SetActive(false)
  ResMgr:destroy_gameobj(obj)
end

function M:get_ui_obj(res_name)
  local pool_type = POOL_TYPE.ui_res
  local pool = self.v_pools[pool_type]
  return self:get_gameobj(pool, res_name)
end

function M:get_world_model(res_name)
  local pool_type = POOL_TYPE.world_model
  local pool = self.v_pools[pool_type]
  return self:get_gameobj(pool, res_name)
end

function M:get_timeline(res_name)
  local pool_type = POOL_TYPE.timeline
  local pool = self.v_pools[pool_type]
  return self:get_gameobj(pool, res_name)
end

function M:_debug_uesless_fx(prefab_path)
  if Global.debug_useless_preload_fx and not Global.gamemode:gmode_is_loadscene() then
    if not Global.debug_preload[prefab_path] then
      Log.Error("特效没有预加载！", prefab_path)
    end
    Global.debug_preload[prefab_path] = 0
  end
end

return M
