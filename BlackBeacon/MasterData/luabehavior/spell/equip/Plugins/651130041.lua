local M = Util.create_class()
local tool = import("common.tool")
local team = tool.team.npc
local damageCD = 1.8
local delayCD = 1
local nowtime

function M:_init()
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  self.DamageTime = get_npc_time(self.npc) + damageCD
  if self.DelaySwitch == false and check_magic(self.npc, 651130042) then
    self.DelaySwitch = true
    self.DelayTime = get_npc_time(self.npc) + delayCD
  end
end

function M:on_start()
  self.DamageTime = get_npc_time(self.npc) + damageCD
  self.DelayTime = math.huge
  self.DelaySwitch = false
  self.level = get_develop_level(self.npc, 6, 651130041)
end

function M:on_frame()
  nowtime = get_npc_time(self.npc)
  if nowtime >= self.DelayTime and check_magic(self.npc, 651130042) then
    self.DelayTime = math.huge
    self.DelaySwitch = false
    abort_magic_by_id(self.npc, 651130042, 1)
  end
  if nowtime >= self.DamageTime and not check_magic(self.npc, 651130042) then
    cast_magic(self.npc, self.npc, 651130042, self.level, 1)
  end
end

function M:on_frame_background()
  nowtime = get_npc_time(self.npc)
  if nowtime >= self.DelayTime and check_magic(self.npc, 651130042) then
    self.DelayTime = math.huge
    self.DelaySwitch = false
    abort_magic_by_id(self.npc, 651130042, 1)
  end
  if nowtime >= self.DamageTime and not check_magic(self.npc, 651130042) then
    cast_magic(self.npc, self.npc, 651130042, self.level, 1)
  end
end

return M
