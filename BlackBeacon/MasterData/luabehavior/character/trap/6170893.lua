local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local rogueMgr = import("common.rogueManager")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  if not monster.summoner then
    monster.summoner = get_come_on_hero()
  end
  monster.lifetime = 10
  monster.init_time = get_npc_time(monster.npc)
  monster.chaopin = false
  monster.cifu_CD = 0
  monster.cifu_timer = 0
  monster.level_6170822 = get_ability_level(50013) or 1
  enable_shadow(npc, false)
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
  local skills = {
    laser = {617089301, 0}
  }
  monstBase._init(monster, skills)
  local states = monster.states
  monster.trace_laser_magic = check_magic(monster.summoner, 6170812)
  monster.baojin_magic = check_magic(monster.summoner, 6170821)
  monster.dengliziquyu_magic = check_magic(monster.summoner, 6170822)
  monster.fisrt_aid_magic = check_magic(monster.summoner, 6170823)
  monster.crit_add_zhujin = check_magic(monster.summoner, 6170831)
  monster.element_magic = check_magic(monster.summoner, 6170834)
  monster.denglizipao_magic = check_magic(monster.summoner, 6170835)
  monster.heal_magic = check_magic(monster.summoner, 6170836)
  cast_magic(npc, npc, 399001, 0)
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.laser)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.wander, _ENV.broken, _ENV.broken_forever)
    _ENV.wander(_ENV.wanderStand(_ENV.standIdle))
  end
  
  function states.laser.finTrans(laser)
    return laser
  end
  
  function states.laser.tick(laser)
    laser.base.tick(laser)
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
    if get_npc_time(monster.npc) > monster.cifu_timer + monster.cifu_CD then
      cast_missile3(monster.npc, target, nil, nil, 61708930105, monster.level_6170822)
      monster.cifu_timer = get_npc_time(monster.npc)
      monster.cifu_CD = 4
      if monster.chaopin then
        monster.cifu_CD = 3
      end
    end
    if rogueMgr.toughness_damage_up and check_npc_status(target, 14) then
      monster.init_time = get_npc_time(monster.npc)
    end
  end
end

function monster.on_target_self_magic_begin(monster, npc, magic_id, magic_level, magic_kind)
  monster.base.on_target_self_magic_begin(monster, npc, magic_id, magic_level, magic_kind)
  if 617080110 == magic_id then
    monster.chaopin = true
    cast_missile3(monster.npc, monster.npc, nil, nil, 61708930403)
    cast_missile3(monster.npc, monster.npc, nil, nil, 61708930406)
    cast_missile3(monster.npc, monster.npc, nil, nil, 61708930407)
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
    remove_missile_by_id(61708930403, monster.npc)
    remove_missile_by_id(61708930406, monster.npc)
    remove_missile_by_id(61708930407, monster.npc)
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
