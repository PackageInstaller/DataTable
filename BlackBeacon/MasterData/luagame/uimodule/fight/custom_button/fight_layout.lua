local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local _floor = math.floor
local Json = require("utils.json")
local dump = require("utils.dumper")
local PathDefine = require("utils.path_define")
local EnemyBarListChoose = "MainEnemyBloodList_/MainEnemyBloodItem_/Choose"
local FIGHT_LAYOUT_CHILD = require("uimodule.fight.custom_button.fight_layout_child")
local Fight_Layout_Cfg = require("uimodule.fight.custom_button.fight_layout_cfg")
local LocalStorage = require("utils.localstorage")
local CSDragEventListener2 = CS.Game.DragEventListener2
local TypeButton = TypeUnityUIButton
local TypeCGR = typeof(CS.Game.CustomGraphicRaycaster)
local TypeTR = typeof(CS.TouchReciver)
local TypeCR = typeof(UnityEngine.CanvasRenderer)
local util_get_color = Util.get_unity_color_by_hex
local _tinsert = table.insert
local _tremove = table.remove
local CTimer = Global.ct_timer
local BTN_LONG_PRESS_MAX_TIME = 99999
local INIT_ADD_BTN_LAYOUT_INDEX = 1
local normal_color = util_get_color(tonumber("FFFFFF", 16))
local overlap_color = util_get_color(tonumber("FF0B00", 16))
local disable_com = {
  TypeSkillJoy = typeof(CS.Game.SkillJoyStick),
  TypeETCJoystick = typeof(CS.ETCJoystick)
}
local disable_obj = {
  "Thumb1",
  "Thumb3",
  "Thumb4",
  "Thumb5",
  "Thumb7",
  "Thumb8"
}
local track_num = 20

local function get_border_sld_ui_part()
  local sld_part = Fight_Layout_Cfg.border_sld_max_num - Fight_Layout_Cfg.border_sld_min_num
  local ui_part = Fight_Layout_Cfg.ui_border_offset_max - Fight_Layout_Cfg.ui_border_offset_min
  local part_num = _floor(ui_part / sld_part)
  return part_num
end

local function map_value(min_scale, sld_value)
  local part = Fight_Layout_Cfg.max_sld_num - Fight_Layout_Cfg.min_sld_num
  local ui_max_num = min_scale * 2
  local ui_min_num = min_scale / 2
  local ui_part = (ui_max_num - ui_min_num) / part
  local result = ui_min_num + (sld_value - Fight_Layout_Cfg.min_sld_num) * ui_part
  return result
end

local function map_ui_to_sld(min_scale, ui_value)
  local part = Fight_Layout_Cfg.max_sld_num - Fight_Layout_Cfg.min_sld_num
  local ui_max_num = min_scale * 2
  local ui_min_num = min_scale / 2
  local ui_part = (ui_max_num - ui_min_num) / part
  local result = Fight_Layout_Cfg.min_sld_num + (ui_value - ui_min_num) / ui_part
  return result
end

local function get_ui_standard(self)
  local scale_list = {}
  for _, group in pairs(Fight_Layout_Cfg.layout_group) do
    for _, ui_name in pairs(group) do
      local rect = self.v_ui_rect[ui_name]
      local scale_x, scale_y, scale_z = rect:GetLocalScaleA3()
      local temp = {
        standard_x = scale_x,
        standard_y = scale_y,
        standard_z = scale_z
      }
      scale_list[ui_name] = temp
    end
  end
  return scale_list
end

local function _record_ui_data(self, ui_list, ui_name)
  local rect = self.v_ui_rect[ui_name]
  if rect then
    local x, y = rect:GetAnchoredPositionA()
    local scale_x, scale_y, scale_z = rect:GetLocalScaleA3()
    local anchor_max_x, anchor_max_y, anchor_min_x, anchor_min_y = rect:GetAnchoredMinMax()
    local pivot_x, pivot_y = rect:GetPivot()
    local temp = {
      x = x,
      y = y,
      scale_x = scale_x,
      scale_y = scale_y,
      scale_z = scale_z,
      anchor_max_x = anchor_max_x,
      anchor_min_x = anchor_min_x,
      anchor_min_y = anchor_min_y,
      anchor_max_y = anchor_max_y,
      pivot_x = pivot_x,
      pivot_y = pivot_y
    }
    ui_list[ui_name] = temp
  else
    Log.Error("自定义按钮界面   ui对象", ui_name, "丢失")
  end
end

local function get_now_ui_list(self)
  local ui_list = {}
  for _, ui_name in pairs(Fight_Layout_Cfg.MOVE_AREA) do
    _record_ui_data(self, ui_list, ui_name)
  end
  for _, group in pairs(Fight_Layout_Cfg.layout_group) do
    for _, ui_name in pairs(group) do
      _record_ui_data(self, ui_list, ui_name)
    end
  end
  return ui_list
end

local function set_ui_list_layout_data(self, ui_list, reset)
  for ui_name, data in pairs(ui_list) do
    local rect = self.v_ui_rect[ui_name]
    if rect and not Fight_Layout_Cfg.MOVE_AREA[ui_name] then
      rect:SetLocalScaleA(data.scale_x, data.scale_y, data.scale_z)
      self.v_ui_init_x[ui_name] = data.x
      rect:SetAnchoredMinMax(data.anchor_min_x, data.anchor_min_y, data.anchor_max_x, data.anchor_max_y)
      Util.VEC2_TEMP:Set(data.pivot_x, data.pivot_y)
      rect:SetPivot(data.pivot_x, data.pivot_y)
      rect:SetAnchoredPositionA(data.x, data.y)
    end
  end
end

function ui:ui_finish_load()
  self.v_fight_layout_child_map = {}
  self.v_show_overlap_timer = {}
  self.v_ui_color_map = {}
  self.v_ui_rect = {}
  self.v_ui_overlay_rect = {}
  self.v_ui_to_group = {}
  self:_init_position_tb()
  self:disable_cash_obj()
  self.v_safe_area = self:get_rect_transform("SafeArea")
  local TypeCSDragEventListener2 = typeof(CSDragEventListener2)
  for _, ui_group in pairs(Fight_Layout_Cfg.layout_group) do
    for _, ui_name in pairs(ui_group) do
      if self.v_ui_rect[ui_name] and self.v_ui_rect[ui_name].parent then
        local parent = self.v_ui_rect[ui_name].parent.gameObject
        local rect = self.v_ui_rect[ui_name]
        local drag_obj = rect.gameObject
        local btn = Util.get_button(nil, drag_obj)
        if not btn then
          btn = drag_obj:AddComponent(TypeButton)
          drag_obj:TryAddComponent(TypeCGR)
          local graphic = self:get_image(nil, drag_obj)
          if not graphic then
            drag_obj:TryAddComponent(TypeCR)
            graphic = drag_obj:TryAddComponent(TypeTR)
            Util.change_component_alpha2(graphic, 0)
          end
          graphic.raycastTarget = true
          btn.targetGraphic = graphic
        end
        self:set_button_listener(btn, function()
          self:choose_new_ui(ui_name)
          self:check_overlap(ui_name)
          self.v_parent_ui:change_operation_content("detail_content")
        end)
        Util.set_start_drag2(drag_obj, parent, function()
          self:choose_new_ui(ui_name)
          self:check_overlap(ui_name)
          self.v_parent_ui:change_operation_content("detail_content")
        end)
        Util.set_drag2(drag_obj, parent, function()
          local drag_com = Util.get_component(nil, drag_obj, TypeCSDragEventListener2)
          local deltaPos = drag_com.deltaPos
          local delta_x = deltaPos.x
          local delta_y = deltaPos.y
          local rect_x, rect_y = rect:GetLocalPositionA3()
          rect_x = rect_x + delta_x
          rect_y = rect_y + delta_y
          self:check_overlap(ui_name)
          self:send_ui_screen_pos(ui_name)
          rect:SetLocalPositionA(rect_x, rect_y)
        end)
        Util.set_end_drag2(drag_obj, parent, function()
          self:check_overlap(ui_name)
          self:save_retrack_data()
          self.v_ui_init_x[ui_name] = rect:GetAnchoredPositionA()
        end)
      else
        Log.Error("自定义按钮界面   ui对象", ui_name, "丢失")
      end
    end
  end
  self.v_choosed_ui_name = nil
  self.v_standard_scale_tb = self:standard_scale_load()
  self.v_standard_layout_tb = get_now_ui_list(self)
  if Util.is_client_only() then
    self.v_standard_scale_tb = get_ui_standard(self)
  end
end

function ui:ui_on_show()
  self.v_overlap_map = {}
end

function ui:ui_on_hide()
  if self.v_long_press_timer then
    CTimer:remove_timer(self.v_long_press_timer)
  end
  self:clear_overlap_timer()
  self.v_retrack_tb = nil
  self.v_retrack_head = nil
  self.v_retrack_tail = nil
  self.v_border_offset = nil
  self.v_is_flip = nil
  self.v_layout_data = nil
end

function ui:ui_on_destroy()
  self.v_layout_state = nil
  self.v_standard_scale_tb = nil
  self.v_standard_layout_tb = nil
  self.v_ui_color_map = nil
  self.v_ui_rect = nil
  self.v_ui_overlay_rect = nil
  self.v_ui_to_group = nil
end

function ui:_init_ui_rect(group_num, ui_name)
  self.v_ui_init_x = {}
  local obj = self:_get_uiobject(group_num, ui_name)
  if obj then
    local rect = self:_get_uicompent(group_num, ui_name .. "_rect")
    self:disable_cash_script(obj)
    self.v_ui_rect[ui_name] = rect
    self.v_ui_init_x[ui_name] = rect:GetAnchoredPositionA()
    self.v_ui_to_group[ui_name] = group_num
  else
    Log.Error("自定义按钮界面   ui对象", ui_name, "丢失")
  end
end

function ui:_init_position_tb()
  for _, ui_name in pairs(Fight_Layout_Cfg.MOVE_AREA) do
    self:_init_ui_rect(nil, ui_name)
  end
  for group_num, ui_group in pairs(Fight_Layout_Cfg.layout_group) do
    for _, ui_name in pairs(ui_group) do
      self:_init_ui_rect(group_num, ui_name)
    end
  end
  for _, ui_name in pairs(Fight_Layout_Cfg.overlay_group) do
    local obj = self:_get_uiobject(nil, ui_name)
    if obj then
      local rect = self:_get_uicompent(nil, ui_name .. "_rect")
      self.v_ui_overlay_rect[ui_name] = rect
    else
      Log.Error("自定义按钮界面   ui对象", ui_name, "丢失")
    end
  end
end

function ui:disable_cash_obj()
  for _, ui_name in pairs(disable_obj) do
    self.v_uiobjects[ui_name]:SetActive(false)
  end
end

function ui:disable_cash_script(gameobj)
  for _, com_type in pairs(disable_com) do
    local com = gameobj:TryGetComponent(com_type)
    if com then
      com = gameobj:GetComponent(com_type)
      if com_type == disable_com.TypeETCJoystick then
        com:SetDragMode(true)
      end
    end
  end
end

function ui:check_overlap(check_ui_name)
  if not check_ui_name then
    return
  end
  local is_overlap = false
  local now_rect = self.v_ui_rect[check_ui_name]
  for _, ui_group in pairs(Fight_Layout_Cfg.layout_group) do
    if self:_check_overlap(now_rect, ui_group, check_ui_name) or self:check_out_of_range(check_ui_name) then
      is_overlap = true
      break
    end
  end
  local before_state = self.v_overlap_map[check_ui_name]
  if is_overlap then
    self:change_choose_color(check_ui_name, overlap_color)
    self.v_overlap_map[check_ui_name] = true
  else
    self.v_overlap_map[check_ui_name] = nil
    self:change_choose_color(check_ui_name, normal_color)
  end
  if before_state ~= self.v_overlap_map[check_ui_name] then
    self.v_parent_ui:on_overlap_state_change(nil ~= next(self.v_overlap_map))
  end
  return is_overlap
end

function ui:_check_overlap(now_rect, ui_group, check_ui_name)
  for _, ui_name in pairs(ui_group) do
    if ui_name == check_ui_name then
    else
      local rect = self.v_ui_rect[ui_name]
      if rect then
        local rect_obj = rect.gameObject
        local is_display = rect_obj.activeInHierarchy
        if not is_display then
        else
          local check = now_rect:isOverlap(rect)
          if check then
            return true
          end
        end
      else
        Log.Error("自定义按钮界面   ui对象", ui_name, "丢失")
      end
    end
  end
  for _, rect in pairs(self.v_ui_overlay_rect) do
    local rect_obj = rect.gameObject
    local is_display = rect_obj.activeInHierarchy
    if is_display then
      local check = now_rect:isOverlap(rect)
      if check then
        return true
      end
    end
  end
  local check_ui = self.v_ui_rect[check_ui_name]
  if self.v_safe_area.component:isOutOfRange(check_ui) then
    self:change_choose_color(check_ui_name, overlap_color)
    return true
  end
  return false
end

local function change_refualte_location(now_dir, rect, offset)
  local local_x, local_y = rect:GetLocalPositionA3()
  if now_dir == Fight_Layout_Cfg.regulation_dir.Left then
    rect:SetLocalPositionA(local_x - offset, local_y)
  elseif now_dir == Fight_Layout_Cfg.regulation_dir.Right then
    rect:SetLocalPositionA(local_x + offset, local_y)
  elseif now_dir == Fight_Layout_Cfg.regulation_dir.Up then
    rect:SetLocalPositionA(local_x, local_y + offset)
  else
    rect:SetLocalPositionA(local_x, local_y - offset)
  end
end

function ui:regulation_save_and_send()
  if self.v_choosed_ui_name then
    self:send_ui_screen_pos(self.v_choosed_ui_name)
    self:save_retrack_data()
  else
    if self.v_long_press_timer then
      CTimer:remove_timer(self.v_long_press_timer)
    end
    return
  end
end

function ui:regulate_location(now_dir, state)
  local rect = self.v_ui_rect[self.v_choosed_ui_name]
  local click_offset = 1
  local long_press_offset = 20
  if state == Fight_Layout_Cfg.dir_btn_state.LONGPRESS then
    self.v_long_press_timer = CTimer:add_timer("btn_long_press", BTN_LONG_PRESS_MAX_TIME, function()
      change_refualte_location(now_dir, rect, long_press_offset)
      self:regulation_save_and_send()
    end)
  elseif state == Fight_Layout_Cfg.dir_btn_state.CLICK then
    change_refualte_location(now_dir, rect, click_offset)
  elseif self.v_long_press_timer then
    CTimer:remove_timer(self.v_long_press_timer)
  end
  self:regulation_save_and_send()
  self:check_overlap(self.v_choosed_ui_name)
end

function ui:right_border_offset(value)
  if not self.v_border_offset then
    return
  end
  local offset = get_border_sld_ui_part() * value
  for _, group_num in pairs(Fight_Layout_Cfg.right_border_offset_group) do
    local group = Fight_Layout_Cfg.layout_group[group_num]
    for _, ui_name in pairs(group) do
      local rect = self.v_ui_rect[ui_name]
      if rect then
        local init_x = self.v_ui_init_x[ui_name]
        local _, init_y = rect:GetAnchoredPositionA()
        if init_x then
          rect:SetAnchoredPositionA(init_x - offset, init_y)
        end
      else
        Log.Error("自定义按钮界面   ui对象", ui_name, "丢失")
      end
    end
  end
  self.v_border_offset = value
end

function ui:click_border_begin_drag()
  self:save_retrack_data()
end

function ui:_record_scale(group_num, ui_name)
  local comp = self:_get_uicompent(group_num, ui_name .. "_rect")
  self.v_standard_scale_tb[ui_name] = {}
  self.v_standard_scale_tb[ui_name].standard_x, self.v_standard_scale_tb[ui_name].standard_y, self.v_standard_scale_tb[ui_name].standard_z = comp:GetLocalScaleA3()
end

function ui:record_all()
  for group_num, ui_group in pairs(Fight_Layout_Cfg.layout_group) do
    for _, ui_name in pairs(ui_group) do
      if not self.v_standard_scale_tb[ui_name] then
        self:_record_scale(group_num, ui_name)
      end
    end
  end
  for _, ui_name in pairs(Fight_Layout_Cfg.MOVE_AREA) do
    if not self.v_standard_scale_tb[ui_name] then
      self:_record_scale(nil, ui_name)
    end
  end
end

function ui:click_btn_scale_sld(value)
  if not self.v_choosed_ui_name then
    return
  end
  local standard_x = self.v_standard_scale_tb[self.v_choosed_ui_name].standard_x
  local standard_y = self.v_standard_scale_tb[self.v_choosed_ui_name].standard_y
  local standard_z = self.v_standard_scale_tb[self.v_choosed_ui_name].standard_z
  local x_result = map_value(standard_x, value)
  local y_result = map_value(standard_y, value)
  local z_result = map_value(standard_z, value)
  local rect = self.v_ui_rect[self.v_choosed_ui_name]
  rect:SetLocalScaleA(x_result, y_result, z_result)
  self:check_overlap(self.v_choosed_ui_name)
end

function ui:click_btn_scale_end_drag()
  self:save_retrack_data()
end

function ui:choose_new_ui(new_ui_name)
  if self.v_choosed_ui_name then
    self:change_choose_enable(self.v_choosed_ui_name, false)
  end
  self.v_choosed_ui_name = new_ui_name
  self:send_ui_screen_pos(new_ui_name)
  self:change_choose_enable(new_ui_name, true)
  self:send_btn_scale(new_ui_name)
end

function ui:retrack_send_info()
  self:send_btn_scale(self.v_choosed_ui_name)
  self:send_border_offset()
end

function ui:send_ui_screen_pos(ui_name)
  local rect = self.v_ui_rect[ui_name]
  local sx, sy = UIMgr.root_camera:GetWorldToScreenPointA(rect:GetPositionA())
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SETTING_CHOOSE_UI)
  msg.mm_obj = {x = sx, y = sy}
  msg.mm_y = Fight_Layout_Cfg.choose_sld_type.position_data
end

function ui:send_btn_scale(ui_name)
  if not ui_name then
    return
  end
  if self.v_ui_rect[ui_name] then
    local x = self.v_ui_rect[ui_name]:GetLocalScaleA3()
    local standard_info = self.v_standard_scale_tb[ui_name]
    if not standard_info then
      Log.Error("按钮大小配置不存在", ui_name)
      return
    end
    local standard_x = standard_info.standard_x
    local result = map_ui_to_sld(standard_x, x)
    local msg = MsgGame:mq_publish2(Const.MSG_ON_SETTING_CHOOSE_UI)
    msg.mm_x = result
    msg.mm_y = Fight_Layout_Cfg.choose_sld_type.btn_scale
  else
    Log.Error("自定义按钮界面   ui对象", ui_name, "丢失")
  end
end

function ui:send_border_offset()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SETTING_CHOOSE_UI)
  msg.mm_x = self.v_border_offset
  msg.mm_y = Fight_Layout_Cfg.choose_sld_type.border_offset
end

function ui:change_choose_enable(ui_name, is_on)
  local rect = self.v_ui_rect[ui_name]
  local obj = rect.gameObject
  local choose_obj = "EnemyBarList" == ui_name and Util.get_child_gameobj(EnemyBarListChoose, obj) or Util.get_child_gameobj("Choose", obj)
  if choose_obj then
    choose_obj.gameObject:SetActive(is_on)
  end
end

function ui:change_choose_color(ui_name, color)
  if self.v_ui_color_map[ui_name] ~= color then
    local rect = self.v_ui_rect[ui_name]
    local obj = rect.gameObject
    local choose_obj = "EnemyBarList" == ui_name and Util.get_child_gameobj(EnemyBarListChoose, obj) or Util.get_child_gameobj("Choose", obj)
    if choose_obj then
      local img = Util.get_image(nil, choose_obj)
      img.color = color
    end
    self.v_ui_color_map[ui_name] = color
  end
end

function ui:click_exchange_btn(ex_ui_name)
  if not self.v_choosed_ui_name then
    return
  end
  local ex_rect = self.v_ui_rect[ex_ui_name]
  local now_rect = self.v_ui_rect[self.v_choosed_ui_name]
  local ex_x, ex_y, ex_z = ex_rect:GetLocalPositionA3()
  local ex_sx, ex_sy, ex_sz = ex_rect:GetLocalScaleA3()
  local now_x, now_y, now_z = now_rect:GetLocalPositionA3()
  local now_sx, now_sy, now_sz = now_rect:GetLocalScaleA3()
  ex_rect:SetLocalPositionA(now_x, now_y, now_z)
  now_rect:SetLocalPositionA(ex_x, ex_y, ex_z)
  ex_rect:SetLocalScaleA(now_sx, now_sy, now_sz)
  now_rect:SetLocalScaleA(ex_sx, ex_sy, ex_sz)
  self:save_retrack_data()
end

function ui:on_click_bg()
  if self.v_choosed_ui_name then
    local pre_rect = self.v_ui_rect[self.v_choosed_ui_name]
    if pre_rect then
      local pre_obj = pre_rect.gameObject
      local choose_img = Util.get_child_gameobj("Choose", pre_obj)
      if choose_img then
        Util.get_child_gameobj("Choose", pre_rect.gameObject):SetActive(false)
      end
    else
      Log.Error("自定义按钮界面   ui对象", self.v_choosed_ui_name, "丢失")
    end
  end
  self.v_choosed_ui_name = nil
end

function ui:_build_retrack_data()
  local now_ui_list = get_now_ui_list(self)
  local temp = {
    ui_list = now_ui_list,
    border_offset = self.v_border_offset,
    choose_ui = self.v_choosed_ui_name
  }
  return temp
end

function ui:save_retrack_data()
  self.v_parent_ui:change_save_interactable(true)
  local length = self.v_retrack_tail - self.v_retrack_head
  if length > track_num then
    self.v_retrack_tb[self.v_retrack_head] = nil
    self.v_retrack_head = self.v_retrack_head + 1
  end
  self.v_retrack_tail = self.v_retrack_tail + 1
  local save_data = self:_build_retrack_data()
  self.v_retrack_tb[self.v_retrack_tail] = save_data
end

function ui:init_retrack_data()
  self.v_retrack_tail = 1
  self.v_retrack_head = 1
  self.v_retrack_tb = {}
  local save_data = self:_build_retrack_data()
  self.v_retrack_tb[self.v_retrack_tail] = save_data
end

function ui:load_retrack_data()
  local length = self.v_retrack_tail - self.v_retrack_head
  if length > 0 then
    self.v_retrack_tb[self.v_retrack_tail] = nil
    self.v_retrack_tail = self.v_retrack_tail - 1
    local retrack = self.v_retrack_tb[self.v_retrack_tail]
    local border_offset = retrack.border_offset
    local now_ui_list = retrack.ui_list
    local choose_ui = retrack.choose_ui
    self.v_border_offset = border_offset
    if choose_ui then
      self:choose_new_ui(choose_ui)
    end
    set_ui_list_layout_data(self, now_ui_list)
    self:retrack_send_info()
  end
end

function ui:get_change_state()
  if self.v_retrack_tail == self.v_retrack_head and 1 == self.v_retrack_head then
    return false
  else
    return true
  end
end

function ui:check_all_overlap(show_tips)
  local is_overlap = false
  for _, ui_group in pairs(Fight_Layout_Cfg.layout_group) do
    for _, ui_name in pairs(ui_group) do
      local ui_obj = self.v_ui_rect[ui_name].gameObject
      local is_display = ui_obj.activeInHierarchy
      if is_display and self:check_overlap(ui_name) then
        self:change_choose_enable(ui_name, true)
        self:change_choose_color(ui_name, overlap_color)
        self:_remove_overlap_timer(ui_name)
        self.v_show_overlap_timer[ui_name] = Timer:add_timer("show_overlap", 0.5, function()
          self:change_choose_enable(ui_name, false)
          self:change_choose_color(ui_name, normal_color)
          self:_remove_overlap_timer(ui_name)
        end)
        is_overlap = true
      end
    end
  end
  if is_overlap and show_tips then
    Util.show_message_tip(2268)
  end
  return is_overlap
end

function ui:check_out_of_range(ui_name)
  local out_of_range = false
  local group = Fight_Layout_Cfg.layout_group_map[ui_name]
  local is_flip = self.v_is_flip or Fight_Layout_Cfg.layout_is_flip.not_flip
  local area_name = Fight_Layout_Cfg.CAN_FLIP_GROUP_TO_AREA_NAME[is_flip][group]
  area_name = area_name or Fight_Layout_Cfg.GOURP_TO_AREA_NAME[group]
  local area_rect = area_name and self.v_ui_rect[area_name]
  if area_rect then
    local rect = self.v_ui_rect[ui_name]
    out_of_range = area_rect:isOutOfRange(rect)
  end
  return out_of_range
end

function ui:add_custom_layout_data(is_add_new)
  local ui_list
  if is_add_new then
    ui_list = get_now_ui_list(self)
  else
    ui_list = BattleSettingMgr:get_standard_layout_ui_list()
    ui_list = BattleSettingMgr:copy_ui_layout_list(ui_list)
  end
  local layout_list = BattleSettingMgr:get_btn_layout_list()
  local custom_list = BattleSettingMgr:load_local_btn_layout_data()
  local max_index = 0
  local name_index = 0
  local compare_text = Util.format_str("自定义方案")
  for _, data in pairs(layout_list) do
    if max_index < data.idx then
      max_index = data.idx
    end
    local _, begin_index = string.find(data.name, compare_text)
    if begin_index then
      local index = string.sub(data.name, begin_index + 1)
      index = tonumber(index)
      if nil ~= index then
        if nil == name_index then
          name_index = index
        elseif index > name_index then
          name_index = index
        end
      end
    end
  end
  max_index = max_index and max_index + 1 or INIT_ADD_BTN_LAYOUT_INDEX
  name_index = name_index and name_index + 1 or INIT_ADD_BTN_LAYOUT_INDEX
  local layout_name = compare_text .. name_index
  local layout_tb = self.get_custom_tb(layout_name, max_index, ui_list, self.v_border_offset)
  custom_list[layout_tb.idx] = layout_tb
  BattleSettingMgr:save_local_btn_layout_data(custom_list)
  BattleSettingMgr:load_init_layout()
  Util.show_message_tip(2269)
end

function ui:delete_custom_layout_data(idx)
  local custom_list = BattleSettingMgr:load_local_btn_layout_data()
  for key, layout_tb in pairs(custom_list) do
    if layout_tb.idx == idx then
      custom_list[key] = nil
      break
    end
  end
  BattleSettingMgr:save_local_btn_layout_data(custom_list)
  BattleSettingMgr:load_init_layout()
  Util.show_message_tip(2270)
end

function ui:save_custom_layout_data()
  local custom_list = BattleSettingMgr:load_local_btn_layout_data()
  local ui_list = get_now_ui_list(self)
  local idx = self.v_layout_data.idx
  self.v_layout_data.ui_list = ui_list
  self.v_layout_data.border_offset = self.v_border_offset
  self.v_layout_data.is_flip = self.v_is_flip
  custom_list[idx] = self.v_layout_data
  BattleSettingMgr:save_local_btn_layout_data(custom_list)
  BattleSettingMgr:load_init_layout()
end

function ui.get_custom_tb(name, idx, ui_list, border_offset)
  local layout_tb = {
    name = name,
    idx = idx,
    ui_list = ui_list,
    border_offset = border_offset or 0,
    is_custom = Fight_Layout_Cfg.layout_custom.custom,
    is_use = 1,
    is_flip = Fight_Layout_Cfg.layout_is_flip.not_flip
  }
  return layout_tb
end

function ui.clear_playerprefs_data()
  LocalStorage:delete_key(Config.SETTING_BTN_LAYOUT_KEY)
end

function ui:reset_layout_data()
  local ui_list, is_flip
  if self.v_layout_data.is_custom == Fight_Layout_Cfg.layout_custom.custom then
    ui_list, is_flip = BattleSettingMgr:get_standard_layout_ui_list()
  elseif self.v_layout_data.is_custom == Fight_Layout_Cfg.layout_custom.origin then
    ui_list, is_flip = BattleSettingMgr:get_standard_layout_ui_list(self.v_layout_data.idx)
  end
  if ui_list then
    self.v_layout_data.ui_list = BattleSettingMgr:copy_ui_layout_list(ui_list)
    self.v_layout_data.border_offset = 0
  end
  self.v_layout_data.is_flip = is_flip
  self:set_layout_data(self.v_layout_data, true)
  BattleSettingMgr:save_select_layout_index(self.v_layout_data.idx)
end

function ui:set_layout_data(layout_info, reset)
  local layout_tb = layout_info
  BattleSettingMgr:check_btn_layout_list(layout_tb)
  self.v_layout_data = layout_tb
  local ui_list
  if Util.is_client_only() then
    ui_list = self.v_standard_layout_tb
  else
    ui_list = layout_tb.ui_list
  end
  local border_offset = layout_tb.border_offset
  self.v_is_flip = layout_tb.is_flip or Fight_Layout_Cfg.layout_is_flip.not_flip
  set_ui_list_layout_data(self, ui_list, reset)
  self.v_parent_ui.v_control_content:set_flip_tog_is_on(Util.is_more_than_zero(self.v_is_flip))
  self.v_border_offset = border_offset or 0
  self:retrack_send_info()
  self:init_retrack_data()
  self.v_parent_ui:click_bg()
  self.v_choosed_ui_name = nil
end

function ui:on_save_layout2()
  if not self.v_layout_data.is_custom then
    return
  end
  if Util.is_client_only() then
    local file_name = self.v_layout_data.file_name
    local name = self.v_layout_data.name
    local idx = self.v_layout_data.idx
    self:save_init_layout_data(file_name, name, idx)
    self.v_parent_ui:ui_hide()
  else
    self:save_custom_layout_data()
    self.v_parent_ui:change_save_interactable(false)
    Util.show_message_tip(2172)
  end
end

function ui:on_save_layout()
  local is_custom = self.v_layout_data.is_custom
  if is_custom then
    if Util.is_client_only() then
      local file_name = self.v_layout_data.file_name
      local name = self.v_layout_data.name
      local idx = self.v_layout_data.idx
      Util.show_conform_tip("确认是否保存当前方案", nil, nil, nil, function()
        self:save_init_layout_data(file_name, name, idx)
        self.v_parent_ui:ui_hide()
      end)
    else
      Util.show_notify_popup_message(function()
        self:save_custom_layout_data()
        self.v_parent_ui:change_save_interactable(false)
        Util.show_message_tip(2172)
      end, "确认是否保存当前方案", "提示", "确定", "取消", nil, false)
    end
  end
end

function ui:get_select_state()
  return self.v_choosed_ui_name
end

function ui:init_original_layout()
  local cfg = ShareRes.get_fight_layout_config()
  for _, info in pairs(cfg) do
    self:save_cur_layout_original_data(info)
  end
end

function ui:save_cur_layout_original_data(info)
  local file_name = info.file_name
  local name = info.name
  local idx = info.idx
  self:save_init_layout_data(file_name, name, idx)
end

function ui:save_init_layout_data(file_name, name, idx)
  local ui_list = get_now_ui_list(self)
  local layout_tb = {
    ui_list = ui_list,
    border = self.v_border_offset,
    is_custom = Fight_Layout_Cfg.layout_custom.origin,
    is_use = 1,
    file_name = file_name,
    idx = idx,
    name = name,
    is_flip = self.v_is_flip
  }
  self._save_lua_file(file_name, layout_tb)
end

function ui._save_lua_file(file_name, result_tb)
  local data = dump(result_tb)
  local replace_path = string.gsub(file_name, "[/.]", "/")
  local path = PathDefine.config_dir .. replace_path .. ".lua"
  local f = io.open(path, "w")
  if f then
    f:write(data)
    f:flush()
    f:close()
  end
end

function ui:standard_scale_save()
  local scale_tb = self.v_standard_scale_tb
  local data = dump(scale_tb)
  local path = PathDefine.btn_layout_dir .. "standard_scale.lua"
  local f = io.open(path, "w")
  if f then
    f:write(data)
    f:flush()
    f:close()
  end
end

function ui:standard_scale_load()
  local btn_scale = ShareRes.create("btn_layout.standard_scale")
  return btn_scale
end

function ui:get_chlid(container_name)
  local child_name = Fight_Layout_Cfg.layout_child_obj_name[container_name]
  local child = self.v_fight_layout_child_map[child_name]
  if not child then
    local root = self.v_uiobjects[container_name]
    self.v_fight_layout_child_map[child_name] = FIGHT_LAYOUT_CHILD:ui_wrap_ex(self, root, true)
    child = self.v_fight_layout_child_map[child_name]
  end
  return child
end

function ui:_get_uiobject(group_num, uiobject_name)
  local container_name = group_num and Fight_Layout_Cfg.layout_container_root[group_num]
  local uiobjects
  if container_name then
    local child = self:get_chlid(container_name)
    if child then
      uiobjects = child.v_uiobjects
    end
  else
    uiobjects = self.v_uiobjects
  end
  return uiobjects[uiobject_name]
end

function ui:_get_uicompent(group_num, uicompent_name)
  local container_name = group_num and Fight_Layout_Cfg.layout_container_root[group_num]
  local uicompents
  if container_name then
    local child = self:get_chlid(container_name)
    if child then
      uicompents = child.v_uicompents
    end
  else
    uicompents = self.v_uicompents
  end
  return uicompents[uicompent_name]
end

function ui:_remove_overlap_timer(ui_name)
  if self.v_show_overlap_timer[ui_name] then
    Timer:remove_timer(self.v_show_overlap_timer[ui_name])
    self.v_show_overlap_timer[ui_name] = nil
  end
end

function ui:clear_overlap_timer()
  for ui_name, timer in pairs(self.v_show_overlap_timer) do
    Timer:remove_timer(timer)
    self.v_show_overlap_timer[ui_name] = nil
  end
end

function ui:flip_layout(isOn)
  self.v_parent_ui:change_save_interactable(true)
  self.v_is_flip = isOn and Fight_Layout_Cfg.layout_is_flip.is_flip or Fight_Layout_Cfg.layout_is_flip.not_flip
  local root_rect = self:get_rect_transform()
  local need_flip_gourp = Fight_Layout_Cfg.FLIP_GROUP
  local flip_suc_area = {}
  for _, gourp_id in ipairs(need_flip_gourp) do
    local group = Fight_Layout_Cfg.layout_group[gourp_id]
    for _, ui_name in pairs(group) do
      local rect = self.v_ui_rect[ui_name]
      if rect then
        CSHelper.FlipXPosition(root_rect.component, rect)
      end
      self.v_ui_init_x[ui_name] = rect:GetAnchoredPositionA()
    end
    local is_flip = self.v_is_flip or Fight_Layout_Cfg.layout_is_flip.not_flip
    local area_name = Fight_Layout_Cfg.CAN_FLIP_GROUP_TO_AREA_NAME[is_flip][gourp_id]
    area_name = area_name or Fight_Layout_Cfg.GOURP_TO_AREA_NAME[gourp_id]
    if not flip_suc_area[area_name] then
      local area_rect = self.v_ui_rect[area_name]
      if area_rect then
        local target_area_name = Fight_Layout_Cfg.AREA_FLIP_EXCHANGE[area_name]
        if target_area_name then
          local target_area_rect = self.v_ui_rect[target_area_name]
          if target_area_rect then
            CSHelper.ExchangeRectInfo(area_rect, target_area_rect)
            self.v_ui_init_x[area_name] = area_rect:GetAnchoredPositionA()
            self.v_ui_init_x[target_area_name] = target_area_rect:GetAnchoredPositionA()
            flip_suc_area[area_name] = true
            flip_suc_area[target_area_name] = true
          end
        end
      end
    end
  end
  for _, gourp_id in ipairs(need_flip_gourp) do
    local group = Fight_Layout_Cfg.layout_group[gourp_id]
    for _, ui_name in pairs(group) do
      self:check_overlap(ui_name)
    end
  end
  self.v_parent_ui.v_control_content:change_save_interactable()
end

return ui
