local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local COLOR_STR = {CUR_FLOOR = "F5EDE2", OHTER = "AE9577"}

function ui:ui_finish_load()
end

function ui:ui_on_show()
  self:refresh_view()
end

function ui:ui_on_hide()
  self.v_cur_light_obj = nil
  self.v_next_light_obj = nil
  self:remove_start_timer()
  self:remove_end_timer()
  self:remove_hide_timer()
end

function ui:ui_on_destroy()
end

function ui:refresh_view()
  Global.sound_mgr:play_common_sound("Sound_switch_layer")
  local tower = TowerMgr:get_tower()
  if not tower then
    Log.Error("获取塔进失败", debug.traceback())
    return
  end
  local progress = TowerMgr:get_tower_progress()
  local episode_id = progress and progress.episode_id
  if not episode_id then
    Log.Error("获取塔进度信息失败", debug.traceback())
    return
  end
  local point_cfg = ShareRes.get_chapter_point_cfg(episode_id)
  ResMgr:load_set_icon(self.v_uicompents.StageIcon_img, point_cfg.PointBgPath, nil, true, self)
  local ring_id = ShareRes.get_ring_id_by_point_id(episode_id)
  local ring_cfg = ShareRes.get_curse_ring_config(ring_id)
  if ring_cfg.StageIconPos then
    self.v_uicompents.StageIcon_rect:SetAnchoredPositionA(ring_cfg.StageIconPos[1] or 0, ring_cfg.StageIconPos[2] or 0)
    self.v_uicompents.StageIcon_rect:SetLocalScaleA(ring_cfg.StageIconPos[3] or 1)
  end
  local max_floor = tower:get_max_floor()
  local cur_floor = tower:get_floor_num()
  local child_count = self.v_uiobjects.Floor.transform.childCount
  local show_root, show_light, floor, num, light, color
  for index = 1, child_count do
    floor = self.v_uiobjects["Floor" .. index]
    if floor then
      show_root = index <= max_floor
      show_light = cur_floor == index
      floor:SetActive(show_root)
      light = self.v_uiobjects["FloorNow" .. index]
      light.gameObject:SetActive(show_light)
      num = self.v_uicompents["Num" .. index .. "_txt"]
      num.text = index
      color = COLOR_STR.OHTER
      if show_light then
        self.v_cur_light_obj = light
        color = COLOR_STR.CUR_FLOOR
      elseif cur_floor + 1 == index then
        self.v_next_light_obj = light
      end
      Util.set_color(num, color)
    end
  end
  if self.v_cur_light_obj then
    local tf = self.v_cur_light_obj.transform
    local parent = tf.parent
    self.v_uiobjects.ParticleStart.transform:SetParent(parent, false)
    self.v_uiobjects.ParticleStart.transform.localPosition = tf.localPosition
    self.v_uiobjects.ParticleTrail.transform:SetParent(parent, false)
    self.v_uiobjects.ParticleTrail.transform.localPosition = tf.localPosition
  end
  if self.v_next_light_obj then
    local tf = self.v_next_light_obj.transform
    local parent = tf.parent
    self.v_uiobjects.ParticleEnd.transform:SetParent(parent, false)
    self.v_uiobjects.ParticleEnd.transform.localPosition = tf.localPosition
  end
  self:remove_start_timer()
  self:remove_end_timer()
  self:remove_hide_timer()
  self.v_start_timer = Timer:add_timer("ParticleStart", 1.2, function()
    if not Util.is_nil(self.v_cur_light_obj) then
      color = COLOR_STR.OHTER
      Util.set_color(self.v_uicompents["Num" .. cur_floor .. "_txt"], color)
      self.v_cur_light_obj:SetActive(false)
      self.v_cur_light_obj = nil
    end
    self:remove_start_timer()
  end)
  self.v_end_timer = Timer:add_timer("ParticleEnd", 1.8, function()
    if not Util.is_nil(self.v_next_light_obj) then
      color = COLOR_STR.CUR_FLOOR
      Util.set_color(self.v_uicompents["Num" .. cur_floor + 1 .. "_txt"], color)
      self.v_next_light_obj:SetActive(true)
      self.v_next_light_obj = nil
    end
    self:remove_end_timer()
  end)
  self.v_hide_timer = Timer:add_timer("hide", 3.8, function()
    ChallengeRingPlusMgr:req_enter_door()
    self:remove_hide_timer()
  end)
end

function ui:remove_start_timer()
  if self.v_start_timer then
    Timer:remove_timer(self.v_start_timer)
    self.v_start_timer = nil
  end
end

function ui:remove_end_timer()
  if self.v_end_timer then
    Timer:remove_timer(self.v_end_timer)
    self.v_end_timer = nil
  end
end

function ui:remove_hide_timer()
  if self.v_hide_timer then
    Timer:remove_timer(self.v_hide_timer)
    self.v_hide_timer = nil
  end
end

return ui
