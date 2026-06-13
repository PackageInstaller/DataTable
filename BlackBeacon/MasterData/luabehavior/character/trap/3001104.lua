local M = Util.create_class()

function M:_init()
  set_ui_object_visible("fight", "Btn_skillTower", false)
  self.hero = get_come_on_hero()
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg)
  if target == get_come_on_hero() then
    set_sync_var("stop_2040903", true)
  end
end

function M:on_start()
  if get_cur_room_id() == 104401 then
    self:apply_second_scene_illumination()
  end
  if get_cur_room_id() == 104601 then
    self:apply_second_scene_illumination()
  end
end

function M:on_story_begin(story_id, step_id, param)
  if 4040811 == story_id then
    if 3 == step_id then
      play_timeline("timeline_n14101-1", 0, 0, nil, false, true, true)
      set_sceneobj_visible_save_state("/Root/Change_/Change_night/Level2/timeline_n14101-11", true)
    end
    if 4 == step_id then
      self:apply_defualt_scene_illumination()
      abort_magic_by_id(self.npc, 3001044001)
    end
    if 8 == step_id then
      stop_timeline("timeline_104401_2")
      stop_timeline("timeline_104401_3")
    end
    if 12 == step_id then
      play_timeline("timeline_104401_2", 2, 2, nil, false, true, true)
    end
    if 15 == step_id then
      play_timeline("timeline_104401_3", 2, 2, nil, false, true, true)
    end
  end
  if 4041001 == story_id and 3 == step_id then
    self:apply_defualt_scene_illumination()
  end
  if 4041003 == story_id then
    if 1 == step_id then
      stop_timeline("timeline_104401_2")
      stop_timeline("timeline_104401_3")
    end
    if 4 == step_id then
      set_sceneobj_visible_save_state("/Root/Level_/FX_water", false)
    end
    if 5 == step_id then
      play_timeline("timeline_104401_2", 2, 2, nil, false, true, true)
    end
    if 7 == step_id then
      play_timeline("timeline_104401_3", 2, 2, nil, false, true, true)
    end
    if 9 == step_id then
      set_sceneobj_visible_save_state("/Root/Level_/luzhuang1/L1_/A1", true)
    end
  end
end

function M:on_story_finish(story_id)
  if 4041003 == story_id then
    stop_timeline("timeline_104401_2")
    stop_timeline("timeline_104401_3")
  end
end

function M:on_frame()
  if get_cur_room_id() == 104501 then
    if check_betargetd(self.hero) and not self.rise_up then
      self.rise_up = true
      set_sceneobj_visible_save_state("/Root/Change_/Change_night/Level2/A4 /L3_/A1", false)
      set_sceneobj_visible_save_state("/Root/Change_/Change_night/Level2/A4 /L3_/A4", true)
    elseif not check_betargetd(self.hero) and self.rise_up then
      self.rise_up = nil
      set_sceneobj_visible_save_state("/Root/Change_/Change_night/Level2/A4 /L3_/A4", false)
      set_sceneobj_visible_save_state("/Root/Change_/Change_night/Level2/A4 /L3_/A1", true)
    end
  end
  if get_cur_room_id() == 104401 then
    local player = get_come_on_hero()
    local role = player:get_behavior()
    if not role then
      return
    end
    self.isInBattle = role:isInBattle()
    if true == self.isInBattle then
      set_sync_var("isInBattle", true)
    else
      set_sync_var("isInBattle", false)
    end
  end
end

function M:apply_defualt_scene_illumination()
  if not SceneMgr then
    return
  end
  SceneMgr:apply_defualt_scene_illumination()
end

function M:apply_second_scene_illumination()
  if not SceneMgr then
    return
  end
  SceneMgr:apply_second_scene_illumination()
end

return M
