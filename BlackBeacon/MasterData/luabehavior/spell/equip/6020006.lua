local M = Util.create_class()

function M:_init()
  self.buff_layer = 0
  self.used_id = 0
  self.buff_timer = 0
  self.buff_set = 0
  self.damage_type = 0
  self.layer_cast = {
    [1] = 6021003,
    [2] = 6021004,
    [3] = 6021005,
    [4] = 6021006,
    [5] = 6021007
  }
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type)
  if npc ~= self.npc then
    return
  end
  if 2 == get_skill_cfg(skill_id).SkillType or 3 == get_skill_cfg(skill_id).SkillType and skill_id ~= self.used_id then
    self.buff_layer = self.buff_layer + 1
    if self.buff_layer >= 5 then
      self.buff_layer = 5
    end
    self.used_id = skill_id
    self.buff_timer = get_npc_time(self.npc) + 5
  end
  if 4 == get_skill_cfg(skill_id).SkillType then
    self.damage_type = 1
  end
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  self.used_id = 0
end

function M:on_skill_end(npc, skill_id)
  if npc ~= get_come_on_hero() then
    return
  end
  if 4 == get_skill_cfg(skill_id).SkillType and 1 == self.damage_type then
    self.buff_layer = 0
    for k, v in pairs(self.layer_cast) do
      abort_magic_by_id(npc, v)
      self.damage_type = 0
    end
  end
end

function M:on_frame()
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type)
  if npc ~= get_come_on_hero() then
    return
  end
  if 1 == self.damage_type then
    local magic_id = self.layer_cast[self.buff_layer]
    if 0 == self.buff_layer then
      return
    elseif magic_id then
      cast_magic(self.npc, self.npc, magic_id, 1)
    end
  end
end

return M
