local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local treasure_check_handbook_node_item_key = "treasure_check_handbook_node_item_key"
local treasure_check_handbook_box_item_key = "treasure_check_handbook_box_item_key"
local BUILDING_CONFIG = require("uimodule.building.building_config")
local BUILDING_DISPATCH_TASK_TYPE = BUILDING_CONFIG.BUILDING_DISPATCH_TASK_TYPE

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("RightBtn", function()
    self:on_next_or_last_btn_click(true)
  end)
  self:set_button("LeftBtn", function()
    self:on_next_or_last_btn_click(false)
  end)
  self:set_button("BtnSkip", function()
    self:on_btn_skip_click()
  end)
  self.v_node_content_rect_trans = Util.get_rect_transform(nil, self.v_uiobjects.NodeContent)
  self.v_init_pos_x, self.v_init_pos_y = self.v_node_content_rect_trans:GetAnchoredPositionA()
  self.v_item_height = Util.get_rect_transform(nil, self.v_uiobjects.NodeItem).rect.height
  self.v_scroll_view_height = Util.get_rect_transform("SafeArea/Scroll View", self.v_object).rect.height
  self.v_one_page_count = math.ceil(self.v_scroll_view_height / self.v_item_height)
  self:register_exist_auto_template(treasure_check_handbook_node_item_key, self.v_uiobjects.NodeItem, self.v_uiobjects.NodeContent)
  self:register_exist_auto_template(treasure_check_handbook_box_item_key, self.v_uiobjects.BoxItem, self.v_uiobjects.NodeContent)
end

function ui:ui_on_show(chapter_id, hide_jump)
  self.v_hide_jump = hide_jump
  self.v_page_type = ShareRes.get_chapter_page_type(chapter_id)
  local all_chapter_index_list
  if not chapter_id or 0 == chapter_id then
    all_chapter_index_list = TreasureChestMgr:get_all_page_un_lock_chapter_id()
  else
    all_chapter_index_list = ChapterMgr:get_all_unlock_chapter_cfg(self.v_page_type, true)
  end
  self.v_all_chapter_index_list = {}
  for _, cfg_id in pairs(all_chapter_index_list) do
    local _, total_count = TreasureChestMgr:get_chapter_treasure_chest_count(cfg_id)
    if total_count > 0 then
      table.insert(self.v_all_chapter_index_list, cfg_id)
    end
  end
  self:refresh_chapter_info(chapter_id)
end

function ui:refresh_chapter_info(chapter_id)
  self.v_chapter_id = chapter_id
  self:refresh_next_and_last_btn_visible()
  self.v_chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  self:refresh_chapter_image()
  self:refresh_chapter_name()
  self:refresh_progress()
  self:refresh_list()
  self:refresh_system_open()
  TreasureChestMgr:reset_build_box_list(self.v_chapter_id)
end

function ui:refresh_chapter_image()
  ResMgr:load_set_icon(self.v_uicompents.ChapterImage_img, self.v_chapter_cfg.PicName, nil, true, self)
end

function ui:refresh_chapter_name()
  self.v_uicompents.ChapterTitle_txt.text = self.v_chapter_cfg.ClientNum
  self.v_uicompents.ChapterTitleNum_txt.text = self.v_chapter_cfg.Name
end

function ui:refresh_progress()
  local finish_count, total_count = TreasureChestMgr:get_chapter_treasure_chest_count(self.v_chapter_id)
  if 0 == total_count then
    self.v_uiobjects.CollectSchedule:SetActive(false)
    return
  end
  self.v_uiobjects.CollectSchedule:SetActive(true)
  local progress = finish_count / total_count
  self.v_uicompents.CollectSchedule_txt.text = math.floor(progress * 100) .. "%"
  self.v_uicompents.ScheduleSlider_img.fillAmount = progress
end

function ui:refresh_list()
  self:give_back_auto_cache(treasure_check_handbook_node_item_key)
  self:give_back_auto_cache(treasure_check_handbook_box_item_key)
  local node_cfg_list = TreasureChestMgr:get_box_node_cfg_list(self.v_chapter_id)
  local need_move_to_index = 0
  local all_index = 0
  for _, node_cfg in pairs(node_cfg_list) do
    all_index = all_index + 1
    local node_item_obj = self:get_auto_cache(treasure_check_handbook_node_item_key)
    self:refresh_node_item(node_item_obj, node_cfg)
    local box_cfg_list = TreasureChestMgr:get_box_cfg_list(node_cfg.BoxGroupId)
    local parent = Util.get_child_gameobj("BoxContent_", node_item_obj).transform
    local is_all_finish = true
    if box_cfg_list then
      for _, box_cfg in pairs(box_cfg_list) do
        local box_item_obj = self:get_auto_cache(treasure_check_handbook_box_item_key)
        box_item_obj.transform:SetParent(parent)
        local is_finished = self:refresh_box_item(box_item_obj, box_cfg, node_cfg)
        if not is_finished then
          is_all_finish = false
        end
      end
    end
    if is_all_finish and need_move_to_index < all_index then
      need_move_to_index = all_index
    end
  end
  local pos_y
  if 1 == all_index then
    pos_y = self.v_init_pos_y
  elseif all_index - need_move_to_index + 1 >= self.v_one_page_count then
    pos_y = self.v_init_pos_y + (need_move_to_index - 1) * self.v_item_height
  else
    pos_y = self.v_init_pos_y + (all_index - 3) * self.v_item_height + self.v_scroll_view_height
  end
  self.v_node_content_rect_trans:SetAnchoredPositionY(pos_y)
end

function ui:refresh_node_item(node_item_obj, node_cfg)
  Util.get_text("Title/StageNum_", node_item_obj).text = node_cfg.TagNumName
  Util.get_text("Title/StageNum2_", node_item_obj).text = node_cfg.MainName
  Util.get_child_gameobj("Title/lock_", node_item_obj):SetActive(false)
  local finish_count, max_count = TreasureChestMgr:get_scene_treasure_chest_count(node_cfg.BoxGroupId)
  Util.get_text("BoxBg/CurremtNum_", node_item_obj).text = finish_count
  Util.get_text("BoxBg/AllNum_", node_item_obj).text = max_count
  Util.get_image("Round1/RoundSchedule_", node_item_obj).fillAmount = finish_count / max_count
end

function ui:refresh_box_item(box_item_obj, box_cfg, node_cfg)
  local state = ChapterMgr:get_node_state(self.v_chapter_id, node_cfg.Id)
  local is_lock = state == Config.CommonDefine.CHAPTER_NODE_STATE.LOCK
  local is_finished = TreasureChestMgr:get_treasure_chest_is_finished(box_cfg.Id)
  Util.get_child_gameobj("CodexLock_", box_item_obj):SetActive(is_lock)
  Util.get_child_gameobj("MaskImage_/Received_", box_item_obj):SetActive(is_finished)
  Util.get_child_gameobj("AlphaMask", box_item_obj):SetActive(not is_finished and not is_lock)
  local icon = Util.get_image("MaskImage_/mask/UIBoxImage_", box_item_obj)
  ResMgr:load_set_icon(icon, box_cfg.Texture, nil, true, self)
  local btn = Util.get_button(nil, box_item_obj)
  self:set_button_listener(btn, function()
    if is_lock then
      Util.show_message_tip(2371)
      return
    end
    UIMgr:get_ui("ui_treasure_chest_preview"):ui_show(box_cfg.Texture)
  end)
  return is_finished
end

function ui:refresh_box_anim(box_item_obj, box_cfg)
  local is_building = TreasureChestMgr:get_is_building(box_cfg.Id)
  if is_building then
    Log.Error("播放动效 宝箱Id", box_cfg.Id)
  end
end

function ui:on_next_or_last_btn_click(is_next)
  self.v_uiobjects.Ani_UIStageBoxCodex_Select:SetActive(false)
  self.v_uiobjects.Ani_UIStageBoxCodex_Select:SetActive(true)
  Timer:add_timer("treasure_chest_handbook_delay", 0.35, function()
    self.v_chapter_id = self.v_all_chapter_index_list[is_next and self.v_chapter_index + 1 or self.v_chapter_index - 1]
    local chapter_detail_ui = UIMgr:try_get_visible_ui("ui_chapter_detail")
    if chapter_detail_ui then
      chapter_detail_ui:change_select_by_chapter_id(self.v_chapter_id)
    end
    self:refresh_chapter_info(self.v_chapter_id)
  end)
end

function ui:refresh_system_open()
  local is_open = SysOpenMgr:get_sys_is_open(59)
  self.v_uiobjects.SystemUnlock:SetActive(not is_open)
  local is_all_box_opened = TreasureChestMgr:get_all_chapter_treasure_chest_opened()
  self.v_uiobjects.BtnSkip:SetActive(is_open and not is_all_box_opened and not self.v_hide_jump)
  self.v_uiobjects.Hint:SetActive(not is_all_box_opened and not self.v_hide_jump)
  if not is_open then
    self.v_uicompents.SystemUnlockText_txt.text = SysOpenMgr:get_sys_tips(59)
  end
end

function ui:on_btn_skip_click()
  self:ui_hide()
  UIMgr:get_ui("building_adventrue_main"):ui_show(BUILDING_DISPATCH_TASK_TYPE.BOX)
end

function ui:refresh_next_and_last_btn_visible()
  self.v_chapter_index = self:get_select_chapter_index()
  local next_id = self.v_all_chapter_index_list[self.v_chapter_index + 1]
  local last_id = self.v_all_chapter_index_list[self.v_chapter_index - 1]
  local can_next = nil ~= next_id and ChapterMgr:check_chapter_is_unlock(next_id, false)
  local can_last = nil ~= last_id and ChapterMgr:check_chapter_is_unlock(last_id, false)
  self.v_uiobjects.RightBtn:SetActive(can_next)
  self.v_uiobjects.LeftBtn:SetActive(can_last)
end

function ui:get_select_chapter_index()
  for index, id in pairs(self.v_all_chapter_index_list) do
    if id == self.v_chapter_id then
      return index
    end
  end
  self.v_chapter_id = self.v_all_chapter_index_list[#self.v_all_chapter_index_list]
  return #self.v_all_chapter_index_list
end

function ui:ui_on_hide()
  self.v_uiobjects.Ani_UIStageBoxCodex_Select:SetActive(false)
end

function ui:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

return ui
