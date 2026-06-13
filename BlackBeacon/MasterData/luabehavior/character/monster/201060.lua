local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local tool = import("common.monster_tool")

function monster._init(monster, npc)
  local monster = monster
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 20106002
  local skills = {
    Atk = {
      20106001,
      1,
      1,
      0,
      30
    }
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.Atk)
    _ENV.wander(_ENV.stand)
  end
  monster.states.attack.interval = 2
  do
    local born = monster.states.born
    
    function born.finish(born)
      local monster = born.monster
      set_npc_hp_visible(born.monster.npc, true)
      monster.search = {minDis = 100, maxDis = 100}
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
      abort_skill(monster.npc)
      cast_magic(monster.npc, monster.npc, 20203502003, 1)
      lookat_position(monster.npc, 0, 0, true)
      abort_magic_by_id(monster.npc, Const.LOCK_MASK, 1)
      abort_magic_by_id(monster.npc, 20103401037, 1)
      abort_magic_by_id(monster.npc, 20103401038, 1)
    end
  end
  do
    local Atk = monster.states.Atk
    local stand = monster.states.stand
    
    function Atk.start(Atk)
      local npc = Atk.monster.npc
      cast_magic(npc, npc, 20203502003, 1)
      lookat_npc(npc, monster.target)
      Atk.base.start(Atk)
    end
    
    function stand.start(stand)
      stop_move(stand.monster.npc)
    end
  end
  do
    local dead = monster.states.dead
    dead.switch = false
    dead.delay = {fx = 0.8, remove = 2}
  end
  monster.npc:initialize_weaponattach_setting(2)
end

function monster.on_start(monster)
  set_lock_velocity(monster.npc, 100)
  set_npc_controller(monster.npc, 2)
  cast_magic(monster.npc, monster.npc, 20103401001, 1)
  cast_magic(monster.npc, monster.npc, 20203502003, 1)
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_owner == m2_owner then
    return
  end
  if m1_cfg.Id == 2010600111 then
    monster:try_red_skill_counter(m2)
  elseif m2_cfg.Id == 2010600111 then
    monster:try_red_skill_counter(m1)
  end
end

function monster.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  monster.base.on_red_skill_countered(monster, attackerNpc, victimNpc, missile)
  abort_skill(monster.npc)
  enter_stun(monster.npc, true, 1)
  remove_missile_by_id(2010600101, monster.npc)
end

function monster.on_red_skill_countered_fx(monster, attackerNpc, missile)
  monster.base.on_red_skill_countered_fx(monster, attackerNpc, missile)
  monster.base.toughness_change_fx(monster)
end

function monster.after_damage_target(monster, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if 20203502001 == magic_id then
    remove_missile_by_id(2010600111, monster.npc)
  end
end

return monster
