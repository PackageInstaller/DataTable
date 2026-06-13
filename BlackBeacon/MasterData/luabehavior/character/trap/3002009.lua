local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  self.control = nil
  self.target = nil
end

function M:search_target()
  self.target = search_npc(self.npc, 4, 18, nil, 1)
end

function M:on_frame()
  if is_pass_room() then
    abort_skill(self.npc)
    self.control = 9
  end
  CommonMonster.tiktok_timer_frame(self)
  self:search_target()
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  if target == self.npc and npc ~= self.npc then
    if 5 == damage_type then
      cast_magic(self.npc, npc, 3002002007, 1)
    else
      cast_magic(self.npc, npc, 3002002006, 1)
    end
    cast_magic(self.npc, self.npc, 3002002003, 2)
  end
end

function M:on_npc_hp_zero(npc)
  Base.on_npc_hp_zero(self, npc)
  if npc ~= self.npc then
    return
  end
  create_scene_effect("Fx_H1001001_skill_weapon", npc:get_pos_vec3(), 0)
  self.npc:on_dead(nil, true)
  remove_npc(npc)
end

return M
