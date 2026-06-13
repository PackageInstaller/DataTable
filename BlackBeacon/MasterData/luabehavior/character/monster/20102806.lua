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
  local skills = {
    skill01 = {
      2010280101,
      5,
      1,
      0,
      3,
      -45,
      45
    },
    redskill = {
      2010280116,
      10 + 10 * math.random(),
      5 + 5 * math.random(),
      0,
      4,
      -45,
      45
    },
    skill02 = {
      2010280111,
      5,
      1,
      0,
      4,
      -45,
      45
    },
    skill03 = {
      2010280110,
      7,
      1,
      1,
      8,
      -45,
      45
    },
    Shield_Start = {
      2010280102,
      25,
      5,
      0,
      4,
      -45,
      45
    },
    Shield_End = {
      2010280104,
      0,
      0,
      0,
      99
    },
    Shield_Hit = {
      2010280116,
      10,
      0,
      0,
      4,
      -45,
      45
    },
    Broke_Star = {
      2010280107,
      0,
      0,
      0,
      99,
      -45,
      45
    },
    Broke_Loop = {
      2010280108,
      0,
      0,
      0,
      99,
      -45,
      45
    },
    Broke_End = {
      2010280109,
      0,
      0,
      0,
      99,
      -45,
      45
    },
    HIt_front = {
      2010280114,
      0,
      0,
      0,
      99
    },
    Hit_back = {
      2010280115,
      0,
      0,
      0,
      99
    }
  }
  local nodes = {
    "Shield_Up",
    "Broke",
    "ATK1",
    "ATK2",
    "Shield_Down",
    "Hit"
  }
  monstBase._init(monster, skills, nil, nodes)
  monster.StatesType = 1
  monster.Broken = false
  monster.Shield_time = 0
  replace_ragdoll_power_profile(monster.npc, 0)
  local states = monster.states
  local skills = monster.skills
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.Hit, _ENV.wander)
    _ENV.rangedAtk(_ENV.redskill)
    _ENV.meleeAtk(_ENV.ATK1, _ENV.ATK2)
    _ENV.freeAtk(_ENV.Shield_Up, _ENV.Shield_Down, _ENV.Broke)
    _ENV.Shield_Up(_ENV.Shield_Start)
    _ENV.Shield_Down(_ENV.Shield_End, _ENV.Shield_Hit)
    _ENV.ATK1(_ENV.skill01)
    _ENV.ATK2(_ENV.skill03, _ENV.skill02)
    _ENV.Broke(_ENV.Broke_Star(_ENV.Broke_Loop(_ENV.Broke_End)))
    _ENV.Hit(_ENV.HIt_front, _ENV.Hit_back)
  end
  do
    local ATK1 = states.ATK1
    local ATK2 = states.ATK2
    local redskill = states.redskill
    
    function ATK1.isReady(ATK)
      if 1 == ATK.monster.StatesType then
        return true
      end
    end
    
    function ATK2.isReady(ATK)
      if 3 == ATK.monster.StatesType then
        return true
      end
    end
    
    function redskill.isReady(redskill)
      if 1 == redskill.monster.StatesType then
        return redskill.base.isReady(redskill)
      end
    end
  end
  do
    local Shield_Up = states.Shield_Up
    local Shield_Start = states.Shield_Start
    
    function Shield_Up.isReady(Shield)
      local self = Shield.monster
      local now_hp = get_npc_attr(self.npc, 1)
      local max_hp = get_npc_attr(self.npc, 4)
      if 1 ~= self.StatesType then
        return false
      end
      if now_hp / max_hp <= 0.7 and Shield.base.isReady(Shield.monster.states.Shield_Start) then
        return true
      end
    end
    
    function Shield_Start.start(Shield)
      local self = Shield.monster
      self.ATK = false
      self.StatesType = 2
      self.Shield_time = get_npc_time(self.npc) + 10
      replace_ragdoll_power_profile(monster.npc, 1)
      cast_magic(self.npc, self.npc, 20102801007, 1)
      cast_magic(self.npc, self.npc, 20102801001, 1)
      cast_magic(self.npc, self.npc, 20102801005, 1)
      set_lock_velocity(self.npc, 0.3)
      cast_magic(self.npc, self.npc, 20102801008, 1)
      set_npc_controller(self.npc, 2)
      Shield.base.start(Shield_Start)
    end
  end
  do
    local faint = monster.states.faint
    
    function faint.start(faint)
      local self = faint.monster
      if 2 == self.StatesType then
        self.StatesType = 1
        replace_ragdoll_power_profile(monster.npc, 0)
        abort_magic_by_id(self.npc, 20102801018, 99)
        abort_magic_by_id(self.npc, 20102801001, 1)
        abort_magic_by_id(self.npc, 20102801005, 1)
        abort_magic_by_id(self.npc, 20102801007, 1)
        abort_magic_by_id(self.npc, 20102801008, 1)
        set_lock_velocity(self.npc, 10)
        set_npc_controller(self.npc, 1)
      end
    end
  end
  do
    local Shield_Down = states.Shield_Down
    local Shield_End = states.Shield_End
    local Shield_Hit = states.Shield_Hit
    
    function Shield_Down.isReady(Shield)
      local self = Shield.monster
      if 2 == self.StatesType and self.target and not check_npc_distance(self.npc, self.target, 6, false) then
        return true
      end
      if 2 == self.StatesType and get_npc_time(self.npc) > self.Shield_time then
        return true
      end
    end
    
    function Shield_End.isReady(Shield)
      local self = Shield.monster
      if self.target and not check_npc_distance(self.npc, self.target, 3, false) then
        return true
      end
    end
    
    function Shield_End.start(Shield)
      local self = Shield.monster
      replace_ragdoll_power_profile(monster.npc, 0)
      abort_magic_by_id(self.npc, 20102801001, 1)
      abort_magic_by_id(self.npc, 20102801005, 1)
      abort_magic_by_id(self.npc, 20102801007, 1)
      abort_magic_by_id(self.npc, 20102801008, 1)
      set_lock_velocity(self.npc, 10)
      set_npc_controller(self.npc, 1)
      self.StatesType = 1
      Shield.base.start(Shield_End)
    end
    
    function Shield_Hit.isReady(Shield)
      local self = Shield.monster
      if self.target and check_npc_distance(self.npc, self.target, 3, false) then
        return Shield_Hit.base.isReady(Shield_Hit)
      end
    end
    
    function Shield_Hit.start(Shield)
      local self = Shield.monster
      replace_ragdoll_power_profile(monster.npc, 0)
      abort_magic_by_id(self.npc, 20102801001, 1)
      abort_magic_by_id(self.npc, 20102801005, 1)
      abort_magic_by_id(self.npc, 20102801007, 1)
      abort_magic_by_id(self.npc, 20102801008, 1)
      set_lock_velocity(self.npc, 10)
      set_npc_controller(self.npc, 1)
      self.StatesType = 1
      Shield.base.start(Shield_Hit)
    end
  end
  do
    local Broke = states.Broke
    local Broke_Star = states.Broke_Star
    
    function Broke.isReady(broke)
      return false
    end
    
    function Broke_Star.start(Broken)
      Broke.isReady = Const.FALSE_FUN
      local self = Broken.monster
      set_npc_controller(monster.npc, 3)
      self.StatesType = 3
      
      local function Break()
        abort_magic_by_id(self.npc, 20102801009, 1)
        cast_magic(self.npc, self.npc, 20102801004, 1)
        set_npc_joint_active(self.npc, "part", false)
      end
      
      monster:doAfter(Break, 0.02)
      Broken.base.start(Broke_Star)
    end
  end
  do
    local wander = states.wander
    
    function wander.tickTrans(wander)
      local states = wander.monster.states
      local Broke = wander.monster.states.Broke
      local skill = monster.tree:chooseChildAction(states.attack)
      if not monster.target then
        return states.noTarget
      end
      if Broke.isReady(Broke) then
        abort_magic_by_id(wander.monster.npc, 20102801018, 99)
        return wander.monster.states.Broke
      end
      if skill then
        return skill
      end
    end
  end
  do
    local Hit = monster.states.Hit
    
    function Hit.isReady(Hit)
      return false
    end
    
    function Hit.start(Hit)
      function Hit.isReady(Hit)
        return false
      end
    end
    
    function Hit.finTrans(Hit)
      return monster.states.wander
    end
    
    function Hit.tick(Hit)
      if monster.states.Shield_Down.isReady(monster.states.Shield_Down) then
        monster.tree:transState(monster.states.Shield_Down)
      end
    end
  end
  do
    local HIt_front = monster.states.HIt_front
    local Hit_back = monster.states.Hit_back
    
    function HIt_front.start(HIt_front)
      time_scale_immune(monster.npc, true)
      HIt_front.base.start(HIt_front)
    end
    
    function HIt_front.finish(HIt_front)
      HIt_front.base.finish(HIt_front)
      time_scale_immune(monster.npc, false)
    end
    
    function Hit_back.start(Hit_back)
      time_scale_immune(monster.npc, true)
      Hit_back.base.start(Hit_back)
    end
    
    function Hit_back.finish(Hit_back)
      Hit_back.base.finish(Hit_back)
      time_scale_immune(monster.npc, false)
    end
  end
end

function monster:on_target_self_skill_hit(skill_id, attacker, hit_type, missile_cfg, missile)
  self.base.on_target_self_skill_hit(self, skill_id, attacker, hit_type, missile_cfg, missile)
  if 2 ~= self.StatesType then
    return
  end
  if 300103901 == skill_id then
    replace_ragdoll_power_profile(monster.npc, 0)
    abort_magic_by_id(self.npc, 20102801018, 99)
    abort_magic_by_id(self.npc, 20102801001, 99)
    abort_magic_by_id(self.npc, 20102801008, 99)
    abort_magic_by_id(self.npc, 20102801005, 99)
    abort_magic_by_id(self.npc, 20102801009, 99)
    abort_magic_by_id(self.npc, 20102801007, 99)
    set_lock_velocity(self.npc, 10)
    self.states.Broke.isReady = Const.TURE_FUN
    self.tree:transState(self.states.Broke)
    self.StatesType = 3
  end
end

function monster.before_damage_self(monster, caster, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  monster.base.before_damage_self(monster, caster, magic_id, damage_sign, damage_type, target_camp, change_level, magic_level, skill_id, missile)
  local angle = get_target_angel(monster.npc, caster, true)
  if 2 ~= monster.StatesType then
    return
  end
  if get_npc_attr(monster.npc, 1) < 0.1 then
    return
  end
  if not change_level and not check_npc_status(monster.npc, 14) then
    if angle < 80 and angle > -80 then
      function monster.states.Hit.isReady(Hit)
        return true
      end
      
      cast_magic(monster.npc, caster, 20102801018, 1)
      monster.tree:transState(monster.states.HIt_front)
    else
      monster.tree:transState(monster.states.Hit_back)
    end
  end
end

function monster.on_target_self_magic_end(monster, caster, magic_id)
  monster.base.on_target_self_magic_end(monster, caster, magic_id)
  if 3001039001 == magic_id and is_cast_skill_time(monster.npc, 2010280107, 1) then
    cast_magic(monster.npc, monster.npc, 20102801019, 1)
  end
end

function monster.on_start(monster)
  enable_part_damage(monster.npc, 1, false)
  cast_magic(monster.npc, monster.npc, 20102801009, 1)
end

function monster.go_mad(monster)
  cast_magic(monster.npc, monster.npc, 500100101, 1)
  cast_magic(monster.npc, monster.npc, 500100102, 1)
  cast_magic(monster.npc, monster.npc, 500100111, 1)
  monster.states.attack.interval = 1
  monster.states.redskill.cd = 8
  local _ENV = monster.states
  _ENV.rangedAtk()
  _ENV.freeAtk(_ENV.redskill, _ENV.Shield_Up, _ENV.Shield_Down, _ENV.Broke)
end

return monster
