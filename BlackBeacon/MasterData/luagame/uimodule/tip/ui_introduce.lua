local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local event_system = UnityEngine.EventSystems
local event_trigger = event_system.EventTrigger
local event_entry = event_trigger.Entry
local UI_INTRODUCE_PAGE_ITEM_KEY = "UI_INTRODUCE_PAGE_ITEM_KEY"
local UI_INTRODUCE_INDEX_ITEM_KEY = "UI_INTRODUCE_INDEX_ITEM_KEY"
local space_offset = 68
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_return = {
    "BtnReturn",
    BIND_TYPE.BUTTON
  },
  v_btn_last = {
    "Btn_Last",
    BIND_TYPE.OBJECT
  },
  v_btn_next = {
    "Btn_Next",
    BIND_TYPE.OBJECT
  },
  v_page_content = {
    "PageContent",
    BIND_TYPE.OBJECT
  },
  v_page_tem = {
    "PageTem",
    BIND_TYPE.OBJECT
  },
  v_index_content = {
    "IndexContent",
    BIND_TYPE.OBJECT
  },
  v_index_tem = {
    "IndexTem",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:init_drag_data()
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("Btn_Last", function()
    self:on_click_last_or_next(false)
  end)
  self:set_button("Btn_Next", function()
    self:on_click_last_or_next(true)
  end)
  self:register_exist_auto_template(UI_INTRODUCE_PAGE_ITEM_KEY, self.v_page_tem, self.v_page_content)
  self:register_exist_auto_template(UI_INTRODUCE_INDEX_ITEM_KEY, self.v_index_tem, self.v_index_content)
end

function ui:ui_on_show(data, index)
  local prafab_name = data.v_object_transform.name
  local switch_cfg = ShareRes.create("graphic_guide.graphic_guide_switch", prafab_name)
  if nil == switch_cfg then
    if nil == data.v_parent_ui then
      UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("待策划配置"))
      Log.Error("Introduce按钮对应预制名为:", prafab_name, index)
      self:ui_hide()
      return
    else
      switch_cfg = ShareRes.create("graphic_guide.graphic_guide_switch", data.v_parent_ui.v_object_transform.name)
      if nil == switch_cfg then
        UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("待策划配置"))
        Log.Error("Introduce按钮对应预制名为:", prafab_name, index)
        self:ui_hide()
        return
      end
    end
  end
  self:refresh_stage(data, index)
  self:reset_pos_and_select_state()
  self:refresh_drag_content()
end

function ui:ui_on_hide()
  self:clear_drag()
  self:clear_sequence()
end

function ui:ui_on_destroy()
end

function ui:on_click_last_or_next(is_click_next)
  local xoffset
  local temp_x = self.v_content_rect_trans.anchoredPosition.x
  xoffset = is_click_next and -1 * self.v_every_cell_offset or self.v_every_cell_offset
  local finally_x = temp_x + xoffset
  if finally_x >= 0 then
    finally_x = 0
  elseif finally_x <= -1 * (#self.v_items - 1) * self.v_every_cell_offset then
    finally_x = -1 * (#self.v_items - 1) * self.v_every_cell_offset
  end
  self:clear_sequence()
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Append(self.v_content_rect_trans:DOAnchorPosX(finally_x, 0.6))
  self.v_sequence:OnComplete(function()
    self:change_btn_last_or_next_state()
    self:set_all_item_select_state()
  end)
end

function ui:init_drag_data()
  self.v_items = {}
  self.v_pos2item = {}
  self.v_index2posx = {}
  self.v_index_tem_list = {}
  self.v_name2index = {}
  self.v_content_rect_trans = Util.get_rect_transform(nil, self.v_page_content)
  self.v_content_start_x = self.v_content_rect_trans.anchoredPosition.x
  self.v_content_start_y = self.v_content_rect_trans.anchoredPosition.y
  self.v_cell_rect_trans = Util.get_rect_transform(nil, self.v_page_tem)
  self.v_cell_start_pos_x = self.v_cell_rect_trans.anchoredPosition.x
  self.v_cell_start_pos_y = self.v_cell_rect_trans.anchoredPosition.y
  self.v_cell_size_x = self.v_cell_rect_trans.sizeDelta.x
  self.v_cell_size_y = self.v_cell_rect_trans.sizeDelta.y
  self.v_every_cell_offset = self.v_cell_size_x + space_offset
end

function ui:refresh_stage(data, index)
  self.v_guide_id_count = 1
  local prafab_name = data.v_object_transform.name
  local switch_cfg = ShareRes.create("graphic_guide.graphic_guide_switch", prafab_name)
  if nil == switch_cfg then
    switch_cfg = ShareRes.create("graphic_guide.graphic_guide_switch", data.v_parent_ui.v_object_transform.name)
  end
  if switch_cfg then
    local group_id_list = switch_cfg.GroupId
    local group_id = group_id_list[1]
    if #group_id_list > 1 then
      group_id = group_id_list[index or data.v_page_toggle_tab.v_cur_select]
    end
    local guide_id_cfg_list = ShareRes.create("graphic_guide.graphic_guide_outside_by_ground", group_id)
    table.sort(guide_id_cfg_list, function(a, b)
      return a.sort < b.sort
    end)
    self.v_guide_id_count = #guide_id_cfg_list
    self:give_back_auto_cache(UI_INTRODUCE_PAGE_ITEM_KEY, false)
    self:give_back_auto_cache(UI_INTRODUCE_INDEX_ITEM_KEY, false)
    for index, guide_id_cfg in ipairs(guide_id_cfg_list) do
      local obj = self:get_auto_cache(UI_INTRODUCE_PAGE_ITEM_KEY)
      local obj_trans = obj.transform
      local x = self.v_cell_start_pos_x + (index - 1) * self.v_every_cell_offset
      local y = obj_trans.anchoredPosition.y
      obj.name = "item" .. index
      obj_trans:SetAnchoredPositionA(x, y)
      self.v_items[index] = obj
      self.v_pos2item[x] = obj
      self.v_index2posx[index] = x
      self.v_name2index[obj.name] = index
      local index_obj = self:get_auto_cache(UI_INTRODUCE_INDEX_ITEM_KEY)
      self.v_index_tem_list[index] = index_obj
      self:set_stage_info(obj, guide_id_cfg.id)
    end
  end
end

function ui:set_stage_info(item, guide_id)
  local guide_info_cfg = ShareRes.create("graphic_guide.graphic_guide_outside", guide_id)
  local guide_title = self:get_text("Guide_Title", item)
  local guide_desc = self:get_text("Guide_Des", item)
  local guide_img = self:get_image("Guide_Img", item)
  guide_title.text = guide_info_cfg.title
  guide_desc.text = guide_info_cfg.text
  ResMgr:load_set_icon(guide_img, guide_info_cfg.picture, nil, true, self)
end

function ui:reset_pos_and_select_state()
  self.v_btn_last:SetActiveEx(false)
  self.v_btn_next:SetActiveEx(self.v_guide_id_count > 1)
  self.v_content_rect_trans:SetAnchoredPositionA(-1 * self.v_index2posx[1], self.v_content_start_y)
  self:set_all_item_select_state()
end

function ui:set_all_item_select_state()
  local select_item, select_index = self:get_select_item()
  for index, item in pairs(self.v_items) do
    self:set_item_select_state(index, item.transform.name == select_item.transform.name)
  end
end

function ui:get_select_item()
  local temp_x = self.v_content_rect_trans.anchoredPosition.x
  local temp_y = self.v_content_rect_trans.anchoredPosition.y
  local half_cell_width = math.floor(self.v_cell_size_x / 2)
  local num = math.floor((-1 * temp_x + half_cell_width) / self.v_every_cell_offset)
  local finally_x = self.v_cell_start_pos_x - num * self.v_every_cell_offset
  local item = self.v_pos2item[-1 * finally_x]
  local select_index = self.v_name2index[item.name]
  return item, select_index, finally_x, temp_y
end

function ui:set_item_select_state(index, is_select)
  local index_obj = self.v_index_tem_list[index]
  local light = self:get_child_gameobj("Light", index_obj)
  light:SetActiveEx(is_select)
end

function ui:refresh_drag_content()
  local trigger = Util.get_component(nil, self.v_page_content, event_trigger)
  self.v_trigger_com = trigger
  self.v_pre_x = nil
  self.v_speed = 0.9
  self:begin_drag()
  self:on_draging()
  self:end_drag()
end

function ui:begin_drag()
  local entrybegindrag = event_entry()
  entrybegindrag.eventID = Config.EVENT_TRIGGER_TYPE.BeginDrag
  entrybegindrag.callback:AddListener(function(data)
    local x = data.position.x
    self.v_pre_x = x
  end)
  self.v_trigger_com.triggers:Add(entrybegindrag)
end

function ui:on_draging()
  local content_rect = self.v_content_rect_trans
  local entrydrag = event_entry()
  entrydrag.eventID = Config.EVENT_TRIGGER_TYPE.Drag
  entrydrag.callback:AddListener(function(data)
    self:set_all_item_select_state()
    local x = data.position.x
    local xoffset = (x - self.v_pre_x) * self.v_speed
    local temp_x = content_rect.anchoredPosition.x
    local temp_y = content_rect.anchoredPosition.y
    local finally_x = temp_x + xoffset
    if finally_x >= 0 then
      finally_x = 0
    elseif finally_x <= -1 * (#self.v_items - 1) * self.v_every_cell_offset then
      finally_x = -1 * (#self.v_items - 1) * self.v_every_cell_offset
    end
    content_rect:SetAnchoredPositionA(finally_x, temp_y)
    self.v_pre_x = x
  end)
  self.v_trigger_com.triggers:Add(entrydrag)
end

function ui:end_drag(content_rect)
  local entry_end_drag = event_entry()
  entry_end_drag.eventID = Config.EVENT_TRIGGER_TYPE.EndDrag
  entry_end_drag.callback:AddListener(function()
    self:on_select()
  end)
  self.v_trigger_com.triggers:Add(entry_end_drag)
end

function ui:on_select()
  local _, select_index, finally_x = self:get_select_item()
  self:clear_sequence()
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Append(self.v_content_rect_trans:DOAnchorPosX(finally_x, 0.4))
  self.v_sequence:OnComplete(function()
    self:change_btn_last_or_next_state(select_index)
    self:set_all_item_select_state()
  end)
end

function ui:change_btn_last_or_next_state(index)
  local select_index
  if index then
    select_index = index
  else
    local _, index = self:get_select_item()
    select_index = index
  end
  if self.v_guide_id_count > 1 then
    if 1 == select_index then
      self.v_btn_last:SetActiveEx(false)
      self.v_btn_next:SetActiveEx(true)
    elseif select_index == self.v_guide_id_count then
      self.v_btn_last:SetActiveEx(true)
      self.v_btn_next:SetActiveEx(false)
    else
      self.v_btn_last:SetActiveEx(true)
      self.v_btn_next:SetActiveEx(true)
    end
  end
end

function ui:clear_drag()
  if self.v_trigger_com then
    for _, trigger_event in pairs(self.v_trigger_com.triggers) do
      trigger_event.callback:RemoveAllListeners()
    end
    self.v_trigger_com.triggers:Clear()
  end
  UtilTable.clear_list(self.v_items)
  UtilTable.clear_map(self.v_pos2item)
  UtilTable.clear_map(self.v_index2posx)
  UtilTable.clear_map(self.v_index_tem_list)
  UtilTable.clear_map(self.v_name2index)
end

function ui:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

return ui
