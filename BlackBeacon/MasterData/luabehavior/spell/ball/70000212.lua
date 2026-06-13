local M = Util.create_class()

function M:_init()
  self.magicNum = 0
  self.intervalTime = 0
end

function M:on_start()
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if npc == self.npc and self.npc == get_come_on_hero() and 7000021202 ~= magic_id then
    local distance = get_npc_distance(self.npc, 1, target, true)
    local distanceCeil = math.ceil(distance / 5 * 10)
    local magicLv = math.ceil(distanceCeil / 2)
    cast_magic(self.npc, self.npc, 7000021201, magicLv)
    if distance >= 3 then
      self.magicNum = self.magicNum + 1
    end
    if self.magicNum >= 10 and get_npc_time(self.npc) >= self.intervalTime then
      self.intervalTime = get_npc_time(self.npc) + 1
      self.magicNum = 0
      local targetList = search_npc(target, 11, 5, nil, true, true)
      cast_missile(self.npc, target, nil, nil, 70000200106, 1)
      cast_missile(self.npc, target, nil, nil, 70000200107, 1)
      for k, v in pairs(targetList) do
        cast_missile(self.npc, v, nil, nil, 70000200106, 1)
        cast_missile(self.npc, v, nil, nil, 70000200107, 1)
      end
      targetList = {}
    end
  end
end

return M
