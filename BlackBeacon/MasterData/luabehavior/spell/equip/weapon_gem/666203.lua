local M = Util.create_class()

function M:_init()
  self.ult_check = false
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc == self.npc and 5 == skill_type then
    self.ult_check = true
  end
end

function M:on_skill_end(npc, skill_id, is_time_out, is_break)
  if npc == self.npc and self.ult_check == true then
    self.ult_check = false
  end
end

function M:on_start()
  self.stone_lv = get_develop_level(self.npc, 6, 666203)
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= self.npc then
    return
  end
  if (3 == damage_sign or 4 == damage_sign or 5 == damage_sign or 6 == damage_sign or 7 == damage_sign or 8 == damage_sign) and not check_magic(npc, 66620311) then
    if 1 == self.stone_lv then
      cast_magic(npc, npc, 6662032, 0)
    elseif 2 == self.stone_lv then
      cast_magic(npc, npc, 66620321, 0)
    elseif 3 == self.stone_lv then
      cast_magic(npc, npc, 66620322, 0)
    elseif 4 == self.stone_lv then
      cast_magic(npc, npc, 66620323, 0)
    elseif 5 == self.stone_lv then
      cast_magic(npc, npc, 66620324, 0)
    end
    cast_magic(npc, target, 6662031, 0)
    cast_magic(npc, npc, 66620311, 0)
  end
  if check_magic(target, 6662031) and self.ult_check and 6 == damage_sign then
    local num = get_magic_num(target, 6662031)
    if 1 == num then
      cast_magic(npc, npc, 6662033, 0)
    elseif 2 == num then
      cast_magic(npc, npc, 6662034, 0)
    elseif 3 == num then
      cast_magic(npc, npc, 6662035, 0)
    elseif 4 == num then
      cast_magic(npc, npc, 6662036, 0)
    elseif 5 == num then
      cast_magic(npc, npc, 6662037, 0)
    elseif 6 == num then
      cast_magic(npc, npc, 6662038, 0)
    end
  end
end

return M
