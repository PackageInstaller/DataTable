local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp)
  if target ~= self.npc then
    return
  end
  if not self.has_attack_list then
    self.has_attack_list = {}
  end
  for k, v in pairs(self.has_attack_list) do
    if npc == v then
      return
    end
  end
  if get_magic_num(self.npc, 61708342) < 0 then
    rogueMgr.level_6170834 = rogueMgr.level_6170834 or 1
    cast_magic(self.npc, self.npc, 61708342, rogueMgr.level_6170834)
    table.insert(self.has_attack_list, npc)
  end
end

return M
