local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local fangcheng_jindu = 0
local element_magic_list = {
  [2] = 61709011,
  [3] = 61709012,
  [4] = 61709013,
  [5] = 61709014,
  [6] = 61709015
}

function M:_init(npc)
end

function M:on_magic_begin(npc, target, magic_id, magic_level, magic_kind, magic_type)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if magic_kind and magic_kind[61709] and get_npc_count_by_res_id(6170896) < 1 then
    local pos = {}
    pos = get_npc_pos(target)
    add_npc2(1, 6170896, pos.x, pos.z, pos.x, pos.z, 2, 1)
  end
end

function M:after_damage_A1(npc, target, magic_id, damage_sign, damage_type, is_crit)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if 5 == get_role_kind(npc) then
    cast_magic(npc, target, 617089614)
  end
end

function M:after_damage_B1(npc, target, magic_id, damage_sign, damage_type, is_crit)
  if self.npc ~= get_come_on_hero() then
    return
  end
  if 5 == get_role_kind(npc) and not check_npc_die(target) then
    local element = get_active_char_element(self.npc)
    cast_magic(self.npc, target, element_magic_list[element])
  end
end

function M:update_fangcheng_jindu()
  local branch_id, branch_level = get_equation_branch_info(13)
  if 1301 == branch_id and 1 == branch_level then
    self.after_damage = self.after_damage_A1
  elseif 1301 == branch_id and 2 == branch_level then
    self.after_damage = self.after_damage_A1
  elseif 1302 == branch_id and 1 == branch_level then
    self.after_damage = self.after_damage_B1
  elseif 1302 == branch_id and 2 == branch_level then
    self.after_damage = self.after_damage_B1
  end
end

function M:on_start()
  self:update_fangcheng_jindu()
end

function M:on_room_change()
  self:update_fangcheng_jindu()
end

return M
