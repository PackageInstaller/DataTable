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
  monster.search = {}
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  set_npc_status(npc, 3, true)
  cast_magic(npc, npc, 30010630902, 1)
  cast_magic(npc, npc, 30010630202, 1)
  cast_magic(npc, npc, 30010630302, 1)
  local skills = {
    smoke = {300106901, 0}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  local god = get_god_npc()
  god.timer_roompass = 0
  monster.timer_reborn = 0
  monster.freezeHero = false
  monster.reborn = false
  if not check_magic(god, 3001064000) then
    cast_magic(npc, god, 3001064000, 1)
  end
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.smoke)
    _ENV.active(_ENV.daze, _ENV.attack, _ENV.stand)
  end
  local states = monster.states
  
  function states.stand.start(stand)
    local npc = stand.monster.npc
    stop_move(npc)
  end
  
  function states.stand.tickTrans(stand)
    local npc = stand.monster.npc
    if get_npc_time(npc) > monster.timer_reborn and monster.reborn == true then
      if true == npc.jinghua then
        monster.timer_reborn = get_npc_time(npc) + 1
        return
      end
      monster.reborn = false
      return stand.monster.states.smoke
    end
    if not get_sync_var("jinghua_room") and not get_sync_var("lantern_room") then
      return
    end
    if get_npc_time(get_god_npc()) > get_god_npc().timer_roompass and 0 == get_sync_var("jinghua_num") then
      if get_sync_var("jinghua_room") then
        set_sync_var("room_pass", true)
        set_sync_var("jinghua_num", -1)
      elseif get_sync_var("lantern_room") and get_sync_var("room_pass") == nil then
        set_sync_var("room_restart", true)
        set_sync_var("jinghua_num", -1)
        if nil ~= get_sync_var("show_tips") then
          set_sync_var("reset_times", get_sync_var("reset_times") + 1)
          if get_sync_var("reset_times") >= 3 then
            set_sync_var("show_tips", true)
            set_sync_var("reset_times", 0)
          end
        end
      end
    end
  end
  
  function states.stand.finTrans(stand)
    return stand
  end
  
  function states.smoke.start(smoke)
    local npc = smoke.monster.npc
    npc.D_hitted = false
    smoke.base.start(smoke)
  end
  
  function states.smoke.finish()
    monster.timer_reborn = get_npc_time(npc) + 5
    monster.reborn = true
  end
  
  function states.smoke.finTrans(smoke)
    return smoke.monster.states.stand
  end
end

function monster.on_be_absorb(monster)
  abort_skill(monster.npc)
  cast_magic(monster.npc, monster.npc, 30010630903, 1)
  monster.tree:finTrans()
end

function monster.on_self_npc_hp_zero(monster)
end

function monster.after_damage_self(monster, caster, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
end

return monster
