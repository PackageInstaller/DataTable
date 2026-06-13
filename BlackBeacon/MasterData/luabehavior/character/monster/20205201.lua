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
      2020520101,
      5,
      3 + 4 * math.random(),
      0,
      2,
      -90,
      90
    },
    ricochet_out_loop = {
      2020520102,
      0,
      0,
      0,
      999
    },
    ricochet_out_end = {
      2020520103,
      0,
      0,
      0,
      999
    },
    ricochet_back_loop = {
      2020520104,
      0,
      0,
      0,
      999
    },
    ricochet_back_end = {
      2020520105,
      0,
      0,
      0,
      999
    }
  }
  local nodes = {
    "Ricochet_out",
    "Ricochet_back"
  }
  local actMoves = {"Stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.ricochet_num = 0
  monster.rebound_num = 3
  monster.check_rebound_frame = 0
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.Ricochet_out, _ENV.Ricochet_back, _ENV.wander)
    _ENV.Ricochet_out(_ENV.ricochet_out_loop(_ENV.ricochet_out_end))
    _ENV.Ricochet_back(_ENV.ricochet_back_loop(_ENV.ricochet_back_end))
    _ENV.meleeAtk(_ENV.head_hit)
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
    
    local ricochet_out_end = monster.states.ricochet_out_end
    local ricochet_back_end = monster.states.ricochet_back_end
    
    function ricochet_out_end.finTrans(ricochet_out_end)
      return monster.states.wander
    end
    
    function ricochet_back_end.finTrans(ricochet_back_end)
      return monster.states.wander
    end
  end
  do
    local forward = monster.states.forward
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
    
    function forward.isReady(self_node)
      local monster = self_node.monster
      local distance = get_npc_distance(monster.npc, 1, monster.target, true)
      if monster.states.head_hit then
        return distance > monster.wander.maxDis
      end
    end
    
    function monster.states.idle.finish(idle)
      idle.monster.search.minDis = 8
      idle.monster.search.maxDis = 99
    end
  end
  do
    local ricochet_out_loop = monster.states.ricochet_out_loop
    local ricochet_back_loop = monster.states.ricochet_back_loop
    
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
      cast_skill(self.npc, nil, 2020520102)
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
      cast_skill(self.npc, nil, 2020520104)
    end
  end
end

function monster.on_skill_hit(monster, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target == monster.npc and (300106302 == skill_id or 100100801 == skill_id) then
    local hp = get_npc_attr(monster.npc, 1)
    if hp > 0 then
      if not check_magic(monster.npc, 201052010301) then
        cast_magic(monster.npc, monster.npc, 201052010301, 1)
      end
      monster.ricochet_num = 0
      abort_skill(monster.npc)
      monster.states.Ricochet_out.isReady = Const.TURE_FUN
      monster.tree:transState(monster.states.Ricochet_out)
    end
  end
end

function monster.on_self_skill_end(monster, skill_id, is_time_out, is_break, behavior_abort)
  monster.base.on_self_skill_end(monster, skill_id, is_time_out, is_break, behavior_abort)
  if 2020520102 == skill_id then
    remove_missile_by_id(202052010202, monster.npc, false)
    remove_missile_by_id(202052010203, monster.npc, false)
  end
  if 2020520104 == skill_id then
    monster.ricochet_num = monster.ricochet_num + 1
    remove_missile_by_id(202052010402, monster.npc, false)
    remove_missile_by_id(202052010404, monster.npc, false)
  end
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  listen_missile_collide_obstacle(monster.npc, 202052010202, monster.on_missile_collide_obstacle, monster)
  listen_missile_collide_obstacle(monster.npc, 202052010404, monster.on_missile_collide_obstacle, monster)
end

function monster.on_missile_collide_obstacle(monster, owner, obstacle_type, missile_cfg, missile)
  if owner ~= monster.npc then
    return
  end
  if not check_magic(monster.npc, 201052010301) then
    return
  end
  if missile_cfg.Id == 202052010202 or missile_cfg.Id == 202052010404 then
    if monster.ricochet_num < monster.rebound_num then
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
        if monster.ricochet_num < monster.rebound_num and monster.ricochet_num ~= math.floor(monster.rebound_num / 2) then
          abort_magic_by_id(monster.npc, 201052010301, 1)
          monster.states.Ricochet_back.isReady = Const.TURE_FUN
          monster.tree:transState(monster.states.Ricochet_back)
        elseif monster.ricochet_num >= monster.rebound_num then
          abort_magic_by_id(monster.npc, 201052010301, 1)
          monster.tree:transState(monster.states.ricochet_out_end, true)
        end
      end
    end
    monster.check_rebound_frame = 0
    return
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
  unlisten_missile_collide_obstacle(monster.npc, 202052010202, monster)
  unlisten_missile_collide_obstacle(monster.npc, 202052010404, monster)
end

return monster
