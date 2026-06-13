local M = Util.create_class()

function M:_init()
  self.kind = 1
end

function M:on_start()
  self.kind = get_role_kind(self.npc)
  cast_magic(self.npc, self.npc, 4033160203, 1)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == self.npc then
    if 2 == self.kind then
      cast_magic(self.npc, self.npc, 4033160201)
    elseif self.kind > 2 then
      cast_magic(self.npc, self.npc, 4033160202)
    end
  end
end

function M:on_frame()
end

return M
