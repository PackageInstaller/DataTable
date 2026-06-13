local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 8,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    skill01 = {
      2010270101,
      5,
      1,
      0,
      2
    },
    skill02 = {
      2010270102,
      8,
      1,
      2,
      8
    },
    counterSkill1 = {
      2010270101,
      0,
      0,
      0,
      4,
      nil,
      nil,
      nil,
      1,
      1.5
    }
  }
  local actMoves = {"Blink"}
  monstBase._init(monster, skills, actMoves, nil)
  monster.blinkCD = 7
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.Blink, _ENV.wander)
    _ENV.rangedAtk(_ENV.skill02)
    _ENV.meleeAtk(_ENV.skill01)
    _ENV.meleeCounter(_ENV.counterSkill1)
  end
  do
    local Blink = monster.states.Blink
    local Blink_CD = 2
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
      if Blink.monster.target and not check_npc_distance(Blink.monster.npc, Blink.monster.target, 3, false) then
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
        Blink_CD = get_npc_time(Blink.monster.npc) + monster.blinkCD
        return Blink.monster.states.wander
      end
    end
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.skill01.cd = 2
  monster.states.skill02.cd = 2
  monster.wander.maxDis = 3
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
  monster.blinkCD = 4
end

function monster.on_self_magic_end(monster, target, magic_id)
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
