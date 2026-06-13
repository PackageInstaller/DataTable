local CommonRole = import("common.role")
local M = Util.create_class()

function M:_init(npc)
  self.is_boom = true
  self.hero = get_come_on_hero()
  self.hero2 = get_scene_hero_by_poskey(21)
  self.hero3 = get_scene_hero_by_poskey(22)
  self.is_hurt = false
  self.hero_hp_now = nil
  self.hero_hp_ago = nil
end

function M:on_start()
end

function M:logic(now_hp)
  local hero_hp = get_npc_attr(self.npc, 1)
  if self.is_hurt and not check_magic(self.npc, 6070090) then
    cast_magic(self.npc, self.npc, 6070090, 1)
    self.is_hurt = false
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc and npc ~= self.npc and not check_magic(self.npc, 6070090) then
    self.is_hurt = true
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if target == self.npc and npc ~= self.npc and not check_magic(self.npc, 6070090) then
    self.is_hurt = true
    self.hero_hp_ago = get_npc_attr(self.npc, 1)
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  if target == self.npc and npc ~= self.npc and not check_magic(self.npc, 6070090) and self.is_hurt then
    self.hero_hp_now = get_npc_attr(self.npc, 1)
    self.is_hurt = false
    if self.hero_hp_ago > self.hero_hp_now then
      cast_magic(self.npc, self.npc, 6070090, 1)
    end
  end
end

function M:on_frame()
end

function M:disenagement_from_battle()
  if not is_in_challenge() then
    self.blood = 0
  end
  if is_pass_room() then
    self.blood = 0
  end
end

return M
