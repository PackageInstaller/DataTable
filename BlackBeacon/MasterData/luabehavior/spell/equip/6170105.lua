local M = Util.create_class()
local Cd_time = 0
local Cd = 5
local target_list = {}
local ability = 20005
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
  if level > 1 then
    Cd = 2
  end
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_owner == self.npc and 3 == m1_cfg.MissileTypeTag and m2_owner ~= self.npc and not check_magic(m1_owner, 1999125) and not check_magic(m1_owner, 1999126) and not check_npc_die(m1) and 3 ~= m2_cfg.MissileTypeTag and get_time() >= Cd_time then
    Cd_time = get_time() + Cd
    if not check_magic(self.npc, 6170108) then
      local pos = get_missile_pos(m1)
      cast_missile(self.npc, m2, pos.x, pos.z, 60700001101, 1, nil, nil)
      cast_missile(self.npc, m2, pos.x, pos.z, 60700001102, 1, nil, nil)
    else
      cast_missile(self.npc, m2, nil, nil, 60700001103, 1, nil, nil)
      cast_magic(self.npc, self.npc, 61701081, 1)
      cast_magic(self.npc, self.npc, 61701082, 1)
    end
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc and missile_cfg.Id == 60700001102 then
    table.insert(target_list, hit_target)
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if owner == self.npc and missile_cfg.Id == 60700001101 then
    for k, v in ipairs(target_list) do
      abort_magic_by_id(v, 3001039001)
    end
    target_list = {}
  end
end

return M
