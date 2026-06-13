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
  cast_magic(npc, npc, 4032905, 1)
  cast_magic(npc, npc, 399001, 1)
  cast_magic(npc, npc, 40321891, 1)
  npc.search = {}
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 2010050117, 1)
  cast_magic(npc, npc, 2010050113, 1)
  local Group = {
    [3001087] = 300108701,
    [30010871] = 300108702,
    [30010872] = 300108703
  }
  local GroupName = {
    [3001087] = "R",
    [30010871] = "G",
    [30010872] = "B"
  }
  local FXid = {
    [3001087] = 30010870403,
    [30010871] = 30010870404,
    [30010872] = 30010870405
  }
  Log.Info("chuansong 1")
  monster.Skill_id = Group[get_npc_id(npc)]
  Log.Info("chuansong 分组为" .. monster.Skill_id)
  monster.Group = GroupName[get_npc_id(npc)]
  Log.Info("chuansong 分组为" .. monster.Group)
  monster.left_door_id = monster.Skill_id * 100 + 1
  monster.right_door_id = monster.Skill_id * 100 + 2
  monster.isEntered = false
  monster.leftEntered = true
  monster.leftPos = get_npc_pos(monster.npc)
  monster.rightPos = get_npc_pos(monster.npc)
  monster.EnterFX = 30010870401
  monster.LeaveFX = 30010870402
  monster.CurFXid = FXid[get_npc_id(npc)]
  local skills = {
    open = {
      monster.Skill_id,
      0
    }
  }
  local nodes = {}
  local actMoves = {}
  monstBase._init(monster, skills, actMoves, nodes)
  local states = monster.states
  do
    local _ENV = monster.states
    _ENV.active(_ENV.open)
  end
  
  function states.open.start(open)
  end
  
  local Leftx, Leftz = get_scene_map_pos_postion(monster.Group .. "1")
  monster.leftPos.x = Leftx
  monster.leftPos.z = Leftz
  local Rightx, Rightz = get_scene_map_pos_postion(monster.Group .. "2")
  monster.rightPos.x = Rightx
  monster.rightPos.z = Rightz
  cast_missile_new(monster.npc, nil, Leftx, Leftz, monster.left_door_id, 1, Rightx, Rightz, nil, nil)
  cast_missile_new(monster.npc, nil, Leftx, Leftz, monster.CurFXid, 1, Rightx, Rightz, nil, nil)
  cast_missile_new(monster.npc, nil, Rightx, Rightz, monster.right_door_id, 1, Leftx, Leftz, nil, nil)
  cast_missile_new(monster.npc, nil, Rightx, Rightz, monster.CurFXid, 1, Leftx, Leftz, nil, nil)
  monster.OrbFX = {
    [30010840201] = true,
    [30010840203] = true,
    [30010840204] = true,
    [30010840205] = true,
    [30010840206] = true,
    [30010840207] = true,
    [30010840208] = true,
    [30010840209] = true,
    [30010840210] = true
  }
  monster.EnterMissileUUID = 0
end

function monster.on_missile_collide(monster, m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if (m1_cfg.Id == monster.left_door_id or m1_cfg.Id == monster.right_door_id) and monster.OrbFX[m2_cfg.Id] ~= nil then
    monster.EnterMissileUUID = m2_cfg.id
    if monster.isEntered == false then
      local nextDoorPos = monster.leftPos
      local curDoorPos = monster.rightPos
      monster.leftEntered = false
      if m1_cfg.Id == monster.left_door_id then
        monster.leftEntered = true
        nextDoorPos = monster.rightPos
        curDoorPos = monster.leftPos
      else
      end
      monster.isEntered = true
      local Orb = m2_owner:get_behavior()
      local Orb_enter_tp = Orb and Orb.on_enter_teleporter
      set_missile_effect_end_anim_idx(m2, 0)
      if Orb_enter_tp then
        set_missile_effect_end_anim_idx(m2, 0)
        Orb_enter_tp(Orb, nextDoorPos)
        cast_missile_new(monster.npc, nil, curDoorPos.x, curDoorPos.z, monster.EnterFX, 1, curDoorPos.x, curDoorPos.z, nil, curDoorPos.y)
        cast_missile_new(monster.npc, nil, nextDoorPos.x, nextDoorPos.z, monster.LeaveFX, 1, nextDoorPos.x, nextDoorPos.z, nil, curDoorPos.y)
      end
    else
      local nextDoor = monster.left_door_id
      if monster.leftEntered == true then
        nextDoor = monster.right_door_id
      end
      if m1_cfg.Id == nextDoor then
        monster.isEntered = false
      end
    end
  end
end

function monster.on_self_npc_removed(monster)
  remove_missile_by_id(monster.CurFXid, monster.npc, false)
  
  local function remove()
    remove_missile_by_id(monster.left_door_id, monster.npc, false)
    remove_missile_by_id(monster.right_door_id, monster.npc, false)
  end
  
  monster:doAfter(remove, 0.5)
end

return monster
