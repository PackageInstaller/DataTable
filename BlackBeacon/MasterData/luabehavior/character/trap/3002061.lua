local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local monster = Util.create_class()

function monster._init(monster, npc)
  monster.npc = npc
  monster.search = {}
  set_can_searched(npc, false)
  enable_shadow(npc, false)
  set_npc_floating_text_hud_visible(npc, false)
  cast_magic(npc, npc, 399001, 1)
  set_npc_status(npc, 4, true)
  cast_magic(npc, npc, 399931, 1)
  cast_magic(npc, npc, 399932, 1)
  cast_magic(npc, npc, 399969, 1)
  cast_magic(npc, npc, 3001022003, 1)
  monster.CD = 0
  monster.hasMissile = true
  set_sync_var("instrument", 0)
  monster.detectMissile(monster)
  set_hud_config("zeroCD", {
    Prefab = "UI_Hud7",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 1, 300206103)
end

function monster.on_self_skill_hit(monster, skill_id, hit_target, hit_type, missile_cfg, missile)
  if (missile_cfg.Id == 30020610201 or missile_cfg.Id == 30020610101) and 1 == get_role_kind(hit_target) then
    if 0 ~= get_magic_num(get_come_on_hero(), 300206102) then
      for i = 1, 3 do
        set_sync_var(i, true)
      end
      abort_magic_by_id(get_come_on_hero(), 300206102, 1)
      print("踏板检测magic层数" .. tostring(get_magic_num(get_come_on_hero(), 300206102)))
    elseif get_cur_room_id() ~= 800401 then
      for i = 1, 3 do
        if get_npc_id(monster.npc) == 3002060 + i then
          set_sync_var("instrument", i)
        end
      end
    end
    if get_cur_room_id() == 800401 then
      for i = 1, 3 do
        set_sync_var(i, true)
      end
    end
  end
end

function monster.detectMissile(monster)
  if 0 == get_magic_num(get_come_on_hero(), 300206101) then
    if get_npc_time(monster.npc) >= monster.CD then
      set_sync_var("missileExist", true)
      monster.hasMissile = true
      cast_missile_new(monster.npc, monster.npc, nil, nil, 30020610101, 1)
      print("生成子弹1")
      monster.CD = math.huge
    end
  else
    print("monster.hasMissile为" .. tostring(monster.hasMissile))
    monster.hasMissile = true
    set_sync_var("missileExist", true)
    cast_missile_new(monster.npc, monster.npc, nil, nil, 30020610201, 1)
    return
  end
end

function monster.on_frame(monster)
  if monster.hasMissile == false then
    monster.detectMissile(monster)
    print("detectMissile1")
  end
  if false == get_sync_var("missileExist") then
    print("移除信号" .. tostring(get_sync_var("missileExist")))
    remove_missile_by_id(30020610101, monster.npc, false)
    monster.detectMissile(monster)
    print("detectMissile2")
  end
end

function monster.on_self_missile_end_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 30020610201 then
    monster.hasMissile = false
    cast_missile_new(monster.npc, monster.npc, nil, nil, 30020610101, 1)
    print("生成子弹2")
    active_hud(monster.npc, "zeroCD", "qipao_gd", false, "剩余时间")
  end
  if missile_cfg.Id == 30020610101 then
    if get_cur_room_id() == 800401 then
      remove_missile_by_id(30020610103, monster.npc, false)
    else
      for i = 1, 3 do
        if get_npc_id(monster.npc) == 3002060 + i then
          remove_missile_by_id(30020610101 + i, monster.npc, false)
        end
      end
    end
  end
  if missile_cfg.Id == 30020610101 then
    monster.hasMissile = false
    monster.CD = get_npc_time(monster.npc) + 3
    set_sync_var("missileExist", false)
    print("CD" .. tostring(monster.CD - get_npc_time(monster.npc)))
  end
end

function monster.on_self_missile_begin_pos(monster, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 30020610101 then
    if get_cur_room_id() == 800401 then
      cast_missile_new(monster.npc, monster.npc, nil, nil, 30020610103, 1)
    else
      for i = 1, 3 do
        if get_npc_id(monster.npc) == 3002060 + i then
          cast_missile_new(monster.npc, monster.npc, nil, nil, 30020610101 + i, 1)
        end
      end
    end
  end
  if missile_cfg.Id == 30020610201 then
    if get_cur_room_id() == 800401 then
      cast_missile_new(monster.npc, monster.npc, nil, nil, 30020610203, 1)
    else
      for i = 1, 3 do
        if get_npc_id(monster.npc) == 3002060 + i then
          cast_missile_new(monster.npc, monster.npc, nil, nil, 30020610201 + i, 1)
        end
      end
    end
    cast_magic(monster.npc, monster.npc, 300206103, 1, 100)
    active_hud(monster.npc, "zeroCD", "qipao_gd", true, "剩余时间")
  end
  if missile_cfg.Id == 30020610201 then
    monster.hasMissile = true
  end
end

function monster.on_self_npc_removed(monster)
  remove_missile_by_id(30020610101, monster.npc, false)
  remove_missile_by_id(30020610201, monster.npc, false)
  for i = 1, 3 do
    if get_npc_id(monster.npc) == 3002060 + i then
      remove_missile_by_id(30020610101 + i, monster.npc, false)
      remove_missile_by_id(30020610201 + i, monster.npc, false)
    end
  end
end

return monster
