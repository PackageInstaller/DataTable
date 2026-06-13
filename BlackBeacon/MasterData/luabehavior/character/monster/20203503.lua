local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2020350304
  local skills = {
    Atk1 = {
      2020350301,
      4,
      1,
      0,
      15,
      -20,
      20
    },
    Atk2 = {
      2020350302,
      4,
      3,
      0,
      30
    },
    GetUp = {2020350305, 999}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.GetUp, _ENV.Atk1, _ENV.Atk2)
    _ENV.wander(_ENV.stand)
  end
  monster.states.attack.interval = 0.5
  tool.NPC_3 = true
  do
    local born = monster.states.born
    
    function born.tickTrans(born)
      local passive = born.passive
      set_npc_hp_visible(monster.npc, false)
      if passive:isReady() then
        return passive
      end
      if tool.NPC_2 == false then
        return monster.states.GetUp
      end
    end
  end
  do
    local GetUp = monster.states.GetUp
    local stand = monster.states.stand
    
    function GetUp.start(GetUp)
      GetUp.isReady = Const.FALSE_FUN
      local center = {
        x = 189.162,
        y = -954.2557,
        z = 205.1954
      }
      
      local function falsh()
        set_npc_hp_visible(monster.npc, true)
        change_follow_target(3, monster.npc, {
          16,
          26,
          {
            x = 0,
            y = -10,
            z = -1
          },
          1,
          0.9
        })
        play_DBM_ani(23)
        start_stroy(202013)
        flash_to_pos(monster.npc, center.x, center.z)
        cast_magic(monster.npc, monster.npc, 20203502003, 1)
        abort_magic_by_id(monster.npc, Const.LOCK_MASK, 1)
        abort_magic_by_id(monster.npc, 20102701007, 1)
        abort_magic_by_id(monster.npc, 20103401037, 1)
        GetUp.base.start(GetUp)
      end
      
      if 114 ~= tool.NPC_3 then
        monster:doAfter(falsh, 1.5)
      end
    end
    
    function stand.start(stand)
      stop_move(stand.monster.npc)
    end
  end
  monster.npc:initialize_weaponattach_setting(1)
end

function monster.on_start(monster)
  set_npc_hp_visible(monster.npc, false)
  set_lock_velocity(monster.npc, 0.1)
  cast_magic(monster.npc, monster.npc, 20103401001, 1)
  cast_magic(monster.npc, monster.npc, 20203502003, 1)
end

function monster.on_frame(monster)
  monster.base.on_frame(monster)
  local npc = monster.npc
  if 114 == tool.NPC_3 then
    cast_magic(npc, npc, 20103401034, 1)
  end
end

function monster.on_self_npc_hp_zero(monster)
  monster.base.on_self_npc_hp_zero(monster)
  tool.NPC_3 = false
end

return monster
