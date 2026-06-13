local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.search = {minDis = 100, maxDis = 100}
  monster.born = 2010340121
  local skills = {
    slap_r = {
      2010340101,
      10,
      3,
      0,
      120,
      120,
      -90
    },
    claw_l = {
      2010340102,
      14,
      10,
      0,
      6,
      -45,
      45
    },
    claw_back = {
      2010340118,
      10,
      2,
      0,
      120,
      120,
      -90
    },
    ground_blast = {
      2010340107,
      15,
      10,
      1,
      15,
      -60,
      60
    },
    hugeSmash = {
      2010340103,
      30,
      10,
      0,
      16,
      -90,
      90
    },
    moveTripleHit = {
      2010340109,
      5,
      0,
      0,
      18,
      -120,
      120
    },
    Redskill = {
      2010340133,
      18,
      8,
      0,
      18,
      -120,
      120
    },
    biggesHit = {
      2010340110,
      50,
      20,
      0,
      16,
      -90,
      90
    },
    changeStateA = {
      2010340116,
      99,
      0,
      0,
      999
    },
    henshin_start = {
      2010340104,
      0,
      0,
      0,
      999
    },
    henshin_loop = {
      2010340105,
      0,
      0,
      0,
      999
    },
    henshin_end = {
      2010340106,
      0,
      0,
      0,
      999
    },
    Transport = {
      2010340127,
      0,
      0,
      0,
      999
    },
    roar = {
      2010340112,
      0,
      0,
      0,
      999
    },
    jumpHit = {
      2010340111,
      2,
      2,
      8,
      120
    },
    Iaser_start = {
      2010340113,
      50,
      30,
      0,
      99
    },
    Iaser_loop = {
      2010340114,
      0,
      0,
      0,
      999
    },
    Iaser_end = {
      2010340115,
      0,
      0,
      0,
      999
    },
    Bomb = {
      2010340126,
      30,
      0,
      0,
      999
    }
  }
  local nodes = {
    "TurnAtk",
    "Henshin",
    "Iaser",
    "FlashBack"
  }
  local actMoves = {"stand", "flash"}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.states.attack.interval = 0.5
  monster.flash_switch = false
  monster.level = monster.npc:get_level()
  tool.BOSS_Dead = false
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.FlashBack, _ENV.TurnAtk, _ENV.attack, _ENV.wander)
    _ENV.TurnAtk(_ENV.jumpHit, _ENV.claw_back, _ENV.slap_r)
    _ENV.freeAtk(_ENV.Iaser, _ENV.biggesHit, _ENV.claw_l, _ENV.ground_blast, _ENV.hugeSmash, _ENV.Redskill, _ENV.moveTripleHit)
    _ENV.Iaser(_ENV.Iaser_start(_ENV.Iaser_loop(_ENV.Iaser_end)))
    _ENV.FlashBack(_ENV.flash, _ENV.Bomb)
    _ENV.wander(_ENV.stand)
  end
  do
    local TurnAtk = monster.states.TurnAtk
    local wander = monster.states.wander
    local stand = monster.states.stand
    local FlashBack = monster.states.FlashBack
    
    function wander.tickTrans(wander)
      local monster = wander.monster
      local states = monster.states
      local tree = monster.tree
      if not monster.target then
        return states.noTarget
      end
      if FlashBack.base.isReady(FlashBack) then
        return FlashBack
      end
      if TurnAtk.base.isReady(TurnAtk) then
        return TurnAtk
      end
      if states.attack then
        return tree:chooseChildAction(states.attack)
      end
    end
    
    function stand.start(stand)
      lookat_npc(stand.monster.npc, stand.monster.target)
      stop_move(stand.monster.npc)
    end
  end
  do
    local claw_back = monster.states.claw_back
    local TurnAtk = monster.states.TurnAtk
    local jumpHit = monster.states.jumpHit
    local slap_r = monster.states.slap_r
    
    function jumpHit.start(jumpHit)
      local monster = jumpHit.monster
      set_lock_velocity(monster.npc, 0.3)
      if monster.target then
        lookat_npc(monster.npc, monster.target, false)
      end
      jumpHit.base.start(jumpHit)
    end
    
    function jumpHit.finish(jumpHit)
      jumpHit.base.finish(jumpHit)
      local monster = jumpHit.monster
      abort_magic_by_id(monster.npc, 20103401027, 1)
      set_lock_velocity(monster.npc, 0.1)
    end
    
    function TurnAtk.finTrans(TurnAtk)
      return TurnAtk.monster.states.wander
    end
  end
  do
    local biggesHit = monster.states.biggesHit
    local hugeSmash = monster.states.hugeSmash
    
    function hugeSmash.start(hugeSmash)
      local self = hugeSmash.monster
      
      local function Stone1()
        local now_pos = get_npc_pos(self.npc)
        local pos1 = get_npc_offset_position(self.npc, nil, 25, 10)
        local pos2 = get_npc_offset_position(self.npc, nil, 115, 10)
        local pos3 = get_npc_offset_position(self.npc, nil, 205, 10)
        local pos4 = get_npc_offset_position(self.npc, nil, 295, 10)
        if is_cast_skill_time(self.npc, 2010340103, 1) then
          add_npc2(2, 20103403, pos2.x, pos2.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos3.x, pos3.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
        end
      end
      
      local function Stone2()
        local now_pos = get_npc_pos(self.npc)
        local pos1 = get_npc_offset_position(self.npc, nil, 1, 6)
        local pos2 = get_npc_offset_position(self.npc, nil, 90, 6)
        local pos3 = get_npc_offset_position(self.npc, nil, 180, 6)
        local pos4 = get_npc_offset_position(self.npc, nil, 270, 6)
        if is_cast_skill_time(self.npc, 2010340103, 1) then
          add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos2.x, pos2.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos3.x, pos3.z, now_pos.x, now_pos.z, 2, self.level)
        end
      end
      
      monster:doAfter(Stone1, 3)
      monster:doAfter(Stone2, 3.3)
      hugeSmash.base.start(hugeSmash)
    end
    
    function biggesHit.start(biggesHit)
      local self = biggesHit.monster
      
      local function Stone1()
        local now_pos = get_npc_pos(self.npc)
        local pos1 = get_npc_offset_position(self.npc, nil, 45, 5)
        local pos2 = get_npc_offset_position(self.npc, nil, 135, 5)
        local pos4 = get_npc_offset_position(self.npc, nil, 315, 5)
        if is_cast_skill_time(self.npc, 2010340110, 1) then
          add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos2.x, pos2.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
        end
      end
      
      local function Stone2()
        local now_pos = get_npc_pos(self.npc)
        local pos1 = get_npc_offset_position(self.npc, nil, 1, 10)
        local pos4 = get_npc_offset_position(self.npc, nil, 270, 10)
        if is_cast_skill_time(self.npc, 2010340110, 1) then
          add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
        end
      end
      
      local function Stone3()
        local now_pos = get_npc_pos(self.npc)
        local pos1 = get_npc_offset_position(self.npc, nil, 45, 15)
        local pos4 = get_npc_offset_position(self.npc, nil, 315, 15)
        if is_cast_skill_time(self.npc, 2010340110, 1) then
          add_npc2(2, 20103403, pos1.x, pos1.z, now_pos.x, now_pos.z, 2, self.level)
          add_npc2(2, 20103403, pos4.x, pos4.z, now_pos.x, now_pos.z, 2, self.level)
        end
      end
      
      monster:doAfter(Stone1, 1.5)
      monster:doAfter(Stone2, 3.5)
      monster:doAfter(Stone3, 6.3)
      biggesHit.base.start(biggesHit)
    end
  end
  do
    local biggesHit = monster.states.biggesHit
    local Iaser = monster.states.Iaser
    local Iaser_start = monster.states.Iaser_start
    local Iaser_loop = monster.states.Iaser_loop
    local Iaser_end = monster.states.Iaser_end
    
    function Iaser_loop.finish(Iaser_loop)
      Iaser_loop.base.finish(Iaser_loop)
      local npc = Iaser_loop.monster.npc
      abort_magic_by_id(npc, 20103401025, 1)
      abort_magic_by_id(npc, 20103401030, 1)
      abort_magic_by_id(npc, 20103401031, 1)
    end
  end
  do
    local faint = monster.states.faint
    
    function faint.start(faint)
      abort_magic_by_id(monster.npc, 20103401066, 1)
      abort_magic_by_id(monster.npc, 20103401068, 1)
      abort_magic_by_id(monster.npc, 20103401069, 1)
      abort_magic_by_id(faint.monster.npc, 20103401025, 1)
      abort_magic_by_id(faint.monster.npc, 20103401030, 1)
      abort_magic_by_id(faint.monster.npc, 20103401031, 1)
    end
  end
  do
    local dead = monster.states.dead
    dead.delay = {fx = 4, remove = 5}
  end
  do
    local FlashBack = monster.states.FlashBack
    local Bomb = monster.states.Bomb
    local flash = monster.states.flash
    flash.isReady = Const.TURE_FUN
    Bomb.isReady = Const.FALSE_FUN
    flash.trans = false
    FlashBack.timer = 20
    
    function FlashBack.isReady(FlashBack)
      if not check_npc_distance_to_pos(monster.npc, monster.born_pos.x, monster.born_pos.z, 12, false) and FlashBack.timer < get_npc_time(monster.npc) then
        return true
      end
      return false
    end
    
    function flash.start()
      abort_skill(monster.npc, false)
      cast_magic(npc, npc, 20103401068, 1)
      cast_magic(npc, npc, 20103401069, 1)
      cast_magic(npc, npc, 20103401066, 1)
      FlashBack.timer = get_npc_time(monster.npc) + 30
      
      local function delay()
        flash.trans = true
        Bomb.isReady = Const.TURE_FUN
        flash_to_pos(monster.npc, monster.born_pos.x, monster.born_pos.z)
        set_lock_velocity(monster.npc, 25)
        monster.tree:transState(monster.states.Bomb)
      end
      
      monster:doAfter(delay, 0.7)
    end
    
    function Bomb.start(Bomb)
      abort_magic_by_id(monster.npc, 20103401068, 1)
      lookat_position(monster.npc, monster.born_pos.x, monster.born_pos.z - 10, false)
      flash.trans = false
      Bomb.isReady = Const.FALSE_FUN
      abort_magic_by_id(monster.npc, 20103401066, 1)
      abort_magic_by_id(monster.npc, 20103401067, 1)
      Bomb.base.start(Bomb)
    end
    
    function Bomb.finish(Bomb)
      Bomb.base.finish(Bomb)
      set_lock_velocity(monster.npc, 0.1)
    end
  end
  do
    local attack = monster.states.attack
    
    function attack.start(attack)
      attack.base.start(attack)
      abort_magic_by_id(monster.npc, 20103401068, 99)
      abort_magic_by_id(monster.npc, 20103401069, 99)
      abort_magic_by_id(monster.npc, 20103401067, 99)
    end
  end
end

function monster.on_start(monster)
  monster.born_pos = get_npc_pos(monster.npc)
  cast_magic(monster.npc, monster.npc, 20103401001, 1)
  monster:xRay()
  set_lock_velocity(monster.npc, 0.1)
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

function monster.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  if 20103401068 == magic_id then
    cast_magic(monster.npc, monster.npc, 20103401069, 1)
  end
end

function monster.on_target_self_magic_end(monster, caster, magic_id)
  monster.base.on_target_self_magic_end(monster, caster, magic_id)
  if 20103401068 == magic_id then
    abort_magic_by_id(monster.npc, 20103401069, 1)
    abort_magic_by_id(monster.npc, 20103401067, 1)
  end
end

return monster
