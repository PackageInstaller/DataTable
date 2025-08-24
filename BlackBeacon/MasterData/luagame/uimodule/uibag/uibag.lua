local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ToggleTab = require("ui.widget.widget_toggle_tab")
local BagList = require("uimodule.uibag.bag_list")
local AssetBarView = require("ui.asset_bar.asset_bar")
local WeaponObj = require("uimodule.uibag.weapon_obj")
local ItemObj = require("uimodule.uibag.item_obj")
local BagCfg = require("uimodule.uibag.uibag_configs")
local _tinsert = table.insert
local BIND_TYPE = Config.BIND_TYPE
local WEAPEN_IDX = BagCfg.WEAPEN_IDX
local ITEM_IDX = BagCfg.ITEM_IDX
local PUZZLE_IDX = BagCfg.PUZZLE_IDX
local PUZZLE_SYS_ID = 58
local TRIGGER_DYNAMIC_EFFECT_TYPE = BagCfg.TRIGGER_DYNAMIC_EFFECT_TYPE
local sub_toggle_unselect_font_style = 0
local sub_toggle_select_font_style = 1
local CHECK_MARK_TAIL = "_/Checkmark"
local LABEL_TAIL = "_/Label"
local delete_texts = {
  [WEAPEN_IDX] = "分  解"
}
local WEAPON_SORT_TYPE2IDX = {
  WeaponTogQuality = 1,
  WeaponTogLevel = 2,
  WeaponTogRecent = 3
}
local ITEM_SORT_TYPE2IDX = {
  ItemTogAll = 1,
  ItemTogCost = 2,
  ItemTogDevelop = 3,
  ItemTogOther = 4
}
local MODEL = {
  v_page_obj = {
    "Page",
    BIND_TYPE.OBJECT
  },
  v_bag_content = {
    "BagListContent",
    BIND_TYPE.OBJECT
  },
  v_asset_bar_obj = {
    "AssetBar",
    BIND_TYPE.OBJECT
  },
  v_return_btn = {
    "Button_return",
    BIND_TYPE.BUTTON
  },
  v_delete_btn = {
    "ButtomDelete",
    BIND_TYPE.BUTTON
  },
  v_cannot_touch_obj = {
    "Cannot_Touch_Bg",
    BIND_TYPE.OBJECT
  },
  v_item_obj = {
    "ItemObj",
    BIND_TYPE.OBJECT
  },
  v_weapon_obj = {
    "WeaponObj",
    BIND_TYPE.OBJECT
  }
}
local EMPTY_TABLE = {}
setmetatable(EMPTY_TABLE, {
  __newindex = function(k, v)
    error("cant mod this static ept table!!!", debug.traceback())
  end
})

function ui:ui_finish_load()
  self.v_sub_panels = {
    [PUZZLE_IDX] = self:get_panel("puzzle_sub_panel")
  }
  self.v_have_resolve_privilege = false
  self:check_have_novice_privilege()
  self.is_first_enter = true
  self:init_model(MODEL)
  self:_init_component()
end

function ui:ui_on_show(select_page)
  local pages = {}
  _tinsert(pages, Util.get_toggle("Weapon_", self.v_page_obj))
  _tinsert(pages, Util.get_toggle("Item_", self.v_page_obj))
  _tinsert(pages, Util.get_toggle("Plugin_", self.v_page_obj))
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.ItemRedPoint, RedEnum.BAG_ITEM, RedEnum.BAG)
  self.v_page_toggle_tab = ToggleTab:new(self)
  self.v_page_toggle_tab:init_by_toggles(pages, function(idx)
    self:_on_click_page(idx)
  end, 0, false)
  self:bind_event()
  self.is_click_return = nil == select_page
  self:to_old_view_or_new_view()
  self:play_dynamic_effect(TRIGGER_DYNAMIC_EFFECT_TYPE.SHOW)
  self:set_cannot_touch(nil == select_page and WEAPEN_IDX or select_page)
  self:update_list()
  self:refresh_capacity_txt()
  self.v_asset_bar:on_create()
  if select_page then
    if not self.v_page_toggle_tab:get_toggle_by_index(select_page).isOn then
      self.v_page_toggle_tab:set_toggle_by_index(select_page)
    else
      self:_on_click_page(select_page)
    end
  end
  self.is_click_return = false
  self:refresh_remain_time(Util.get_text("Text", self.v_uiobjects.ItemTimeTag), Util.get_image(nil, self.v_uiobjects.ItemTimeTag), self.v_uiobjects.ItemTimeTag, self.v_uiobjects.ItemRedPoint)
  self.v_uiobjects.Plugin:SetActive(SysOpenMgr:get_sys_is_open(PUZZLE_SYS_ID))
end

function ui:on_go_to_main()
  self.is_click_return = true
end

function ui:ui_on_hide()
  self:reset_multi_index()
  self.v_panel_weapon_dec:set_enable(false)
  self.v_panel_item_sell:set_enable(false)
  self:reset_dec_and_sell_view_pos()
  self.v_asset_bar:on_hide()
  if self.v_remove_cannot_touch_obj_timer then
    Timer:remove_timer(self.v_remove_cannot_touch_obj_timer)
  end
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:bind_event()
  self:bind_auto_mq(Const.MSG_ROLE_WEAPENLIST_CHANGE, self.update_equips, self)
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self.update_items, self)
end

function ui:_init_component()
  self:set_button_listener(self.v_return_btn, function()
    self.is_click_return = true
    self:ui_hide()
  end)
  self:init_item_list()
  self:init_delete_btn()
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:init_item_list()
  self.bag_list = BagList:ui_wrap(self, self.v_bag_content)
  self.weapon_obj = WeaponObj:ui_wrap(self, self.v_weapon_obj)
  self.v_panel_weapon_dec = self.weapon_obj:get_panel("weapon_dec")
  self.v_weapon_dec_obj = self.weapon_obj.v_weapon_dec_obj
  self.item_obj = ItemObj:ui_wrap(self, self.v_item_obj)
  self.v_panel_item_sell = self.item_obj:get_panel("item_sell")
  self.v_item_sell_obj = self.item_obj.v_item_sell_obj
  local equips = CharacterMgr:get_equip_list() or EMPTY_TABLE
  local items = BagMgr:get_bag(2) or EMPTY_TABLE
  self.bag_list:setup({equips, items})
end

function ui:init_delete_btn()
  self.v_delete_btn.gameObject:SetActive(true)
  self:set_button_listener(self.v_delete_btn, function()
    if self.v_last_idx == nil or self.v_last_idx == WEAPEN_IDX then
      self.v_uiobjects.Capacity:SetActive(false)
      self.v_delete_btn.gameObject:SetActive(false)
      self.v_return_btn.gameObject:SetActive(false)
      self.v_uiobjects.BtnMain:SetActive(false)
      self.v_uiobjects.BtnIntroduce:SetActive(false)
      self.v_panel_weapon_dec:set_enable(true)
      self.weapon_obj:set_button_active(true)
      self:play_dynamic_effect(TRIGGER_DYNAMIC_EFFECT_TYPE.LEFT_VIEW_SHOW)
      self:set_cannot_touch_obj_state(0.25)
      self.bag_list:update_weapon_filt(nil, true)
    elseif self.v_last_idx == ITEM_IDX then
      self.v_uiobjects.Capacity:SetActive(false)
      self.v_delete_btn.gameObject:SetActive(false)
      self.v_return_btn.gameObject:SetActive(false)
      self.v_uiobjects.BtnMain:SetActive(false)
      self.v_uiobjects.BtnIntroduce:SetActive(false)
      self.v_panel_item_sell:set_enable(true)
      self.item_obj:set_button_active(true)
      self:play_dynamic_effect(TRIGGER_DYNAMIC_EFFECT_TYPE.LEFT_VIEW_SHOW)
      self:set_cannot_touch_obj_state(0.25)
      self.bag_list:update_item_filt(nil, true)
    end
  end)
end

function ui:update_list()
  if self.is_first_enter then
    self.is_first_enter = false
    return
  end
  self:update_equips()
  self:update_items()
end

function ui:update_equips()
  local equips = CharacterMgr:get_equip_list() or EMPTY_TABLE
  self.bag_list:update_bag(equips, WEAPEN_IDX, true)
  self.bag_list:update_weapon_filt(nil, true)
end

function ui:update_items()
  local items = BagMgr:get_bag(ITEM_IDX) or EMPTY_TABLE
  self.bag_list:update_bag(items, ITEM_IDX, true)
  self.bag_list:update_item_filt(nil, true)
  self:refresh_remain_time(Util.get_text("Text", self.v_uiobjects.ItemTimeTag), Util.get_image(nil, self.v_uiobjects.ItemTimeTag), self.v_uiobjects.ItemTimeTag, self.v_uiobjects.ItemRedPoint)
end

function ui:_on_click_page(idx)
  if self.v_last_idx == idx then
    return
  end
  if idx == ITEM_IDX then
    self:refresh_remain_time(Util.get_text("Text", self.v_uiobjects.ItemTimeTag), Util.get_image(nil, self.v_uiobjects.ItemTimeTag), self.v_uiobjects.ItemTimeTag, self.v_uiobjects.ItemRedPoint)
  end
  self.v_last_idx = idx
  if not self.is_first_enter then
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.bag_item_refresh_UI_SOUND)
  end
  self.weapon_obj:set_enable(idx == WEAPEN_IDX)
  self.item_obj:set_enable(idx == ITEM_IDX)
  for _idx, sub_panels in pairs(self.v_sub_panels) do
    sub_panels:set_enable(idx == _idx)
  end
  local is_use_sub_panel = self.v_sub_panels[idx] ~= nil
  self.v_uiobjects.Item_list:SetActive(not is_use_sub_panel)
  self.v_uiobjects.Bottom_main:SetActive(not is_use_sub_panel)
  if not is_use_sub_panel then
    self:play_dynamic_effect(TRIGGER_DYNAMIC_EFFECT_TYPE.PAGE)
    self:set_cannot_touch(idx)
  end
  self.v_uiobjects.NovicePrivilege:SetActive(idx == WEAPEN_IDX and self.v_have_resolve_privilege)
  if nil ~= delete_texts[idx] then
    self.v_uicompents.ButtonDeleteText_txt.text = Util.format_str(delete_texts[idx])
  end
  if not is_use_sub_panel then
    self.bag_list:set_bag_type(idx)
    self:refresh_capacity_txt()
  end
  local show_delete_btn = idx == WEAPEN_IDX
  self.v_uiobjects.ButtomDelete:SetActive(show_delete_btn)
end

function ui:set_toggle_index()
  self.is_first_enter_set_toggle = true
  self.v_page_toggle_tab:set_toggle_by_index(WEAPEN_IDX)
  self.weapon_obj.v_weapon_select_toggle_tab:set_toggle_by_index(WEAPON_SORT_TYPE2IDX.WeaponTogQuality)
  self.item_obj.v_item_filt_toggle_tab:set_toggle_by_index(ITEM_SORT_TYPE2IDX.ItemTogAll)
  self.is_first_enter_set_toggle = false
  self.v_page_toggle_tab:get_toggle_by_index(WEAPEN_IDX).interactable = false
end

function ui:set_toggle_mask(is_click_return)
  if is_click_return then
    local weapon_down_content = self.weapon_obj.v_down_content
    for name, index in pairs(WEAPON_SORT_TYPE2IDX) do
      Util.get_child_gameobj(name .. CHECK_MARK_TAIL, weapon_down_content):SetActive(index == WEAPON_SORT_TYPE2IDX.WeaponTogQuality)
      local text = Util.get_text(name .. LABEL_TAIL, weapon_down_content)
      if index == WEAPON_SORT_TYPE2IDX.WeaponTogQuality then
        text.fontStyle = sub_toggle_select_font_style
      else
        text.fontStyle = sub_toggle_unselect_font_style
      end
    end
    local item_down_content = self.item_obj.v_down_content
    for name, index in pairs(ITEM_SORT_TYPE2IDX) do
      Util.get_child_gameobj(name .. CHECK_MARK_TAIL, item_down_content):SetActive(index == ITEM_SORT_TYPE2IDX.ItemTogAll)
      local text = Util.get_text(name .. LABEL_TAIL, item_down_content)
      if index == ITEM_SORT_TYPE2IDX.ItemTogAll then
        text.fontStyle = sub_toggle_select_font_style
      else
        text.fontStyle = sub_toggle_unselect_font_style
      end
    end
  else
    if self.v_last_idx == nil then
      self.v_last_idx = WEAPEN_IDX
    end
    if nil == self.v_last_weapon_idx then
      self.v_last_weapon_idx = WEAPON_SORT_TYPE2IDX.WeaponTogQuality
    end
    if nil == self.v_last_item_idx then
      self.v_last_item_idx = ITEM_SORT_TYPE2IDX.ItemTogAll
    end
    local weapon_down_content = self.weapon_obj.v_down_content
    for name, index in pairs(WEAPON_SORT_TYPE2IDX) do
      Util.get_child_gameobj(name .. CHECK_MARK_TAIL, weapon_down_content):SetActive(index == self.v_last_weapon_idx)
      local text = Util.get_text(name .. LABEL_TAIL, weapon_down_content)
      if index == self.v_last_weapon_idx then
        text.fontStyle = sub_toggle_select_font_style
      else
        text.fontStyle = sub_toggle_unselect_font_style
      end
    end
    local item_down_content = self.item_obj.v_down_content
    for name, index in pairs(ITEM_SORT_TYPE2IDX) do
      Util.get_child_gameobj(name .. CHECK_MARK_TAIL, item_down_content):SetActive(index == self.v_last_item_idx)
      local text = Util.get_text(name .. LABEL_TAIL, item_down_content)
      if index == self.v_last_item_idx then
        text.fontStyle = sub_toggle_select_font_style
      else
        text.fontStyle = sub_toggle_unselect_font_style
      end
    end
  end
end

function ui:select_weapon_type_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  if self.v_last_weapon_idx == cur_select or self.is_first_enter_set_toggle then
    return
  end
  self.v_last_weapon_idx = cur_select
  self.sort_type = cur_select
  self.bag_list:sort_list(WEAPEN_IDX)
  self.bag_list:update_bag(nil, WEAPEN_IDX)
  local weapon_down_content = self.weapon_obj.v_down_content
  for name, index in pairs(WEAPON_SORT_TYPE2IDX) do
    Util.get_child_gameobj(name .. CHECK_MARK_TAIL, weapon_down_content):SetActive(index == cur_select)
    local text = Util.get_text(name .. LABEL_TAIL, weapon_down_content)
    if index == cur_select then
      text.fontStyle = sub_toggle_select_font_style
    else
      text.fontStyle = sub_toggle_unselect_font_style
    end
  end
  self:set_cannot_touch(WEAPEN_IDX)
end

function ui:select_item_type_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  if self.v_last_item_idx == cur_select or self.is_first_enter_set_toggle then
    return
  end
  self.v_last_item_idx = cur_select
  self.bag_list:update_item_filt(cur_select, true)
  local item_down_content = self.item_obj.v_down_content
  for name, index in pairs(ITEM_SORT_TYPE2IDX) do
    Util.get_child_gameobj(name .. CHECK_MARK_TAIL, item_down_content):SetActive(index == cur_select)
    local text = Util.get_text(name .. LABEL_TAIL, item_down_content)
    if index == cur_select then
      text.fontStyle = sub_toggle_select_font_style
    else
      text.fontStyle = sub_toggle_unselect_font_style
    end
  end
  self:set_cannot_touch(ITEM_IDX)
end

function ui:set_delete_btn_active(param)
  self.v_delete_btn.gameObject:SetActive(param)
  if param then
    self:refresh_capacity_txt()
  end
end

function ui:set_return_btn_active(param)
  self.v_return_btn.gameObject:SetActive(param)
  self.v_uiobjects.BtnMain:SetActive(param)
  self.v_uiobjects.BtnIntroduce:SetActive(param)
end

function ui:is_selecting_weapon()
  return self.v_weapon_dec_obj.activeInHierarchy
end

function ui:is_selecting_item()
  return self.v_item_sell_obj.activeInHierarchy
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_last_idx
end

function ui:set_weapon_sort_state(state)
  self.weapon_sort_by_dec = state
end

function ui:get_weapon_sort_state()
  return self.weapon_obj.weapon_sort_by_dec
end

function ui:get_pre_weapon_sort_state()
  return self.weapon_obj.pre_weapon_sort_by_dec
end

function ui:play_dynamic_effect(type, effect_time)
  if self.v_sequences then
    for k, sequence in pairs(self.v_sequences) do
      sequence:Kill(false)
      sequence = nil
    end
  end
  self.v_sequences = {}
  local return_btn_canvas = self.v_return_btn.gameObject:GetComponent("CanvasGroup")
  local main_btn_canvas = self.v_uiobjects.BtnMain:GetComponent("CanvasGroup")
  local asset_bar_canvas = self.v_asset_bar_obj.gameObject:GetComponent("CanvasGroup")
  local page_select_canvas = self.v_page_obj.gameObject:GetComponent("CanvasGroup")
  local delete_btn_canvas = self.v_delete_btn.gameObject:GetComponent("CanvasGroup")
  local weapon_select_canvas = self.weapon_obj.v_weapon_select_obj:GetComponent("CanvasGroup")
  local item_select_canvas = self.item_obj.v_item_filter_obj:GetComponent("CanvasGroup")
  local sequence = Util.create_sequence()
  local time = effect_time or 1
  local factor = 0.25
  local alpha_zero = 0
  local alpha_one = 1
  local item_sell_half_width = Util.get_rect_transform(nil, self.v_item_sell_obj).sizeDelta.x / 2
  if Global.screen_width / Global.screen_height <= 1.8 then
    local screen_half_width = 960
    self.original_pos_x = -1 * (screen_half_width + item_sell_half_width)
    self.target_pos_x = -1 * (screen_half_width - item_sell_half_width)
  else
    local screen_half_width = 1170
    self.original_pos_x = -1 * (screen_half_width + item_sell_half_width)
    self.target_pos_x = -1 * (screen_half_width - item_sell_half_width)
  end
  if type == TRIGGER_DYNAMIC_EFFECT_TYPE.SHOW then
    return_btn_canvas.alpha = alpha_zero
    main_btn_canvas.alpha = alpha_zero
    asset_bar_canvas.alpha = alpha_zero
    weapon_select_canvas.alpha = alpha_zero
    page_select_canvas.alpha = alpha_zero
    delete_btn_canvas.alpha = alpha_zero
    sequence:Append(return_btn_canvas:DOFade(alpha_one, time))
    sequence:Join(main_btn_canvas:DOFade(alpha_one, time))
    sequence:Join(asset_bar_canvas:DOFade(alpha_one, time))
    sequence:Join(weapon_select_canvas:DOFade(alpha_one, time))
    sequence:Join(page_select_canvas:DOFade(alpha_one, time))
    sequence:Join(delete_btn_canvas:DOFade(alpha_one, time))
  elseif type == TRIGGER_DYNAMIC_EFFECT_TYPE.PAGE then
    return_btn_canvas.alpha = alpha_one
    main_btn_canvas.alpha = alpha_one
    asset_bar_canvas.alpha = alpha_one
    weapon_select_canvas.alpha = alpha_zero
    item_select_canvas.alpha = alpha_zero
    delete_btn_canvas.alpha = alpha_zero
    sequence:Append(weapon_select_canvas:DOFade(alpha_one, time))
    sequence:Join(item_select_canvas:DOFade(alpha_one, time))
    sequence:Join(delete_btn_canvas:DOFade(alpha_one, time))
  elseif type == TRIGGER_DYNAMIC_EFFECT_TYPE.LEFT_VIEW_SHOW then
    page_select_canvas.alpha = alpha_one
    sequence:Join(page_select_canvas:DOFade(alpha_zero, time * factor))
  elseif type == TRIGGER_DYNAMIC_EFFECT_TYPE.LEFT_VIEW_HIDE then
    page_select_canvas.alpha = alpha_zero
    sequence:Join(page_select_canvas:DOFade(alpha_one, time * factor))
  end
  table.insert(self.v_sequences, sequence)
end

function ui:reset_dec_and_sell_view_pos()
  local pos_y = self.v_weapon_dec_obj.transform.position.y
  local pos_z = self.v_weapon_dec_obj.transform.position.z
  self.v_weapon_dec_obj.transform:SetLocalPositionA(self.original_pos_x, pos_y, pos_z)
  self.v_item_sell_obj.transform:SetLocalPositionA(self.original_pos_x, pos_y, pos_z)
end

function ui:set_cannot_touch(bag_type)
  local count = self.bag_list:get_length_by_bag_type(bag_type)
  local time
  if count <= 12 then
    time = 0
  else
    time = 0.5
  end
  self:set_cannot_touch_obj_state(time)
end

function ui:set_cannot_touch_obj_state(time)
  if self.v_remove_cannot_touch_obj_timer then
    Timer:remove_timer(self.v_remove_cannot_touch_obj_timer)
  end
  self.v_cannot_touch_obj.gameObject:SetActive(true)
  self.v_remove_cannot_touch_obj_timer = Timer:add_timer("remove_cannot_touch_obj_timer", time, function()
    self.v_cannot_touch_obj.gameObject:SetActive(false)
  end)
end

function ui:to_old_view_or_new_view()
  if self.is_click_return == true then
    self.weapon_obj:set_weapon_sort_state(true)
    self.sort_type = WEAPON_SORT_TYPE2IDX.WeaponTogQuality
    self:set_toggle_index()
    self:set_toggle_mask(true)
  else
    self:set_toggle_mask(false)
    local idx = self.v_page_toggle_tab:get_select_idx()
    self.weapon_obj:set_enable(idx == WEAPEN_IDX)
    self.item_obj:set_enable(idx == ITEM_IDX)
    self.v_page_toggle_tab:get_toggle_by_index(idx).interactable = false
  end
end

function ui:reset_multi_index()
  if self.is_click_return == true then
    self.v_last_idx = nil
    self.v_last_weapon_idx = nil
    self.v_last_item_idx = nil
    self.bag_list:reset_cur_item_filt_index()
  end
end

function ui:check_have_novice_privilege()
  self.v_have_resolve_privilege = NewbieTowerMgr:check_have_resolve_privilege()
  self.v_uiobjects.NovicePrivilege:SetActive(self.v_have_resolve_privilege)
end

function ui:set_no_item_tip_show_state(is_show)
  self.v_uiobjects.NoItem:SetActive(is_show)
end

function ui:refresh_capacity_txt()
  local idx = self.v_last_idx
  self.v_uiobjects.Capacity:SetActive(idx == WEAPEN_IDX)
  if idx == WEAPEN_IDX then
    local count = self.bag_list:get_item_count(idx)
    local capacity = BagCfg.CAPACITY[idx]
    self.v_uicompents.Capacity_txt.text = string.format("%s/%s", count, capacity)
  end
end

function ui:refresh_remain_time(ui_txt, ui_img, remain_obj, red_obj)
  local remain_time = BagMgr:get_min_remain_time_item()
  local TIME_UNIT = Config.TIME_UNIT
  local TIMEUNIT2STR = {
    [TIME_UNIT.DAY] = "天",
    [TIME_UNIT.HOUR] = "小时",
    [TIME_UNIT.MINUTE] = "分钟"
  }
  if remain_time then
    local num, time_unit = Util.sec2time(remain_time)
    if time_unit == TIME_UNIT.DAY and num >= 7 then
      ui_txt.text = Util.format_str(string.format("%d周", math.floor(num / 7)))
    else
      if 0 == num and time_unit == TIME_UNIT.MINUTE then
        num = 1
      end
      ui_txt.text = Util.format_str(string.format("%d%s", num, TIMEUNIT2STR[time_unit]))
    end
    ui_img.color = Util.get_unity_color_by_hex(tonumber("f5ede2", 16))
    if remain_obj then
      remain_obj:SetActive(true)
    end
    if red_obj then
      red_obj:SetActive(false)
    end
  elseif remain_obj then
    remain_obj:SetActive(false)
  end
end

return ui
