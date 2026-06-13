local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local CHAPTER_NODE_STATE = Config.CommonDefine.CHAPTER_NODE_STATE
local TYPE_FUNC_NAME = {
  [Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE] = "set_node_detail_data",
  [Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT] = "set_point_detail_data"
}

function ui:ui_finish_load()
  self.v_star_light_list = {}
  local childCount = self.v_uiobjects.StarLayout.transform.childCount
  self.v_timer_name_list = {}
  for index = 1, childCount do
    self.v_star_light_list[index] = Util.get_child("Light", self.v_uiobjects["Star" .. index])
  end
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ON_CHAPTER_UPDATE, self.set_star_count, self)
end

function ui:ui_on_hide()
  self:stop_timer()
end

function ui:ui_on_destroy()
end

function ui:set_data(area_data, area_point_id)
  self.v_area_data = area_data
  self.v_area_point_cfg = area_data.point_gather[area_point_id]
  self.v_chapter_id = self.v_area_point_cfg.Chapter
  self.v_module_param = self.v_area_point_cfg.ModuleParam
  self.v_module_type = self.v_area_point_cfg.ModuleType
  self.v_object.name = area_point_id
  local func = TYPE_FUNC_NAME[self.v_module_type]
  if func and self[func] then
    self[func](self)
  else
    Log.Error("未定义区域模块类型:", self.v_module_type, "请联系程序添加", debug.traceback())
  end
  self:refresh_hard_color()
  self:set_type_icon()
  self:set_listener()
  self:set_boss_icon()
  self:set_offset()
  self:set_select_state()
  self:set_star_count()
  self:set_challenge_text_show()
end

function ui:refresh_hard_color()
  local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  if chapter_cfg.ChapterMode == Config.Chapter_Mode.HARD then
    Util.set_color(self.v_uicompents.Frame_img, "9d1e1e")
    Util.set_color(self.v_uicompents.Pivot_img, "9d1e1e")
  else
    Util.set_color(self.v_uicompents.Frame_img, "AE9577")
    Util.set_color(self.v_uicompents.Pivot_img, "AE9577")
  end
end

function ui:set_listener()
  local btn = self:get_button()
  btn.enabled = true
  self:set_button_listener(btn, function()
    self:on_click_detail_item()
  end)
end

function ui:set_challenge_text_show()
  self.v_uiobjects.StageNum:SetActive(true)
  self.v_uiobjects.Challenge:SetActive(false)
end

function ui:set_star_count()
  if self.v_module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
    self.v_uiobjects.StarLayout:SetActive(false)
    return
  end
  self.v_uiobjects.StarLayout:SetActive(true)
  local star_list = ChapterMgr:get_hard_node_star_count_by_id(self.v_chapter_id, self.v_module_param)
  for index, obj in pairs(self.v_star_light_list) do
    if star_list and star_list[index] then
      if star_list[index] ~= Config.CommonDefine.CHAPTER_STAR_STAING_STATE.INCOMPLETE then
        obj:SetActive(true)
      else
        obj:SetActive(false)
      end
    else
      obj:SetActive(false)
    end
  end
end

function ui:set_node_detail_data()
  local node_id = self.v_module_param
  local node_cfg = ShareRes.get_chapter_node_cfg(node_id)
  if node_cfg then
    local node_state = ChapterMgr:get_node_state(self.v_chapter_id, node_id)
    local is_lock = node_state == CHAPTER_NODE_STATE.LOCK
    local is_clear = node_state == CHAPTER_NODE_STATE.FINISHED
    self:set_stage_icon(node_cfg.PointBgPath, true)
    self:set_lock_state(is_lock, false)
    self:set_clear_state(is_clear)
    self:set_stage_num(node_cfg.TagNumName)
    self:refresh_treasure_chest(node_cfg)
  else
    Log.Error("节点配置不存在，节点ID：", node_id)
  end
end

function ui:set_point_detail_data()
  local point_id = self.v_module_param
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  if point_cfg then
    local point_state = ChapterMgr:get_chapter_point_state(self.v_chapter_id, point_id, true)
    local is_lock = point_state == CHAPTER_NODE_STATE.LOCK
    local is_clear = point_state == CHAPTER_NODE_STATE.FINISHED
    self:set_stage_icon(point_cfg.PointBgPath, true)
    self:set_lock_state(is_lock, false)
    self:set_clear_state(is_clear)
    self:set_stage_num(point_cfg.SerialNum)
    self:refresh_treasure_chest(point_cfg)
  else
    Log.Error("关卡配置不存在，节点ID：", point_id)
  end
end

function ui:refresh_treasure_chest(cfg)
  local box_group_id = cfg.BoxGroupId
  if not box_group_id or 0 == box_group_id then
    self.v_uiobjects.BoxTag:SetActive(false)
    return
  end
  self.v_uiobjects.BoxTag:SetActive(true)
  local finish_count, max_count = TreasureChestMgr:get_scene_treasure_chest_count(box_group_id)
  self.v_uicompents.BoxNum_txt.text = Util.format_str("{1}/{2}", finish_count, max_count)
end

function ui:set_boss_icon()
  local path = self.v_area_point_cfg.BossIconPath
  if path then
    ResMgr:load_set_icon(self.v_uicompents.BossIcon_img, path)
    self.v_uiobjects.BossIcon:SetActive(true)
  else
    self.v_uiobjects.BossIcon:SetActive(false)
  end
end

function ui:set_offset()
  local offset = self.v_area_point_cfg.Offset
  local rect = self:get_rect_transform()
  if offset and #offset >= 2 then
    rect:SetAnchoredPositionA(offset[1], offset[2])
  else
    rect:SetAnchoredPositionA(0, 0)
  end
end

function ui:set_stage_icon(path, is_texture)
  ResMgr:load_set_icon(self.v_uicompents.StageIcon_img, path, nil, is_texture, is_texture and self)
  ResMgr:load_set_icon(self.v_uicompents.StageIconGrey_img, path, nil, is_texture, is_texture and self)
end

function ui:set_lock_state(is_lock, mask_gray)
  Util.apply_grey_ex(self.v_uiobjects.StageIcon, is_lock and true ~= mask_gray)
  Util.apply_grey_ex(self.v_uiobjects.StageIconGrey, is_lock and true == mask_gray, true)
  self.v_uiobjects.StageIconGrey:SetActive(is_lock and true == mask_gray)
  self.v_uiobjects.LockMask:SetActive(is_lock)
  self.v_uiobjects.Lock:SetActive(is_lock)
end

function ui:set_clear_state(is_clear)
  self.v_uiobjects.Clear:SetActive(is_clear)
end

function ui:set_stage_num(stage_num)
  self.v_uicompents.StageNum_txt.text = stage_num
end

function ui:set_type_icon(path, is_texture)
  local type_cfg = ShareRes.get_chapter_area_point_type_cfg(self.v_area_point_cfg.IconType)
  ResMgr:load_set_icon(self.v_uicompents.TypeIcon_img, type_cfg.TypeIconPath, nil, is_texture)
end

function ui:set_select_state()
  local select_chapter_id, select_module_param, select_module_type = self.v_parent_ui:get_select_param()
  local is_select = select_chapter_id == self.v_chapter_id and select_module_param == self.v_module_param and select_module_type == self.v_module_type
  self.v_uiobjects.Select:SetActive(is_select)
end

function ui:on_click_detail_item(not_move)
  if not self:check_can_select() then
    return
  end
  self.v_parent_ui:on_click_detail_item(self.v_area_point_cfg, not_move)
  self:set_select_state()
end

function ui:get_area_point_id()
  return self.v_area_point_cfg.Id
end

function ui:get_area_point_cfg()
  return self.v_area_point_cfg
end

function ui:get_left_end_point_pos()
  local parent_anchored_pos = self:get_rect_transform().anchoredPosition
  return self.v_uicompents.LeftEndPoint_rect.anchoredPosition + parent_anchored_pos
end

function ui:get_right_end_point_pos()
  local parent_anchored_pos = self:get_rect_transform().anchoredPosition
  return self.v_uicompents.RightEndPoint_rect.anchoredPosition + parent_anchored_pos
end

function ui:get_self_obj_pos()
  local parent_anchored_pos = self:get_rect_transform().anchoredPosition
  return self.v_uicompents.RightEndPoint_rect.anchoredPosition + parent_anchored_pos
end

function ui:check_can_select()
  local allow_click = true
  local id = self.v_module_param
  local state, tip_srt
  if self.v_module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
    local node_cfg = ShareRes.get_chapter_node_cfg(id)
    state = ChapterMgr:get_node_state(self.v_chapter_id, id)
    tip_srt = node_cfg.UnlockText
    if node_cfg.NodeType == Config.ENTER_NODE_TYPE.STORY_NODE then
      allow_click = true
    else
      allow_click = node_cfg.ExploreNode ~= nil
    end
  elseif Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT then
    local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
    local result_id = Condition:check_condition_list(chapter_cfg.Condition)
    state, tip_srt = ChapterMgr:get_chapter_point_state(self.v_chapter_id, id)
    if 0 ~= result_id then
      local con_cfg = ShareRes.create("condition.condition", result_id)
      Util.show_message_tip(con_cfg.Desc)
      return
    end
  end
  if state == CHAPTER_NODE_STATE.LOCK then
    UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str(tip_srt))
  elseif state == CHAPTER_NODE_STATE.UNLOCK then
    return true
  elseif allow_click then
    return true
  else
    UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("当前节点已完成"))
  end
end

function ui:move_to_target_area_point(target_node_id)
  local area_point_cfg = ShareRes.get_chapter_area_point_cfg_by_module(Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE, target_node_id)
  if area_point_cfg then
    local area_id = area_point_cfg.AreaId
    local area_point_id = area_point_cfg.Id
    self.v_parent_ui:move_to_target_area_point(area_id, area_point_id, true, false)
  else
    Log.Error(string.format("节点%s未配置区域点位配置", target_node_id))
  end
end

function ui:stop_timer(timer_name)
  if timer_name then
    if self.v_timer_name_list[timer_name] then
      Timer:remove_timer(self.v_timer_name_list[timer_name])
      self.v_timer_name_list[timer_name] = nil
    end
  else
    for name, timer_index in pairs(self.v_timer_name_list) do
      Timer:remove_timer(timer_index)
      self.v_timer_name_list[name] = nil
    end
  end
end

function ui:play_pd(cb, pd, timer_name)
  local duration = pd.duration
  pd:ResetPD()
  pd:Play()
  self:stop_timer(timer_name)
  self.v_timer_name_list[timer_name] = Timer:add_timer(timer_name, duration, cb, self)
end

function ui:play_unlock_pd(cb)
  local tiemr_name = "play_unlock_pd"
  
  local function unlock_cb(item)
    if cb then
      cb()
    end
    item.v_uicompents.UnLockPd_pd:ResetPD()
    item:stop_timer(tiemr_name)
    self:set_lock_state(false, false)
  end
  
  self:play_pd(unlock_cb, self.v_uicompents.UnLockPd_pd, tiemr_name)
end

function ui:play_clear_pd(cb)
  local tiemr_name = "play_clear_pd"
  
  local function clear_cb(item)
    if cb then
      cb()
    end
    item.v_uicompents.ClearPd_pd:ResetPD()
    item:stop_timer(tiemr_name)
  end
  
  self:play_pd(clear_cb, self.v_uicompents.ClearPd_pd, tiemr_name)
end

function ui:update_lock_state()
  local node_id = self.v_module_param
  local node_state = ChapterMgr:get_node_state(self.v_chapter_id, node_id)
  local is_lock = node_state == CHAPTER_NODE_STATE.LOCK
  self:set_lock_state(is_lock, false)
end

return ui
