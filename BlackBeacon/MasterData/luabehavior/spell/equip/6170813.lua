local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local dianjinshou = 61708131
local layer = 3

function M:_init(npc)
end

function M:on_fate_book_battle_start()
  self.now_layer = get_magic_num(self.npc, dianjinshou)
  self.cast_layer = layer - self.now_layer
  if self.cast_layer > 0 then
    for i = 1, self.cast_layer do
      cast_magic(self.npc, self.npc, dianjinshou)
    end
  end
end

function M:on_npc_born(npc)
  if 5 == get_role_kind(npc) then
    self.now_layer = get_magic_num(self.npc, dianjinshou)
    self.cast_layer = layer - self.now_layer
    if self.cast_layer > 0 then
      for i = 1, self.cast_layer do
        cast_magic(self.npc, self.npc, dianjinshou)
      end
    end
  end
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if 2 ~= get_role_kind(target) and 3 ~= get_role_kind(target) and 4 ~= get_role_kind(target) then
    return
  end
  if check_magic(self.npc, dianjinshou) and not check_magic(target, rogueMgr.baojin) and not check_npc_die(target) then
    cast_magic(self.npc, target, rogueMgr.baojin)
    abort_magic_by_id(self.npc, dianjinshou, 1)
  end
end

function M:on_start()
  for i = 1, 3 do
    cast_magic(self.npc, self.npc, dianjinshou)
  end
  if not check_magic(get_god_npc(), 61708001) then
    cast_magic(self.npc, get_god_npc(), 61708001)
  end
  self.level = get_ability_level(50011) or 1
  if self.level > 1 then
    layer = 5
  end
end

function M:on_room_change(npc)
  self.level = get_ability_level(50011) or 1
  if self.level > 1 then
    layer = 5
  end
end

return M
