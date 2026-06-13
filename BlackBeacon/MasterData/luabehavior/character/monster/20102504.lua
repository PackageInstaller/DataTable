local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 5,
    minTime = 0.8,
    maxTime = 2,
    type = "walk"
  }
  monster.search = {minDis = 5, maxDis = 20}
  local skills = {
    Atk1_1 = {
      2010250411,
      0,
      0,
      0,
      6,
      -90,
      90
    },
    Atk1_2 = {
      2010250412,
      0,
      0,
      0,
      10
    },
    Atk1_3 = {
      2010250413,
      0,
      0,
      0,
      5
    },
    TripleAtk = {
      2010250418,
      0,
      0,
      0,
      6,
      -90,
      90
    },
    Atk3_1 = {
      2010250432,
      0,
      0,
      0,
      5,
      -90,
      90
    },
    Atk3_2 = {
      2010250423,
      0,
      0,
      0,
      7
    },
    Blink1 = {
      2010250424,
      30,
      8,
      0,
      10
    },
    Hit1 = {
      2010250425,
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
      2010250428,
      0,
      0,
      0,
      80
    },
    dashOut = {
      2010250415,
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
      2010250404,
      30 + 5 * math.random(),
      10,
      0,
      80
    },
    dashOutHit = {
      2010250416,
      0,
      5,
      0,
      80
    },
    JumpOut = {
      "dashOutHit",
      20,
      5,
      0,
      12
    },
    Dart1 = {
      2010250414,
      0,
      0,
      0,
      80
    },
    Dart2 = {
      "Dart1",
      0,
      0,
      0,
      80
    },
    Jump = {
      "Blink1",
      0,
      0,
      0,
      80
    },
    JumpHit1 = {
      2010250409,
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
    "Evade",
    "interrupt",
    "EvadeATK",
    "specialATK"
  }
  monstBase._init(monster, skills, nil, nodes)
  monster.states.attack.interval = 0
  monster.states.active.ChangeState = true
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.specialATK, _ENV.NormalATK)
    _ENV.NormalATK(_ENV.Atk1_1(_ENV.Atk1_2(_ENV.Atk1_3)), _ENV.TripleAtk, _ENV.Atk3_1(_ENV.Atk3_2))
    _ENV.specialATK(_ENV.Blink_ATK, _ENV.JumpATK)
    _ENV.Blink_ATK(_ENV.Blink1(_ENV.Hit1(_ENV.Blink2(_ENV.Hit2(_ENV.dashOut(_ENV.Blink3(_ENV.Hit3)), _ENV.dashOutHit(_ENV.Blink3(_ENV.Hit3)))))))
    _ENV.JumpATK(_ENV.JumpOut(_ENV.Dart1(_ENV.Dart2(_ENV.Jump(_ENV.JumpHit1(_ENV.Atk3_2))))))
  end
  do
    local Blink1 = monster.states.Blink1
    local Hit1 = monster.states.Hit1
    local Blink2 = monster.states.Blink2
    local Hit2 = monster.states.Hit2
    local Blink3 = monster.states.Blink3
    local Hit3 = monster.states.Hit3
    local JumpHit1 = monster.states.JumpHit1
    
    function Blink1.start(Blink1)
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
      Hit3.base.start(Hit3)
    end
  end
  do
    local NormalATK = monster.states.NormalATK
    local Atk1_1 = monster.states.Atk1_1
    local TripleAtk = monster.states.TripleAtk
    local Atk3_1 = monster.states.Atk3_1
    local Atk3_2 = monster.states.Atk3_2
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
      NormalATK.timer = get_npc_time(NormalATK.monster.npc) + 0.5 * math.random()
      NormalATK.random = math.random()
    end
  end
  do
    local specialATK = monster.states.specialATK
    
    function specialATK.isReady(specialATK)
      if get_cur_room_id() == 103305 then
        return false
      end
      return true
    end
  end
end

function monster.on_self_magic_end(target, magic_id, magic_kind, magic_type, is_break)
  if 2010250116 == magic_id then
    cast_magic(monster.npc, monster.npc, 2010250118, 1)
    cast_magic(monster.npc, monster.npc, 2010250119, 1)
  end
  if 2010250120 == magic_id then
    cast_magic(monster.npc, monster.npc, 2010250121, 1)
  end
end

function monster.on_skill_hit(monster, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= monster.npc then
    return
  end
  if 2010250416 == skill_id or 2010250414 == skill_id then
    if not missile.d_firstHitEnd then
      missile.d_firstHitEnd = true
      change_missile_move_params(missile, 7.5, 0)
    else
      change_missile_move_params(missile, 0, 0)
    end
  end
end

return monster
