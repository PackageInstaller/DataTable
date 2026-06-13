local M = Util.create_class()

function M:_init()
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc and check_magic(hit_target, 1999010) then
    cast_magic(self.npc, self.npc, 60510021, 1)
    print("magic加上")
  end
end

return M
