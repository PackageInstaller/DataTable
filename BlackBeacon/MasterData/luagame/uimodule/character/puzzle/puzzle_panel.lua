local Base = require("ui.uibase")
local LoopListClass = require("ui.widget.infinite_loop_list")
local AssetBarView = require("ui.asset_bar.asset_bar")
local PuzzleItemClass = require("uimodule.character.puzzle.puzzle_item")
local SIZE_ICON_COLOR_ACTIVE = Util.get_unity_color_by_hex(tonumber("f5ede2", 16))
local SIZE_ICON_COLOR_INACTIVE = Util.get_unity_color_by_hex(tonumber("ae9577", 16))
local GetPuzzleJumpId = ShareRes.get_comm_value("GetPuzzleJumpId")
local VIEW_TYPE = Config.PUZZLE_OPERATE_PANEL_VIEW_TYPE
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self.v_puzzle_operate_view = self:get_panel("puzzle_operate_view")
  self.v_puzzle_up_lv_view = self:get_panel("puzzle_up_lv_view")
  self.v_puzzle_decompose_view = self:get_panel("puzzle_decompose_view")
  self.v_puzzle_filter_view = self:get_panel("puzzle_filter_view")
  self.v_puzzle_refine_view = self:get_panel("puzzle_refine_view")
  self.v_views = {
    [VIEW_TYPE.OPERATE] = self.v_puzzle_operate_view,
    [VIEW_TYPE.UP_LV] = self.v_puzzle_up_lv_view,
    [VIEW_TYPE.DECOMPOSE] = self.v_puzzle_decompose_view,
    [VIEW_TYPE.REFINE] = self.v_puzzle_refine_view
  }
  self:set_button("Bg", function()
  end)
  self:set_button("BtnRet1", function()
    if self.v_need_return_operate_view then
      self.v_puzzle_operate_view:set_need_show_anim(true)
      self:set_view_enable(VIEW_TYPE.OPERATE)
      self.v_need_return_operate_view = false
      return
    end
    self.v_cur_view_type = nil
    self:ui_hide()
  end)
  self:set_button("BtnJump", function()
    SysOpenMgr:jump_to_sys(GetPuzzleJumpId, true)
  end)
  self:set_button("BtnScreen", function()
    self.v_puzzle_filter_view:set_enable(true)
    self.v_puzzle_operate_view:reset_operate_obj_data()
    self:update_item_selected_state()
  end)
  self.v_scroll_list = LoopListClass:new(self, self.v_uiobjects.SizePage, PuzzleItemClass)
  self.v_asset_bar_view = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:set_view_enable(view_type, param)
  if self.v_cur_view_type == VIEW_TYPE.OPERATE and view_type ~= VIEW_TYPE.OPERATE then
    self.v_need_return_operate_view = true
  end
  self.v_cur_view_type = view_type
  self.v_view_param = param or self.v_buddy_id
  for _type, view in ipairs(self.v_views) do
    view:set_enable(view_type == _type, self.v_view_param)
  end
  self.v_selected_uuid = nil
  self.v_temp_selected_uuid = nil
  self:send_update_item_state_msg()
  if view_type == VIEW_TYPE.REFINE then
    self.v_asset_bar_view:reset_by_id_list({
      Config.PUZZLE_REFINE_COIN
    })
    self.v_asset_bar_view:on_create()
  else
    self.v_asset_bar_view:reset_by_id_list({
      Config.COIN_ITEMID
    })
    self.v_asset_bar_view:on_create()
  end
end

function ui:on_click_return()
  self:ui_hide()
end

function ui:on_go_to_main()
end

function ui:ui_on_hide()
  self.v_cur_size_idx = nil
  self.v_scroll_list:ui_on_hide()
  self.v_asset_bar_view:on_hide()
  Util.show_puzzle_tip(nil)
end

function ui:ui_on_destroy()
  self.v_scroll_list:ui_on_destroy()
  self.v_asset_bar_view:on_destory()
  self.v_asset_bar_view = nil
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_buddy_id, self.v_cur_view_type, self.v_view_param, self.v_need_return_operate_view
end

function ui:ui_on_show(buddy_id, view_type, view_param, need_return_operate_view)
  PuzzleMgr:init_view_filter()
  self.v_need_return_operate_view = true == need_return_operate_view
  self.v_buddy_id = buddy_id
  self.v_selected_uuid = nil
  self.v_temp_selected_uuid = nil
  self.v_cost_uuid_map = {}
  self:bind_auto_mq(Const.MSG_ON_PUZZLE_BATCH_SET, self.show_equip_suc_eff, self)
  self:bind_auto_mq(Const.MSG_ON_PUZZLE_LIST_UPDATE, self.on_puzzle_list_update, self)
  self:bind_auto_mq(Const.MSG_ON_CHOOSE_PUZZLE_ITEM, self.on_select_puzzle, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_PUZZLE_ITEM_TIPS, self.clear_temp_selected_item, self)
  self:bind_auto_mq(Const.MSG_ON_PUZZLE_VIEW_FILTER_UPDATE, self.on_puzzle_list_update, self)
  self:set_view_enable(view_type or VIEW_TYPE.OPERATE, view_param)
  self.v_puzzle_filter_view:set_enable(false)
  self:refresh_scroll_list()
  self.v_uiobjects.Ani_Equip:SetActive(false)
  self.v_uiobjects.Ani_Levelup:SetActive(false)
end

function ui:on_puzzle_list_update()
  self:refresh_scroll_list()
end

function ui:refresh_scroll_list()
  self.v_scroll_list_data = {}
  local all_puzzle_data = PuzzleMgr:get_view_puzzle_list()
  if not all_puzzle_data then
    return
  end
  local is_refine_page = self.v_cur_view_type == VIEW_TYPE.REFINE
  local is_lv_page = self.v_cur_view_type == VIEW_TYPE.UP_LV
  local filter_puzzle_id, filter_uuid_id, filter_attr_map
  if is_lv_page then
    filter_puzzle_id = self.v_puzzle_up_lv_view:get_operate_puzzle_id()
    filter_uuid_id = self.v_puzzle_up_lv_view.v_operate_uuid
    filter_attr_map = self.v_puzzle_up_lv_view:get_operate_puzzle_attr_map()
  end
  for _, data in pairs(all_puzzle_data) do
    local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(data.id)
    if is_refine_page and 1 ~= puzzle_cfg.CanRefine then
    else
      local _data = UtilTable.copy_table(data)
      _data.buddy_id = _data.buddy_id or 0
      _data.graph_id = puzzle_cfg.GraphID
      _data.filter_puzzle_id = filter_puzzle_id
      _data.is_lvup_operating = filter_uuid_id == data.uuid
      _data.show_ban_mask = false
      if is_lv_page and filter_uuid_id then
        if filter_uuid_id == data.uuid then
          _data.lv_page_order = 1
          _data.show_operate_mask = true
        elseif filter_puzzle_id == data.id then
          if data.quality == Config.PUZZLE_MIN_QUALITY then
            if self:check_attr_at_map(data, filter_attr_map) then
              _data.show_same_attr = true
              _data.show_ban_mask = true
              _data.lv_page_order = 3
            else
              _data.lv_page_order = 2
            end
          else
            _data.show_ban_mask = true
            _data.lv_page_order = 4
          end
        else
          _data.show_ban_mask = true
          _data.lv_page_order = 5
        end
      end
      self.v_scroll_list_data[#self.v_scroll_list_data + 1] = _data
    end
  end
  table.sort(self.v_scroll_list_data, function(dataA, dataB)
    if dataA.lv_page_order and dataA.lv_page_order ~= dataB.lv_page_order then
      return dataA.lv_page_order < dataB.lv_page_order
    end
    if dataA.buddy_id ~= dataB.buddy_id then
      if 0 == dataA.buddy_id then
        return not is_refine_page
      end
      if 0 == dataB.buddy_id then
        return is_refine_page
      end
    end
    if dataA.quality ~= dataB.quality then
      return dataA.quality > dataB.quality
    end
    if dataA.id ~= dataB.id then
      return dataA.id < dataB.id
    end
    return dataA.uuid < dataB.uuid
  end)
  self.v_scroll_list:refresh_data(self.v_scroll_list_data)
  local is_list_empty = 0 == #self.v_scroll_list_data
  self.v_uiobjects.NoItem:SetActive(is_list_empty)
  self.v_scroll_list:scroll_to_old_pos()
  self.v_uiobjects.Screening:SetActive(PuzzleMgr:is_any_filter())
end

function ui:update_item_selected_state()
  if not self.v_scroll_list then
    return
  end
  local all_itmes = self.v_scroll_list:get_all_uis()
  for _, ui_item in pairs(all_itmes) do
    if ui_item:is_visible_item() then
      ui_item:update_selected()
    end
  end
end

function ui:check_attr_at_map(puzzle_data, filter_map)
  local attr_list = puzzle_data.attr_list
  if attr_list and filter_map then
    for index, id in ipairs(attr_list) do
      local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(id)
      local attr_id = attr_cfg.AttrId
      if filter_map[attr_id] then
        return true
      end
    end
  end
  return false
end

function ui:send_update_item_state_msg()
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_PUZZLE_ITEM_STATE)
end

function ui:on_select_puzzle(msg)
  local uuid = msg.mm_x
  if self.v_puzzle_decompose_view.v_visible then
    self.v_puzzle_decompose_view:change_selected_item(uuid)
    self.v_selected_uuid = uuid
  elseif self.v_puzzle_up_lv_view.v_visible then
    local puzzle_data = PuzzleMgr:get_puzzle_data(uuid)
    if not puzzle_data then
      return
    end
    if puzzle_data.quality >= Config.PUZZLE_MAX_QUALITY then
      Util.show_message_tip(2260)
      return
    end
    self.v_puzzle_up_lv_view:change_selected_item(uuid)
  elseif self.v_puzzle_refine_view.v_visible then
    self.v_puzzle_refine_view:change_selected_item(uuid)
  end
  self:send_update_item_state_msg()
end

function ui:on_click_remove_puzzle_item()
  if self.v_puzzle_up_lv_view.v_visible then
    self.v_puzzle_up_lv_view:change_selected_item(nil)
  elseif self.v_puzzle_refine_view.v_visible then
    self.v_puzzle_refine_view:change_selected_item(nil)
  end
end

function ui:clear_temp_selected_item(msg)
  if msg.mm_x == self.v_temp_selected_uuid then
    self.v_temp_selected_uuid_cache = self.v_temp_selected_uuid
    self.v_temp_selected_uuid = nil
  end
end

function ui:on_click_puzzle_item(uuid)
  if uuid == self.v_temp_selected_uuid then
    self.v_temp_selected_uuid = nil
  else
    self.v_temp_selected_uuid = uuid
  end
  local pos = self.v_uicompents.ItemTipsPos_LeftList_rect.localPosition
  local list_item_offset = {
    pos.x,
    pos.y
  }
  if self.v_puzzle_operate_view.v_visible then
    Util.show_puzzle_tip(self.v_temp_selected_uuid, {
      offset = list_item_offset,
      show_up_lv_btn = true,
      show_refine_btn = true,
      show_remove_btn = false,
      show_select_btn = false,
      hide_close_btn = true
    })
    local cache = self.v_temp_selected_uuid
    self.v_puzzle_operate_view:reset_operate_obj_data()
    self:set_temp_selected_uuid(cache)
  elseif self.v_puzzle_decompose_view.v_visible then
    Util.show_puzzle_tip(self.v_temp_selected_uuid, {
      offset = list_item_offset,
      show_up_lv_btn = false,
      show_remove_btn = false,
      show_select_btn = nil ~= uuid
    })
  elseif self.v_puzzle_up_lv_view.v_visible then
    local operate_uuid = self.v_puzzle_up_lv_view.v_operate_uuid
    local cost_uuid = self.v_puzzle_up_lv_view.v_cost_uuid
    local show_remove_btn = self.v_temp_selected_uuid == cost_uuid
    local show_select_btn = not show_remove_btn and (not operate_uuid or not cost_uuid)
    local show_replace_btn = nil ~= cost_uuid and self.v_temp_selected_uuid ~= cost_uuid
    Util.show_puzzle_tip(self.v_temp_selected_uuid, {
      offset = list_item_offset,
      show_up_lv_btn = false,
      show_remove_btn = show_remove_btn,
      show_select_btn = show_select_btn,
      show_replace_btn = show_replace_btn,
      remove_cb = function()
        self:on_click_remove_puzzle_item(self.v_temp_selected_uuid)
      end
    })
  elseif self.v_puzzle_refine_view.v_visible then
    local operate_uuid = self.v_puzzle_refine_view.v_operate_uuid
    local show_remove_btn = self.v_temp_selected_uuid == operate_uuid
    local show_select_btn = not operate_uuid
    local show_replace_btn = nil ~= operate_uuid and self.v_temp_selected_uuid ~= operate_uuid
    Util.show_puzzle_tip(self.v_temp_selected_uuid, {
      offset = list_item_offset,
      show_up_lv_btn = false,
      show_remove_btn = show_remove_btn,
      show_select_btn = show_select_btn,
      show_replace_btn = show_replace_btn,
      remove_cb = function()
        self:on_click_remove_puzzle_item(self.v_temp_selected_uuid)
      end
    })
  end
end

function ui:get_cur_buddy_id()
  return self.v_buddy_id
end

function ui:get_cur_view_type()
  return self.v_cur_view_type
end

function ui:is_operating_uuid(uuid)
  return self.v_selected_uuid == uuid or self.v_temp_selected_uuid == uuid
end

function ui:set_temp_selected_uuid(uuid)
  self.v_temp_selected_uuid = uuid
end

function ui:is_cost_uuid(uuid)
  if self.v_puzzle_up_lv_view.v_visible then
    return self.v_puzzle_up_lv_view.v_cost_uuid == uuid
  elseif self.v_puzzle_refine_view.v_visible then
    return self.v_puzzle_refine_view.v_operate_uuid == uuid
  end
  return false
end

function ui:on_drag_start(data)
  self.v_temp_selected_uuid = data.uuid
  if self.v_puzzle_operate_view.v_visible then
    self.v_puzzle_operate_view:on_drag_start(data)
  end
end

function ui:on_drag()
  if self.v_puzzle_operate_view.v_visible then
    self.v_puzzle_operate_view:on_drag()
  end
end

function ui:on_drag_end()
  self:send_update_item_state_msg()
  if self.v_puzzle_operate_view.v_visible then
    self.v_puzzle_operate_view:on_drag_end(true)
  end
end

function ui:show_up_lv_suc_eff()
  self.v_uiobjects.Ani_Levelup:SetActive(false)
  self.v_uiobjects.Ani_Levelup:SetActive(true)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.puzzle_synthesis_UI_SOUND)
end

function ui:show_equip_suc_eff()
  self.v_uiobjects.Ani_Equip:SetActive(false)
  self.v_uiobjects.Ani_Equip:SetActive(true)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.puzzle_set_UI_SOUND)
end

return ui
