local M = Util.create_class()
local time = 0
local exist_time = 0
local exist_staty = false
local interval_time = 0
local heal_val_now = 0
local heal_val_level = 0
local magic_id = {61702082, 61702083}
local ability = 30008
local level = 1

function M:_init(npc)
end

function M:on_start()
  level = get_ability_level(ability)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 60700002102 and self.npc == get_come_on_hero() then
    cast_magic(self.npc, hit_target, magic_id[level], heal_val_level)
  end
end

function M:after_heal(npc, target, magic_id, heal_val)
  if target == get_come_on_hero() then
    if not check_magic(target, 61702081) then
      cast_magic(target, target, 61702081, 1)
      exist_time = time + 15
      exist_staty = true
    end
    heal_val_now = heal_val + heal_val_now
    heal_val_level = math.ceil(heal_val_now / get_npc_attr(target, 4) * 10)
  end
end

function M:cast_damage()
  if exist_staty and time >= interval_time then
    interval_time = time + 3
    if self.npc == get_come_on_hero() then
      cast_missile(self.npc, nil, nil, nil, 60700002102, 1)
    end
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if npc == self.npc then
    if false == is_showup then
      abort_magic_by_id(self.npc, 61702081)
    elseif true == is_showup and time < exist_time then
      cast_magic(self.npc, self.npc, 61702081, 1)
    end
  end
end

function M:on_frame()
  time = get_time()
  self:cast_damage()
  if time >= exist_time then
    abort_magic_by_id(self.npc, 61702081)
    exist_staty = false
    heal_val_now = 0
  end
end

return M
