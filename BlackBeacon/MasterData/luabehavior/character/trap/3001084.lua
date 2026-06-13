local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  set_hud_config("3001084_bar", {
    Prefab = "UI_Hud9",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = false,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 3, 6)
  monster.npc = npc
  monster.search = {}
  enable_shadow(npc, false)
  monster.reborn_check = 5
  monster.timer_reborn = 0
  monster.reborn = false
  monster.Check_Missile_id = 30010840101
  monster.Orb_Missile_id = 30010840201
  monster.Orb_CheckFX_id = 30010840404
  monster.Connect_Missile_id = 30010840202
  monster.Barrier_Missile_id = 30010850201
  monster.teleportPosition = get_npc_pos(npc)
  monster.Explode_Missile_id = 30010840212
  cast_magic(npc, npc, 2010050117, 1)
  cast_magic(npc, npc, 2010050113, 1)
  cast_magic(npc, npc, 300108404, 1, 1)
  cast_magic(npc, npc, 300108401, 1, 1)
  cast_magic(npc, npc, 4032905, 1)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 3220002, 1)
  set_npc_status(npc, 3, true)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, false)
  cast_magic(npc, npc, 300108406, 1)
  set_npc_floating_text_hud_visible(npc, false)
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  set_npc_status(npc, 3, true)
  local FX = {
    [3001084] = 30010840201,
    [30010841] = 30010840203,
    [30010842] = 30010840204,
    [30010843] = 30010840205,
    [30010844] = 30010840206,
    [30010845] = 30010840207,
    [30010846] = 30010840208,
    [30010847] = 30010840209,
    [30010848] = 30010840210
  }
  local CheckFx = {
    [3001084] = 30010840401,
    [30010841] = 30010840402,
    [30010842] = 30010840402,
    [30010843] = 30010840401,
    [30010844] = 30010840402,
    [30010845] = 30010840402,
    [30010846] = 30010840401,
    [30010847] = 30010840402,
    [30010848] = 30010840402
  }
  local OrbCheckFX = {
    [3001084] = 30010840404,
    [30010841] = 30010840405,
    [30010842] = 30010840406,
    [30010843] = 30010840407,
    [30010844] = 30010840408,
    [30010845] = 30010840409,
    [30010846] = 30010840410,
    [30010847] = 30010840404,
    [30010848] = 30010840411
  }
  local ConnectFx = {
    [3001084] = 30010840202,
    [30010841] = 30010840211,
    [30010842] = 30010840211,
    [30010843] = 30010840202,
    [30010844] = 30010840211,
    [30010845] = 30010840211,
    [30010846] = 30010840202,
    [30010847] = 30010840211,
    [30010848] = 30010840211
  }
  monster.Orb_Missile_id = FX[get_npc_id(npc)]
  monster.Orb_CheckFX_id = OrbCheckFX[get_npc_id(npc)]
  monster.CheckFx_Missile_id = CheckFx[get_npc_id(npc)]
  monster.CheckFx_Missile_id2 = 30010840403
  monster.Connect_Missile_id = ConnectFx[get_npc_id(npc)]
  monster.FailCount = 0
  monster.RoomId = {
    [1090303] = true,
    [1090404] = true,
    [1090501] = true,
    [1090502] = true,
    [1090503] = true,
    [1090702] = true
  }
  if true == monster.RoomId[get_cur_room_id()] then
    set_sync_var("LockOrb", false)
  end
  Log.Info("nengliangqiu 球外观" .. monster.Orb_Missile_id)
  do
    local spawnPos = get_npc_pos(monster.npc)
    cast_missile_new(monster.npc, monster.npc, spawnPos.x, spawnPos.z, monster.CheckFx_Missile_id, 1, nil, nil, nil, spawnPos.y)
    cast_missile_new(monster.npc, monster.npc, spawnPos.x, spawnPos.z, monster.CheckFx_Missile_id2, 1, nil, nil, nil, spawnPos.y)
  end
  do
    local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
    listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, monster.Orb_Missile_id, monster.on_npc_enter_missile, monster)
    listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, monster.Check_Missile_id, monster.on_npc_enter_check_missile, monster)
    listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, monster.Check_Missile_id, monster.on_npc_leave_check_missile, monster)
  end
  local skills = {
    check = {300108401, 0},
    follow = {300108402, 0},
    respawn = {300108403, 0}
  }
  local nodes = {}
  local actMoves = {}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = monster.states
    _ENV.active(_ENV.check, _ENV.follow, _ENV.respawn)
  end
  local states = monster.states
  
  function states.check.start(check)
    check.base.start(check)
    local npc = check.monster.npc
    cast_magic(npc, npc, 300108401, 1, 1)
  end
  
  function states.check.finish(check)
    remove_missile_by_id(monster.Orb_CheckFX_id)
  end
  
  function states.follow.start(follow)
    monster.SpawnOrb(follow.monster, get_npc_pos(follow.monster.npc))
    follow.monster.reborn_check = 5
  end
  
  function states.follow.tickTrans(follow)
    local npc = follow.monster.npc
    local monster = follow.monster
    if monster.reborn == true then
      if get_npc_time(npc) >= monster.timer_reborn then
        monster.reborn_check = monster.reborn_check - 1
        monster.timer_reborn = get_npc_time(npc) + 1
        cast_magic(monster.npc, monster.npc, 300108402, 1, 1)
        active_hud(monster.npc, "3001084_bar", "T1", true)
      end
    elseif monster.reborn_check >= 5 then
      active_hud(monster.npc, "3001084_bar", "T1", false)
    elseif get_npc_time(npc) >= follow.monster.timer_reborn then
      monster.reborn_check = monster.reborn_check + 1
      monster.timer_reborn = get_npc_time(npc) + 1
      cast_magic(monster.npc, monster.npc, 300108403, 1, 1)
    end
    if monster.reborn_check <= 0 then
      remove_missile_by_id(monster.Orb_Missile_id)
    end
  end
  
  function states.follow.finish(follow)
    local monster = follow.monster
    remove_missile_by_id(monster.Orb_Missile_id)
    remove_missile_by_id(monster.Connect_Missile_id)
    remove_missile_by_id(monster.Check_Missile_id)
    abort_skill(monster.npc)
  end
  
  function states.respawn.start(respawn)
    respawn.base.start(respawn)
    local npc = respawn.monster.npc
    local monster = respawn.monster
    monster.timer_reborn = get_npc_time(npc) + 1
    monster.reborn = true
    monster.reborn_check = 0
    cast_magic(npc, npc, 300108405, 1, 1)
    active_hud(npc, "3001084_bar", "T1", true)
  end
  
  function states.respawn.tickTrans(respawn)
    local npc = respawn.monster.npc
    local monster = respawn.monster
    if (get_sync_var("LockOrb") == false or get_sync_var("LockOrb") == nil) and get_npc_time(npc) >= respawn.monster.timer_reborn then
      respawn.monster.timer_reborn = get_npc_time(npc) + 1
      monster.reborn_check = monster.reborn_check + 1
      cast_magic(npc, npc, 300108403, 1, 1)
      Log.Info("nengliangqiu 重生计数+" .. tostring(monster.reborn_check))
      if monster.reborn_check >= 5 then
        return states.check
      end
    end
  end
  
  function states.respawn.finish(respawn)
    local npc = respawn.monster.npc
    monster.reborn = false
    active_hud(npc, "3001084_bar", "T1", false)
  end
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile, is_break)
  if missile_cfg.Id == monster.Explode_Missile_id then
    remove_missile_by_id(monster.Orb_Missile_id)
  end
  if missile_cfg.Id == monster.Orb_CheckFX_id then
    set_missile_effect_end_anim_idx(missile, 0)
  end
end

function monster.on_self_missile_collide(monster, otherNpc, self_missile, other_missile, self_missile_cfg, other_missile_cfg)
  if self_missile_cfg.Id == monster.Orb_Missile_id and other_missile_cfg.Id == monster.Barrier_Missile_id and monster.state.name == "follow" then
    set_missile_effect_end_anim_idx(self_missile, 2)
    monster.end_follow(monster, get_missile_pos(self_missile))
  end
end

function monster.on_npc_enter_missile(monster, owner, target_npc, missile_cfg, missile)
  if missile_cfg.Id == monster.Orb_Missile_id and monster.state.name == "follow" then
    if get_role_kind(target_npc) <= 3 and get_role_kind(target_npc) > 1 then
      set_missile_effect_end_anim_idx(missile, 2)
      monster.end_follow(monster, get_missile_pos(missile))
    end
    if (get_config_id(target_npc) == 3001086 or get_config_id(target_npc) == 30010861 or get_config_id(target_npc) == 30010862 or get_config_id(target_npc) == 30010863) and is_cast_skill_time(target_npc, 300108601) then
      local TargetPoint = target_npc:get_behavior()
      local TargetPointComplete = TargetPoint and TargetPoint.OrbHit
      if TargetPointComplete then
        TargetPointComplete(TargetPoint, missile_cfg)
      end
      set_missile_effect_end_anim_idx(missile, 0)
      monster.tree:transState(monster.states.respawn)
      remove_missile_by_id(monster.Orb_Missile_id)
    end
  end
end

function monster.on_self_npc_removed(monster)
  remove_missile_by_id(monster.Orb_Missile_id)
  remove_missile_by_id(monster.Orb_CheckFX_id)
  remove_missile_by_id(monster.Connect_Missile_id)
  remove_missile_by_id(monster.Check_Missile_id)
  remove_missile_by_id(monster.CheckFx_Missile_id)
  remove_missile_by_id(monster.CheckFx_Missile_id2)
  remove_missile_by_id(monster.Explode_Missile_id)
  remove_missile_by_id(monster.Explode_Missile_id + 1)
end

function monster.end_follow(monster, MissilePos)
  if monster.RoomId[get_cur_room_id()] == true then
    monster.FailCount = monster.FailCount + 1
    if monster.FailCount >= 4 then
      set_sync_var("LockOrb", true)
      call_scene_logic_custom_event("FAIL")
      monster.FailCount = 0
    end
  end
  monster.tree:transState(monster.states.respawn)
  remove_missile_by_id(monster.Orb_Missile_id)
  cast_missile_new(monster.npc, nil, MissilePos.x, MissilePos.z, monster.Explode_Missile_id, 1, nil, nil, nil, MissilePos.y)
end

function monster.on_enter_teleporter(monster, newPos)
  set_missile_effect_end_anim_idx(monster.Orb_Follow, 0)
  remove_missile_by_id(monster.Orb_Missile_id)
  remove_missile_by_id(monster.Connect_Missile_id)
  Log.Info("nengliangqiu 球进入传送门，所以删除旧球。新球生成位置为" .. newPos.x .. ", " .. newPos.z)
  monster.SpawnOrb(monster, newPos)
end

function monster.SpawnOrb(monster, spawnPos)
  local hero = get_come_on_hero()
  cast_missile_new(monster.npc, hero, spawnPos.x, spawnPos.z, monster.Orb_Missile_id, 1, nil, nil, nil, spawnPos.y)
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 30010840101 and monster.state.name == "check" then
    local spawnPos = get_npc_pos(monster.npc)
    cast_missile_new(monster.npc, monster.npc, spawnPos.x, spawnPos.z, monster.Orb_CheckFX_id, 1, nil, nil, nil, nil)
  end
  if missile_cfg.Id == monster.Orb_Missile_id and monster.state.name == "follow" then
    monster.Orb_Follow = missile
    Log.Info("nengliangqiu 球生成,位置为" .. pos_x .. ", " .. pos_z .. "球id为" .. missile.id)
    cast_missile_new(get_come_on_hero(), missile, pos_x, pos_z, monster.Connect_Missile_id, 1, nil, nil, nil, nil)
    
    local function changeFx()
      set_missile_effect_end_anim_idx(missile, 0)
    end
    
    monster:doAfter(changeFx, 0.1)
  end
  if missile_cfg.Id == monster.Orb_CheckFX_id then
    monster.Orb_CheckFX = missile
    
    local function changeFx()
      set_missile_effect_end_anim_idx(missile, 0)
    end
    
    monster:doAfter(changeFx, 0.1)
  end
end

function monster.on_npc_enter_check_missile(monster, owner, target_npc, missile_cfg, missile)
  if 1 == get_role_kind(target_npc) and owner == monster.npc then
    Log.Info("nengliangqiu 玩家已进入")
    if monster.state.name == "check" then
      set_missile_effect_end_anim_idx(monster.Orb_CheckFX, 0)
      monster.tree:transState(monster.states.follow)
    end
  end
end

function monster.on_npc_leave_check_missile(monster, owner, target_npc, missile_cfg, missile)
  if 1 == get_role_kind(target_npc) and owner == monster.npc and monster.state.name == "follow" then
    monster.reborn = false
    monster.timer_reborn = get_npc_time(monster.npc) + 1
  end
end

return monster
