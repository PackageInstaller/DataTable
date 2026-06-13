local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 1,
    minTime = 0.5,
    maxTime = 2,
    type = "walk"
  }
  monster.search = {minDis = 0, maxDis = 2}
  monster.born = 2020510106
  local skills = {
    Turn_Back = {
      2020510101,
      0,
      0,
      0,
      99
    },
    Split = {
      2020510102,
      5,
      2 + 5 * math.random(),
      0,
      3,
      -60,
      60
    },
    Stab = {
      2020510103,
      0,
      0,
      0,
      4
    },
    Turn_Hit = {
      2020510104,
      0,
      0,
      0,
      4
    },
    Atk = {
      2020510105,
      10,
      2 + 5 * math.random(),
      0,
      3,
      -60,
      60
    },
    born_end = {
      2020510107,
      math.huge,
      0,
      monster.search.minDis,
      monster.search.maxDis
    }
  }
  local nodes = {}
  local actMoves = {"Stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.born_end, _ENV.attack, _ENV.Turn_Back, _ENV.wander)
    _ENV.meleeAtk(_ENV.Split)
    _ENV.rangedAtk(_ENV.Atk)
    _ENV.wander(_ENV.forward, _ENV.Stand)
  end
  do
    local born = monster.states.born
    local born_end = monster.states.born_end
    monster.born_hit = false
    
    function born.tickTrans(born)
      local passive = born.passive
      local born_end = born.monster.states.born_end
      set_npc_hp_visible(monster.npc, false)
      set_can_searched(monster.npc, false)
      monster:searchTarget()
      if passive:isReady() then
        set_npc_hp_visible(monster.npc, true)
        set_can_searched(monster.npc, true)
        enable_shadow(monster.npc, true)
        return passive
      end
      if born_end.isReady(born_end) or monster.born_hit == true or check_magic(monster.npc, 201051010204) then
        born_end.isReady = Const.TURE_FUN
        set_npc_hp_visible(monster.npc, true)
        if not check_magic(monster.npc, 201051010206) then
          set_can_searched(monster.npc, true)
        end
        enable_shadow(monster.npc, true)
        return born_end
      end
    end
    
    function born_end.start(born_end)
      born_end.base.start(born_end)
      born_end.isReady = Const.FALSE_FUN
      monster.states.Atk.timer = get_npc_time(monster.npc) + 5 + 5 * math.random()
      monster.states.Split.timer = get_npc_time(monster.npc) + 5 + 5 * math.random()
      monster.search.minDis = 8
      monster.search.maxDis = 99
    end
    
    function born_end.finTrans(born_end)
      return monster.states.wander
    end
  end
  do
    local Turn_Back = monster.states.Turn_Back
    local Stand = monster.states.Stand
    local wander = monster.states.wander
    
    function Turn_Back.isReady(Turn_Back)
      if not Turn_Back.monster.target then
        return false
      end
      local AngleToPlayer = get_target_angel(Turn_Back.monster.npc, Turn_Back.monster.target, true)
      if AngleToPlayer > 90 or AngleToPlayer < -90 then
        return true
      end
    end
    
    function Turn_Back.finTrans(Turn_Back)
      return monster.states.wander
    end
    
    function wander.tickTrans(wander)
      local monster = wander.monster
      local states = monster.states
      if not monster.target then
        return states.noTarget
      end
      if Turn_Back.isReady(Turn_Back) then
        return Turn_Back
      end
      if states.attack then
        return monster.tree:chooseChildAction(states.attack)
      end
    end
  end
end

function monster.on_start(monster)
  set_npc_hp_visible(monster.npc, false)
  set_can_searched(monster.npc, false)
  enable_shadow(monster.npc, false)
  if get_sync_var("sculptures_search_large") == true then
    monster.states.born_end.maxDis = 4.3
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  if is_cast_skill_time(monster.npc, 2020510106, 1) then
    monster.born_hit = true
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if get_sync_var("qian_dark") == true then
    monster.search.minDis = 4
    monster.search.maxDis = 4
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  monster.base.on_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  if 201051010205 == magic_id then
    monster.states.born_end.maxDis = 0
  end
end

return monster
