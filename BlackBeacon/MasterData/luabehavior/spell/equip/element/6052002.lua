local M = Util.create_class()

function M:_init()
  self.cast_set = false
  self.target = nil
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= self.npc then
    return
  end
  if check_magic(hit_target, 1999020) and 0 ~= hit_type then
    local random_choice = math.random(0, 100)
    if random_choice <= 20 then
      cast_missile(self.npc, hit_target, nil, nil, 10019010501, 1)
    end
  end
end

return M
