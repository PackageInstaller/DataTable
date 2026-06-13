local M = Util.create_class()

function M:_init()
  self.atk_count = 0
end

function M:on_start()
  self.stone_lv = get_develop_level(self.npc, 6, 666101)
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if 1 == damage_sign and npc == self.npc then
    self.atk_count = self.atk_count + 1
    if 10 == self.atk_count then
      self.atk_count = 0
      if not check_magic(npc, 6661031) then
        cast_magic(npc, npc, 6661011, self.stone_lv)
      elseif check_magic(npc, 6661031) then
        cast_magic(npc, npc, 6661012, self.stone_lv)
      end
    end
  end
end

return M
