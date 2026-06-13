local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:after_damage(npc, target, magic_id, damage_sign, damage_type)
  if not self.has_attack_list then
    self.has_attack_list = {}
  end
  if (1 == get_role_kind(npc) or 5 == get_role_kind(npc)) and (2 == get_role_kind(target) or 3 == get_role_kind(target) or 4 == get_role_kind(target)) then
    for k, v in pairs(self.has_attack_list) do
      if npc == v then
        return
      end
    end
    if self.level and self.level > 1 then
      cast_magic(self.npc, self.npc, rogueMgr.jiaguangchen10)
    else
      cast_magic(self.npc, self.npc, rogueMgr.jiaguangchen5)
    end
    table.insert(self.has_attack_list, npc)
  end
end

function M:on_fate_book_battle_start()
  self.has_attack_list = {}
end

function M:on_start()
  self.level = get_ability_level(50023) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(50023) or 1
end

function M:_init(npc)
end

return M
