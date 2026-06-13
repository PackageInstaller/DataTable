local M = Util.create_class()

function M:_init()
  self.on_ground = true
end

function M:on_start()
  self.stone_lv = get_develop_level(self.npc, 6, 666302)
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  if self.npc == npc then
    if is_showup then
      self.on_ground = true
    else
      self.on_ground = false
    end
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if not self.on_ground and npc == self.npc then
    if not check_magic(target, 6663032) then
      cast_magic(self.npc, self.npc, 6663021, self.stone_lv)
    elseif check_magic(target, 6663032) then
      cast_magic(self.npc, self.npc, 6663022, self.stone_lv)
    end
  end
end

return M
