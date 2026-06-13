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
  local skills = {
    punch = {
      2010500101,
      5,
      3,
      0,
      3,
      -90,
      90
    },
    smash = {
      2010500102,
      8,
      0,
      0,
      4,
      -90,
      90
    },
    Rage = {
      2010500103,
      24,
      5,
      0,
      5,
      -90,
      90
    },
    stab_start = {
      2010500104,
      15,
      3,
      1,
      6,
      -90,
      90
    },
    stab_loop = {
      2010500105,
      0,
      0,
      0,
      99
    },
    stab_end = {
      2010500106,
      0,
      0,
      0,
      99
    },
    show = {2010500106}
  }
  local nodes = {"ATK"}
  local actMoves = {}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.ATK, _ENV.attack, _ENV.wander)
    _ENV.meleeAtk(_ENV.Rage, _ENV.punch(_ENV.smash))
    _ENV.rangedAtk(_ENV.stab_start(_ENV.stab_loop(_ENV.stab_end)))
    _ENV.ATK(_ENV.show)
  end
  do
    local ATK = monster.states.ATK
    local faint = monster.states.faint
    local stab_end = monster.states.stab_end
    monster.switch = true
    ATK.isReady = Const.FALSE_FUN
    
    function ATK.start()
      ATK.isReady = Const.FALSE_FUN
    end
    
    function ATK.finTrans(ATK)
      monster.switch = true
      return monster.states.wander
    end
    
    function faint.start(faint)
      cast_magic(monster.npc, monster.npc, 201050010110, 1)
    end
    
    function stab_end.finTrans(stab_end)
      return monster.states.wander
    end
    
    function monster.states.idle.finish(idle)
      idle.monster.search.minDis = 8
      idle.monster.search.maxDis = 99
    end
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  if 300106301 == skill_id then
    if monster.states.rangedAtk.isRunning(monster.states.rangedAtk) then
      cast_magic(monster.npc, monster.npc, 201051010207, 1)
      cast_magic(monster.npc, monster.npc, 3001064001, 1)
    elseif monster.switch == true then
      cast_magic(monster.npc, monster.npc, 201050010110, 1)
      monster.switch = false
      monster.tree:transState(monster.states.show, true)
    end
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if get_sync_var("qian_dark") == true then
    monster.search.minDis = 4
    monster.search.maxDis = 4
  end
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  local player = get_come_on_hero()
  if m1_owner == player and m2_owner == monster.npc then
    local magics = m1_cfg.magic
    if m2_cfg.Id == 201050010501 then
      monster:try_red_skill_counter(m1, m2)
    end
  end
end

return monster
