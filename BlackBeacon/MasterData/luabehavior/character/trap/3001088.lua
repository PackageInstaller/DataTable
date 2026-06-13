local monstBase = import("character.base.monster_base")
local M = Util.create_child_mt(monstBase)

function M:_init(npc)
  self.trigger = false
  set_npc_floating_text_hud_visible(npc, false)
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  self.search = {}
  local actSkills = {
    move = {300108801}
  }
  local actMoves = {"wait"}
  local nodes = {}
  monstBase._init(self, actSkills, actMoves, nodes)
  local states = self.states
  do
    local _ENV = states
    _ENV.root(_ENV.wait, _ENV.move, _ENV.decisionFailed)
  end
  states.wait.move = states.move
  
  function states.wait.finTrans(wait)
    return wait.move
  end
end

function M:on_target_self_skill_hit(skill_id, attacker, hit_type, missile_cfg, missile, part_npc)
  if get_cur_room_id() ~= 1071503 then
    return
  end
  if self.trigger then
    return
  end
  if 1 == get_role_kind(attacker) then
    self:finTrans()
    call_scene_logic_custom_event("stone")
    self.trigger = true
  end
end

return M
