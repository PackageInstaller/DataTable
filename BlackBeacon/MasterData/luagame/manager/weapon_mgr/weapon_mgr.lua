local Base = require("obj.base_component")
local CSChangeLayer = CSHelper.ChangeLayerRecursively
local Layer = require("utils.layer")
local TypeAttachPoint = typeof(CS.AttachPoint)
local ACT_DEFINE = Config.ACT_DEFINE
local M = Util.create_child_mt(Base)
local ResPool = Global.res_pool_mgr
local CROSSFADE_MODE = {FIXED_TIME = 1, NORMALIZED_TIME = 2}

function M:_init(char)
  Base._init(self)
  self.v_char = char
  self.gameobjs = {}
  self.v_cid_to_go = {}
  self.v_weapon_animator = {}
  self.runtime_animator = {}
  self.animator = {}
  self.v_attach_point = {}
  self.v_cid_to_res_id = {}
  self.v_change_attach_go = {}
  self.v_weapon_res_id = {}
  self.v_weapon_res_attch = {}
  self.v_weapon_res_name = {}
  self.cache_ani_data = {}
  self.v_need_load_weapon_count = 0
  self.v_loaded_weapon_count = 0
end

function M:on_before_destroy()
  self.v_char = nil
end

function M:on_destroy_gameobj()
  if self.v_weapon_animator then
    for _, animator_info in pairs(self.v_weapon_animator) do
      ResPool:release_res(animator_info)
    end
    self.v_weapon_animator = nil
  end
  for _, gameobj in pairs(self.gameobjs) do
    if not gameobj:IsNull() then
      ResPool:release(gameobj)
    end
  end
  self.gameobjs = nil
  self.v_cid_to_go = nil
  self.v_cid_to_res_id = nil
  self.v_change_attach_go = nil
  self.v_weapon_animator = nil
  self.runtime_animator = nil
  self.animator = nil
  self.v_weapon_res_id = nil
  self.v_weapon_res_attch = nil
  self.v_weapon_res_name = nil
  self.cache_ani_data = nil
end

function M:init_weapon()
  local weapon_fashion_id = self.v_char:get_weapon_fashion()
  if weapon_fashion_id then
    local weapon_fashion_res = ShareRes.get_weapon_fashion_cfg(weapon_fashion_id)
    if weapon_fashion_res and weapon_fashion_res.WeaponRes then
      self:change_weapon_by_res(weapon_fashion_res.WeaponRes)
      return
    end
  end
  local weapon_id = self.v_char:get_weapon_id()
  if not weapon_id then
    local npc_id = self.v_char:get_npc_id()
    weapon_id = ShareRes.get_buddy_cfg(npc_id).WeaponInitId
  end
  if weapon_id then
    self:change_weapon(weapon_id)
  end
end

function M:ui_model_init_weapon(fixed_id, use_weapon_id, ignore_fashion)
  local weapon_id = use_weapon_id
  local npc_id = self.v_char:get_npc_id()
  local weapon_fashion_id
  if not weapon_id and fixed_id then
    local buddy_info
    buddy_info = FixedBuddyMgr:get_fixed_buddy_info(fixed_id)
    if buddy_info then
      weapon_id = buddy_info.weapon
      weapon_fashion_id = buddy_info.equip_fashion
    end
  else
    weapon_id = CharacterMgr:get_weapon_id(npc_id)
  end
  weapon_id = weapon_id or CharacterMgr:get_weapon_id(npc_id) or ShareRes.get_buddy_cfg(npc_id).WeaponInitId
  local weapon_cfg = ShareRes.create("equip.equip", weapon_id)
  if not ignore_fashion then
    weapon_fashion_id = weapon_fashion_id or FashionMgr:get_wearing_weapon_fashion_id(weapon_cfg.SubType)
    local fashion_cfg = ShareRes.get_weapon_fashion_cfg(weapon_fashion_id)
    if fashion_cfg and fashion_cfg.WeaponRes then
      self:change_weapon_by_res(fashion_cfg.WeaponRes)
      return
    end
  end
  self:change_weapon(weapon_id)
end

function M:ui_model_init_weapon_by_res(use_weapon_res)
  self:change_weapon_by_res(use_weapon_res)
end

function M:change_weapon(weapon_id)
  if not weapon_id or 0 == weapon_id then
    return
  end
  local weapon_cfg = ShareRes.create("equip.equip", weapon_id)
  if not weapon_cfg then
    return
  end
  self.v_need_load_weapon_count = #weapon_cfg.ResId
  self.v_loaded_weapon_count = 0
  local equip_res_cfg = ShareRes.create("equip.equip_res")
  for k, weapon_res_id in pairs(weapon_cfg.ResId) do
    local weapon_res_cfg = equip_res_cfg[weapon_res_id]
    assert(weapon_res_cfg, "no such weapon_res_cfg " .. weapon_res_id)
    self:load_model_animator(weapon_res_cfg, k, weapon_res_id)
  end
  self.v_cur_weapon_res = weapon_cfg.ResId
end

function M:change_weapon_by_res(weapon_res)
  if not weapon_res or UtilTable.is_empty(weapon_res) then
    return
  end
  self.v_need_load_weapon_count = #weapon_res
  self.v_loaded_weapon_count = 0
  local equip_res_cfg = ShareRes.create("equip.equip_res")
  for k, weapon_res_id in pairs(weapon_res) do
    local weapon_res_cfg = equip_res_cfg[weapon_res_id]
    assert(weapon_res_cfg, "no such weapon_res_cfg " .. weapon_res_id)
    self:load_model_animator(weapon_res_cfg, k, weapon_res_id)
  end
  self.v_cur_weapon_res = weapon_res
end

function M:load_model_animator(weapon_res_cfg, index, weapon_res_id)
  local attach_point = weapon_res_cfg.AttachPoint
  local parent = self.v_char:get_setting_point(attach_point)
  if not parent then
    Log.Error("找不到武器挂点： ", self.v_char.character_cfg.ModelId, attach_point, weapon_res_cfg.Id)
    return
  end
  local animator_cfg
  if self.v_char:is_ui_model() then
    animator_cfg = ShareRes.get_character_model_cfg(weapon_res_cfg.ModelPath .. "_UI")
  end
  animator_cfg = animator_cfg or ShareRes.get_character_model_cfg(weapon_res_cfg.ModelPath)
  if not animator_cfg then
    self:load_weapon(weapon_res_cfg, attach_point, index, weapon_res_id)
    return
  end
  local sync_load
  if self.v_char.is_ui_hero and self.v_char:is_ui_hero() then
    sync_load = true
  elseif self.v_char:is_hero() then
    local tower = TowerMgr and TowerMgr:get_tower()
    if Global.gamemode:gmode_is_loadscene() or tower and tower:is_in_room_preload() then
      sync_load = true
    else
      sync_load = false
    end
  else
    sync_load = false
  end
  
  local function load_cb(_, animator_info)
    if self.v_char:is_destroy() or not self.v_weapon_animator then
      ResPool:release_res(animator_info)
      return
    end
    local old_animator_info = self.v_weapon_animator[index]
    if old_animator_info then
      ResPool:release_res(old_animator_info)
    end
    self.runtime_animator[index] = animator_info.res
    self.v_weapon_animator[index] = animator_info
    self:load_weapon(weapon_res_cfg, attach_point, index, weapon_res_id)
  end
  
  if sync_load then
    local animator_info = ResPool:get_animator(animator_cfg.ControllerPath)
    load_cb(nil, animator_info)
  else
    ResPool:get_animator_async(animator_cfg.ControllerPath, load_cb)
  end
end

function M:load_weapon(weapon_cfg, attach_point, index, weapon_res_id)
  local sync_load
  if self.v_char.is_ui_hero and self.v_char:is_ui_hero() then
    sync_load = true
  elseif self.v_char:is_hero() then
    local tower = TowerMgr and TowerMgr:get_tower()
    if Global.gamemode:gmode_is_loadscene() or tower and tower:is_in_room_preload() then
      sync_load = true
    else
      sync_load = false
    end
  else
    sync_load = false
  end
  
  local function load_cb(go)
    local cid = go:GetInstanceID()
    if self.v_char:is_destroy() then
      ResPoolMgr:release(go)
      return
    end
    local old_gameobj = self.gameobjs[index]
    if old_gameobj and not old_gameobj:IsNull() then
      ResPool:release(old_gameobj)
    end
    local parent = self.v_char:get_setting_point(attach_point)
    CSChangeLayer(go.transform, self.v_char:get_layer())
    go.transform:SetParent(parent)
    go:ResetAttr()
    self.gameobjs[index] = go
    self.v_weapon_res_id[index] = weapon_res_id
    self.v_weapon_res_attch[index] = weapon_cfg.AttachPoint
    self.v_weapon_res_name[index] = weapon_cfg.ModelPath
    self.v_cid_to_go[cid] = go
    self.v_cid_to_res_id[cid] = weapon_res_id
    self:init_animator(index)
    go:GetComponent(TypeUnityAnimator).enabled = true
    local msg = MsgGame:mq_publish2(Const.MSG_ON_WEAPON_LOADED)
    msg.mm_obj = self.v_char
    msg.mm_x = {go = go, res_id = weapon_res_id}
    self.v_loaded_weapon_count = self.v_loaded_weapon_count + 1
    if self.v_loaded_weapon_count == self.v_need_load_weapon_count and self.cache_ani_data and next(self.cache_ani_data) then
      if self.cache_ani_data.crossfade_mode == CROSSFADE_MODE.FIXED_TIME then
        self:crossfade_weapon_ani_in_fixedtime(self.cache_ani_data.action, self.cache_ani_data.transition_time, self.cache_ani_data.layer, self.cache_ani_data.transition_time_offset)
      elseif self.cache_ani_data.crossfade_mode == CROSSFADE_MODE.NORMALIZED_TIME then
        self:crossfade_weapon_ani_in_normalizedtime(self.cache_ani_data.action, self.cache_ani_data.transition_time, self.cache_ani_data.layer, self.cache_ani_data.transition_time_offset)
      end
      UtilTable.clear_map(self.cache_ani_data)
    end
  end
  
  if sync_load then
    local go = ResPoolMgr:get_weapon(weapon_cfg.ModelPath)
    load_cb(go)
  else
    ResPoolMgr:get_weapon_async(weapon_cfg.ModelPath, load_cb)
  end
end

function M:init_animator(index)
  if self.runtime_animator[index] and self.gameobjs[index] then
    local animator = self.gameobjs[index]:GetComponent(TypeUnityAnimator)
    animator.runtimeAnimatorController = self.runtime_animator[index]
    self.animator[index] = animator
  end
end

function M:crossfade_weapon_ani_in_fixedtime(action, transition_time, layer, fixedtimeoffset)
  transition_time = transition_time or 0
  layer = layer or 0
  for _, animator in pairs(self.animator) do
    self:reset_weapon_pos(animator)
    fixedtimeoffset = fixedtimeoffset or 0
    animator:CrossFadeInFixedTime(action, transition_time, layer, fixedtimeoffset)
  end
  if not next(self.animator) then
    UtilTable.clear_map(self.cache_ani_data)
    self.cache_ani_data.action = action
    self.cache_ani_data.transition_time = transition_time
    self.cache_ani_data.transition_time_offset = fixedtimeoffset
    self.cache_ani_data.layer = layer
    self.cache_ani_data.crossfade_mode = CROSSFADE_MODE.FIXED_TIME
  end
end

function M:crossfade_weapon_ani_in_normalizedtime(action, normalized_transition_time, layer, normalized_time_offset)
  normalized_transition_time = normalized_transition_time or 0
  layer = layer or 0
  for _, animator in pairs(self.animator) do
    self:reset_weapon_pos(animator)
    normalized_time_offset = normalized_time_offset or 0
    animator:CrossFade(action, normalized_transition_time, layer, normalized_time_offset)
  end
  if not next(self.animator) then
    UtilTable.clear_map(self.cache_ani_data)
    self.cache_ani_data.action = action
    self.cache_ani_data.transition_time = normalized_transition_time
    self.cache_ani_data.transition_time_offset = normalized_time_offset
    self.cache_ani_data.layer = layer
    self.cache_ani_data.crossfade_mode = CROSSFADE_MODE.NORMALIZED_TIME
  end
end

function M:reset_weapon_pos(animator)
  local cid = animator.gameObject:GetInstanceID()
  if self.v_change_attach_go[cid] then
    return
  end
  if 0 ~= animator.transform.localPosition.x or 0 ~= animator.transform.localPosition.y or 0 ~= animator.transform.localPosition.z then
    animator.gameObject:SetActive(false)
    animator.gameObject:ResetAttr()
    animator.gameObject:SetActive(true)
  end
end

function M:get_attach_point_obj(point_name)
  if not point_name or "" == point_name then
    return
  end
  if self.v_attach_point[point_name] then
    return self.v_attach_point[point_name].transform
  end
  for _, gameobj in pairs(self.gameobjs) do
    if not gameobj:IsNull() then
      local attach_point = gameobj.transform:GetComponent(TypeAttachPoint)
      if attach_point then
        local point = attach_point:GetPoint(point_name)
        if point then
          self.v_attach_point[point_name] = point
          return point.transform
        elseif UNITY_EDITOR then
          local cid = gameobj:GetInstanceID()
          Log.Info("武器挂点获取失败， 武器resid:", self.v_cid_to_res_id[cid], ", 挂点名：", point_name, debug.traceback())
        end
      end
    end
  end
end

function M:set_weapon_animator_speed(speed)
  for key, animator in pairs(self.animator) do
    animator.speed = speed
  end
end

function M:on_hero_to_background()
  for key, animator in pairs(self.animator) do
    animator:Rebind()
  end
end

function M:change_weapon_attach_point(res_id_map, attach_point_list, reset_trans)
  local go, parent, attach_point, has_set_parent
  for cid, res_id in pairs(self.v_cid_to_res_id) do
    if res_id_map[res_id] then
      go = self.v_cid_to_go[cid]
      if go and not go:IsNull() then
        attach_point = attach_point_list[res_id]
        if not Util.is_empty(attach_point) then
          has_set_parent = true
          parent = self.v_char:get_setting_point(attach_point)
          if not parent or parent.gameObject:IsNull() then
            Log.Error("找不到武器挂点： ", self.v_char.character_cfg.ModelId, attach_point, res_id)
            return
          end
          go.transform:SetParent(parent.transform)
        else
          go.transform:SetParent(nil, true)
          UnityGameObject.DontDestroyOnLoad(go.gameObject)
        end
        if reset_trans or has_set_parent then
          go:ResetAttr()
        end
        self.v_change_attach_go[cid] = res_id
      end
    end
  end
end

function M:reset_weapon_attach_point(res_id_map)
  local go, parent
  local equip_res_cfg = ShareRes.create("equip.equip_res")
  local res_cfg, attach_point
  for cid, res_id in pairs(self.v_change_attach_go) do
    if res_id_map[res_id] then
      go = self.v_cid_to_go[cid]
      if go and not go:IsNull() then
        res_cfg = equip_res_cfg[res_id]
        attach_point = res_cfg.AttachPoint
        if attach_point then
          parent = self.v_char:get_setting_point(attach_point)
          if not parent or parent.gameObject:IsNull() then
            Log.Error("找不到武器挂点： ", self.v_char.character_cfg.ModelId, attach_point, res_id)
            return
          end
          go.transform:SetParent(parent.transform)
          go:ResetAttr()
        end
      end
      self.v_change_attach_go[cid] = nil
    end
  end
end

function M:get_load_weapon_obj(index)
  if index then
    return self.gameobjs[index]
  else
    local is_tbl = true
    return self.gameobjs, is_tbl
  end
end

function M:get_weapon_res_id(index)
  if index then
    return self.v_weapon_res_id[index]
  else
    local is_tbl = true
    return self.v_weapon_res_id, is_tbl
  end
end

function M:get_weapon_attch_name(index)
  if index then
    return self.v_weapon_res_attch[index]
  else
    local is_tbl = true
    return self.v_weapon_res_attch, is_tbl
  end
end

function M:get_weapon_prefab_name(index)
  if index then
    return self.v_weapon_res_name[index]
  else
    local is_tbl = true
    return self.v_weapon_res_name, is_tbl
  end
end

function M:get_current_weapon_res()
  return self.v_cur_weapon_res
end

return M
