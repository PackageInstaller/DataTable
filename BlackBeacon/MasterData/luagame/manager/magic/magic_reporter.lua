local CommonDef = require("cs_share.common_define")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local FightDefine = require("cs_share.fight_define")
local MagicDef = require("cs_share.magic_def")
local Seri = require("seri")
local MAGIC_TYPE = MagicDef.MAGIC_TYPE
local ATTR_TYPE = FightDefine.ATTR_TYPE
local MAGIC_REBORT_TYPE = MagicDef.MAGIC_REBORT_TYPE
local AddMagicStartReport = Util.create_class()
local EXTARGS = {
  frame_num = "key_frame_num",
  frame_event = "key_frame_event",
  talent_id = "talent_id",
  skill_major_id = "skill_major_id",
  room_restore_hp = "room_restore_hp",
  is_greed_kill = "is_greed_kill",
  arg = "arg"
}

function AddMagicStartReport:_init(attacker_uuid, magic_rtid, target_uuid, magic_info, magic_type, ext_args, hp, energy, not_send_msg)
  self.uuid = attacker_uuid
  self.target_uuid = target_uuid
  self.magic_id = magic_info.magic_id
  self.magic_level = magic_info.magic_level
  self.magic_rtid = magic_rtid
  self.part_id = magic_info.part_id
  self.random_seed = -1
  if SceneMgr:get_scene_logic() then
    self.random_seed = SceneMgr:get_scene_logic():get_random_ctx().random_seed
  end
  for key, key_name in pairs(EXTARGS) do
    if ext_args and ext_args[key] then
      self[key_name] = ext_args[key]
    else
      self[key_name] = nil
    end
  end
  if ext_args then
    for key, value in pairs(ext_args) do
      local key_name = EXTARGS[key]
      if key_name then
        self[key_name] = value
      end
    end
  end
  if magic_info.owner_skill then
    self.cast_skill_rtid = magic_info.owner_skill.rtid
  else
    self.cast_skill_rtid = nil
  end
  if magic_info.owner_missile then
    self.cast_missile_rtid = magic_info.owner_missile.rtid
  else
    self.cast_missile_rtid = nil
  end
  if MAGIC_REBORT_TYPE[magic_type] then
    self.hp = hp or 0
  else
    self.hp = nil
  end
  self.energy = energy
  self.not_send_msg = not_send_msg
end

function AddMagicStartReport:on_destroy()
end

local AddMagicEndReport = Util.create_class()

function AddMagicEndReport:_init(hp)
  self.hp = hp
  self.random_seed = -1
  if SceneMgr:get_scene_logic() then
    self.random_seed = SceneMgr:get_scene_logic():get_random_ctx().random_seed
  end
end

function AddMagicEndReport:on_destroy()
end

local RemoveMagicReport = Util.create_class()

function RemoveMagicReport:_init(owner_uuid, magic_id, rtid)
  self.target_uuid = owner_uuid
  self.magic_id = magic_id
  self.magic_rtid = rtid
end

function RemoveMagicReport:on_destroy()
end

local SetNpcStatusReport = Util.create_class()

function SetNpcStatusReport:_init(uuid, status, attacker_id)
  self.uuid = uuid
  self.npc_status = status
  self.attacker_id = attacker_id
end

function SetNpcStatusReport:on_destroy()
end

local MagicInfo = Util.create_class()

function MagicInfo:_init(type, magic)
  self.type = type
  self.magic = magic
end

function MagicInfo:on_destroy()
end

local M = Util.create_class()

function M:_init()
  self.v_add_magic_start_pool = LuaObjPoolMgr.register("rp_add_magic_start_pool", 100, AddMagicStartReport)
  self.v_add_magic_end_pool = LuaObjPoolMgr.register("rp_add_magic_end_pool", 100, AddMagicEndReport)
  self.v_remove_magic_pool = LuaObjPoolMgr.register("rp_remove_magic_pool", 100, RemoveMagicReport)
  self.v_set_npc_status_pool = LuaObjPoolMgr.register("rp_set_npc_status_pool", 100, SetNpcStatusReport)
  self.v_magic_info_pool = LuaObjPoolMgr.register("rp_magic_info_pool", 150, MagicInfo)
  self.v_pool_list = {
    self.v_add_magic_start_pool,
    self.v_add_magic_end_pool,
    self.v_remove_magic_pool,
    self.v_set_npc_status_pool,
    self.v_magic_info_pool
  }
  self.v_cache_remove_npc = {}
  self:_reset()
  MsgGame:mq_bind(Const.MSG_NETWORK_RCT_SUC, self._on_reconnect, self)
end

function M:_reset()
  self.v_stack = {}
  self.v_cur_index = 1
  self.v_cur_magic_num = 0
  self.v_stack_len = 0
  self.v_root_type = nil
  self.v_debug_root_info = nil
  self.v_debug_root_trace = nil
end

function M:_release_using_report()
  for _, pool in ipairs(self.v_pool_list) do
    local active_objs = pool:get_active_objs()
    for obj in pairs(active_objs) do
      pool:destroy_obj(obj)
    end
  end
end

local REPORT_FILTER_ATTR_TYPE = {
  [ATTR_TYPE.CHAR_SP] = true,
  [ATTR_TYPE.CHAR_FIGHT_LINE_BAR] = true
}

function M:_is_report_filterd(magic_type, logic_cfg)
  if logic_cfg and (magic_type == MAGIC_TYPE.ChangeAttr or magic_type == MAGIC_TYPE.EnergyRecovery) then
    local attr_type = logic_cfg[1]
    if attr_type and REPORT_FILTER_ATTR_TYPE[attr_type] then
      return true
    end
  end
  return false
end

function M:_clear_remove_npc_map()
  if self.v_has_remove_npc then
    for npc in pairs(self.v_cache_remove_npc) do
      self.v_cache_remove_npc[npc] = nil
      SceneMgr:remove_npc(npc)
    end
    self.v_has_remove_npc = false
  end
end

function M:update()
  self:_clear_remove_npc_map()
end

function M:cache_remove_npc(npc)
  self.v_has_remove_npc = true
  self.v_cache_remove_npc[npc] = true
end

function M:add_magic_start(char, attacker, magic_info, logic_cfg, ext_args, rtid, not_send_msg)
  if Util.is_client_only() then
    return
  end
  if magic_info and magic_info.is_destroy then
    Log.Errorf("magic report error, magic is destroy, owner id:%s, attacker id:%s  %s", char.id, attacker.id, debug.traceback())
    return
  end
  local magic_type = logic_cfg.type
  local attacker_uuid = assert(attacker.uuid)
  local target_uuid = assert(char.uuid)
  local hp = char.attr_mgr:get_hp()
  local energy = char:get_cur_energy()
  local report_info = self.v_add_magic_start_pool:new_obj(attacker_uuid, rtid, target_uuid, magic_info, magic_type, ext_args, hp, energy, not_send_msg)
  self:push_action_start(report_info, CommonDef.MAGIC_ACTION_TYPE.magic_start, report_info)
  self.v_cur_magic_num = self.v_cur_magic_num + 1
  return report_info
end

function M:add_magic_end(belong_report, char, logic_cfg)
  if Util.is_client_only() then
    return
  end
  if not belong_report then
    return
  end
  local magic_type = logic_cfg.type
  local attr_mgr = char.attr_mgr
  if nil == attr_mgr then
    Log.Error("add_magic_end, attr_mgr nil, Id : ", char.character_cfg.NpcId, char.uuid, debug.traceback())
  end
  local hp = attr_mgr and attr_mgr:get_hp() or 0
  local report_info
  if MAGIC_REBORT_TYPE[magic_type] then
    report_info = self.v_add_magic_end_pool:new_obj(hp)
  end
  self:push_action_end(belong_report, CommonDef.MAGIC_ACTION_TYPE.magic_start, report_info)
end

function M:remove_magic_start(magic)
  if Util.is_client_only() then
    return
  end
  if self:_is_report_filterd(magic.magic_type, magic.cfg) then
    return
  end
  local report_info = self.v_remove_magic_pool:new_obj(magic.owner.uuid, magic.magic_id, magic.rtid)
  self:push_action_start(report_info, CommonDef.MAGIC_ACTION_TYPE.magic_remove, report_info)
  return report_info
end

function M:remove_magic_end(belong_report)
  if Util.is_client_only() then
    return
  end
  if not belong_report then
    return
  end
  self:push_action_end(belong_report, CommonDef.MAGIC_ACTION_TYPE.magic_remove)
end

function M:set_npc_status(belong_report, uuid, status, attacker_id)
  if Util.is_client_only() then
    return
  end
  if not belong_report then
    return
  end
  local report_info = self.v_set_npc_status_pool:new_obj(uuid, status, attacker_id)
  self:push_action_single(belong_report, CommonDef.MAGIC_ACTION_TYPE.set_npc_status, report_info)
end

function M:push_action_single(belong_report, type, magic_info)
  if Util.is_client_only() then
    return
  end
  if not belong_report then
    return
  end
  local info = self.v_magic_info_pool:new_obj(type, magic_info)
  self.v_stack[self.v_cur_index] = info
  self.v_cur_index = self.v_cur_index + 1
end

function M:push_action_start(belong_report, type, magic_info)
  if Util.is_client_only() then
    return
  end
  if not belong_report then
    return
  end
  self.v_root_type = self.v_root_type or type
  local info = self.v_magic_info_pool:new_obj(type, magic_info)
  self.v_stack[self.v_cur_index] = info
  self.v_cur_index = self.v_cur_index + 1
  if type == self.v_root_type then
    self.v_stack_len = self.v_stack_len + 1
  end
  if 2 == self.v_cur_index then
  end
  if UNITY_EDITOR and (self.v_cur_magic_num >= 25 or self.v_cur_index >= 200) then
    if self.v_debug_root_info then
      self.v_debug_root_info = nil
      self.v_debug_root_trace = nil
    end
    Log.Error("magic report too long...", self.v_cur_index, self.v_cur_magic_num, self.v_stack[1], debug.traceback())
  end
end

function M:push_action_end(belong_report, type, magic_info)
  if Util.is_client_only() then
    return
  end
  if not belong_report then
    return
  end
  local info = self.v_magic_info_pool:new_obj(type + 1, magic_info)
  self.v_stack[self.v_cur_index] = info
  self.v_cur_index = self.v_cur_index + 1
  if type == self.v_root_type then
    self.v_stack_len = self.v_stack_len - 1
    if self.v_stack_len <= 0 then
      if StateReport then
        StateReport:report_magic_action(self.v_stack)
      end
      self:_reset()
      self:_release_using_report()
    end
  end
end

function M:is_building_report()
  return self.v_root_type ~= nil
end

function M:_on_reconnect()
end

return M
