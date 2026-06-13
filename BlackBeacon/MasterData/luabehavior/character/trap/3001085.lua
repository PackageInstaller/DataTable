local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  set_npc_status(npc, 1, true)
  set_npc_status(npc, 2, true)
  set_npc_status(npc, 3, true)
  set_can_searched(npc, false)
  time_scale_immune(npc, true)
  enable_shadow(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 4032905, 1)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 40321891, 1)
  npc.search = {}
  cast_magic(npc, npc, 2010050117, 1)
  cast_magic(npc, npc, 2010050113, 1)
  monster.Pos_Missile_id = 30010850101
  monster.Check_Missile_id = 30010850201
  monster.ColorCheck_Missile_id = 30010850204
  monster.FX_Missile_id = 30010850202
  monster.multiplier = 2
  monster.FXmultiplier = 1
  if get_sync_var("barrierLen") ~= nil then
    if get_sync_var("barrierLen") >= 15 then
      monster.FX_Missile_id = 30010850203
      monster.FXmultiplier = 18
    else
      monster.FXmultiplier = 10
    end
    monster.multiplier = get_sync_var("barrierLen") / 2
  end
  monster.EnterNumber = 0
  local skills = {
    open = {300108501, 0}
  }
  local nodes = {}
  local actMoves = {}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.active(_ENV.open)
  end
  local states = monster.states
  do
    local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
    listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, monster.ColorCheck_Missile_id, monster.on_self_missile_catch_npc, monster)
    listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, monster.ColorCheck_Missile_id, monster.on_self_missile_release_npc, monster)
  end
end

function monster.on_self_missile_catch_npc(monster, owner, target_npc, missile_cfg, missile)
  if owner == monster.npc and missile_cfg.Id == monster.ColorCheck_Missile_id and get_npc_id(target_npc) ~= 3001085 then
    Log.Info("dianwang " .. monster.EnterNumber .. " npc " .. get_npc_id(target_npc) .. " 子弹调用 catch " .. monster.FX_Missile.id)
    missile_play_effect_anim(monster.FX_Missile, "End2")
    monster.EnterNumber = monster.EnterNumber + 1
  end
end

function monster.on_self_missile_release_npc(monster, owner, target_npc, missile_cfg, missile)
  if owner == monster.npc and missile_cfg.Id == monster.ColorCheck_Missile_id and get_npc_id(target_npc) ~= 3001085 then
    Log.Info("dianwang " .. monster.EnterNumber .. " npc " .. get_npc_id(target_npc) .. " 子弹调用 release" .. monster.FX_Missile.id)
    monster.EnterNumber = monster.EnterNumber - 1
    if monster.EnterNumber <= 1 then
      missile_play_effect_anim(monster.FX_Missile, "Loop")
      monster.EnterNumber = 0
    end
  end
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == monster.Pos_Missile_id then
    local zero_pos = get_npc_pos(monster.npc)
    local standard_pos = {
      [1] = pos_x - zero_pos.x,
      [2] = pos_z - zero_pos.z
    }
    local FXzero_pos = {
      [1] = zero_pos.x - standard_pos[1] * 1.5,
      [2] = zero_pos.z - standard_pos[2] * 1.5
    }
    local target_pos = {
      [1] = standard_pos[1] * monster.multiplier + zero_pos.x,
      [2] = standard_pos[2] * monster.multiplier + zero_pos.z
    }
    local FXtarget_pos = {
      [1] = standard_pos[1] * monster.multiplier / monster.FXmultiplier + zero_pos.x,
      [2] = standard_pos[2] * monster.multiplier / monster.FXmultiplier + zero_pos.z
    }
    cast_missile_new(monster.npc, nil, target_pos[1], target_pos[2], monster.Check_Missile_id, 1, target_pos[1], target_pos[2], zero_pos.y, zero_pos.y, zero_pos.x, zero_pos.z, zero_pos.y)
    cast_missile_new(monster.npc, nil, target_pos[1], target_pos[2], monster.ColorCheck_Missile_id, 1, target_pos[1], target_pos[2], zero_pos.y, zero_pos.y, zero_pos.x, zero_pos.z, zero_pos.y)
    cast_missile_new(monster.npc, nil, FXtarget_pos[1], FXtarget_pos[2], monster.FX_Missile_id, 1, FXtarget_pos[1], FXtarget_pos[2], zero_pos.y, zero_pos.y, zero_pos.x, zero_pos.z, zero_pos.y)
  end
  if missile_cfg.Id == monster.FX_Missile_id then
    monster.FX_Missile = missile
    Log.Info("dianwang 子弹存储" .. monster.FX_Missile.id)
  end
end

function monster.on_self_npc_removed(monster)
  Log.Info("dianwang 关闭")
  remove_missile_by_id(monster.FX_Missile_id, monster.npc, false)
  remove_missile_by_id(monster.Check_Missile_id, monster.npc, false)
  
  local function remove()
    remove_missile_by_id(monster.ColorCheck_Missile_id, monster.npc, false)
  end
  
  monster:doAfter(remove, 1)
end

return monster
