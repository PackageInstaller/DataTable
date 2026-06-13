local M = Util.create_class()

function M:_init(npc)
  self.skill1 = 320010201
  self.skill_missile_id1 = 320010201001
  npc.state = 0
  set_npc_floating_text_hud_visible(npc, false)
  set_sync_var("lantern_num", 0)
end

function M:on_npc_born(npc)
  cast_skill(self.npc, self.target, self.skill1)
  set_can_searched(self.npc, false)
  enable_shadow(self.npc, false)
  self.state = 1
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= self.npc then
    if npc ~= self.npc then
      return
    end
    if get_npc_id(hit_target) == 3001064 and skill_id == self.skill1 then
      hit_target.D_hitted = true
      hit_target.jinghua = true
      abort_skill(hit_target)
    end
    return
  end
end

return M
