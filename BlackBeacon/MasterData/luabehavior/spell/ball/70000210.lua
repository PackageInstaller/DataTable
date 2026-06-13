local M = Util.create_class()

function M:_init()
  self.missileNumb = 0
  self.intervalTime = 0
end

function M:on_start()
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if 7000021001 == magic_id and npc == self.npc then
    cast_magic(self.npc, self.npc, 7000021002, self.missileNumb)
  end
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if 1 ~= element then
    local nowTime = get_npc_time(self.npc)
    if nowTime >= self.intervalTime then
      self.missileNumb = 0
    end
    if attacker == self.npc then
      cast_missile(get_come_on_hero(), nil, nil, nil, 70000200102, 1)
      cast_missile(get_come_on_hero(), nil, nil, nil, 70000200103, 1)
    end
    self.missileNumb = self.missileNumb + 1
    self.intervalTime = nowTime + 10
  end
end

function M:on_magic_begin(npc, target, magic_id, magic_level, magic_kind, magic_type)
  if 51 == magic_type then
    local nowTime = get_npc_time(self.npc)
    if nowTime >= self.intervalTime then
      self.missileNumb = 0
    end
    if get_come_on_hero() == self.npc then
      cast_missile(get_come_on_hero(), nil, nil, nil, 70000200102, 1)
      cast_missile(get_come_on_hero(), nil, nil, nil, 70000200103, 1)
    end
    self.missileNumb = self.missileNumb + 1
    self.intervalTime = nowTime + 10
  end
end

return M
