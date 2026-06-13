local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BUILDING_TYPE = Config.CommonDefine.BUILDING_TYPE
local BUILDING_CONFIG = require("uimodule.building.building_config")
local BUILDING_ROOT_NAME_MAP = {
  [BUILDING_TYPE.TOWER] = "MainTower",
  [BUILDING_TYPE.ADVENTURE] = "Task",
  [BUILDING_TYPE.FACTORY] = "ProductRoom",
  [BUILDING_TYPE.STAMINA] = "Force",
  [BUILDING_TYPE.COMBINE] = "ItemSynthesis"
}
local BUILDING_REFRESH_FUNC_NAME_MAP = {
  [BUILDING_TYPE.TOWER] = "refresh_main_tower_root",
  [BUILDING_TYPE.ADVENTURE] = "refresh_task_root",
  [BUILDING_TYPE.FACTORY] = "refresh_product_root",
  [BUILDING_TYPE.STAMINA] = "refresh_force_root",
  [BUILDING_TYPE.COMBINE] = "ItemSynthesis"
}
local BUILDING_CLICK_FUNC_NAME_MAP = {
  [BUILDING_TYPE.TOWER] = "on_click_main_tower_btn",
  [BUILDING_TYPE.ADVENTURE] = "on_click_task_btn",
  [BUILDING_TYPE.FACTORY] = "on_click_product_room_btn",
  [BUILDING_TYPE.STAMINA] = "on_click_force_btn",
  [BUILDING_TYPE.COMBINE] = "on_click_item_synthesis_btn"
}

function ui:on_building_data_update(msg)
  self:refresh_all_recive_btn()
end

function ui:on_click_building(building_type)
  if not BuildingMgr:check_building_is_unlock(building_type, true) then
    UIMgr:try_show_ui("building_main_unlock_tips", nil, building_type)
    return
  end
  local func_name = BUILDING_CLICK_FUNC_NAME_MAP[building_type]
  if func_name and self[func_name] then
    self[func_name]()
  end
end

function ui:on_click_return_btn()
  self:ui_hide()
end

function ui:on_click_task_group_btn()
  local misc_cfg = ShareRes.get_building_misc_cfg()
  if not Util.is_more_than_zero(misc_cfg.TaskGroupId) then
    return
  end
  local task_group_id = misc_cfg.TaskGroupId
  local cfg_group = ShareRes.get_task_group_cfg(task_group_id)
  if not cfg_group then
    return
  end
  UIMgr:get_ui("chapter_task"):ui_show(nil, task_group_id)
end

function ui:on_click_main_tower_btn()
  UIMgr:get_ui("building_tower_view"):ui_show()
end

function ui:on_click_force_btn()
  UIMgr:get_ui("uiforcerecharg"):ui_show(3)
end

function ui:on_click_item_synthesis_btn()
  UIMgr:get_ui("new_ui_item_synthesis"):ui_show()
end

function ui:on_click_product_room_btn()
  UIMgr:get_ui("building_factory_room"):ui_show()
end

function ui:on_click_task_btn()
  UIMgr:get_ui("building_adventrue_main"):ui_show()
end

function ui:on_click_all_recive_btn()
  local building_data = BuildingMgr:get_building_data(BUILDING_TYPE.FACTORY)
  if building_data and building_data.factory_list then
    for factory_id in pairs(building_data.factory_list) do
      if BuildingMgr:factory_is_full(factory_id) then
        BuildingMgr:requst_factory_gain_award(factory_id)
      end
    end
  end
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_return_btn()
  end)
  self:set_button("BtnTask", function()
    self:on_click_task_group_btn()
  end)
  self:set_button("MainTower", function()
    self:on_click_building(BUILDING_TYPE.TOWER)
  end)
  self:set_button("Force", function()
    self:on_click_building(BUILDING_TYPE.STAMINA)
  end)
  self:set_button("ItemSynthesis", function()
    self:on_click_building(BUILDING_TYPE.COMBINE)
  end)
  self:set_button("ProductRoom", function()
    self:on_click_building(BUILDING_TYPE.FACTORY)
  end)
  self:set_button("Task", function()
    self:on_click_building(BUILDING_TYPE.ADVENTURE)
  end)
  self:set_button("BtnAllRecive", function()
    self:on_click_all_recive_btn()
  end)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.BtnTaskRedPoint, RedEnum.BUILDING_TASK)
  self.v_canvas = self:get_canvas()
end

function ui:ui_on_show(pop_by_stack)
  self:bind_auto_mq(Const.MSG_ON_BUILDING_DATA_UPDATE, self.on_building_data_update, self)
  
  local function open_scene_cb()
    self.v_uiobjects.Fx_Cloud:SetActive(not pop_by_stack)
    self:play_playable_director("Ani_UIHomeMain_In")
    self.v_uiobjects.Black:SetActive(false)
    BuildingMgr:set_scene_visible(true)
    self:refresh_view()
    self.v_camera = BuildingMgr:get_building_scene_camera()
  end
  
  self.v_uiobjects.Black:SetActive(true)
  BuildingMgr:open_building_scene(open_scene_cb)
end

function ui:ui_on_hide()
  BuildingMgr:set_scene_visible(false)
end

function ui:ui_on_destroy()
  BuildingMgr:release_building_scene()
end

function ui:refresh_view()
  local go, lock_go, unlock_go, name_txt, lock_name_txt, unlockable_go, tag_unlock_go, building_unlock, building_level, building_cfg, building_level_cfg, rect_pos, can_unlock
  for building_type, go_name in pairs(BUILDING_ROOT_NAME_MAP) do
    building_unlock = BuildingMgr:check_building_is_unlock(building_type)
    can_unlock = not building_unlock and BuildingMgr:building_level_up_check(building_type)
    building_level = BuildingMgr:get_building_level(building_type)
    building_level_cfg = ShareRes.get_building_level_cfg(building_type, building_level)
    go = self.v_uiobjects[go_name]
    if go then
      building_cfg = ShareRes.get_building_cfg(building_type)
      lock_go = self:get_child_gameobj("Lock_", go)
      unlock_go = self:get_child_gameobj("UnLock_", go)
      unlockable_go = self:get_child_gameobj("Unlockable_", go)
      tag_unlock_go = self:get_child_gameobj("TagLock_", go)
      local rect_tf = self:get_rect_transform(nil, unlock_go)
      rect_pos = building_level_cfg and building_level_cfg.EntrancePos
      if rect_pos and rect_pos[1] and rect_pos[2] then
        rect_tf:SetAnchoredPositionA(rect_pos[1], rect_pos[2])
      else
        rect_tf:SetAnchoredPositionA(0, 0)
      end
      name_txt = self:get_text("Name", unlock_go).component
      name_txt.text = building_cfg.Name
      lock_name_txt = self:get_text("Name", lock_go).component
      lock_name_txt.text = building_cfg.Name
      lock_go:SetActive(not can_unlock and not building_unlock)
      unlock_go:SetActive(building_unlock)
      unlockable_go:SetActive(can_unlock)
      tag_unlock_go:SetActive(can_unlock)
      local refresh_func_name = BUILDING_REFRESH_FUNC_NAME_MAP[building_type]
      if refresh_func_name and self[refresh_func_name] then
        self[refresh_func_name](self, go)
      end
    end
  end
  self:refresh_all_recive_btn()
end

function ui:refresh_task_root(go)
  BuildingMgr:check_building_redpoint_by_type(BUILDING_TYPE.ADVENTURE)
  local tag = self:get_child_gameobj("Tag_", go)
  local working = self:get_child_gameobj("TagWorking_", go)
  local un_working = self:get_child_gameobj("TagUnWorking_", go)
  RedPointMgr:bind_redpoint(self, tag, RedEnum.ADVENTURE)
  local working_active, unworking_active = false, false
  if not tag.activeSelf and BuildingMgr:check_building_is_unlock(BUILDING_TYPE.ADVENTURE) then
    local red_state = BuildingMgr:get_dispatch_red_state()
    if red_state == BUILDING_CONFIG.BUILDING_WORK_TAG.WORKING then
      working_active = true
    elseif red_state == BUILDING_CONFIG.BUILDING_WORK_TAG.UNWORKING then
      unworking_active = true
    end
  end
  working:SetActive(working_active)
  un_working:SetActive(unworking_active)
end

function ui:refresh_product_root(go)
  local tag = self:get_child_gameobj("Tag_", go)
  local working = self:get_child_gameobj("TagWorking_", go)
  local un_working = self:get_child_gameobj("TagUnWorking_", go)
  RedPointMgr:bind_redpoint(self, tag, RedEnum.FACTORY)
  local working_active, unworking_active = false, false
  if not tag.activeSelf and BuildingMgr:check_building_is_unlock(BUILDING_TYPE.FACTORY) then
    local red_state = BuildingMgr:get_factory_red_state()
    if red_state == BUILDING_CONFIG.BUILDING_WORK_TAG.WORKING then
      working_active = true
    elseif red_state == BUILDING_CONFIG.BUILDING_WORK_TAG.UNWORKING then
      unworking_active = true
    end
  end
  working:SetActive(working_active)
  un_working:SetActive(unworking_active)
end

function ui:refresh_force_root(go)
  local tag = self:get_child_gameobj("Tag_", go)
  local working = self:get_child_gameobj("TagWorking_", go)
  local un_working = self:get_child_gameobj("TagUnWorking_", go)
  RedPointMgr:bind_redpoint(self, tag, RedEnum.STAMINA)
  local working_active, unworking_active = false, false
  if not tag.activeSelf and BuildingMgr:check_building_is_unlock(BUILDING_TYPE.STAMINA) then
    working_active = true
  end
  working:SetActive(working_active)
  un_working:SetActive(unworking_active)
end

function ui:refresh_main_tower_root(go)
  local redpoint = self:get_child_gameobj("UnLock_/RedPoint_", go)
  RedPointMgr:bind_redpoint(self, redpoint, RedEnum.TOWER)
end

function ui:refresh_all_recive_btn()
  local active_btn = false
  local building_data = BuildingMgr:get_building_data(BUILDING_TYPE.FACTORY)
  if building_data and building_data.factory_list then
    for factory_id in pairs(building_data.factory_list) do
      if BuildingMgr:factory_is_full(factory_id) then
        active_btn = true
        break
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.FACTORY, active_btn)
  self.v_uiobjects.BtnAllRecive:SetActive(active_btn)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return true
end

function ui:response_click_escape()
  local RESPONCE_ESCAPE_TYPE = UIMgr.RESPONCE_ESCAPE_TYPE
  return self.v_uiobjects.Black.activeSelf and RESPONCE_ESCAPE_TYPE.ESCAPE_CUSTOM or RESPONCE_ESCAPE_TYPE.AUTO_CALL
end

function ui:ui_on_update()
  self:update_btn_pos()
end

function ui:update_btn_pos()
  if not self:visible() or not self.v_camera then
    return
  end
  BuildingMgr:pass_update()
  local binding_pos_map = BuildingMgr:get_ui_binding_pos_map()
  if not binding_pos_map then
    return
  end
  for building_type, go_name in pairs(BUILDING_ROOT_NAME_MAP) do
    local binding_pos = binding_pos_map[building_type]
    local ui_go = self.v_uiobjects[go_name]
    if binding_pos and ui_go then
      local screen_pos_x, screen_pos_y = UtilUI.world_to_screen_pos(self.v_camera, self.v_canvas, binding_pos[1], binding_pos[2], binding_pos[3])
      ui_go.transform:SetAnchoredPositionA(screen_pos_x, screen_pos_y)
    end
  end
end

return ui
