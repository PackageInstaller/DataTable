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
    local Arrow_Loop = monster.states.Arrow_Loop
    local Arrow = monster.states.Arrow
    local Arrow_Start = monster.states.Arrow_Start
    
    function Arrow_Start.start(Arrow_Start)
      local function Shield()
        monster.effect = play_effect(monster.npc, "Fx_M201032_skill3_1_1", "Groundpoint", false)
      end
      
      monster:doAfter(Shield, 0.4)
      Arrow_Start.base.start(Arrow_Start)
    end
    
    Arrow_Loop.Running = false
    
    function Arrow_Loop.start(Arrow_Loop)
      Arrow_Loop.Running = true
      Arrow_Loop.base.start(Arrow_Loop)
    end
    
    function Arrow_Loop.tick(Arrow_Loop)
      Arrow_Loop.DMG = 999999 - get_npc_shield(Arrow_Loop.monster.npc)
    end
    
    function Arrow_Loop.finish(Arrow_Loop)
      Arrow_Loop.base.finish(Arrow_Loop)
      Arrow_Loop.Running = false
      abort_magic_by_id(Arrow_Loop.monster.npc, 20103201002, 1)
      abort_magic_by_id(Arrow_Loop.monster.npc, 20104201022, 1)
      abort_magic_by_id(Arrow_Loop.monster.npc, 20103201021, 1)
      set_effect_end_anim_idx(monster.npc, "Fx_M201032_skill3_1_1", 0)
      stop_effect(monster.npc, monster.effect)
    end
    
    function Arrow.isReady(Arrow)
      if 1 == Arrow.monster.ATK_states then
        return true
      end
    end
    
    function Arrow.start(Arrow)
      Arrow.monster.states.Arrow_Loop.DMG = 0
      Arrow.monster.states.DoubleDamage.Num = 2
      Arrow.monster.states.TrebleDamage.Num = 3
    end
  end
  do
    local ArrowDamage = monster.states.ArrowDamage
    local DoubleDamage = monster.states.DoubleDamage
    local TrebleDamage = monster.states.TrebleDamage
    local NoDamage = monster.states.NoDamage
    
    function ArrowDamage.isReady(ArrowDamage)
      local DMG = ArrowDamage.monster.states.Arrow_Loop.DMG
      if DMG > 0 and DMG <= 150 then
        return true
      end
    end
    
    function ArrowDamage.finish(ArrowDamage)
      ArrowDamage.base.finish(ArrowDamage)
      abort_magic_by_id(ArrowDamage.monster.npc, 20104201030, 1)
    end
    
    function DoubleDamage.isReady(DoubleDamage)
      local DMG = DoubleDamage.monster.states.Arrow_Loop.DMG
      if 0 == DoubleDamage.Num then
        return false
      end
      if DMG >= 150 and DMG < 300 then
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
      local DMG = TrebleDamage.monster.states.Arrow_Loop.DMG
      if 0 == TrebleDamage.Num then
        return false
      end
      if DMG > 300 then
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
      local DMG = NoDamage.monster.states.Arrow_Loop.DMG
      if 0 == DMG then
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
        stop_effect(self.npc, self.states.Shield_Start.effect)
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

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if check_magic(monster.npc, 20103201006) then
    monster.states.gotHit.Hits = true
    monster.states.Shield_Atk.Counter = monster.states.Shield_Atk.Counter + 1
  end
end

function monster.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  monster.base.after_damage_self(monster, npc, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if monster.states.Arrow_Loop.Running == true and (4 == damage_type or 6 == damage_type and is_cast_skill_time(monster.npc, 2010320112, 1)) then
    set_effect_end_anim_idx(monster.npc, "Fx_M201032_skill3_1_1", 2)
    stop_effect(monster.npc, monster.effect)
    abort_skill(monster.npc)
    enter_stun(monster.npc, false, 3)
    cast_magic(monster.npc, monster.npc, 20101101034, 1)
    cast_magic(monster.npc, monster.npc, 20101201014, 1)
    cast_magic(monster.npc, monster.npc, 20101101026, 1)
    cast_magic(monster.npc, monster.npc, 20101101027, 1)
    play_effect(monster.npc, "Fx_M201032_skill3_1_4", "Groundpoint", false)
    abort_skill(monster.npc)
  end
end

return monster
