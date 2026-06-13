local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 8,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    skill01 = {
      2010400201,
      5,
      math.random(2, 6),
      0,
      8,
      -90,
      90
    },
    skill02 = {
      2010400202,
      15,
      math.random(2, 10),
      0,
      8,
      -90,
      90
    },
    skill03 = {
      2010400203,
      12,
      5,
      0,
      2,
      -60,
      60
    },
    counterR1 = {
      2010400201,
      0,
      0,
      4.5,
      7,
      nil,
      nil,
      nil,
      0
    },
    counterR2 = {
      2010400202,
      6,
      0,
      4.5,
      7,
      nil,
      nil,
      nil,
      0
    },
    counterM = {
      2010400203,
      0,
      0,
      0,
      4.5,
      nil,
      nil,
      nil,
      0,
      2.5
    }
  }
  local actMoves = {"Blink"}
  monstBase._init(monster, skills, nil, actMoves, nil)
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.Blink, _ENV.evade, _ENV.wander)
    _ENV.rangedAtk(_ENV.skill02, _ENV.skill01)
    _ENV.freeAtk(_ENV.skill03)
    _ENV.rangedCounter(_ENV.counterR2, _ENV.counterR1)
  end
  do
    local skill01 = monster.states.skill01
    local skill02 = monster.states.skill02
    
    function skill01.start(skill)
      local function missile()
        local self = skill.monster
        
        cast_missile(self.npc, nil, get_npc_pos(get_come_on_hero()).x, get_npc_pos(get_come_on_hero()).z, 201040010408, 0)
        cast_missile(self.npc, self.npc, nil, nil, 201040010407, 0)
      end
      
      monster:doAfter(missile, 1)
      skill.base.start(skill01)
    end
    
    monster.states.counterR1.start = skill01.start
    
    function skill02.start(skill)
      local self = skill.monster
      
      local function missile1()
        cast_missile(self.npc, nil, get_npc_pos(get_come_on_hero()).x, get_npc_pos(get_come_on_hero()).z, 201040010401, 0)
        cast_missile(self.npc, self.npc, nil, nil, 201040010404, 0)
      end
      
      local function missile2()
        local pos1 = get_npc_offset_position(get_come_on_hero(), get_npc_pos(self.npc), math.random(60, 300), 2)
        cast_missile(self.npc, nil, pos1.x, pos1.z, 201040010402, 0)
        cast_missile(self.npc, self.npc, nil, nil, 201040010405, 0)
      end
      
      local function missile3()
        local pos2 = get_npc_offset_position(get_come_on_hero(), get_npc_pos(self.npc), math.random(60, 300), 2)
        cast_missile(self.npc, nil, pos2.x, pos2.z, 201040010403, 0)
        cast_missile(self.npc, self.npc, nil, nil, 201040010406, 0)
      end
      
      monster:doAfter(missile1, 0.5)
      monster:doAfter(missile2, 1.5)
      monster:doAfter(missile3, 2.5)
      skill.base.start(skill02)
    end
    
    monster.states.counterR2.start = skill02.start
  end
  do
    local Blink = monster.states.Blink
    local Blink_CD = 1 + 3 * math.random()
    local wander = monster.states.wander
    
    function wander.tickTrans(wander)
      local states = wander.monster.states
      local skill = monster.tree:chooseChildAction(states.attack)
      if not monster.target then
        return states.noTarget
      end
      if skill then
        return skill
      end
      if get_npc_time(wander.monster.npc) > Blink_CD then
        return states.Blink
      end
    end
    
    function Blink.isReady(Blink)
      if get_npc_time(Blink.monster.npc) < Blink_CD then
        return false
      end
      if not check_npc_distance(Blink.monster.npc, Blink.monster.target, 3, false) then
        return false
      end
      return true
    end
    
    function Blink.start(Blink)
      local self = Blink.monster
      local angle = math.random() * 360
      local distance = 6
      local pos = get_npc_offset_position(self.target, nil, angle, distance)
      Blink_CD = get_npc_time(self.npc) + 1
      cast_magic(self.npc, self.npc, 20102701009, 1)
      enable_shadow(self.npc, false)
      set_npc_hp_visible(self.npc, false)
      cast_magic(self.npc, self.npc, 20102701005, 1)
      cast_magic(self.npc, self.npc, 20102701006, 1)
      cast_magic(self.npc, self.npc, 20102701006, 1)
      cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
      cast_magic(self.npc, self.npc, 100104, 1)
      
      local function Flash()
        flash_to_pos(self.npc, pos.x, pos.z)
        cast_magic(self.npc, self.npc, 20102701008, 1)
        set_can_searched(self.npc, true)
      end
      
      monster:doAfter(Flash, 0.9)
    end
    
    function Blink.tickTrans(Blink)
      if get_npc_time(Blink.monster.npc) > Blink_CD then
        Blink_CD = get_npc_time(Blink.monster.npc) + 7
        return Blink.monster.states.wander
      end
    end
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  monster.base.on_self_magic_end(monster, target, magic_id)
  if 20102701009 == magic_id then
    abort_magic_by_id(monster.npc, Const.LOCK_MASK, 1)
    abort_magic_by_id(monster.npc, 100104, 1)
    abort_magic_by_id(monster.npc, 20102701007, 1)
    abort_magic_by_id(monster.npc, 20102701006, 1)
    abort_magic_by_id(monster.npc, 20102701005, 1)
  end
  if 20102701008 == magic_id then
    enable_shadow(monster.npc, true)
    set_npc_hp_visible(monster.npc, true)
  end
end

return monster
