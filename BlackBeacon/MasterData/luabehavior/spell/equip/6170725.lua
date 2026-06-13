local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local current_time = 0
local CD = 1

function M:on_start()
  listen_attr_change_mq(self.npc, 1, self.on_hp_change, self)
end

function M:on_hp_change(npc, attr_tpe, change_value)
  if get_npc_time(self.npc) > current_time + CD then
    self.is_niubi = true
    current_time = get_npc_time(self.npc)
  end
end

function M:on_remove()
  unlisten_attr_change_mq(self.npc, 1, self)
end

function M:_init(npc)
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  if self.is_niubi then
    local level = get_ability_level(40016)
    if level > 1 then
      cast_magic(self.npc, self.npc, 61707251)
      self.is_niubi = false
    else
      local info = missile and get_missile_skill_action_info(missile)
      local skAct = info and info.skAct
      if skAct and skAct:deemAtk() then
        cast_magic(self.npc, self.npc, 61707251)
        self.is_niubi = false
      end
    end
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break, behavior_abort)
  if npc ~= self.npc then
    return
  end
  if check_magic(self.npc, 61707251) then
    abort_magic_by_id(self.npc, 61707251)
  end
end

return M
