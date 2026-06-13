local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.teletportposx = 0
  monster.teletportposz = 0
  monster.wander = {
    minDis = 0,
    maxDis = 999,
    minTime = 3.5,
    maxTime = 3.5
  }
  monster.AllowSpecialskill = false
  monster.Iswander = false
  monster.specialattackcount = 0
  monster.centerposX, monster.centerposY, monster.centerposZ = get_area_pos("O0")
  monster.AllowCastNormal = false
  monster.phase = 1
  monster.pointneedx = 0
  monster.pointneedz = 0
  monster.knifepos = {}
  monster.linepos = {}
  monster.knife = nil
  if get_tower_id() == 220503 or get_tower_id() == 220504 or get_tower_id() == 220505 then
    monster.hard = true
  end
  print("monster.hard", monster.hard)
  local skills = {
    JumpSlashStart = {
      30010050202,
      20,
      0,
      0,
      999
    },
    JumpSlashMiddle = {
      30010050203,
      0,
      0
    },
    JumpSlashEnd = {
      30010050204,
      0,
      0
    },
    BackThrow = {
      30010050205,
      10,
      0,
      0,
      8
    },
    TP = {
      30010050206,
      0,
      0
    },
    KickThrow = {
      30010050207,
      0,
      0,
      0,
      3,
      -90,
      90,
      nil,
      5
    },
    DashSlash2 = {
      30010050201,
      10,
      0,
      6,
      10
    },
    UltSkill1 = {
      30010050209,
      60,
      0,
      0,
      999
    },
    UltSkill2 = {
      30010050210,
      10,
      0,
      0,
      999
    },
    JumpHit = {
      30010050212,
      10,
      0,
      2,
      999
    },
    UltSkill1Loop = {
      30010050213,
      0,
      0,
      0,
      999
    },
    UltSkill1End = {
      30010050214,
      0,
      0,
      0,
      999
    },
    SpinSlash2 = {
      30010050215,
      0,
      0,
      0,
      999
    },
    SpinSlash3 = {
      30010050216,
      0,
      0,
      0,
      999
    },
    evade_skill = {
      30010050217,
      13,
      0
    },
    JumpSlashMiddleToEnd = {
      30010050218,
      0,
      0
    },
    ultSkillPre = {
      30010050235,
      0,
      0
    },
    ultSkillPre2 = {
      30010050236,
      0,
      0
    },
    JumpThrow = {
      30010050208,
      0,
      0,
      0,
      4
    },
    SpinSlash1 = {
      30010050211,
      0,
      0,
      0,
      999
    },
    DashSlash = {
      30010050201,
      0,
      0,
      6,
      10
    },
    KickThrowSP = {
      30010050207,
      0,
      0,
      0,
      3,
      -90,
      90,
      nil,
      5
    },
    JumpHit1 = {
      30010050220,
      0,
      0,
      0,
      999
    },
    DashSlash1 = {
      30010050221,
      0,
      0,
      0,
      999
    },
    KickThrow1 = {
      30010050222,
      0,
      0,
      0,
      999
    },
    JumpThrow1 = {
      30010050223,
      0,
      0,
      0,
      999
    },
    JumpSlashStart1 = {
      30010050224,
      60,
      0,
      0,
      999
    },
    SpinSlash11 = {
      30010050225,
      5,
      0,
      0,
      999
    },
    BackThrow3 = {
      30010050226,
      0,
      0,
      0,
      999
    },
    TP1 = {
      30010050227,
      0,
      0
    },
    TP2 = {
      30010050228,
      0,
      0
    },
    TP3 = {
      30010050229,
      0,
      0
    },
    TP4 = {
      30010050230,
      0,
      0
    },
    TP5 = {
      30010050231,
      0,
      0
    },
    TP6 = {
      30010050232,
      0,
      0
    },
    TP7 = {
      30010050233,
      0,
      0
    },
    TP8 = {
      30010050234,
      15,
      0
    },
    TP9 = {
      30010050237,
      0,
      0
    }
  }
  local nodes = {
    "close1",
    "middle1",
    "far1",
    "attackforphase2",
    "AllDistance",
    "attackforphase1",
    "specialattack"
  }
  monstBase._init(monster, skills, nil, nodes)
  local states = monster.states
  local skills = monster.skills
  cast_magic(monster.npc, monster.npc, 30010050414)
  if not monster.hard then
    local _ENV = monster.states
    _ENV.JumpHit.cd = 13
    _ENV.JumpSlashStart.cd = 23
    _ENV.BackThrow.cd = 13
    _ENV.DashSlash2.cd = 13
  end
  if monster.hard then
    local _ENV = states
    _ENV.active(_ENV.daze, _ENV.gotTarget, _ENV.noTarget, _ENV.TP7, _ENV.TP8)
    _ENV.gotTarget(_ENV.specialattack, _ENV.attack, _ENV.wander)
    _ENV.evade(_ENV.evade_skill)
    _ENV.attack(_ENV.freeAtk)
    _ENV.freeAtk(_ENV.attackforphase2, _ENV.attackforphase1)
    _ENV.attackforphase1(_ENV.JumpHit, _ENV.JumpSlashStart, _ENV.BackThrow, _ENV.DashSlash2(_ENV.KickThrow))
    _ENV.attackforphase2(_ENV.AllDistance(_ENV.TP6(_ENV.UltSkill1), _ENV.TP1(_ENV.JumpHit1(_ENV.TP2(_ENV.DashSlash1((_ENV.BackThrow3(_ENV.JumpSlashStart1)))))), _ENV.TP3(_ENV.SpinSlash2(_ENV.TP4(_ENV.KickThrow1(_ENV.TP5(_ENV.JumpThrow1(_ENV.TP9(_ENV.ultSkillPre2(_ENV.UltSkill2))))))))))
    _ENV.specialattack(_ENV.JumpThrow, _ENV.far1(_ENV.DashSlash(_ENV.KickThrowSP), _ENV.SpinSlash1))
  else
    local _ENV = states
    _ENV.active(_ENV.daze, _ENV.gotTarget, _ENV.noTarget, _ENV.TP7, _ENV.TP8)
    _ENV.gotTarget(_ENV.specialattack, _ENV.attack, _ENV.wander)
    _ENV.evade(_ENV.evade_skill)
    _ENV.attack(_ENV.freeAtk)
    _ENV.freeAtk(_ENV.attackforphase2, _ENV.attackforphase1)
    _ENV.attackforphase1(_ENV.JumpHit, _ENV.JumpSlashStart, _ENV.BackThrow, _ENV.DashSlash2)
    _ENV.attackforphase2(_ENV.AllDistance(_ENV.TP6(_ENV.UltSkill1), _ENV.TP1(_ENV.JumpHit1(_ENV.TP2(_ENV.DashSlash1((_ENV.BackThrow3(_ENV.JumpSlashStart1)))))), _ENV.TP3(_ENV.SpinSlash2(_ENV.TP4(_ENV.KickThrow1(_ENV.TP5(_ENV.JumpThrow1(_ENV.TP9(_ENV.ultSkillPre2(_ENV.UltSkill2))))))))))
    _ENV.specialattack(_ENV.JumpThrow, _ENV.far1(_ENV.SpinSlash1))
  end
  do
    local wanderMove = states.wanderMove
    local surround = states.surround
    local wander = states.wander
    wanderMove(surround)
    
    function wander.tickTrans(wander)
      if monster.AllowSpecialskill == true and monster.tree:chooseChildAction(wander.monster.states.specialattack) then
        return wander.monster.states.TP8
      end
      return monster.tree:chooseChildAction(wander.monster.states.attack)
    end
    
    function wander.start(wander)
      wander.base.start(wander)
      cast_magic(wander.monster.npc, wander.monster.npc, 30010050206, 1)
    end
  end
  do
    local specialattack = states.specialattack
    
    function specialattack.isReady(specialattack)
      if monster.AllowSpecialskill == false and false == monster.AllowSpecialskill2 then
        return false
      elseif monster.AllowSpecialskill == false and monster.AllowSpecialskill2 == true then
        return true
      elseif monster.AllowSpecialskill == true then
        return true
      end
    end
    
    function specialattack.start(specialattack)
      monster.AllowSpecialskill = false
      specialattack.base.start(specialattack)
      monster.specialattackcount = monster.specialattackcount + 1
    end
    
    function specialattack.finTrans(specialattack)
      return monster.states.active
    end
  end
  
  function states.active.start(active)
    active.base.start(active)
    change_follow_target(3, monster.npc, {
      6,
      8,
      {
        x = 0,
        y = 0,
        z = 0
      },
      1,
      0.6
    })
  end
  
  states.stun.EnterTime = 0
  states.stun.HitInterval = 3
  
  function states.stun.start(stun)
    stun.EnterTime = get_npc_time(states.stun.monster.npc)
    cast_magic(monster.npc, monster.npc, 30010050204)
  end
  
  states.stun.faint = states.faint
  
  function states.stun.tickTrans(stun)
    if stun.faint:isReady() then
      return stun.faint
    end
    if get_npc_time(states.stun.monster.npc) >= states.stun.EnterTime + states.stun.HitInterval then
      return states.TP7
    end
  end
  
  function states.faint.start(faint)
    faint.base.start(faint)
    if check_magic(monster.npc, 30010050203) then
      abort_magic_by_id(monster.npc, 30010050203, 99)
    end
  end
  
  function states.JumpHit.isReady(JumpHit)
    local monster = JumpHit.monster
    local tool = monster.tool
    local randCheck = tool.randByTime(monster, 0.25)
    local baseCheck = JumpHit.base.isReady(JumpHit)
    return randCheck and baseCheck
  end
  
  states.attack.timer = 0
  states.attack.interval = 0
  states.evade_skill.count = 0
  
  function states.attackforphase1.isReady(attackforphase1)
    if not attackforphase1.base.isReady(attackforphase1) then
      return false
    end
    if 1 == monster.phase or monster.AllowCastNormal == true then
      return true
    end
    if 2 == monster.phase then
      return false
    end
  end
  
  function states.attackforphase2.isReady(attackforphase2)
    if not attackforphase2.base.isReady(attackforphase2) then
      return false
    end
    local HpMax = get_npc_attr(attackforphase2.monster.npc, 4)
    local current_hp = get_npc_attr(attackforphase2.monster.npc, 1)
    if 1 ~= monster.phase then
      if current_hp <= HpMax * 0.2 then
        return true
      end
      if 1 == monster.phase or monster.AllowCastNormal == true then
        return false
      end
      return true
    end
  end
  
  function states.attackforphase2.start(attackforphase2)
    if check_magic(attackforphase2.monster.npc, 30010050230) == false then
      cast_magic(attackforphase2.monster.npc, attackforphase2.monster.npc, 30010050230, 1)
      abort_magic_by_id(attackforphase2.monster.npc, 30010050229, 1)
    end
    attackforphase2.base.start(attackforphase2)
  end
  
  function states.JumpThrow.isReady(JumpThrow)
    local monster = JumpThrow.monster
    local tool = monster.tool
    local randCheck = tool.randByTime(monster, 0.5)
    local baseCheck = JumpThrow.base.isReady(JumpThrow)
    return randCheck and baseCheck
  end
  
  function states.JumpThrow.start(JumpThrow)
    if get_npc_time(monster.npc) < monster.skills.DashSlash.timer and get_npc_time(monster.npc) < monster.skills.SpinSlash1.timer then
      set_keyframe_enable(JumpThrow.monster.npc, 3001005020810, false, true)
      set_keyframe_enable(JumpThrow.monster.npc, 3001005020809, false, true)
    end
    JumpThrow.transstate = nil
    JumpThrow.base.start(JumpThrow)
  end
  
  function states.JumpThrow.finish(JumpThrow)
    set_keyframe_enable(JumpThrow.monster.npc, 3001005020809, true, true)
    set_keyframe_enable(JumpThrow.monster.npc, 3001005020810, true, true)
  end
  
  function states.SpinSlash1.isReady(SpinSlash1)
    local monster = SpinSlash1.monster
    local tool = monster.tool
    local randCheck = tool.randByTime(monster, 0.5)
    local baseCheck = SpinSlash1.base.isReady(SpinSlash1)
    return randCheck and baseCheck
  end
  
  function states.SpinSlash1.finish(SpinSlash1)
    abort_magic_by_id(monster.npc, 2020470103, 1)
    abort_magic_by_id(monster.npc, 2020470104, 1)
  end
  
  function states.SpinSlash2.finish(SpinSlash2)
    abort_magic_by_id(monster.npc, 2020470103, 1)
    abort_magic_by_id(monster.npc, 2020470104, 1)
  end
  
  do
    local SpinSlash1 = monster.skills.SpinSlash1
    local SpinSlash2 = monster.skills.SpinSlash2
    local SpinSlash3 = monster.skills.SpinSlash3
    SpinSlash1(SpinSlash2(SpinSlash3))
  end
  do
    local SpinSlash11 = monster.skills.SpinSlash11
    local SpinSlash2 = monster.skills.SpinSlash2
    local SpinSlash3 = monster.skills.SpinSlash3
    SpinSlash11(SpinSlash2(SpinSlash3))
  end
  do
    local UltSkill1 = monster.skills.UltSkill1
    local UltSkill1Loop = monster.skills.UltSkill1Loop
    local UltSkill1End = monster.skills.UltSkill1End
    UltSkill1(UltSkill1Loop(UltSkill1End))
    
    function states.UltSkill1.start(UltSkill1)
      change_follow_target(1, UltSkill1.monster.npc, {
        0,
        0,
        {
          0,
          0,
          monster.pointneedz
        },
        0,
        0,
        0.55
      })
      cast_magic(UltSkill1.monster.npc, UltSkill1.monster.npc, 2020470201, 1)
      UltSkill1.base.start(UltSkill1)
    end
    
    function states.UltSkill1.finish(UltSkill1)
      abort_magic_by_id(monster.target, 30010050224, 1)
      local player = get_come_on_hero()
      change_follow_target(4)
      UltSkill1.base.finish(UltSkill1)
    end
  end
  do
    local JumpSlashStart = monster.skills.JumpSlashStart
    local JumpSlashMiddle = monster.skills.JumpSlashMiddle
    local JumpSlashEnd = monster.skills.JumpSlashEnd
    local JumpSlashMiddleToEnd = monster.skills.JumpSlashMiddleToEnd
    JumpSlashMiddle.count = 0
    JumpSlashStart(JumpSlashMiddle(JumpSlashMiddle, JumpSlashMiddleToEnd(JumpSlashEnd)))
    
    function skills.JumpSlashMiddle.isReady(JumpSlashMiddle)
      if not JumpSlashMiddle.base.isReady(JumpSlashMiddle) then
        return false
      end
      if 2 == JumpSlashMiddle.count then
        return false
      end
      return true
    end
    
    function skills.JumpSlashMiddle.onBegin(JumpSlashMiddle)
      JumpSlashMiddle.count = JumpSlashMiddle.count + 1
    end
    
    skills.JumpSlashStart.JumpSlashMiddle = JumpSlashMiddle
    
    function skills.JumpSlashStart.onBegin(JumpSlashStart)
      JumpSlashStart.JumpSlashMiddle.count = 0
    end
  end
  do
    local JumpSlashStart1 = monster.skills.JumpSlashStart1
    local JumpSlashMiddle = monster.skills.JumpSlashMiddle
    local JumpSlashEnd = monster.skills.JumpSlashEnd
    local JumpSlashMiddleToEnd = monster.skills.JumpSlashMiddleToEnd
    JumpSlashMiddle.count = 0
    JumpSlashStart1(JumpSlashMiddle(JumpSlashMiddle, JumpSlashMiddleToEnd(JumpSlashEnd)))
    
    function skills.JumpSlashMiddle.isReady(JumpSlashMiddle)
      if not JumpSlashMiddle.base.isReady(JumpSlashMiddle) then
        return false
      end
      if 2 == JumpSlashMiddle.count then
        return false
      end
      return true
    end
    
    function skills.JumpSlashMiddle.onBegin(JumpSlashMiddle)
      JumpSlashMiddle.count = JumpSlashMiddle.count + 1
    end
    
    skills.JumpSlashStart1.JumpSlashMiddle = JumpSlashMiddle
    
    function skills.JumpSlashStart1.onBegin(JumpSlashStart1)
      JumpSlashStart1.JumpSlashMiddle.count = 0
    end
  end
  
  function states.KickThrow.isReady(KickThrow)
    local monster = KickThrow.monster
    local tool = monster.tool
    local randCheck = tool.randByTime(monster, 0.6)
    local baseCheck = KickThrow.base.isReady(KickThrow)
    return randCheck and baseCheck
  end
  
  function states.TP1.isReady(TP1)
    if get_npc_time(monster.npc) >= monster.skills.JumpSlashStart1.timer then
      return true
    else
      return false
    end
  end
  
  function states.TP3.isReady(TP3)
    if get_npc_time(monster.npc) >= monster.skills.UltSkill2.timer then
      return true
    else
      return false
    end
  end
  
  function states.TP6.isReady(TP6)
    return TP6.base.isReady(TP6) and TP6.monster.states.UltSkill1:isReady()
  end
  
  function states.TP6.start(TP6)
    cast_magic(monster.npc, monster.target, 30010050224, 1)
    TP6.base.start(TP6)
  end
  
  function states.TP6.finish(TP6)
    abort_magic_by_id(monster.npc, 30010050203, 1)
  end
  
  function states.TP7.start(TP7)
    change_follow_target(1, monster.npc, {
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
    local player = get_come_on_hero()
    TP7.base.start(TP7)
  end
  
  function states.TP7.finish(TP7)
    abort_magic_by_id(monster.npc, 30010050203, 1)
  end
  
  function states.TP7.finTrans(TP7)
    return states.gotTarget
  end
  
  function states.TP8.isReady(TP8)
    print("monster.AllowSpecialskill", monster.AllowSpecialskill)
    if monster.AllowSpecialskill == false then
      return false
    else
      return true
    end
  end
  
  function states.TP8.start(TP8)
    change_follow_target(1, monster.npc, {
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
    local player = get_come_on_hero()
    TP8.base.start(TP8)
    monster:doAfter(function(monster)
      cast_magic(TP8.monster.npc, player, 201025030809, 1)
      cast_magic(TP8.monster.npc, player, 201025030810, 1)
    end, 0.2)
  end
  
  function states.TP8.finish(TP8)
    abort_magic_by_id(monster.npc, 30010050203, 1)
  end
  
  function states.TP8.finTrans(TP8)
    if monster.tree:chooseChildAction(TP8.monster.states.specialattack) ~= nil then
      cast_magic(monster.npc, monster.npc, 30010050207, 1)
      cast_magic(monster.npc, monster.npc, 30010050208, 1)
      return monster.tree:chooseChildAction(TP8.monster.states.specialattack)
    else
      return states.wander
    end
  end
  
  do
    local ultSkillPre2 = monster.skills.ultSkillPre2
    local UltSkill2 = monster.skills.UltSkill2
    
    function skills.UltSkill2.onBegin(UltSkill2)
      cast_magic(monster.npc, monster.target, 30010050225, 1)
      monster:CalculateCameraFoucusPoint()
      change_follow_target(1, monster.npc, {
        0,
        0,
        {
          0,
          0,
          monster.pointneedz
        },
        0,
        0,
        0.55
      })
    end
    
    function skills.UltSkill2.onEnd(UltSkill2)
      abort_magic_by_id(monster.target, 30010050225, 1)
      UltSkill2.base.onEnd(UltSkill2)
      local player = get_come_on_hero()
      change_follow_target(4)
      monster.AllowCastNormal = true
      monster.AllowSpecialskill2 = true
    end
  end
end

function monster.on_start(monster)
  change_follow_target(3, monster.npc, {
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
  set_npc_phase_number(monster.npc, 2)
  print(get_cur_camera_id())
end

function monster.on_self_npc_hp_zero(monster)
  if 2 == monster.phase then
    monster.base.on_self_npc_hp_zero(monster)
    switch_bgm_block("bgm_chapter5_Boss", 3)
  end
  if 1 == monster.phase then
    monster.phase = 2
    change_npc_phase_state(monster.npc, 2, false)
    cast_magic(monster.npc, monster.npc, 20103101061)
    monster.tree:transState(monster.states.attackforphase2)
    remove_missile_by_id(3001005021901)
    remove_missile_by_id(3001005021904)
    remove_missile_by_id(3001005020306)
    remove_missile_by_id(3001005021805)
    switch_bgm_block("bgm_chapter5_Boss", 2)
    monster.knife = nil
    monster.linepos = {}
  end
end

function monster.on_missile_begin_pos(monster, owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= monster.npc then
    return
  end
  if missile_cfg.Id == 3001005021901 or missile_cfg.Id == 3001005020306 or missile_cfg.Id == 3001005021805 then
    if monster.knife ~= nil then
      local param = {
        npc = monster.npc,
        posx = get_missile_pos(monster.knife).x,
        posz = get_missile_pos(monster.knife).z,
        missile_id = 3001005021904,
        missile_level = 1,
        lookat_posx = get_missile_pos(monster.knife).x,
        lookat_posz = get_missile_pos(monster.knife).z,
        lookat_posy = monster.knife.v_born_pos.y,
        born_posx = (pos_x + get_missile_pos(monster.knife).x) / 2,
        born_posz = (pos_z + get_missile_pos(monster.knife).z) / 2
      }
      cast_missile2(param)
      local temp = {
        x = param.born_posx,
        z = param.born_posz,
        m1 = monster.knife,
        m2 = missile
      }
      table.insert(monster.linepos, temp)
      monster.knife = nil
    else
      monster.knife = missile
    end
  end
  if missile_cfg.Id == 3001005021904 then
    for key, temp in pairs(monster.linepos) do
      if monster.isSame(temp, pos_x, pos_z) then
        missile.d_m1 = temp.m1
        missile.d_m2 = temp.m2
        monster.linepos[key] = nil
      end
    end
  end
end

function monster.isSame(temp, pos_x, pos_z)
  if math.abs(temp.x - pos_x) > 0.01 then
    return false
  end
  if math.abs(temp.z - pos_z) > 0.01 then
    return false
  end
  return true
end

function monster.after_damage(monster, npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  local states = monster.states
  if npc == get_come_on_hero() and target == monster.npc and monster.states.wander:isRunning() == true and monster.AllowSpecialskill == false then
    monster.AllowSpecialskill = true
  end
end

function monster.on_skill_hit(monster, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc == monster.npc then
    if 1 ~= get_role_kind(hit_target) then
      return
    end
    if missile_cfg.Id == 3001005021904 then
      local missileEnd = missile.d_m1
      local missileStart = missile.d_m2
      stop_missile(missile)
      local param = {
        npc = monster.npc,
        posx = get_missile_pos(missileEnd).x,
        posz = get_missile_pos(missileEnd).z,
        missile_id = 3001005021902,
        missile_level = 1,
        lookat_posx = get_missile_pos(missileEnd).x,
        lookat_posz = get_missile_pos(missileEnd).z,
        lookat_posy = missile.d_m2.v_born_pos.y,
        born_posx = (get_missile_pos(missileStart).x + get_missile_pos(missileEnd).x) / 2,
        born_posz = (get_missile_pos(missileStart).z + get_missile_pos(missileEnd).z) / 2
      }
      cast_missile2(param)
      param.missile_id = 3001005021907
      cast_missile2(param)
      monster:doAfter(function(monster)
        stop_missile(missileEnd)
        stop_missile(missileStart)
      end, 0.5)
    end
  end
end

function monster.before_damage_self(monster, caster, magic_id, damage_sign, damage_type, camp, change_grading, magic_level, skill_id, missile)
  monster.base.before_damage_self(monster, caster, magic_id, damage_sign, damage_type, camp, change_grading, magic_level, skill_id, missile)
  if 1 == change_grading or 2 == change_grading or 3 == change_grading or 4 == change_grading or 5 == change_grading or 0 == change_grading then
    abort_magic_by_id(monster.npc, 30010050203, 1)
    cast_magic(monster.npc, monster.npc, 30010050204)
  end
end

function monster.on_element_aborn_start(monster, npc, element, skill_id)
  if npc == monster.npc and nil ~= skill_id then
    abort_magic_by_id(monster.npc, 30010050203, 1)
    cast_magic(monster.npc, monster.npc, 30010050204)
  end
end

function monster.teleport(monster, r)
  local states = monster.states
  local randompoint = math.random(0, 360)
  local target_pos = get_npc_pos(get_come_on_hero())
  monster.teletportposx = target_pos.x + r * math.cos(randompoint)
  monster.teletportposz = target_pos.z + r * math.sin(randompoint)
  monster.teletportposy = target_pos.y
  local posX = target_pos.x + r * math.cos(randompoint)
  local posZ = target_pos.z + r * math.sin(randompoint)
  local posY = target_pos.y
  return posX, posZ, posY
end

function monster.teleport1(monster, r)
  local states = monster.states
  local randompoint = math.random(0, 360)
  monster.teletportposx = monster.centerposX + r * math.cos(randompoint)
  monster.teletportposz = monster.centerposZ + r * math.sin(randompoint)
  monster.teletportposY = monster.centerposY
  local posX = monster.centerposX + r * math.cos(randompoint)
  local posZ = monster.centerposZ + r * math.sin(randompoint)
  local posY = monster.teletportposY
  return posX, posZ, posY
end

function monster.on_target_self_magic_begin(monster, caster, magic_id)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id)
  local states = monster.states
  if 30010050201 == magic_id then
    if monster.tree:curState() == states.JumpThrow then
      monster.teleport_target = monster.target
      monster:teleport(7)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
      monster:doAfter(function(monster)
        local states = monster.states
        monster.tree:transState(states.far1)
      end, 0.2)
    end
    if monster.tree:curState() == states.UltSkill1 then
      monster.teleport_target = monster.target
      monster:teleport(4)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.JumpSlashStart then
      monster.teleport_target = monster.target
      monster:teleport(1)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.JumpSlashStart1 then
      monster.teleport_target = monster.target
      monster:teleport(1)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.TP1 then
      monster.teleport_target = monster.target
      monster:teleport(5)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.TP2 then
      monster.teleport_target = monster.target
      monster:teleport(7)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.TP3 then
      monster.teleport_target = monster.target
      monster:teleport(7)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.TP4 then
      monster.teleport_target = monster.target
      monster:teleport(2)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.TP5 then
      monster.teleport_target = monster.target
      monster:teleport(3)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.TP6 then
      flash_to_pos(monster.npc, monster.centerposX, monster.centerposZ, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.TP7 then
      flash_to_pos(monster.npc, monster.centerposX, monster.centerposZ, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.TP8 then
      monster:teleport1(4)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.TP9 then
      flash_to_pos(monster.npc, monster.centerposX, monster.centerposZ, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
    if monster.tree:curState() == states.UltSkill2 then
      monster.teleport_target = monster.target
      monster:teleport(6)
      flash_to_pos(monster.npc, monster.teletportposx, monster.teletportposz, monster.teletportposy)
      lookat_npc(monster.npc, get_come_on_hero(), true)
    end
  end
  if 30010050202 == magic_id then
    local param1 = {
      npc = monster.npc,
      posx = get_npc_pos(monster.npc).x,
      posz = get_npc_pos(monster.npc).z,
      missile_id = 3001005021901,
      missile_level = 1,
      lookat_posx = get_npc_pos(monster.npc).x,
      lookat_posz = get_npc_pos(monster.npc).z,
      lookat_posy = get_npc_pos(monster.npc).y,
      posy = get_npc_pos(monster.npc).y,
      born_posx = get_npc_pos(monster.npc).x,
      born_posz = get_npc_pos(monster.npc).z,
      born_posy = get_npc_pos(monster.npc).y
    }
    cast_missile2(param1)
  end
  if 30010050204 == magic_id then
    abort_magic_by_id(monster.npc, 30010050203, 1)
  end
  if 30010050237 == magic_id then
    abort_magic_by_id(monster.npc, 2020470201, 1)
  end
end

function monster.CalculateCameraFoucusPoint(monster)
  local playerpoint = get_npc_pos(get_come_on_hero())
  local selfpoint = get_npc_pos(monster.npc)
  monster.pointneedx = selfpoint.x - playerpoint.x
  monster.pointneedz = selfpoint.z - playerpoint.z
  return monster.pointneedx, monster.pointneedz
end

function monster.on_self_magic_end(monster, target, magic_id)
  monster.base.on_self_magic_end(monster, target, magic_id)
  if 30010050205 == magic_id then
    cast_magic(monster.npc, monster.npc, 30010050207, 1)
    cast_magic(monster.npc, monster.npc, 30010050208, 1)
  end
end

function monster.on_skill_break(monster, npc, skill_id)
  if npc == monster.npc then
    abort_magic_by_id(monster.npc, 2020470103, 1)
    abort_magic_by_id(monster.npc, 2020470104, 1)
  end
end

return monster
