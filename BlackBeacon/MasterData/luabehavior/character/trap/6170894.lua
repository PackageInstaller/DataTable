local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local rogueMgr = import("common.rogueManager")
local damage_missile = 61708940101

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
  monster.summoner = get_come_on_hero()
  monster.lifetime = 10
  monster.init_time = get_npc_time(monster.npc)
  monster.chaopin = false
  do
    local level_6170833 = get_ability_level(50019) or 1
    if level_6170833 > 1 then
      local COPY_ATTR_MAP = {
        [4] = 12000,
        [20] = 12000,
        [23] = 12000,
        [26] = 12000,
        [34] = 12000,
        [40] = 12000,
        [76] = 12000,
        [78] = 12000,
        [115] = 12000,
        [122] = 12000,
        [123] = 12000,
        [124] = 12000,
        [125] = 12000,
        [126] = 12000,
        [127] = 12000,
        [128] = 12000,
        [129] = 12000,
        [130] = 12000,
        [131] = 12000,
        [132] = 12000,
        [152] = 12000
      }
      copy_attr_to_npc(get_come_on_hero(), npc, COPY_ATTR_MAP)
    else
      local COPY_ATTR_MAP = {
        [4] = 10000,
        [20] = 10000,
        [23] = 10000,
        [26] = 10000,
        [34] = 10000,
        [40] = 10000,
        [76] = 10000,
        [78] = 10000,
        [115] = 10000,
        [122] = 10000,
        [123] = 10000,
        [124] = 10000,
        [125] = 10000,
        [126] = 10000,
        [127] = 10000,
        [128] = 10000,
        [129] = 10000,
        [130] = 10000,
        [131] = 10000,
        [132] = 10000,
        [152] = 10000
      }
      copy_attr_to_npc(get_come_on_hero(), npc, COPY_ATTR_MAP)
    end
  end
  local skills = {
    atk = {617089401, 0},
    check = {617089402, 0}
  }
  monstBase._init(monster, skills)
  cast_magic(npc, npc, 399001, 1)
  monster.line_light_magic = check_magic(monster.summoner, 6170813)
  monster.baojin_magic = check_magic(monster.summoner, 6170821)
  monster.fisrt_aid_magic = check_magic(monster.summoner, 6170823)
  monster.crit_add_zhujin = check_magic(monster.summoner, 6170831)
  monster.heal_magic = check_magic(monster.summoner, 6170836)
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.check, _ENV.atk)
    _ENV.wander(_ENV.wanderStand)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.wander)
  end
  local states = monster.states
  
  function states.standIdle.isReady()
    return true
  end
  
  states.standIdle.time = 2
  states.wander.tick = nil
  
  function states.standIdle.finTrans()
    return standIdle.monster.states.standIdle
  end
  
  function states.wander.tickTrans(wander)
    local monster = wander.monster
    local states = monster.states
    if states.attack then
      return tree:chooseChildAction(states.attack)
    end
  end
  
  function states.attack.isReady()
    return true
  end
  
  function states.attack.finTrans(attack)
    return attack.monster.states.check
  end
  
  function monster.states.standIdle.tickTrans()
    return
  end
  
  function states.check.tick(check)
    check.base.tick(check)
    if monster.heal_magic then
      local CD = 6
      if not monster.heal_timer then
        monster.heal_timer = 0
      end
      if get_npc_time(monster.npc) > monster.heal_timer + CD then
        rogueMgr.level_6170836 = rogueMgr.level_6170836 or 1
        cast_missile3(monster.npc, monster.npc, nil, nil, 61708920202, rogueMgr.level_6170836)
        monster.heal_timer = get_npc_time(monster.npc)
      end
    end
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if missile_cfg.Id == 61708940201 then
    monster.tree:transState(monster.states.atk, true)
  end
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  if rogueMgr.beam_connection_magic then
    rogueMgr:beam_connection(monster.npc)
  end
end

function monster.after_damage_target(monster, target, magic_id)
  if 2 == get_role_kind(target) or 3 == get_role_kind(target) or 4 == get_role_kind(target) then
    rogueMgr:device_add_money(monster.summoner)
    rogueMgr:device_add_baojin(monster.npc, target)
  end
  if rogueMgr.toughness_damage_up and check_npc_status(target, 14) then
    monster.init_time = get_npc_time(monster.npc)
  end
  if monster.chaopin then
    cast_magic(get_come_on_hero(), target, 617089412)
  end
end

function monster.on_target_self_magic_begin(monster, npc, magic_id, magic_level, magic_kind)
  monster.base.on_target_self_magic_begin(monster, npc, magic_id, magic_level, magic_kind)
  if 617080110 == magic_id then
    monster.chaopin = true
  elseif 61708015 == magic_id then
    monster.delay_lifetime = monster.lifetime + monster.init_time - get_npc_time(monster.npc)
    monster.lifetime = 99999
  end
end

function monster.on_target_self_magic_end(monster, npc, magic_id, magic_kind)
  monster.base.on_target_self_magic_end(monster, npc, magic_id, magic_kind)
  if 617080110 == magic_id then
    monster.chaopin = false
    monster.init_time = get_npc_time(monster.npc)
  elseif 61708015 == magic_id then
    monster.init_time = get_npc_time(monster.npc)
    monster.lifetime = monster.delay_lifetime
  end
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  rogueMgr.device_kill_themselves(rogueMgr, monster)
end

return monster
