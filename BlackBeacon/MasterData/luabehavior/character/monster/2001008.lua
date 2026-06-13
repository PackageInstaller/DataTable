local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.2,
    maxDis = 5,
    minTime = 0.8,
    maxTime = 2,
    type = "walk"
  }
  monster.search = {minDis = 200, maxDis = 200}
  local skills = {
    Atk1_1 = {
      2010250111,
      0,
      0,
      0,
      6,
      -90,
      90
    },
    Atk1_2 = {
      2010250112,
      0,
      0,
      0,
      10
    },
    Atk1_3 = {
      2010250113,
      0,
      0,
      0,
      5
    },
    TripleAtk = {
      2010250118,
      0,
      0,
      0,
      6,
      -90,
      90
    },
    Atk3_1 = {
      2010250132,
      0,
      0,
      0,
      5,
      -90,
      90
    },
    Atk3_2 = {
      2010250123,
      12,
      0,
      0,
      7,
      -90,
      90
    },
    Blink1 = {
      2010250124,
      0,
      0,
      0,
      10
    },
    Hit1 = {
      2010250125,
      0,
      0,
      0,
      80
    },
    Blink2 = {
      "Blink1",
      0,
      0,
      0,
      80
    },
    Hit2 = {
      2010250128,
      0,
      0,
      0,
      80
    },
    dashOut = {
      2010250115,
      0,
      0,
      0,
      80
    },
    Blink3 = {
      "Blink1",
      0,
      0,
      0,
      80
    },
    Hit3 = {
      2010250104,
      25 + 5 * math.random(),
      10,
      0,
      80
    },
    dashOutHit = {
      2010250116,
      0,
      5,
      0,
      80
    },
    JumpOut = {
      "dashOutHit",
      16,
      5,
      2,
      12
    },
    Dart1 = {
      2010250114,
      15,
      0,
      0,
      80
    },
    Dart2 = {
      "Dart1",
      15,
      0,
      0,
      80
    },
    Jump = {
      "Blink1",
      10,
      0,
      0,
      80
    },
    JumpHit1 = {
      2010250109,
      10,
      0,
      0,
      80
    },
    GetBack = {
      2010250121,
      0,
      0,
      0,
      10
    },
    punish = {
      2010250105,
      30,
      5,
      0,
      80
    },
    GotHit1 = {
      2010250135,
      0,
      0,
      0,
      80
    },
    GotHit2 = {
      2010250136,
      0,
      0,
      0,
      80
    }
  }
  local nodes = {
    "NormalATK",
    "Blink_ATK",
    "JumpATK",
    "dodge",
    "interrupt",
    "dodgeATK"
  }
  monstBase._init(monster, skills, nil, nodes)
  monster.states.attack.interval = 0.5
  monster.states.active.ChangeState = true
  monster.redskillnum = 0
  cast_magic(monster.npc, monster.npc, 20102501931)
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.wander, _ENV.dodge)
    _ENV.freeAtk(_ENV.Blink_ATK, _ENV.JumpATK, _ENV.NormalATK, _ENV.GotHit1, _ENV.GotHit2)
    _ENV.NormalATK(_ENV.Atk1_1(_ENV.Atk1_2(_ENV.Atk1_3)), _ENV.TripleAtk, _ENV.Atk3_1(_ENV.Atk3_2))
    _ENV.dodge(_ENV.GetBack(_ENV.punish(_ENV.GotHit2, _ENV.Blink2)))
    _ENV.Blink_ATK(_ENV.Blink1)
    _ENV.Blink1(_ENV.Hit1)
    _ENV.Hit1(_ENV.GotHit2, _ENV.Blink2)
    _ENV.Blink2(_ENV.Hit2)
    _ENV.Hit2(_ENV.GotHit1, _ENV.dashOut, _ENV.dashOutHit)
    _ENV.dashOut(_ENV.Blink3(_ENV.Hit3))
    _ENV.dashOutHit(_ENV.Blink3(_ENV.Hit3))
    _ENV.GotHit2(_ENV.Blink2)
    _ENV.GotHit1(_ENV.dashOut, _ENV.dashOutHit)
    _ENV.dashOutHit(_ENV.Blink3(_ENV.Hit3))
    _ENV.JumpATK(_ENV.JumpOut(_ENV.Dart1(_ENV.Dart2(_ENV.Jump(_ENV.JumpHit1(_ENV.Atk3_2))))))
  end
  
  function monster.states.wander.start(wander)
    wander.base.start(wander)
    replace_ragdoll_power_profile(monster.npc, 1)
  end
  
  function monster.states.wander.finish(wander)
    replace_ragdoll_power_profile(monster.npc, 0)
    wander.base.finish(wander)
  end
  
  do
    local Blink1 = monster.states.Blink1
    local Hit1 = monster.states.Hit1
    local Blink2 = monster.states.Blink2
    local Hit2 = monster.states.Hit2
    local Blink3 = monster.states.Blink3
    local Hit3 = monster.states.Hit3
    local JumpHit1 = monster.states.JumpHit1
    local Blink1Skill = monster.skills.Blink1
    
    function Blink1Skill.onEnd(Blink1Skill)
      monster:falsh(get_come_on_hero())
      Blink1Skill.base.onEnd(Blink1Skill)
    end
    
    function Blink1.start(Blink1)
      set_tough_bar_protect_state(monster.npc, 1)
      enable_shadow(Blink1.monster.npc, false)
      Blink1.base.start(Blink1)
    end
    
    function Hit1.start(Hit1)
      enable_shadow(Hit1.monster.npc, true)
      Hit1.base.start(Hit1)
    end
    
    function Blink2.start(Blink2)
      enable_shadow(Blink2.monster.npc, false)
      Blink2.base.start(Blink2)
    end
    
    function Hit2.start(Hit2)
      enable_shadow(Hit2.monster.npc, true)
      Hit2.base.start(Hit2)
    end
    
    function Blink3.start(Blink3)
      enable_shadow(Blink3.monster.npc, false)
      Blink3.base.start(Blink3)
    end
    
    function Hit3.start(Hit3)
      local npc = Hit3.monster.npc
      enable_shadow(Hit3.monster.npc, true)
      if not get_sync_var("is_friendly") then
        cast_magic(npc, npc, 20102501920, 1)
        cast_magic(npc, npc, 20102501970, 1)
        cast_magic(npc, npc, 20102501921, 1)
      end
      Hit3.base.start(Hit3)
    end
    
    function Hit3.finish()
      Hit3.base.finish(Hit3)
      set_tough_bar_protect_state(monster.npc, 3)
    end
    
    function Hit3.finTrans()
      return monster.states.wander
    end
  end
  do
    local Blink_ATK = monster.states.Blink_ATK
    local punish = monster.states.punish
    local Hit3 = monster.states.Hit3
    
    function Blink_ATK.isReady(Blink_ATK)
      if Hit3.base.isReady(Hit3) then
        return true
      end
      return false
    end
    
    function punish.isReady(punish)
      if punish.base.isReady(punish) and Hit3.base.isReady(Hit3) then
        return true
      end
      return false
    end
  end
  do
    local Blink_ATK = monster.states.Blink_ATK
    local punish = monster.states.punish
    
    function Blink_ATK.start(Blink_ATK)
      Blink_ATK.base.start(Blink_ATK)
      cast_magic(monster.npc, monster.npc, 1999225, 1)
      cast_magic(monster.npc, monster.npc, 20102501926, 1)
    end
    
    function punish.start(punish)
      punish.base.start(punish)
      cast_magic(monster.npc, monster.npc, 1999225, 1)
      cast_magic(monster.npc, monster.npc, 20102501926, 1)
    end
  end
  do
    local JumpATK = monster.states.JumpATK
    
    function JumpATK.isReady(JumpATK)
      local now_hp = get_npc_attr(JumpATK.monster.npc, 1)
      local hp_max = get_npc_attr(JumpATK.monster.npc, 4)
      if now_hp / hp_max < 0.7 then
        return true
      end
    end
  end
  do
    local dodge = monster.states.dodge
    local stun = monster.states.stun
    dodge.switch = false
    stun.HitInterval = 2.5
    stun.timer = 0
    
    function dodge.isReady(dodge)
      return dodge.switch
    end
    
    function dodge.start(dodge)
      local npc = dodge.monster.npc
      cast_magic(npc, npc, 2010250116, 1)
      cast_magic(npc, npc, 2010250117, 1)
      dodge.switch = false
    end
    
    function dodge.finTrans(dodge)
      return dodge.monster.states.wander
    end
    
    function stun.start(stun)
      stun.timer = get_npc_time(stun.monster.npc)
      stun.fall_switch = true
    end
    
    stun.dodge = monster.states.dodge
    
    function stun.tickTrans(stun)
      local faint = stun.monster.states.faint
      if faint.isReady(faint) then
        return faint
      end
      if get_npc_time(stun.monster.npc) > stun.timer + stun.HitInterval then
        if not check_npc_status(monster.npc, 10) then
          stun.monster.states.dodge.switch = true
          return stun.dodge
        end
        if check_npc_status(monster.npc, 10) and true == stun.fall_switch then
          local monster = stun.monster
          local target = monster.target
          if target then
            local monsPos = get_npc_pos(monster.npc)
            local tarPos = get_npc_pos(target)
            abort_skill(monster.npc, true)
            flash_to_pos(monster.npc, monsPos.x, monsPos.z, tarPos.y)
            stun.fall_switch = false
            stun.dodge.switch = true
            return stun.dodge
          end
        end
      end
    end
  end
  do
    local dashOut = monster.states.dashOut
    local dashOutHit = monster.states.dashOutHit
    
    function dashOut.isReady(dashOut)
      local now_hp = get_npc_attr(dashOut.monster.npc, 1)
      local hp_max = get_npc_attr(dashOut.monster.npc, 4)
      return dashOut.base.isReady(dashOut) and now_hp / hp_max > 0.5
    end
    
    function dashOutHit.isReady(dashOutHit)
      local now_hp = get_npc_attr(dashOutHit.monster.npc, 1)
      local hp_max = get_npc_attr(dashOutHit.monster.npc, 4)
      return dashOutHit.base.isReady(dashOutHit) and now_hp / hp_max <= 0.5
    end
  end
  do
    local NormalATK = monster.states.NormalATK
    local Atk1_1 = monster.states.Atk1_1
    local TripleAtk = monster.states.TripleAtk
    local Atk3_1 = monster.states.Atk3_1
    NormalATK.random = math.random()
    NormalATK.timer = 0
    
    function NormalATK.isReady(NormalATK)
      if get_npc_time(NormalATK.monster.npc) > NormalATK.timer then
        return true
      end
    end
    
    function Atk1_1.isReady(Atk1_1)
      if NormalATK.random < 0.33333 then
        return Atk1_1.base.isReady(Atk1_1)
      end
    end
    
    function TripleAtk.isReady(TripleAtk)
      if NormalATK.random > 0.33333 and NormalATK.random < 0.66666 then
        return TripleAtk.base.isReady(TripleAtk)
      end
    end
    
    function Atk3_1.isReady(Atk3_1)
      if NormalATK.random > 0.6666 then
        return Atk3_1.base.isReady(Atk3_1)
      end
    end
    
    function NormalATK.finish(NormalATK)
      NormalATK.timer = get_npc_time(NormalATK.monster.npc) + 1 + 0.5 * math.random()
      NormalATK.random = math.random()
    end
  end
  do
    local GetBack = monster.states.GetBack
    
    function GetBack.start(GetBack)
      local npc = GetBack.monster.npc
      
      local function shadow()
        enable_shadow(npc, false)
      end
      
      local function Flash()
        if monster.target then
          local pos = get_npc_offset_position(GetBack.monster.target, nil, math.random() * 360, 0.8 + 0.5 * math.random())
          flash_to_pos(npc, pos.x, pos.z)
          lookat_npc(npc, GetBack.monster.target)
        end
      end
      
      monster:doAfter(shadow, 0.5)
      if monster.target then
        monster:doAfter(Flash, 1.5)
      end
      GetBack.base.start(GetBack)
    end
    
    function GetBack.finish(GetBack)
      local npc = GetBack.monster.npc
      cast_magic(npc, npc, 2010250114, 1)
      enable_shadow(GetBack.monster.npc, true)
    end
  end
  do
    local faint = monster.states.faint
    local attack = monster.states.attack
    
    function faint.start(faint)
      local monster = faint.monster
      monster.redskillnum = 0
    end
    
    function attack.start(attack)
      abort_magic_by_id(monster.npc, 2010250104, 5)
      abort_magic_by_id(monster.npc, 20102501924, 5)
    end
    
    function attack.finish()
      monster.redskillnum = 0
    end
  end
  do
    local GotHit1 = monster.states.GotHit1
    local GotHit2 = monster.states.GotHit2
    
    function GotHit1.isReady(GotHit1)
      return GotHit1.switch
    end
    
    function GotHit2.isReady(GotHit2)
      return GotHit2.switch
    end
  end
end

function monster.on_self_magic_end(monster, target, magic_id, magic_kind, magic_type, is_break)
  monster.base.on_self_magic_end(monster, target, magic_id, magic_kind, magic_type, is_break)
  if 2010250116 == magic_id then
    cast_magic(monster.npc, monster.npc, 2010250118, 1)
    cast_magic(monster.npc, monster.npc, 2010250119, 1)
  end
  if not get_sync_var("is_friendly") and (2010250103 == magic_id or 20102501031 == magic_id) then
    cast_magic(monster.npc, monster.npc, 20102501931)
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
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  monster.base.on_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  if not get_sync_var("is_friendly") and (2010250103 == magic_id or 20102501031 == magic_id) then
    change_follow_target(0)
  end
end

function monster.on_start(monster)
  cast_magic(monster.npc, monster.npc, 2010250114)
  set_keyframe_enable(monster.npc, 2010230100409, false, true)
  if not get_sync_var("is_friendly") then
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
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if hit_target ~= monster.target then
    return
  end
  if 2010250116 == skill_id or 2010250114 == skill_id then
    change_missile_move_params(missile, 0, 0)
  end
end

function monster.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  local states = monster.states
  local isKilled = get_missile_kill_role_count(monster.npc, missile) > 0
  cast_magic(attackerNpc, attackerNpc, 20102501924, 1)
  if is_cast_skill_time(monster.npc, 2010250125) or is_cast_skill_time(monster.npc, 2010250105) then
    monster.redskillnum = monster.redskillnum + 1
    states.GotHit2.switch = true
    if not isKilled then
      monster.tree:derive(states.GotHit2)
    end
    states.GotHit2.switch = false
    cast_magic(attackerNpc, monster.npc, 20102501925)
  end
  if is_cast_skill_time(monster.npc, 2010250128) then
    monster.redskillnum = monster.redskillnum + 1
    states.GotHit1.switch = true
    if not isKilled then
      monster.tree:derive(states.GotHit1)
    end
    states.GotHit1.switch = false
    cast_magic(attackerNpc, monster.npc, 20102501925)
  end
  if is_cast_skill_time(monster.npc, 2010250104) then
    monster.redskillnum = monster.redskillnum + 1
    if not isKilled then
      abort_skill(monster.npc, false)
      enter_stun(monster.npc, false, 3 * monster.redskillnum)
    end
    cast_magic(monster.npc, monster.npc, 20102501927, 1)
    set_tough_bar_protect_state(monster.npc, 2)
  end
  abort_magic_by_id(monster.npc, Const.RED_SKILL)
  lookat_npc(monster.npc, attackerNpc, true)
  monster:doAfter(monster.on_red_skill_countered_fx, nil, attackerNpc, missile)
end

function monster.on_red_skill_countered_fx(monster, attackerNpc, missile)
  attackerNpc = attackerNpc or get_come_on_hero()
  local npc = monster.npc
  local monster_kind = get_role_kind(monster.npc)
  if 4 ~= monster_kind then
    cast_magic(attackerNpc, attackerNpc, 1999351)
  else
    cast_magic(attackerNpc, attackerNpc, 1999352)
  end
  lookat_npc(npc, attackerNpc, true)
  cast_magic(npc, npc, Const.MONSTER_BE_HIT.SOUND_REVERB, 0)
  cast_magic(attackerNpc, npc, 1999242)
  cast_magic(attackerNpc, npc, 1999261)
  cast_magic(attackerNpc, npc, 1999219)
  cast_magic(attackerNpc, npc, 1999221)
  cast_magic(attackerNpc, npc, 1999222)
  cast_magic(attackerNpc, npc, 1999285)
  cast_magic(attackerNpc, npc, 1999347)
end

function monster.falsh(monster, target)
  local pos = get_npc_offset_position(target, get_npc_pos(monster.npc), 0, 1)
  flash_to_pos(monster.npc, pos.x, pos.z)
  lookat_npc(monster.npc, target, true)
end

return monster
