local behaviorBase = import("common.base.behavior_base")
local M = Util.create_child_mt(behaviorBase)
local tool = import("common.tool")
local current_energy = 0
local rogueMgr = import("common.rogueManager")
local huisu2 = 61706141

function M:_init(npc)
end

function M:on_target_self_magic_begin(npc, magic_id, magic_level, magic_kind, magic_type)
  if magic_id == rogueMgr.huisu then
    local level = get_ability_level(20012) or 1
    cast_magic(self.npc, self.npc, 61706211, level)
  end
end

function M:before_damage_target(target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  if 61706213 == magic_id then
    return
  end
  if self.curr_time + self.CD >= get_npc_time(self.npc) or target == self.npc then
    return
  end
  local info = missile and get_missile_skill_action_info(missile)
  local skAct = info and info.skAct
  if skAct and (skAct:isAtk() or skAct:isSkill() or skAct:isUlt()) and 1008524 ~= magic_id and check_magic(self.npc, 61706212) then
    abort_magic_by_id(self.npc, 61706212, 1)
    cast_magic(self.npc, target, 61706213)
    self.curr_time = get_npc_time(self.npc)
  end
end

function M:on_start()
  self.CD = 0.5
  self.curr_time = get_npc_time(self.npc)
  self.energy_each = self.npc:get_each_point_expend_value()
  current_energy = get_npc_attr(self.npc, 2)
  self.last_gezi = math.floor(current_energy / self.energy_each)
  listen_attr_change_mq(self.npc, 2, self.on_jingli_change, self)
end

function M:on_jingli_change(npc, attr_tpe, change_value)
  current_energy = get_npc_attr(self.npc, 2)
  self.gezi = math.floor(current_energy / self.energy_each)
  if self.gezi > self.last_gezi then
    local buff_add = self.gezi - self.last_gezi
    for _ = 1, buff_add do
      cast_magic(self.npc, self.npc, 61706212, 0)
    end
  end
  self.last_gezi = self.gezi
end

function M:on_remove()
  unlisten_attr_change_mq(self.npc, 2, self)
end

return M
