local M = Util.create_class()
local hit_numbs = 0

function M:_init(npc)
end

function M:on_start()
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == self.npc then
    hit_numbs = hit_numbs + 1
    if hit_numbs >= 3 then
      cast_magic(npc, self.npc, 61701101, 1)
      cast_magic(npc, self.npc, 61701102, 1)
      hit_numbs = 0
    end
  end
end

return M
