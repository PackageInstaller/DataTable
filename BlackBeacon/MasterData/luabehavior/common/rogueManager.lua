local rogueMgr = Util.create_class()
local tool = import("common.tool")
rogueMgr.kuangnu = 61707311
rogueMgr.baojun = 61707122
rogueMgr.huisu = 61706331
rogueMgr.huisu_heal = 61706332
rogueMgr.huisu2 = 61706141
rogueMgr.weilai = 61706341
rogueMgr.baojin = 617089218
rogueMgr.jiaguangchen2 = 61712371
rogueMgr.jiaguangchen5 = 61708371
rogueMgr.jiaguangchen10 = 61708372
rogueMgr.jiaguangchen50 = 61708373
rogueMgr.shoushi = 61711321
rogueMgr.fanji = 61711241
rogueMgr.shengguang = 61711111
rogueMgr.dot_kind = 61709
rogueMgr.paotai_limit = 2
rogueMgr.fragment_missile_shoot = 61712910401
rogueMgr.fragment_missile_judge = 61712910402
rogueMgr.fragment_magic = 61712111
rogueMgr.fragment_effect_magic = 61712011
rogueMgr.fragment_control = 6171201
rogueMgr.relay = 61713011

function rogueMgr.add_water_control_magic(rogueMgr, hero)
  local water_control_enemy = 61709331
  local water_control_friend = 61709333
  local water_control_god = 61709334
  tool:castMagicToTeam(water_control_friend, nil, nil, 1)
  if not check_magic(get_god_npc(), water_control_god) then
    cast_magic(hero, get_god_npc(), water_control_god)
    local enemies = search_npc(hero, 4, 30, nil, 0, true)
    if enemies then
      for _, enemy in pairs(enemies) do
        if not check_magic(enemy, water_control_enemy) then
          cast_magic(hero, enemy, water_control_enemy)
        end
      end
    end
  end
end

function rogueMgr.born_add_water_control(rogueMgr, hero, npc)
  local water_control_enemy = 61709331
  local water_control_friend = 61709333
  local water_control_god = 61709334
  if not check_magic(npc, water_control_enemy) and (2 == get_role_kind(npc) or 3 == get_role_kind(npc) or 4 == get_role_kind(npc)) then
    cast_magic(hero, npc, water_control_enemy)
  end
end

function rogueMgr.update_yongxia_blessings(hero)
  rogueMgr.dot_enemy = check_magic(hero, 6170922)
  rogueMgr.dot_friend = check_magic(hero, 6170921)
  rogueMgr.defence_decrease = check_magic(hero, 6170911)
  rogueMgr.dead_add_water = check_magic(hero, 6170933)
  rogueMgr.level_water = check_magic(hero, 6170931)
end

function rogueMgr.add_zhulei_control_magic(rogueMgr, hero)
  local zhulei_control_god = 61708001
  cast_magic(hero, get_god_npc(), zhulei_control_god)
end

function rogueMgr.beam_connection(rogueMgr, npc)
  local near_paotai = search_npc(npc, 2, 10, nil, true, true, nil, 5)
  if near_paotai then
    for _, v in pairs(near_paotai) do
      if get_npc_attr(v, 1) >= 1 and get_npc_distance(npc, 1, v, false) > 5 then
        rogueMgr.level_6170838 = rogueMgr.level_6170838 or 1
        cast_missile3(npc, v, nil, nil, 61708921101, rogueMgr.level_6170838)
      end
    end
  end
end

function rogueMgr.device_add_money(rogueMgr, summoner)
  if not rogueMgr.crit_add_money then
    return
  end
  rogueMgr.add_money_possible = rogueMgr.add_money_possible or 0.3
  local crit_rate = get_npc_attr(summoner, 76) / 10000
  local pro_add = math.min(math.max(crit_rate - 0.5, 0), 0.2)
  if math.random() < 0.3 + pro_add then
    cast_magic(summoner, summoner, rogueMgr.jiaguangchen5)
  end
end

function rogueMgr.device_add_baojin(rogueMgr, npc, target)
  if not rogueMgr.baojin_magic then
    return
  end
  rogueMgr.baojin_possible = rogueMgr.baojin_possible or 0.3
  local per1, per2 = tool:randByTime(0.3, rogueMgr.baojin_possible)
  if per2 and not check_magic(target, rogueMgr.baojin) then
    cast_magic(npc, target, rogueMgr.baojin)
  end
end

function rogueMgr.device_kill_themselves(rogueMgr, monster)
  if get_npc_time(monster.npc) > monster.init_time + monster.lifetime and not check_magic(monster.npc, 61708015) then
    cast_magic(monster.npc, monster.npc, 10001001)
  end
end

function rogueMgr.random_cast_fragment(rogueMgr, npc, num, ran_dis, target)
  for _ = 1, num do
    local ran_len = 1 + math.random() * ran_dis
    local ran_ang = math.random() * 360
    local far_pos1 = {}
    local wp_judge = false
    local wp_pos = {}
    local born_pos = {}
    if target then
      born_pos = get_npc_pos(target)
      far_pos1 = get_npc_offset_position(target, nil, ran_ang, ran_len)
      wp_judge, wp_pos = get_nearest_walkable_pos(born_pos, far_pos1, 2)
    else
      born_pos = get_npc_pos(npc)
      far_pos1 = get_npc_offset_position(npc, nil, ran_ang, ran_len)
      wp_judge, wp_pos = get_nearest_walkable_pos(born_pos, far_pos1, 2)
    end
    local hero = get_come_on_hero()
    if wp_judge then
      cast_missile(hero, nil, far_pos1.x, far_pos1.z, rogueMgr.fragment_missile_shoot, 1, nil, nil, nil, nil, born_pos.x, born_pos.z)
    else
      cast_missile(hero, nil, wp_pos.x, wp_pos.z, rogueMgr.fragment_missile_shoot, 1, nil, nil, nil, nil, born_pos.x, born_pos.z)
    end
  end
end

return rogueMgr
