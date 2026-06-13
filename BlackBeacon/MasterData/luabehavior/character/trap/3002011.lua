local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {}
  local actMoves = {"pace"}
  local nodes = {}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.wander(_ENV.pace)
    _ENV.gotTarget(_ENV.wander)
  end
  do
    local states = monster.states
    states.pace.timer = get_npc_time(monster.npc)
    
    function states.pace.start(pace)
      local elapse = 1.5 + math.random() * 1.5
      pace.timer = get_npc_time(monster.npc) + elapse
      local angle = math.random(45, 315)
      local monster = pace.monster
      monster.TEMP_POS = get_npc_offset_position(monster.npc, nil, angle, 100000)
      lookat_position(monster.npc, monster.TEMP_POS.x, monster.TEMP_POS.z, true)
      move_to_pos(monster.npc, monster.TEMP_POS)
      switch_move_type(monster.npc, 0)
    end
    
    function states.pace.tickTrans(pace)
      if get_npc_time(pace.monster.npc) > pace.timer then
        return pace
      end
    end
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if 0 ~= hit_type then
    cast_magic(monster.npc, monster.npc, 3002002003, 2)
  end
end

return monster
