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
  monster.fogList = {}
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_status(npc, 3, true)
  local skills = {
    blue = {300107003, 0},
    white = {300107002, 0},
    stand = {300107001, 0}
  }
  local nodes = {}
  local actMoves = {}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  cast_magic(npc, npc, 399001, 1)
  set_npc_ignore_sync_area(npc, false)
  cast_magic(npc, npc, 4032905, 1)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 3001070006)
  set_sync_var("lantern_num", 0)
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.blue, _ENV.white)
    _ENV.active(_ENV.daze, _ENV.stand, _ENV.attack)
  end
  
  function states.stand.start(stand)
    stand.base.start(stand)
  end
  
  function states.stand.finish(stand)
    local npc = stand.monster.npc
    cast_magic(npc, npc, 3001070008)
    active_hud(npc, "3001070_bar", "T1", true)
  end
  
  function states.white.tickTrans(white)
    local npc = white.monster.npc
    cast_magic(npc, npc, 3001070007)
    if get_npc_attr(npc, 3) <= 0 then
      return white.monster.states.stand
    end
  end
  
  function states.white.finish(white)
    local npc = white.monster.npc
    active_hud(npc, "3001070_bar", "T1", false)
  end
  
  do
    local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
    listen_missile_evt(MISSILE_EVT_TYPE.BEGIN_POS, npc, 30010700201, monster.on_create_missile, monster)
    listen_missile_evt(MISSILE_EVT_TYPE.END_POS, npc, 30010700201, monster.on_destroy_missile, monster)
    listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, 30010700201, monster.on_npc_enter_missile, monster)
    listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, 30010700201, monster.on_npc_leave_missile, monster)
  end
  set_hud_config("3001070_bar", {
    Prefab = "UI_Hud9",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = false
  }, 2, 3, 6)
  if get_cur_room_id() == 4051 then
    monster.dianliangcishu_id = 10057
  elseif get_cur_room_id() == 4052 then
    monster.dianliangcishu_id = 10060
  elseif get_cur_room_id() == 4053 then
    monster.dianliangcishu_id = 10063
  end
end

function monster.on_create_missile(monster, owner, pos_x, pos_z, missile_cfg, missile)
  if owner == monster.npc then
    local targets_List = search_npc(monster.npc, 7, 6, nil, false, true)
    for i, target_npc in pairs(targets_List) do
      if 1 == get_role_kind(target_npc) then
        abort_magic_by_id(target_npc, 3001064002)
        abort_magic_by_id(target_npc, 3001064003)
        abort_magic_by_id(target_npc, 3001064008)
        abort_magic_by_id(target_npc, 3001064009)
      elseif 2 == get_role_kind(target_npc) or 3 == get_role_kind(target_npc) then
        abort_magic_by_id(target_npc, 3001064011)
        abort_magic_by_id(target_npc, 3001064012)
        abort_magic_by_id(target_npc, 3001064013)
        abort_magic_by_id(target_npc, 3001064014)
        target_npc.d_qingdeng_num = target_npc.d_qingdeng_num and target_npc.d_qingdeng_num + 1 or 1
        if 1 == target_npc.d_qingdeng_num then
          cast_magic(monster.npc, target_npc, 3001070002, 1)
          cast_magic(monster.npc, target_npc, 3001070003, 1)
        end
      end
    end
  end
end

function monster.on_destroy_missile(monster, owner, pos_x, pos_z, missile_cfg, missile)
  if owner == monster.npc then
    if check_magic(monster.npc, 1067041) then
      if get_sync_var("lantern_num") then
        set_sync_var("lantern_num", get_sync_var("lantern_num") - 1)
      end
    elseif check_magic(monster.npc, 1067042) and get_sync_var("box_lantern") then
      set_sync_var("box_lantern", get_sync_var("box_lantern") - 1)
    end
    local targets_List = search_npc(monster.npc, 7, 6, nil, false, true)
    if nil ~= targets_List then
      for i, target_npc in pairs(targets_List) do
        if nil ~= target_npc and (2 == get_role_kind(target_npc) or 3 == get_role_kind(target_npc)) and nil ~= target_npc.d_qingdeng_num then
          target_npc.d_qingdeng_num = target_npc.d_qingdeng_num - 1
          if 0 == target_npc.d_qingdeng_num then
            abort_magic_by_id(target_npc, 3001070002)
            abort_magic_by_id(target_npc, 3001070003)
          elseif target_npc.d_qingdeng_num < 0 then
            target_npc.d_qingdeng_num = 0
          end
        end
      end
    end
    for i, target in pairs(monster.fogList) do
      target.d_qingdeng_num = target.d_qingdeng_num - 1
      if 0 == target.d_qingdeng_num then
        target.jinghua = false
        if check_magic(target, 1067041) and get_sync_var("jinghua_num") then
          set_sync_var("jinghua_num", get_sync_var("jinghua_num") + 1)
        end
      end
    end
    monster.fogList = {}
  end
end

function monster.on_npc_enter_missile(monster, owner, target_npc, missile_cfg, missile)
  if owner == monster.npc then
    if 1 == get_role_kind(target_npc) then
      abort_magic_by_id(target_npc, 3001064002)
      abort_magic_by_id(target_npc, 3001064003)
      abort_magic_by_id(target_npc, 3001064008)
      abort_magic_by_id(target_npc, 3001064009)
    elseif 2 == get_role_kind(target_npc) or 3 == get_role_kind(target_npc) then
      abort_magic_by_id(target_npc, 3001064011)
      abort_magic_by_id(target_npc, 3001064012)
      abort_magic_by_id(target_npc, 3001064013)
      abort_magic_by_id(target_npc, 3001064014)
      target_npc.d_qingdeng_num = target_npc.d_qingdeng_num and target_npc.d_qingdeng_num + 1 or 1
      if 1 == target_npc.d_qingdeng_num then
        cast_magic(monster.npc, target_npc, 3001070002, 1)
        cast_magic(monster.npc, target_npc, 3001070003, 1)
      end
    end
  end
end

function monster.on_npc_leave_missile(monster, owner, target_npc, missile_cfg, missile)
  if owner == monster.npc then
    if get_npc_id(target_npc) == 3001064 then
      for i, target in pairs(monster.fogList) do
        if target == target_npc then
          target_npc.d_qingdeng_num = target_npc.d_qingdeng_num - 1
          if 0 == target_npc.d_qingdeng_num then
            target_npc.jinghua = false
            if check_magic(target_npc, 1067041) then
              set_sync_var("jinghua_num", get_sync_var("jinghua_num") + 1)
            end
          end
          table.remove(monster.fogList, i)
          break
        end
      end
    end
    if 2 == get_role_kind(target_npc) or 3 == get_role_kind(target_npc) then
      target_npc.d_qingdeng_num = target_npc.d_qingdeng_num - 1
      if 0 == target_npc.d_qingdeng_num then
        abort_magic_by_id(target_npc, 3001070002)
        abort_magic_by_id(target_npc, 3001070003)
      elseif target_npc.d_qingdeng_num < 0 then
        target_npc.d_qingdeng_num = 0
      end
    end
  end
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 300107002 == skill_id and get_npc_id(hit_target) == 3001064 then
    hit_target.d_qingdeng_num = hit_target.d_qingdeng_num and hit_target.d_qingdeng_num + 1 or 1
    hit_target.D_hitted = true
    hit_target.jinghua = true
    if check_magic(hit_target, 1067041) and 1 == hit_target.d_qingdeng_num and (get_sync_var("jinghua_room") or get_sync_var("lantern_room")) then
      set_sync_var("jinghua_num", get_sync_var("jinghua_num") - 1)
      if 0 == get_sync_var("jinghua_num") then
        get_god_npc().timer_roompass = get_npc_time(get_god_npc()) + 3.25
      end
    end
    monster.fogList[#monster.fogList + 1] = hit_target
    local smoke = hit_target:get_behavior()
    local smokeOnAbsorb = smoke and smoke.on_be_absorb
    if smokeOnAbsorb then
      smokeOnAbsorb(smoke)
    end
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, attacker, hit_type, missile_cfg, missile)
  if monster.state.name ~= "white" and missile_cfg.Id == 30010630201 then
    abort_skill(monster.npc)
    monster:transState(monster.states.white)
    if check_magic(monster.npc, 1067041) then
      set_sync_var("lantern_num", get_sync_var("lantern_num") + 1)
      if get_sync_var("lantern_room") and get_sync_var("lantern_num") >= get_sync_var("total_lantern_num") and get_sync_var("room_pass") == nil then
        set_sync_var("room_pass", true)
      end
    elseif check_magic(monster.npc, 1067042) then
      set_sync_var("box_lantern", get_sync_var("box_lantern") + 1)
      if get_sync_var("box_lantern") >= get_sync_var("box_lantern_max") and nil == get_sync_var("box_showup") then
        set_sync_var("box_showup", true)
      end
    end
    if nil ~= monster.dianliangcishu_id then
      add_task_progress(monster.dianliangcishu_id, 1)
    end
  end
end

function monster.on_self_missile_collide(monster, otherNpc, self_missile, other_missile, self_missile_cfg, other_missile_cfg)
  if self_missile_cfg.Id == 30010700201 then
    if other_missile_cfg.Id == 201049010404 then
      remove_missile(other_missile)
    end
    if other_missile_cfg.Id == 202049010402 then
      remove_missile(other_missile)
    end
  end
end

function monster.after_damage_self(monster, caster, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
end

return monster
