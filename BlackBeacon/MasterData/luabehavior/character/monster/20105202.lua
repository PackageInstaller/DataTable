local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 1.5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    head_hit = {
      2010520101,
      5,
      3,
      0,
      2,
      -90,
      90
    },
    rotate_start = {
      2010520102,
      10,
      2,
      0,
      6
    },
    rotate_loop = {2010520103},
    rotate_end = {2010520104},
    ricochet_out_loop = {2010520105},
    ricochet_out_end = {2010520106},
    ricochet_back_loop = {2010520107},
    ricochet_back_end = {2010520108},
    red_back_loop = {2010520110},
    red_back_end = {2010520111}
  }
  local nodes = {
    "Ricochet_out",
    "Ricochet_back",
    "RedSkill"
  }
  local actMoves = {"Stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.ricochet_num = 0
  monster.rebound_num = 7
  monster.check_rebound_frame = 0
  do
    local _ENV = monster.states
    _ENV.Ricochet_out(_ENV.ricochet_out_loop(_ENV.ricochet_out_end))
    _ENV.Ricochet_back(_ENV.ricochet_back_loop(_ENV.ricochet_back_end))
    _ENV.RedSkill(_ENV.red_back_loop(_ENV.red_back_end))
    _ENV.attack(_ENV.freeAtk, _ENV.Ricochet_out, _ENV.Ricochet_back, _ENV.RedSkill)
    _ENV.freeAtk(_ENV.rotate_start(_ENV.rotate_loop(_ENV.rotate_end)), _ENV.head_hit)
    _ENV.wander(_ENV.forward, _ENV.Stand)
  end
  do
    local Ricochet_out = monster.states.Ricochet_out
    
    function Ricochet_out.isReady(Ricochet_out)
      return false
    end
    
    function Ricochet_out.start(Ricochet_out)
      function Ricochet_out.isReady(Ricochet_out)
        return false
      end
    end
    
    function Ricochet_out.finTrans()
      return monster.states.wander
    end
    
    local Ricochet_back = monster.states.Ricochet_back
    
    function Ricochet_back.isReady(Ricochet_back)
      return false
    end
    
    function Ricochet_back.start(Ricochet_back)
      function Ricochet_back.isReady(Ricochet_back)
        return false
      end
    end
    
    local RedSkill = monster.states.RedSkill
    
    function RedSkill.isReady(RedSkill)
      return false
    end
    
    function RedSkill.start(RedSkill)
      function RedSkill.isReady(RedSkill)
        return false
      end
    end
    
    local red_back_end = monster.states.red_back_end
    local ricochet_out_end = monster.states.ricochet_out_end
    local ricochet_back_end = monster.states.ricochet_back_end
    
    function ricochet_out_end.finTrans(ricochet_out_end)
      return monster.states.wander
    end
    
    function ricochet_back_end.finTrans(ricochet_back_end)
      return monster.states.wander
    end
    
    function red_back_end.finTrans(red_back_end)
      return monster.states.wander
    end
  end
  do
    local wander = monster.states.wander
    local Stand = monster.states.Stand
    
    function Stand.start(Stand)
      stop_move(Stand.monster.npc)
      lookat_npc(Stand.monster.npc, Stand.monster.target)
    end
    
    function Stand.tickTrans(Stand)
      if get_npc_distance(monster.npc, 1, monster.target, true) > monster.wander.maxDis then
        return monster.states.wander
      end
    end
    
    function wander.start(wander)
      monster.ricochet_num = 0
    end
  end
  do
    local faint = monster.states.faint
    
    function faint.start(faint)
      monster.ricochet_num = 0
      monster.states.rotate_start.timer = get_npc_time(monster.npc) + 10
      abort_magic_by_id(monster.npc, 2020470103, 10)
      cast_magic(monster.npc, monster.npc, 201052010302, 1)
    end
    
    function monster.states.idle.finish(idle)
      idle.monster.search.minDis = 8
      idle.monster.search.maxDis = 99
    end
  end
  do
    local ricochet_out_loop = monster.states.ricochet_out_loop
    local ricochet_back_loop = monster.states.ricochet_back_loop
    local red_back_loop = monster.states.red_back_loop
    
    function ricochet_out_loop.start(ricochet_out_loop)
      local pos = get_npc_pos(monster.npc)
      local ricochet_pos = get_npc_offset_position(monster.target, pos, 0, 10)
      lookat_position(monster.npc, ricochet_pos.x, ricochet_pos.z, true)
      local self = ricochet_out_loop.monster
      ricochet_out_loop.isCastOver = false
      local skill = ricochet_out_loop.skill
      ricochet_out_loop.curSk = skill
      skill.state = ricochet_out_loop
      abort_skill(self.npc, true)
      ricochet_out_loop.timer = get_npc_time(ricochet_out_loop.monster.npc) + ricochet_out_loop.cd
      skill.isCastOver = false
      skill.castTimer = get_npc_time(self.npc) + skill.befTime + skill.castTime
      cast_skill(self.npc, nil, 2010520105)
    end
    
    function ricochet_back_loop.start(ricochet_back_loop)
      local target_pos = get_npc_pos(monster.target)
      lookat_position(monster.npc, target_pos.x + math.random(-1, 1), target_pos.z + math.random(-1, 1), true)
      local self = ricochet_back_loop.monster
      ricochet_back_loop.isCastOver = false
      local skill = ricochet_back_loop.skill
      ricochet_back_loop.curSk = skill
      skill.state = ricochet_back_loop
      abort_skill(self.npc, true)
      ricochet_back_loop.timer = get_npc_time(ricochet_back_loop.monster.npc) + ricochet_back_loop.cd
      skill.isCastOver = false
      skill.castTimer = get_npc_time(self.npc) + skill.befTime + skill.castTime
      cast_skill(self.npc, nil, 2010520107)
    end
    
    function red_back_loop.start(red_back_loop)
      monster.ricochet_num = monster.ricochet_num + 1
      local target_pos = get_npc_pos(monster.target)
      lookat_position(monster.npc, target_pos.x, target_pos.z, true)
      local self = red_back_loop.monster
      red_back_loop.isCastOver = false
      local skill = red_back_loop.skill
      red_back_loop.curSk = skill
      skill.state = red_back_loop
      abort_skill(self.npc, true)
      red_back_loop.timer = get_npc_time(red_back_loop.monster.npc) + red_back_loop.cd
      skill.isCastOver = false
      skill.castTimer = get_npc_time(self.npc) + skill.befTime + skill.castTime
      cast_skill(self.npc, nil, 2010520110)
    end
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  if 300106301 == skill_id then
    cast_magic(monster.npc, monster.npc, 201051010207, 1)
  end
end

function monster.on_self_skill_end(monster, skill_id, is_time_out, is_break, behavior_abort)
  monster.base.on_self_skill_end(monster, skill_id, is_time_out, is_break, behavior_abort)
  if 2010520106 == skill_id or 2010520108 == skill_id or 2010520111 == skill_id or 2010520104 == skill_id then
    monster.states.rotate_start.timer = get_npc_time(monster.npc) + 12
  end
  if 2010520105 == skill_id then
    remove_missile_by_id(201052010502, monster.npc, false)
    remove_missile_by_id(201052010503, monster.npc, false)
  end
  if 2010520107 == skill_id then
    monster.ricochet_num = monster.ricochet_num + 1
    remove_missile_by_id(201052010702, monster.npc, false)
    remove_missile_by_id(201052010704, monster.npc, false)
  end
  if 2010520110 == skill_id then
    monster.ricochet_num = monster.ricochet_num + 1
    remove_missile_by_id(201052011002, monster.npc, false)
  end
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  listen_missile_collide_obstacle(monster.npc, 201052010502, monster.on_missile_collide_obstacle, monster)
  listen_missile_collide_obstacle(monster.npc, 201052010704, monster.on_missile_collide_obstacle, monster)
end

function monster.on_missile_collide_obstacle(monster, owner, obstacle_type, missile_cfg, missile)
  if owner ~= monster.npc then
    return
  end
  if not check_magic(monster.npc, 201052010301) then
    return
  end
  if missile_cfg.Id == 201052010502 or missile_cfg.Id == 201052010704 then
    if monster.ricochet_num == math.floor(monster.rebound_num / 2) then
      abort_magic_by_id(monster.npc, 201052010301, 1)
      monster.states.RedSkill.isReady = Const.TURE_FUN
      monster.tree:transState(monster.states.RedSkill)
    elseif monster.ricochet_num < monster.rebound_num and monster.ricochet_num ~= math.floor(monster.rebound_num / 2) then
      abort_magic_by_id(monster.npc, 201052010301, 1)
      monster.states.Ricochet_back.isReady = Const.TURE_FUN
      monster.tree:transState(monster.states.Ricochet_back)
    elseif monster.ricochet_num >= monster.rebound_num then
      abort_magic_by_id(monster.npc, 201052010301, 1)
      monster.tree:transState(monster.states.ricochet_out_end, true)
    end
  end
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  monster.check_rebound_frame = monster.check_rebound_frame + 1
  if monster.check_rebound_frame > 1 then
    local hp = get_npc_attr(monster.npc, 1)
    if hp > 0 then
      local pos = get_npc_pos(monster.npc, "Bone009")
      if check_magic(monster.npc, 201052010301) and not is_in_region(pos) then
        if monster.ricochet_num == math.floor(monster.rebound_num / 2) then
          abort_magic_by_id(monster.npc, 201052010301, 1)
          monster.states.RedSkill.isReady = Const.TURE_FUN
          monster.tree:transState(monster.states.RedSkill)
        elseif monster.ricochet_num < monster.rebound_num and monster.ricochet_num ~= math.floor(monster.rebound_num / 2) then
          abort_magic_by_id(monster.npc, 201052010301, 1)
          monster.states.Ricochet_back.isReady = Const.TURE_FUN
          monster.tree:transState(monster.states.Ricochet_back)
        elseif monster.ricochet_num >= monster.rebound_num and monster.states.ricochet_out_loop:isRunning() then
          abort_magic_by_id(monster.npc, 201052010301, 1)
          monster.tree:transState(monster.states.ricochet_out_end, true)
        end
      end
    end
    monster.check_rebound_frame = 0
    return
  end
end

function monster.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  remove_missile_by_id(201052010204, monster.npc, false)
  local monster_kind = get_role_kind(monster.npc)
  if 4 ~= monster_kind then
    cast_magic(attackerNpc, attackerNpc, 1999351)
  else
    cast_magic(attackerNpc, attackerNpc, 1999352)
  end
  cast_magic(attackerNpc, monster.npc, 1999242)
  cast_magic(attackerNpc, monster.npc, 1999261)
  cast_magic(attackerNpc, monster.npc, 1999219)
  cast_magic(attackerNpc, monster.npc, 1999221)
  cast_magic(attackerNpc, monster.npc, 1999222)
  cast_magic(attackerNpc, monster.npc, 1999285)
  cast_magic(attackerNpc, monster.npc, 1999347)
  local isKilled = get_missile_kill_role_count(monster.npc, missile) > 0
  if not isKilled then
    monster.states.Ricochet_out.isReady = Const.TURE_FUN
    monster.tree:transState(monster.states.Ricochet_out)
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if get_sync_var("qian_dark") == true then
    monster.search.minDis = 4
    monster.search.maxDis = 4
  end
end

function monster.on_remove(monster)
  unlisten_missile_collide_obstacle(monster.npc, 201052010502, monster)
  unlisten_missile_collide_obstacle(monster.npc, 201052010704, monster)
end

return monster
