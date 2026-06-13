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
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  local skills = {
    atk = {300105702, 0},
    check = {300105701, 0}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 2010050117, 1)
  cast_magic(npc, npc, 2010050113, 1)
  cast_magic(npc, npc, 399932, 1)
  cast_magic(npc, npc, 399931, 1)
  cast_magic(npc, npc, 30010570102, 1)
  monster.knife1posX = nil
  monster.knife1posZ = nil
  monster.knife1pos = {
    monster.knife1posX,
    monster.knife1posZ
  }
  monster.knife2posX = nil
  monster.knife2posZ = nil
  monster.knife2pos = {
    monster.knife2posX,
    monster.knife2posZ
  }
  monster.knifetx = nil
  monster.knife1 = nil
  monster.knife2 = nil
  do
    local _ENV = monster.states
    _ENV.active(_ENV.daze, _ENV.check, _ENV.atk, _ENV.stand)
  end
  
  function states.atk.start(atk)
    atk.base.start(atk)
    remove_missile_by_id(30010570102, npc, true)
    remove_missile_by_id(30010570103, npc, true)
    remove_missile_by_id(30010570301, npc, false)
    local param = {
      npc = monster.npc,
      posx = monster.knife1posX,
      posz = monster.knife1posZ,
      missile_id = 30010570302,
      missile_level = 1,
      lookat_posx = monster.knife1posX,
      lookat_posz = monster.knife1posZ,
      lookat_posy = monster.knife2.v_born_pos.y,
      born_posx = (monster.knife2posX + monster.knife1posX) / 2,
      born_posz = (monster.knife2posZ + monster.knife1posZ) / 2
    }
    cast_missile2(param)
  end
  
  function states.atk.finish()
  end
  
  function states.atk.finTrans(atk)
    return atk.monster.states.stand
  end
  
  function states.stand.tick(stand)
    remove_npc(stand.monster.npc)
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 300105701 == skill_id and hit_target == get_come_on_hero() then
    monster.tree:transState(monster.states.atk, true)
  end
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 30010570102 then
    monster.knife1 = missile
    monster.knife1posX = get_missile_pos(monster.knife1).x
    monster.knife1posZ = get_missile_pos(monster.knife1).z
  end
  if missile_cfg.Id == 30010570103 then
    monster.knife2 = missile
    monster.knife2posX = get_missile_pos(monster.knife2).x
    monster.knife2posZ = get_missile_pos(monster.knife2).z
    local param = {
      npc = monster.npc,
      posx = monster.knife1posX,
      posz = monster.knife1posZ,
      missile_id = 30010570301,
      missile_level = 1,
      lookat_posx = monster.knife1posX,
      lookat_posz = monster.knife1posZ,
      lookat_posy = monster.knife2.v_born_pos.y,
      born_posx = (monster.knife2posX + monster.knife1posX) / 2,
      born_posz = (monster.knife2posZ + monster.knife1posZ) / 2
    }
    cast_missile2(param)
  end
  if missile_cfg.Id == 30010570301 then
    monster.knifetx = missile
  end
end

return monster
