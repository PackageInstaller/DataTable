local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 4,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    Atk1 = {
      2010320201,
      5,
      1,
      0,
      4,
      -60,
      60
    },
    Atk2 = {
      2010320202,
      8,
      3,
      1,
      7,
      -60,
      60
    },
    Atk3 = {
      2010320204,
      12,
      5 + 7 * math.random(),
      0,
      4,
      -60,
      60
    },
    Shield_Start = {
      2010320103,
      22,
      1,
      0,
      3,
      -60,
      60
    },
    Shield_End = {
      2010320104,
      0,
      3,
      0,
      0
    },
    Shield_Hit = {
      2010320105,
      0,
      0,
      0,
      99
    },
    Shield_Atk = {
      2010320106,
      5,
      3,
      0,
      3,
      -60,
      60
    },
    Arrow_Start = {
      2010320111,
      20,
      3 + 10 * math.random(),
      0,
      5,
      -60,
      60
    },
    Arrow_Loop = {
      2010320112,
      0,
      0,
      0,
      8
    },
    ArrowDamage = {
      2010320113,
      0,
      0,
      0,
      8
    },
    DoubleDamage = {
      2010320114,
      0,
      0,
      0,
      0
    },
    TrebleDamage = {
      2010320115,
      0,
      0,
      0,
      0
    },
    NoDamage = {
      2010320116,
      0,
      0,
      0,
      0
    }
  }
  local nodes = {
    "Arrow",
    "Shield",
    "Far",
    "Close",
    "gotHit"
  }
  local actMoves = {"MoveToNpc"}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.ATK_states = 1
  monster.shieldMax = 0
  monster.shieldNow = 0
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.gotHit, _ENV.wander)
    _ENV.rangedAtk(_ENV.Arrow)
    _ENV.meleeAtk(_ENV.Atk3, _ENV.Atk2, _ENV.Atk1)
    _ENV.Arrow(_ENV.Arrow_Start(_ENV.Arrow_Loop(_ENV.ArrowDamage, _ENV.DoubleDamage(_ENV.DoubleDamage), _ENV.TrebleDamage(_ENV.TrebleDamage), _ENV.NoDamage)))
  end
  do
    local Atk1 = monster.states.Atk1
    local Atk2 = monster.states.Atk2
    local Atk3 = monster.states.Atk3
    
    function Atk1.isReady(Atk1)
      if 1 ~= Atk1.monster.ATK_states then
        return false
      end
      return Atk1.base.isReady(Atk1)
    end
    
    function Atk2.isReady(Atk2)
      if 1 ~= Atk2.monster.ATK_states then
        return false
      end
      return Atk2.base.isReady(Atk2)
    end
    
    function Atk3.isReady(Atk3)
      if 1 ~= Atk3.monster.ATK_states then
        return false
      end
      return Atk3.base.isReady(Atk3)
    end
  end
  do
    local ArrowDamage = monster.states.ArrowDamage
    local DoubleDamage = monster.states.DoubleDamage
    local TrebleDamage = monster.states.TrebleDamage
    local NoDamage = monster.states.NoDamage
    local Arrow_Loop = monster.states.Arrow_Loop
    local Arrow = monster.states.Arrow
    
    function Arrow.start(Arrow)
      Arrow.monster.states.Arrow_Loop.DMG = 0
      Arrow.monster.states.DoubleDamage.Num = 2
      Arrow.monster.states.TrebleDamage.Num = 3
    end
    
    function Arrow_Loop.tick(Arrow_Loop)
      if 0 == get_npc_shield(Arrow_Loop.monster.npc) then
        abort_skill(monster.npc)
        cast_magic(monster.npc, monster.npc, 1999220, 1)
      elseif monster.shieldMax then
        monster.shieldNow = get_npc_shield(Arrow_Loop.monster.npc) / monster.shieldMax
        print("当前护盾", monster.shieldNow)
      end
    end
    
    function ArrowDamage.isReady(ArrowDamage)
      if monster.shieldNow > 0 and monster.shieldNow <= 0.33 then
        return true
      end
    end
    
    function ArrowDamage.finish(ArrowDamage)
      ArrowDamage.base.finish(ArrowDamage)
      abort_magic_by_id(ArrowDamage.monster.npc, 20104201030, 1)
    end
    
    function DoubleDamage.isReady(DoubleDamage)
      if 0 == DoubleDamage.Num then
        return false
      end
      if monster.shieldNow >= 0.33 and monster.shieldNow < 0.66 then
        return true
      end
    end
    
    function DoubleDamage.start(DoubleDamage)
      DoubleDamage.Num = DoubleDamage.Num - 1
      DoubleDamage.base.start(DoubleDamage)
    end
    
    function DoubleDamage.finish(DoubleDamage)
      DoubleDamage.base.finish(DoubleDamage)
      abort_magic_by_id(DoubleDamage.monster.npc, 20104201030, 1)
    end
    
    function TrebleDamage.isReady(TrebleDamage)
      if 0 == TrebleDamage.Num then
        return false
      end
      if monster.shieldNow >= 0.66 then
        return true
      end
    end
    
    function TrebleDamage.start(TrebleDamage)
      TrebleDamage.Num = TrebleDamage.Num - 1
      TrebleDamage.base.start(TrebleDamage)
    end
    
    function TrebleDamage.finish(TrebleDamage)
      TrebleDamage.base.finish(TrebleDamage)
      abort_magic_by_id(TrebleDamage.monster.npc, 20104201030, 1)
    end
    
    function NoDamage.isReady(NoDamage)
      if monster.shieldNow <= 0 then
        return true
      end
    end
  end
  do
    local faint = monster.states.faint
    
    function faint.start(faint)
      local self = faint.monster
      if 2 == self.ATK_states then
        self.states.Shield_Atk.Counter = 0
        abort_magic_by_id(self.npc, 20103201021, 1)
        set_lock_velocity(self.npc, 10)
        set_npc_controller(self.npc, 1)
        enable_part_damage(self.npc, 1, false)
        abort_magic_by_id(self.npc, 20103201001, 1)
        abort_magic_by_id(self.npc, 20103201005, 1)
        abort_magic_by_id(self.npc, 20103201006, 1)
      end
      self.states.gotHit.Hits = false
      set_npc_controller(self.npc, 1)
      self.ATK_states = 1
    end
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  monster.base.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  if missile_cfg.Id == 201032011104 then
    if 3 == hit_target.v_kind then
      cast_magic(monster.npc, hit_target, 20103201021, 1)
    elseif 2 == hit_target.v_kind then
      cast_magic(monster.npc, hit_target, 20103201027, 1)
    end
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  monster.base.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  if 20103201021 == magic_id and target == monster.npc then
    local function delay()
      monster.shieldMax = get_npc_shield(monster.npc)
    end
    
    monster:doAfter(delay, 0.1)
  end
end

function monster.go_mad(monster)
  cast_magic(monster.npc, monster.npc, 500100101, 1)
  cast_magic(monster.npc, monster.npc, 500100102, 1)
  cast_magic(monster.npc, monster.npc, 500100111, 1)
  monster.states.Atk3.cd = 5
  monster.states.attack.interval = 1
  local _ENV = monster.states
  _ENV.meleeAtk(_ENV.Atk2, _ENV.Atk1)
  _ENV.freeAtk(_ENV.Atk3)
end

return monster
