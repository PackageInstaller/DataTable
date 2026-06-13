local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local monsterTool = import("common.monster_tool")
local vec3 = require("base.vec3")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0,
    maxDis = 999,
    minTime = 1.5,
    maxTime = 1.5,
    type = "run"
  }
  monster.search = {minDis = 100, maxDis = 100}
  monster.stone_now_time = 0
  monster.mega_stone_timer = 0
  local actskills = {
    L_punch = {
      2010380102,
      30,
      8,
      0,
      9999,
      -90,
      0
    },
    R_punch = {
      2010380103,
      30,
      8,
      0,
      9999,
      0,
      90
    },
    L_punch1 = {
      2010380102,
      15,
      8,
      0,
      9999,
      -90,
      0
    },
    R_punch1 = {
      2010380103,
      15,
      8,
      0,
      9999,
      0,
      90
    },
    L_stone = {
      2010380124,
      30,
      12,
      0,
      9999,
      -90,
      0
    },
    L_stone1 = {
      2010380124,
      15,
      12,
      0,
      9999,
      -90,
      0
    },
    R_stone = {
      2010380123,
      30,
      12,
      0,
      9999,
      0,
      90
    },
    R_stone1 = {
      2010380123,
      15,
      12,
      0,
      9999,
      0,
      90
    },
    mega_double_punch = {
      2010380108,
      30,
      8,
      0,
      9999
    },
    mega_double_punch1 = {
      2010380108,
      30,
      8,
      0,
      9999
    },
    mega_double_punch2 = {
      2010380108,
      30,
      8,
      0,
      9999
    },
    mega_double_punch3 = {
      2010380108,
      35,
      8,
      0,
      9999
    },
    mega_double_punch4 = {
      2010380108,
      35,
      8,
      0,
      9999
    },
    laserbomb = {
      2010380107,
      25,
      2,
      0,
      9999
    },
    laserbomb1 = {
      2010380107,
      25,
      2,
      0,
      9999
    },
    laserbomb2 = {
      2010380107,
      25,
      2,
      0,
      9999
    },
    laserbomb3 = {
      2010380107,
      35,
      2,
      0,
      9999
    },
    laserbomb4 = {
      2010380107,
      35,
      2,
      0,
      9999
    },
    L_burst_start = {
      2010380110,
      0,
      0,
      0,
      9999
    },
    L_burst_loop = {2010380111},
    L_burst_end = {2010380112},
    R_burst_start = {
      2010380113,
      0,
      0,
      0,
      9999
    },
    R_burst_loop = {2010380114},
    R_burst_end = {2010380115},
    die = {
      2010380119,
      0,
      0,
      0,
      9999
    },
    chuifei = {
      2010380125,
      9999,
      10,
      0,
      9999
    },
    xixinide_start = {2010380126},
    xixinide_loop = {2010380127},
    xixinide_loop2 = {2010380127},
    xixinide_end = {2010380128},
    stun_loop = {2010380130},
    stun_end = {2010380131},
    jijinide = {2010380129}
  }
  local nodes = {
    "evade",
    "HaveArm",
    "HaveTwoArm",
    "HaveOneArm",
    "BreakArm",
    "close1",
    "close2",
    "close3",
    "close4",
    "close5",
    "close6",
    "close7",
    "close8"
  }
  monstBase._init(monster, actskills, nil, nodes)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.wander)
    _ENV.wander(_ENV.wanderStand)
    _ENV.freeAtk(_ENV.HaveArm(_ENV.HaveTwoArm, _ENV.HaveOneArm), _ENV.HaveTwoArm(_ENV.close8(_ENV.chuifei(_ENV.xixinide_start(_ENV.xixinide_loop(_ENV.xixinide_loop2(_ENV.xixinide_end(_ENV.stun_loop(_ENV.stun_end)), _ENV.jijinide))))), _ENV.close1(_ENV.mega_double_punch3, _ENV.laserbomb3, _ENV.L_punch(_ENV.L_stone)), _ENV.close2(_ENV.mega_double_punch4, _ENV.laserbomb4, _ENV.R_punch(_ENV.R_stone))), _ENV.HaveOneArm(_ENV.close5(_ENV.laserbomb1, _ENV.L_punch1(_ENV.L_stone1)), _ENV.close6(_ENV.laserbomb2, _ENV.R_punch1(_ENV.R_stone1))), _ENV.BreakArm(_ENV.close3(_ENV.L_burst_start), _ENV.close4(_ENV.R_burst_start), _ENV.close7(_ENV.die)))
  end
  
  function states.standIdle.tickTrans(standIdle)
  end
  
  function states.standIdle.isReady(standIdle)
    return true
  end
  
  do
    local dead = monster.states.dead
    dead.delay = {fx = 4, remove = 5}
  end
  do
    local L_burst_start = skills.L_burst_start
    local L_burst_loop = skills.L_burst_loop
    local L_burst_end = skills.L_burst_end
    L_burst_start(L_burst_loop(L_burst_end))
    local R_burst_start = monster.skills.R_burst_start
    local R_burst_loop = monster.skills.R_burst_loop
    local R_burst_end = monster.skills.R_burst_end
    R_burst_start(R_burst_loop(R_burst_end))
  end
  do
    local active = monster.states.active
    
    function active.tick(active)
      if check_magic(monster.npc, 20103801210) then
        local missile_list = {
          201038010901,
          201038010902,
          201038010903
        }
        local nowtime = get_npc_time(monster.npc)
        if nowtime > monster.stone_now_time then
          local scale = 3
          local pos = get_npc_pos(get_come_on_hero())
          local target_pos_x = pos.x + scale * math.random() * 2 - scale
          local target_pos_z = pos.z + scale * math.random() * 2 - scale
          local target_pos = vec3.New(target_pos_x, pos.y, target_pos_z)
          local is_pos, posSet = get_nearest_walkable_pos(pos, target_pos, 0.5)
          if not is_pos then
            target_pos_x = posSet.x
            target_pos_z = posSet.z
          end
          for _, missile_id in ipairs(missile_list) do
            cast_missile(monster.npc, nil, target_pos_x, target_pos_z, missile_id)
          end
          monster.stone_now_time = nowtime + 0.5
        end
      end
      if check_magic(monster.npc, 20103801209) then
        local missile_list = {
          201038010901,
          201038010902,
          201038010903
        }
        local nowtime = get_npc_time(monster.npc)
        if nowtime > monster.stone_now_time then
          local scale = 4
          local pos = get_npc_pos(get_come_on_hero())
          local target_pos_x = pos.x + scale * math.random() * 2 - scale
          local target_pos_z = pos.z + scale * math.random() * 2 - scale
          local target_pos = vec3.New(target_pos_x, pos.y, target_pos_z)
          local is_pos, posSet = get_nearest_walkable_pos(pos, target_pos, 0.5)
          if not is_pos then
            target_pos_x = posSet.x
            target_pos_z = posSet.z
          end
          for _, missile_id in ipairs(missile_list) do
            cast_missile(monster.npc, nil, target_pos_x, target_pos_z, missile_id)
          end
          monster.stone_now_time = nowtime + 0.5
        end
      end
    end
  end
  do
    local born = monster.states.born
    
    function born.start(born)
      born.isDone = true
      if monster.npc.id == 20103801 then
        born.base.start(born)
        monster.part_l_npc = create_part_npc(201160, monster.npc, "Part_L_Hand", 1, 2)
        monster.part_r_npc = create_part_npc(201161, monster.npc, "Part_R_Hand", 2, 2)
        enable_part_damage(monster.npc, 1, true)
        enable_part_damage(monster.npc, 2, true)
      end
    end
    
    function born.fintrans()
    end
  end
  states.attack.interval = 0.5
  monster.HaveLeftHand = true
  monster.HaveRightHand = true
  
  function states.HaveTwoArm.isReady(HaveTwoArm)
    if monster.HaveLeftHand == true and true == monster.HaveRightHand then
      return true
    else
      return false
    end
  end
  
  function states.HaveOneArm.isReady(HaveOneArm)
    if monster.HaveLeftHand == true and monster.HaveRightHand == false or monster.HaveLeftHand == false and true == monster.HaveRightHand then
      return true
    else
      return false
    end
  end
  
  function states.close6.isReady(close6)
    if monster.HaveLeftHand == false and monster.HaveRightHand == true then
      return true
    else
      return false
    end
  end
  
  function states.close5.isReady(close5)
    if monster.HaveLeftHand == true and monster.HaveRightHand == false then
      return true
    else
      return false
    end
  end
  
  function states.die.finish(die)
    cast_magic(monster.npc, monster.npc, 20103801058, 0)
    remove_npc(monster.npc)
  end
  
  function states.BreakArm.isReady(BreakArm)
    return false
  end
  
  function states.L_burst_start.tick(L_burst_start)
    if monster.HaveLeftHand == false and false == monster.HaveRightHand then
      cast_magic(monster.npc, monster.npc, 20103801212)
      cast_magic(monster.npc, monster.npc, 20103801042, 0)
      cast_magic(monster.npc, monster.npc, 20103801058, 0)
      abort_magic_by_id(monster.npc, 20103801059)
    end
  end
  
  function states.R_burst_start.tick(R_burst_start)
    if monster.HaveLeftHand == false and false == monster.HaveRightHand then
      cast_magic(monster.npc, monster.npc, 20103801213)
      cast_magic(monster.npc, monster.npc, 20103801044, 0)
      cast_magic(monster.npc, monster.npc, 20103801058, 0)
      abort_magic_by_id(monster.npc, 20103801059)
    end
  end
  
  function monster.states.chuifei.isReady(chuifei)
    local L_hand_hp_max = get_npc_attr(monster.part_l_npc, 4)
    local L_hand_hp_cur = get_npc_attr(monster.part_l_npc, 1)
    local R_hand_hp_max = get_npc_attr(monster.part_r_npc, 4)
    local R_hand_hp_cur = get_npc_attr(monster.part_r_npc, 1)
    local L_hp_per = L_hand_hp_cur / L_hand_hp_max
    local R_hp_per = R_hand_hp_cur / R_hand_hp_max
    return chuifei.base.isReady(chuifei) and (L_hp_per < 0.7 or R_hp_per < 0.7)
  end
  
  function monster.states.chuifei.start(chuifei)
    chuifei.base.start(chuifei)
    local scale = 2
    local random_value1 = 1 == math.random(2) and -1 or 1
    local random_value2 = 1 == math.random(2) and -1 or 1
    local random_value3 = 1 == math.random(2) and -1 or 1
    local pos_ran1 = math.random() * math.random(2, 4) * random_value1
    local pos_ran2 = math.random() * math.random(2, 4) * random_value2
    local pos_ran3 = math.random() * math.random(2, 4) * random_value3
    local lookat_pos = get_npc_pos(monster.npc)
    abort_magic_by_id(monster.npc, 20103801210)
    abort_magic_by_id(monster.npc, 20103801209)
    cast_missile(monster.npc, nil, pos_ran1, 22, 201038013201)
    cast_missile(monster.npc, nil, pos_ran3, 26, 201038013203)
    
    local function play_dbm()
      play_DBM_ani(33)
    end
    
    monster.doAfter(monster, play_dbm, 2)
    cast_magic(monster.part_l_npc, monster.part_l_npc, 20103801222)
    cast_magic(monster.part_l_npc, monster.part_l_npc, 20103801223)
    cast_magic(monster.part_r_npc, monster.part_r_npc, 20103801222)
    cast_magic(monster.part_r_npc, monster.part_r_npc, 20103801223)
  end
  
  function monster.states.xixinide_start.start(xixinide_start)
    xixinide_start.base.start(xixinide_start)
  end
  
  function monster.states.xixinide_loop.start(xixinide_loop)
    xixinide_loop.base.start(xixinide_loop)
    set_effect_end_anim_idx(monster.npc, "Fx_M201038_exskill_1_2", 0)
  end
  
  function monster.states.xixinide_loop.finish(xixinide_loop)
    xixinide_loop.base.finish(xixinide_loop)
  end
  
  function monster.states.xixinide_loop2.start(xixinide_loop2)
    xixinide_loop2.base.start(xixinide_loop2)
    cast_missile3(monster.npc, nil, nil, nil, 201038012703)
  end
  
  function monster.states.xixinide_loop2.finish(xixinide_loop2)
    xixinide_loop2.base.finish(xixinide_loop2)
    remove_missile_by_id(201038012703)
  end
  
  function monster.states.jijinide.start(jijinide)
    jijinide.base.start(jijinide)
    char_visible(true)
    remove_missile_by_id(201038012602, monster.npc, true)
    remove_missile_by_id(201038012506, monster.npc, true)
    remove_missile_by_id(201038013201, monster.npc, true)
    remove_missile_by_id(201038013202, monster.npc, true)
    
    local function boom()
      set_effect_end_anim_idx(monster.npc, "Fx_M201038_exskill_1_2", 1)
      remove_missile_by_id(201038012603, monster.npc, true)
    end
    
    local function visible()
      char_visible(false)
    end
    
    monster.doAfter(monster, boom, 0.3)
    monster.doAfter(monster, visible, 2.7)
  end
  
  function monster.states.jijinide.finish(jijinide)
    jijinide.base.finish(jijinide)
  end
  
  function monster.states.xixinide_end.start(xixinide_end)
    xixinide_end.base.start(xixinide_end)
    remove_missile_by_id(201038012602, monster.npc, true)
    remove_missile_by_id(201038012603, monster.npc, true)
    set_all_npc_hp_visible(true, true)
    remove_missile_by_id(201038012704, monster.npc, true)
  end
  
  function monster.states.xixinide_end.finish(xixinide_end)
    xixinide_end.base.finish(xixinide_end)
  end
  
  function monster.states.close8.start(close8)
    monster:disableXray()
    set_all_npc_hp_visible(false, true)
    set_camera(10004, true)
    set_can_searched(monster.npc, false)
  end
  
  function monster.states.close8.finish(close8)
    set_camera(10003, true)
    set_all_npc_hp_visible(true, true)
    set_can_searched(monster.npc, true)
    monster:xRay()
  end
end

function monster.on_start(monster)
  monster:xRay()
  change_follow_target_new(1, monster.npc, {
    6,
    12,
    {
      x = 0,
      y = -5,
      z = -1.8
    },
    1,
    0.6
  })
end

function monster.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  monster.base.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  if 20103801001 == magic_id then
    monster.stone_now_time = get_npc_time(monster.npc)
  end
  if 20103801221 == magic_id then
    local role = target:get_behavior()
    if not role or not role:isInControl() then
      return
    end
    
    function monster.states.jijinide.isReady(jijinide)
      return true
    end
    
    function monster.states.xixinide_end.isReady(xixinide_end)
      return false
    end
    
    monster.tool.roleFaint(target, 6, 6)
    monster.tree:derive(monster.states.jijinide)
  end
end

function monster.on_self_magic_end(monster, target, magic_id, magic_kind, magic_type, is_break)
  monster.base.on_self_magic_end(monster, target, magic_id, magic_kind, magic_type, is_break)
  if 20103801221 == magic_id then
    function monster.states.jijinide.isReady(jijinide)
      return false
    end
    
    function monster.states.xixinide_end.isReady(xixinide_end)
      return true
    end
  end
end

function monster.after_damage(monster, caster, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skillId, missile)
  if target == monster.part_l_npc then
    local cur_hp = get_npc_attr(monster.part_l_npc, 1)
    local l_hand_hp_max = get_npc_attr(monster.part_l_npc, 4)
    if cur_hp / l_hand_hp_max <= 0 then
      abort_skill(monster.npc)
      cast_magic(monster.npc, monster.npc, 20103801052, 0)
      remove_npc(monster.part_l_npc)
      monster.HaveLeftHand = false
      monster.tree:transState(monster.states.close3)
      enable_part_damage(monster.npc, 1, false)
    end
  end
  if target == monster.part_r_npc then
    local cur_hp = get_npc_attr(monster.part_r_npc, 1)
    local R_hand_hp_max = get_npc_attr(monster.part_r_npc, 4)
    if cur_hp / R_hand_hp_max <= 0 then
      abort_skill(monster.npc)
      cast_magic(monster.npc, monster.npc, 20103801053, 0)
      remove_npc(monster.part_r_npc)
      monster.HaveRightHand = false
      monster.tree:transState(monster.states.close4)
      enable_part_damage(monster.npc, 2, false)
    end
  end
end

function monster.on_skill_begin(monster, npc, skill_id)
  if 100101514 == skill_id then
    local function focus()
      cast_magic(monster.npc, npc, 20103801215)
      
      cast_magic(monster.npc, monster.npc, 20103801214)
    end
    
    monster:doAfter(focus)
  end
end

function monster.before_damage_target(monster, target, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  if 2010380129 == skill_id then
    monster.tool.roleFaintFinish(target)
    remove_missile_by_id(201038012704, monster.npc, true)
  end
end

return monster
